unit GeneralUtils;

{ *Genera utilities for the de novo sequencer. * }
interface

uses System.Classes, SysUtils, System.Math, StrUtils,
  Globals, io_unit, General, StrGeneral, LogForm, System.Generics.Collections;

const
  Signs: array [TValueSign] of string = ('', '', '+');
  MAX_MODIFICATIONS = 50;

type

  TUtility = class
    public
      class procedure ReverseSequenceArray<T>(var arr: array of T);
  end;

  SequenceTag = record
    seq1Let: string; // 1-letter sequence without modifications
    seq3Let: string; // 3-letter sequence without modifications
    seq1LetMod: string; // 1-letter sequence with modifications
    seq3LetMod: string; // 3-letter sequence with modifications
    length: integer;
    mass: real;
    precursor: real;
    charge: integer;
  end;

  SequenceFastaEntry = record
    header: string;
    sequence: string;
  end;

  SequenceFastaEntries = array of SequenceFastaEntry;

  Residue = record
    xPos, yPos, level: integer;
    aaNum, resIdx: integer;
    peakIdx, internPeakId: integer;
    mz, int: real;
    res1: string; // 1-let Residue
    res3: string; // 3-let Residue
    res1mod: string; // 1-let Residue(+/-MassChange. If modified)
    res3mod: string; // 3-let Residue(+/-MassChange. If modified)
    massDeviation: real;
    mass: real;
    resBox: tBox;
  end;
  Residues = array of Residue;

  DeNovoSeqArray = array [1 .. 30] of Residue;

  ResidueMass = record
    aaNum: integer; // The AA number of the (original) residue
    res1: string; // 1-let Residue
    res3: string; // 3-let Residue
    res1mod: string; // 1-let Residue(+/-MassChange. If modified)
    res3mod: string; // 3-let Residue(+/-MassChange. If modified)
    mass: real; // The mass after potential modification
    modified: boolean;
    fixedMod: boolean;
    modName: string;
    massChange: real;
  end;

  ResidueMassList = array of ResidueMass;

  PossibleModification = record
    name: string;
    formula: string;
    massChange: real;
    residues: string;
    fixedModification: boolean;
  end;

  PossibleModifications = array of PossibleModification;

Function GetSequenceTag(seq: DeNovoSeqArray; charge: integer; reverseSequence: boolean = False)
  : SequenceTag; overload;
Function GetSequenceTag(resIdxs: array of integer; charge: integer; reverseSequence: boolean = False)
  : SequenceTag; overload;
Function GetSequenceTagFragment(seq: array of Residue; charge: integer; addWater: boolean = True; reverseSequence : boolean = False) : SequenceTag;



Procedure CreateFastaFile(entries: SequenceFastaEntries; filename: string);


Function CreateResidue(resIdx: integer; peakIdx: integer; internPeakIdx: integer; mz: real; intensity: real; massDev: real): Residue;
Function CreateFragmentResidue(resIdxs : array of integer; peakIdx: integer; internPeakIdx: integer; mz: real; intensity: real; massDev: real): Residue;
Function CompositionToMonoMass(comp: string): real;


Procedure GenerateResidueMassList(mods: PossibleModifications; leuIleEqual: boolean; lysGlnEqual: boolean);

Function LoadModificationFile(filename: string; var mods: PossibleModifications; logWindow: TFormLog): boolean;
Function SaveModificationFile(filename: string; mods: PossibleModifications; logWindow: TFormLog) : boolean;


var
  ResMassList: ResidueMassList;

implementation

Function GetSequenceTag(seq: DeNovoSeqArray; charge: integer; reverseSequence: boolean = False): SequenceTag;
{ * Get the sequence tag (1-letter, 3-letter, and mass) from the DeNovoSeqArray * }
var seqResIdxs: array [1..30] of integer;
begin
  for var i := Low(seqResIdxs) to High(seqResIdxs) do
    seqResIdxs[i] := seq[i].resIdx;

  result := GetSequenceTag(seqResIdxs, charge, reverseSequence);
end;

