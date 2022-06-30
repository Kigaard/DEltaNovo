unit DeNovoScoringUtils;
{*Utilities for scoring the de novo sequencing results. *}
interface

uses System.Generics.Collections, GeneralUtils, StrUtils,
    SysUtils, REST.Client, REST.Types, System.JSON, System.JSON.Writers, System.JSON.Types, System.Classes,
    Globals, General, StrGeneral, io_unit,
    SpectraUtils, DeNovoSequencingUtils, LogForm, DeNovoRecords;

{ Fragmentation }
Function GetFragmenentationType(sequence: DNSequenceSeriesTag; logWindow : TFormLog): integer;

Procedure CalculateSummedIntensity(var sequence: DNSequenceSeriesTag; logWindow : TFormLog);
{ Fragments }
Procedure ScoreFragmentIons(var sequence: DNSequenceSeriesTag; logWindow : TFormLog);

{ Immonium }


{ Neutral loss }
const AMMONIA_LOSS_PROBABILITIES : array[0..22] of real =   (-1, -1, 0.0352, 0.0154, 0.0264, 0.0264, 0.066, 0.0594, 0.0198, 0.0418, // Last: Lysine
                                                             0, 0.0308, 0.0374, 0.2, 0.308, 0.12, 0.1, 0.0374, 0.0396, 0.0286, 0.0594, // Last: Tryptophan
                                                             0.044, -1);
const WATER_LOSS_PROBABILITIES : array[0..22] of real =     (-1, -1, 0.0141, 0, 0.1, 0.08, 0.0212, 0.11, 0.0106, 0.03, 0, // Last: Lysine
                                                             0.0018, 0.0106, 0.08, 0, 0.176, 0.0794, 0.15, 0.16, 0, 0, // Last: Tryptophan
                                                             0.0406, -1);

Procedure ScoreNeutralLossIons(var sequence: DNSequenceSeriesTag; logWindow : TFormLog);

implementation

{---------------------------------Fragmentation-------------------------------}
Function GetFragmenentationType(sequence: DNSequenceSeriesTag; logWindow : TFormLog): integer;
Function GetArginineCount(): integer;
var i: Integer;
begin
  result := 0;
  for i := 1 to Length(sequence.tag.seq1Let) do
    if sequence.tag.seq1Let[i] = 'R' then
      inc(result);
end;
Function HasAcidicResidues() : boolean;
var i: Integer;
begin
  result := False;
  for i := 1 to Length(sequence.tag.seq1Let) do
    if (sequence.tag.seq1Let[i] = 'D') or (sequence.tag.seq1Let[i] = 'E') then
    begin
      result := True;
      Exit;
    end;

end;
var argCount : integer;
begin
argCount := GetArginineCount();

  if sequence.precursorCharge > argCount then
  begin
    logWindow.AddLogMessage('Sequence %s: Charge: %d. Arginine count: %d - Mobile proton.',
      [sequence.tag.seq1Let, sequence.precursorCharge, argCount]);
    result := 1;
  end
  else
  begin
    if HasAcidicResidues() then
    begin
      logWindow.AddLogMessage('Sequence %s: Charge: %d. Arginine count: %d - No Mobile proton. Has acidic residues - Charge-remote fragmentation',
        [sequence.tag.seq1Let, sequence.precursorCharge, argCount]);
      result := 2;
    end
    else
    begin

      logWindow.AddLogMessage('Sequence %s: Charge: %d. Arginine count: %d - No Mobile proton. Has no acidic residues - charge-remote fragmentation',
        [sequence.tag.seq1Let, sequence.precursorCharge, argCount]);
      result := 0;
    end;
  end;
end;

Procedure CalculateSummedIntensity(var sequence: DNSequenceSeriesTag; logWindow : TFormLog);
begin
  sequence.sumI := 0;
  for var i := Low(sequence.tempResidues) to High(sequence.tempResidues) do
    sequence.sumI := sequence.sumI + sequence.tempResidues[i].int;
end;
{---------------------------------Fragments-----------------------------------}
Procedure ScoreFragmentIons(var sequence: DNSequenceSeriesTag; logWindow : TFormLog);
var resIdxs: string;