Function GetSequenceTag(resIdxs: array of integer; charge: integer; reverseSequence: boolean = False): SequenceTag; overload;
begin
  result := Default(SequenceTag);
  // Exit from the function, if no residues is found
  if Length(resIdxs) < 1 then Exit;
  // Reverse the sequence if required
  if reverseSequence then TUtility.ReverseSequenceArray<integer>(resIdxs);
  // Loop over the residues
  for var i := Low(resIdxs) to High(resIdxs) do
  begin
    if resIdxs[i] = 0 then continue;

    Inc(result.length);
    result.mass := result.mass + ResMassList[resIdxs[i]].mass;
    result.seq1Let := result.seq1Let + ResMassList[resIdxs[i]].res1;
    result.seq3Let := result.seq3Let + ResMassList[resIdxs[i]].res3;
    result.seq1LetMod := result.seq1LetMod + ResMassList[resIdxs[i]].res1Mod;
    result.seq3LetMod := result.seq3LetMod + ResMassList[resIdxs[i]].res3Mod;
  end;

  result.charge := charge;
  result.mass := result.mass;

  result.precursor := RoundTo((result.mass + (charge * protonMS)) /
    charge, -4);
  result.mass := RoundTo(result.mass, -4);
end;

Function GetSequenceTagFragment(seq: array of Residue; charge: integer; addWater: boolean = True; reverseSequence : boolean = False) : SequenceTag;
begin
  result := Default(SequenceTag);
  // Exit from the function, if no residues is found
  if Length(seq) < 1 then Exit;
  // Reverse the sequence if required
  if reverseSequence then TUtility.ReverseSequenceArray<Residue>(seq);

  for var i := Low(seq) to High(seq) do
  begin
    if seq[i].resIdx = 0 then continue;


    if seq[i].resIdx = -99 then
    begin
      Inc(result.length, Length(seq[i].res1) - 2); // Add the number of residues. -2 takes care of square brackets
      result.mass := result.mass + seq[i].mass;
      result.seq1Let := result.seq1Let + seq[i].res1;
      result.seq3Let := result.seq3Let + seq[i].res3;
      result.seq1LetMod := result.seq1LetMod + seq[i].res1Mod;
      result.seq3LetMod := result.seq3LetMod + seq[i].res3Mod;
    end
    else
    begin
      Inc(result.length);
      result.mass := result.mass + ResMassList[seq[i].resIdx].mass;
      result.seq1Let := result.seq1Let + ResMassList[seq[i].resIdx].res1;
      result.seq3Let := result.seq3Let + ResMassList[seq[i].resIdx].res3;
      result.seq1LetMod := result.seq1LetMod + ResMassList[seq[i].resIdx].res1Mod;
      result.seq3LetMod := result.seq3LetMod + ResMassList[seq[i].resIdx].res3Mod;
    end;

  end;

  result.charge := charge;
  result.mass := result.mass;
  if addWater then result.mass := result.mass + aa.mass[3, 0];
  result.precursor := RoundTo((result.mass + (charge * protonMS)) / charge, -4);
  result.mass := RoundTo(result.mass, -4);
end;

Procedure CreateFastaFile(entries: SequenceFastaEntries; filename: string);
var
  lines: TStringList;
  header: string;
begin
  lines := TStringList.Create;
  try
    for var recIdx := Low(entries) to High(entries) do
    begin
      if Length(entries[recIdx].sequence) < 1 then
        continue;
      header := Format('>%s', [entries[recIdx].header]);
      lines.Add(header);
      lines.Add(entries[recIdx].sequence);
    end;

    lines.SaveToFile(filename);
  finally
    lines.Free;
  end;
end;

Procedure GenerateResidueMassList(mods: PossibleModifications; leuIleEqual: boolean; lysGlnEqual: boolean);
var
  i, modIdx, aaNum: integer;
  res: char;
begin
  // Reset residue mass list
  SetLength(ResMassList, 0);
  SetLength(ResMassList, Length(aa.name1)-2);

  // Add placeholder residue
  ResMassList[0].aaNum := 0;
  ResMassList[0].res1 := aa.name1[0];
  ResMassList[0].res3 := aa.name3[0];
  ResMassList[0].res1Mod := aa.name1[0];
  ResMassList[0].res3Mod := aa.name3[0];
  ResMassList[0].mass := aa.mass[3, 0];
  ResMassList[0].modified := False;
  ResMassList[0].fixedMod := False;
  ResMassList[0].modName := '';
  ResMassList[0].massChange := 0;

  // Add the standard residues
  for i := 2 to Length(aa.name1) - 2 do
  begin
    if ((aa.name1[i] = 'Q') and lysGlnEqual) or ((aa.name1[i] = 'I') and leuIleEqual) then
      continue;

    ResMassList[i-1].aaNum := i;
    ResMassList[i-1].res1 := aa.name1[i];
    ResMassList[i-1].res3 := aa.name3[i];
    ResMassList[i-1].res1Mod := aa.name1[i];
    ResMassList[i-1].res3Mod := aa.name3[i];
    ResMassList[i-1].mass := aa.mass[3, i];
    ResMassList[i-1].modified := False;
    ResMassList[i-1].fixedMod := False;
    ResMassList[i-1].modName := '';
    ResMassList[i-1].massChange := 0;
  end;

  // Add the modifications if any
  if Length(mods) < 1 then
    Exit;

  for i := Low(mods) to High(mods) do
    for res in mods[i].residues do
    begin
      if mods[i].fixedModification then
      begin // Fixed modifications
        modIdx := aa.aaIndex[Ord(res)] - 1;
        ResMassList[modIdx].fixedMod := True;
        aaNum := modIdx + 1;
      end
      else
      begin // Variable modification
        SetLength(ResMassList, Length(ResMassList) + 1);
        modIdx := High(ResMassList);
        aaNum := aa.aaIndex[Ord(res)];
      end;

      ResMassList[modIdx].aaNum := aaNum;
      ResMassList[modIdx].modified := True;

      ResMassList[modIdx].res1 := aa.name1[aaNum];
      ResMassList[modIdx].res3 := aa.name3[aaNum];

      ResMassList[modIdx].res1Mod := Format('%s(%s%0.3f)', [aa.name1[aaNum], Signs[sign(mods[i].massChange)], mods[i].massChange]);
      ResMassList[modIdx].res3Mod := Format('%s(%s%0.3f)', [aa.name3[aaNum], Signs[sign(mods[i].massChange)], mods[i].massChange]);
      ResMassList[modIdx].mass :=  aa.mass[3, aaNum] + mods[i].massChange;

      ResMassList[modIdx].modName := Format('%s%s', [mods[i].name, aa.name1[aaNum]]);
      ResMassList[modIdx].massChange := mods[i].massChange;
    end;

end;

Function LoadModificationFile(filename: string; var mods: PossibleModifications; logWindow: TFormLog) : boolean;
var s : shortString; tf : textFile;
    modRec : PossibleModification;          unused: real;
begin
  result := false;
  SetLength(mods, 0);
  if not FileExists (filename) then
  begin
    logWindow.AddLogMessage('Could not load %s: File does not exist', [filename]);
    Exit;
  end;

  if IOCheck (filename) = 1640 then              {old modification file. Not accepted}
  begin
    logWindow.AddLogMessage('Could not load %s: The file is an old format. Please use the new format', [filename]);
    Exit;
  end;
  try
    AssignFile (tf, filename);
    Reset (tf);
    while not EOF (tf) do
    begin
      ReadLn (tf, S);
    end;
    CloseFile (tf);
    Reset (tf);
    ReadLn (tf, S);
    if S <> 'MODIFICATION V.3.01' then
    begin
      logWindow.AddLogMessage('Could not load %s: The modification file must be version 3.01', [filename]);
      result := False;
      CloseFile (tf);
      Exit;
    end;
    for var i := 0 to MAX_MODIFICATIONS do
    with modRec do                      // mList.dBase [i]
    begin
      ReadLn (tf, s);
      if s = '' then
      begin
        ReadLn(tf, s);
        ReadLn(tf, s);
        ReadLn(tf, s);
        continue;
      end;

      name := s;

      ReadLn (tf, s);
      S := Trim (S);
      if WordCountS (s, ' ') = 1 then        //formula
      begin
        formula := copy (s, 1, 20);
        ComposStr2AveMono (formula, unused, massChange);
      end else begin                        //mass values
        logWindow.AddLogMessage('Could not load %s: The modifications must contain formula instead of masses', [filename]);
        result := False;
        CloseFile (tf);
        Exit;
      end;
      ReadLn (tf, S);
      residues := Copy (s, 1, 20);
      //ResStr2Set (validRes, residues, aa.aastr1 + '[]');
      ReadLn (tf, S);                     //enabled - charge - pI
      if WordCountS (s, ' ') = 3 then
        fixedModification := not (boolean (S [1] = '0'))
      else
        fixedModification := not (boolean (S = '0'));

      SetLength(mods, Length(mods)+1);
      mods[High(mods)] := modRec;
    end;
    CloseFile (tf);
    result := true;
  except
    result := false;
  end;