Procedure MatchFragments();
var permutation: string; newFragments: FragmentIons;
begin
  for var fragIdx := Low(sequence.fragments) to High(sequence.fragments) do
  begin
    for var permIdx := Low(sequence.fragments[fragIdx].resIdxPermutations) to High(sequence.fragments[fragIdx].resIdxPermutations) do
    begin

      if Length(sequence.fragments[fragIdx].resIdxPermutations[permIdx]) = 2 then
        permutation := Format('|%d|%d|', [sequence.fragments[fragIdx].resIdxPermutations[permIdx][0],
                                       sequence.fragments[fragIdx].resIdxPermutations[permIdx][1]])
      else
        permutation := Format('|%d|%d|%d|', [sequence.fragments[fragIdx].resIdxPermutations[permIdx][0],
                                       sequence.fragments[fragIdx].resIdxPermutations[permIdx][1],
                                       sequence.fragments[fragIdx].resIdxPermutations[permIdx][2]]);
      
  
      if ContainsText(resIdxs, permutation) then
      begin
        SetLength(sequence.fragments[fragIdx].matchingFragments, Length(sequence.fragments[fragIdx].matchingFragments)+1);
        sequence.fragments[fragIdx].matchingFragments[High(sequence.fragments[fragIdx].matchingFragments)] := sequence.fragments[fragIdx].resIdxPermutations[permIdx];
      end;
    end;

    if Length(sequence.fragments[fragIdx].matchingFragments) > 0 then
    begin
      SetLength(newFragments, Length(newFragments)+1);
      newFragments[High(newFragments)] := sequence.fragments[fragIdx];
    end;
  end;

  sequence.fragments := newFragments;

end;
var i: integer;
begin
  // Create the sequence tag as a string
  for i := Low(sequence.tempResidues) to High(sequence.tempResidues) do
    resIdxs := Format('%s|%d', [resIdxs, sequence.tempResidues[i].resIdx]);
  resIdxs := resIdxs + '|';
  
  MatchFragments();

  
end;
{---------------------------------Immonium------------------------------------}

{---------------------------------Neutral loss--------------------------------}
Procedure ScoreNeutralLossIons(var sequence: DNSequenceSeriesTag; logWindow : TFormLog);
Procedure RemoveNeutralLossIon(const Index: Cardinal);
var ALength: Cardinal;
begin
  ALength := Length(sequence.neutralLossIons);
  for var i := Index + 1 to ALength - 1 do
    sequence.neutralLossIons[i - 1] := sequence.neutralLossIons[i];
  SetLength(sequence.neutralLossIons, ALength - 1);
end;
Procedure PreprocessNeutralLossIons();
var ionIdx, resIdx, i: integer; freeNLIons: TList<integer>;

begin
  freeNLIons := TList<integer>.Create;
  for ionIdx := Low(sequence.neutralLossIons) to High(sequence.neutralLossIons) do
  begin
    // Remove neutral loss ions with main ions outside the sequence.
    if (sequence.neutralLossIons[ionIdx].lostFromPeakIdx < sequence.startPeakIdx) or
      (sequence.neutralLossIons[ionIdx].lostFromPeakIdx > sequence.endPeakIdx) then
    begin
      freeNLIons.Add(ionIdx);
      continue;
    end;

    sequence.neutralLossIons[ionIdx].lostFromAaNum := -1;
    // Find the neutral loss
    for resIdx := Low(sequence.tempResidues) to High(sequence.tempResidues) do
    begin
      if sequence.neutralLossIons[ionIdx].lostFromPeakIdx = sequence.tempResidues[resIdx].peakIdx then
      begin
        sequence.neutralLossIons[ionIdx].lostFromAaNum := sequence.tempResidues[resIdx].aaNum;
      end;

    end;

    if sequence.neutralLossIons[ionIdx].lostFromAaNum = -1 then
    begin
      freeNLIons.Add(ionIdx);
      continue;
    end;

    // Determine terminal loss
    if sequence.neutralLossIons[ionIdx].lostFromPeakIdx = sequence.startPeakIdx then
      sequence.neutralLossIons[ionIdx].lostFromTerminus := 1
    else if sequence.neutralLossIons[ionIdx].lostFromPeakIdx = sequence.endPeakIdx then
      sequence.neutralLossIons[ionIdx].lostFromTerminus := 2
    else
      sequence.neutralLossIons[ionIdx].lostFromTerminus := 0;
  end;

  freeNLIons.Reverse;

  for i in freeNLIons do
  begin
    RemoveNeutralLossIon(i);
  end;
end;
Procedure ScoreNLIon(ion: NeutralLossIon);
var probability: real;
begin
  if ion.lossType = 17 then
    probability := AMMONIA_LOSS_PROBABILITIES[ion.lostFromAaNum]
  else
    probability := WATER_LOSS_PROBABILITIES[ion.lostFromAaNum];
end;

begin
  PreprocessNeutralLossIons();
  for var i := Low(sequence.neutralLossIons) to High(sequence.neutralLossIons) do
    ScoreNLIon(sequence.neutralLossIons[i]);
end;

end.