end;

Function SaveModificationFile(filename: string; mods: PossibleModifications; logWindow: TFormLog) : boolean;
var f : textFile;
begin
  try
    AssignFile (f, filename);
    Rewrite (f);
    WriteLn (f, 'MODIFICATION V.3.01');
    for var i := Low(mods) to High(mods) do
      with mods[i] do
      begin
        WriteLn (f, name);
        WriteLn (f, formula);
        WriteLn (f, residues);
        if fixedModification then
          WriteLn (f, '1 0 0')
        else
          WriteLn (f, '0 0 0');
      end;
    CloseFile (f);
    result := true;
  except
    result := false
  end;
end;

Function CompositionToMonoMass(comp: string): real;
var unused: real;
begin
  ComposStr2AveMono(comp, unused, result);
end;


Function CreateResidue(resIdx: integer; peakIdx: integer; internPeakIdx: integer; mz: real; intensity: real; massDev: real): Residue;
begin
  result.xPos := 0;
  result.yPos := 0;
  result.level := 0;
  result.aaNum := ResMassList[resIdx].aaNum;
  result.resIdx := resIdx;
  result.peakIdx := peakIdx;
  result.internPeakId := internPeakIdx;
  result.mz := mz;
  result.int := intensity;
  result.res1 := ResMassList[resIdx].res1;
  result.res3 := ResMassList[resIdx].res3;
  result.res1mod := ResMassList[resIdx].res1mod;
  result.res3mod := ResMassList[resIdx].res3mod;
  result.massDeviation := massDev;
  result.mass := ResMassList[resIdx].mass;
end;

Function CreateFragmentResidue(resIdxs : array of integer; peakIdx: integer; internPeakIdx: integer; mz: real; intensity: real; massDev: real): Residue;
{Create psudeo-residue to represent fragments, where the order is not known}
begin
  result.xPos := 0;
  result.yPos := 0;
  result.level := 0;
  result.aaNum := 0;
  result.resIdx := -99;
  result.peakIdx := peakIdx;
  result.internPeakId := internPeakIdx;
  result.mz := mz;
  result.int := intensity;

  result.res1 := '[';
  result.res3 := '[';
  result.res1mod := '[';
  result.res3mod := '[';
  result.mass := 0;

  for var i := Low(resIdxs) to High(resIdxs) do
  begin
    result.res1 := result.res1 + ResMassList[resIdxs[i]].res1;
    result.res3 := result.res3 + ResMassList[resIdxs[i]].res3;
    result.res1mod := result.res1mod + ResMassList[resIdxs[i]].res1Mod;
    result.res3mod := result.res3mod + ResMassList[resIdxs[i]].res3Mod;
    result.mass := result.mass + ResMassList[resIdxs[i]].mass;
  end;

  result.res1 := result.res1 + ']';
  result.res3 := result.res3 + ']';
  result.res1mod := result.res1mod + ']';
  result.res3mod := result.res3mod + ']';
  result.massDeviation := massDev;
  result.mass := result.mass;
  result.resBox := Default(tBox);
end;
{ TUtility }

class procedure TUtility.ReverseSequenceArray<T>(var arr: array of T);
var temp: T;
begin
	if Length(arr) > 0 then
	begin
		for var i := Low(arr) to High(arr) div 2 do
		begin
			temp := arr[i];
			arr[i] := arr[High(arr) - i];
			arr[High(arr) - i] := temp;
		end;
	end;
end;


end.
