unit DeNovoSequencingUtils;
{*Utilities for performing the de novo sequencing. *}
interface

uses VCLTee.Series, System.Math, System.Generics.Collections, GeneralUtils,
    SysUtils, REST.Client, REST.Types, System.JSON, System.JSON.Writers, System.JSON.Types, System.Classes,
    Globals, General, StrGeneral, io_unit, SpectraUtils, LogForm, DeNovoRecords;

const topDN = 12;
type
  DeNovoResArray = array [1..topDN] of Residue;

  DeNovoResCandidates = record
        Enabled : boolean;
        basePks : Residue;
        newPks : array [1..2] of DeNovoResArray;    //1..2 down..up peaks
        end;

  AutoDeNovoSeqSettings = record
    maxMainPeaks: integer;
    minTagLength: integer;
    ensureTagConnect: boolean;
  end;


  ImmoniumIonMass = record
    aaNum : integer;
    mass : real;
  end;

  ImmoniumIonMasses = array of ImmoniumIonMass;

  FragmentIonMass = record
    residueIdxs : TArray<integer>;
    resIdxPermutations: TArray<TArray<integer>>; // Permutation Idx - Res Idx
    mass: real;
  end;

  FragmentIonMasses = array of FragmentIonMass;

  IonMassList = record
    immoniumIons: ImmoniumIonMasses;
    diPeptideMasses: FragmentIonMasses;
    triPeptideMasses: FragmentIonMasses;
  end;

Function CalculateIonMasses() : IonMassList;
Function GetPermutations(ASet: TArray<integer>): TArray<TArray<integer>>;

Procedure GenerateSequenceIds(var sequences: DNSequenceSeriesTags);
Procedure GeneratePossibleDeNovoSequences(var sequences: DNSequenceSeriesTags; seriesSequences: DNSequenceSeriesTags; nlIons: NeutralLossIons; fragIons: FragmentIons; immIons: ImmoniumIons);


Procedure FindResidueCandidates(spectrum: msmsSpectrum; valueIndex: integer; precision: real; var candidates: DeNovoResCandidates; logWindow : TFormLog;
                                selectNMostIntenseCandidates: integer; autoDeNovo: boolean = False);

Function CalculateMassDeviation(peak1mz: real; peak2mz: real; resIdx: integer): real;

implementation

Function CalculateIonMasses() : IonMassList;
var immoIons: ImmoniumIonMasses; diPeptides, triPeptides: FragmentIonMasses;

Procedure GeneratePossibleMasses();
var   residueCount: integer; aa1Idx, aa2Idx, aa3Idx: integer; diPeptideIdx, triPeptideIdx: integer;
      immoniumMass, diMass, triMass: real; residueMasses: array of real;
      unused, immonium: real;
begin
  SetLength(residueMasses, Length(ResMassList));
  residueCount := Length(residueMasses);
  for var i := Low(ResMassList) to High(ResMassList) do
    residueMasses[i] := ResMassList[i].mass;

  ComposStr2AveMono('C1O1', unused, immonium);
  // Set the array lengths
  SetLength(immoIons, residueCount);
  SetLength(diPeptides, residueCount*residueCount);
  SetLength(triPeptides, residueCount*residueCount*residueCount);

  // Loop over the residues and calculate the mass
  for aa1Idx := Low(residueMasses) to High(residueMasses) do
  begin
    // Calculate the mass for the immonium mass
    immoniumMass := residueMasses[aa1Idx] - immonium; // TODO: Use ions from literature instead/as as supplement?
    immoIons[aa1Idx].mass := immoniumMass;
    immoIons[aa1Idx].aaNum := aa1Idx;

    for aa2Idx := Low(residueMasses) to High(residueMasses) do
    begin
      // Calculate the mass for the dipeptide mass
      diMass := (residueMasses[aa1Idx] + residueMasses[aa2Idx]);
      diPeptideIdx := aa1Idx + (residueCount * aa2Idx);
      diPeptides[diPeptideIdx].mass := diMass;
      SetLength(diPeptides[diPeptideIdx].residueIdxs, 2);
      diPeptides[diPeptideIdx].residueIdxs[0] := aa1Idx;
      diPeptides[diPeptideIdx].residueIdxs[1] := aa2Idx;

      for aa3Idx := Low(residueMasses) to High(residueMasses) do
      begin
        // Calculate the mass for the tripeptide mass
        triMass := (residueMasses[aa1Idx] + residueMasses[aa2Idx] + residueMasses[aa3Idx]);
        triPeptideIdx := aa1Idx + (residueCount * aa2Idx) + (residueCount * residueCount * aa3Idx);
        triPeptides[triPeptideIdx].mass := triMass;
        SetLength(triPeptides[triPeptideIdx].residueIdxs, 3);
        triPeptides[triPeptideIdx].residueIdxs[0] := aa1Idx;
        triPeptides[triPeptideIdx].residueIdxs[1] := aa2Idx;
        triPeptides[triPeptideIdx].residueIdxs[2] := aa3Idx;
      end;
    end;
  end;
end;

Procedure PruneFragmentIonList(var fragmentList: FragmentIonMasses);
var fragments: TList<string>;
   newFragments: FragmentIonMasses; fragStr: string; invalid: boolean;
begin
  SetLength(newFragments, 0);
  fragments := TList<string>.Create;

  for var i := Low(fragmentList) to High(fragmentList) do
  begin
    TArray.Sort<integer>(fragmentList[i].residueIdxs);
    //if fragmentList[i].residueIdxs[0] = 0 then continue;

    invalid := False;
    for var j := Low(fragmentList[i].residueIdxs) to High(fragmentList[i].residueIdxs) do
      if ResMassList[fragmentList[i].residueIdxs[j]].aaNum = 0 then  invalid := True;

    if invalid then continue;
    

    if Length(fragmentList[i].residueIdxs) = 2 then
      fragStr := Format('%d%d', [fragmentList[i].residueIdxs[0], fragmentList[i].residueIdxs[1]])
    else
      fragStr := Format('%d%d%d', [fragmentList[i].residueIdxs[0], fragmentList[i].residueIdxs[1], fragmentList[i].residueIdxs[2]]);

    // Check if the fragment already exists in the table, if so continue
    if fragments.IndexOf(fragStr) <> -1 then
      continue;


    SetLength(newFragments, Length(newFragments)+1);
    fragments.Add(fragStr);

    newFragments[High(newFragments)].mass := fragmentList[i].mass;
    newFragments[High(newFragments)].residueIdxs := fragmentList[i].residueIdxs;
  end;

  fragmentList := newFragments;

end;

Procedure GenerateResiduePermutations(var fragmentList: FragmentIonMasses);
var rawPermutations, permutations: TArray<TArray<integer>>;
    usedPermutations: TList<TArray<integer>>;
begin
  for var fragIdx := Low(fragmentList) to High(fragmentList) do
  begin

    rawPermutations := GetPermutations(fragmentList[fragIdx].residueIdxs);

    usedPermutations := TList<TArray<integer>>.Create;
    SetLength(permutations, 0);
    for var permIdx := Low(rawPermutations) to High(rawPermutations) do
    begin
      if usedPermutations.IndexOf(rawPermutations[permIdx]) <> -1 then
        continue;

      usedPermutations.Add(rawPermutations[permIdx]);
      SetLength(permutations, Length(permutations)+1);
      permutations[High(permutations)] := rawPermutations[permIdx];
    end;

    fragmentList[fragIdx].resIdxPermutations := permutations;
  end;
end;
begin
  // Generate all possible masses
  GeneratePossibleMasses();

  // Prune the fragment ion list, so only unique are found
  PruneFragmentIonList(diPeptides);
  PruneFragmentIonList(triPeptides);

  // Create permutated residues for each fragment
  GenerateResiduePermutations(diPeptides);
  GenerateResiduePermutations(triPeptides);

  result.immoniumIons := immoIons;
  result.diPeptideMasses := diPeptides;
  result.triPeptideMasses := triPeptides;
end;

Function GetPermutations(ASet: TArray<integer>): TArray<TArray<integer>>;
{ Copied from https://github.com/GolezTrol/delphi-aoc-2019/blob/main/source/Solvers/Permutation.pas}
var index: Integer;

procedure Swap(var a, b: integer); inline;
var
  c: Integer;
begin
  c := a;
  a := b;
  b := c;
end;

procedure Generate(k: Integer; A: TArray<integer>);
var
  i: Integer;
begin
  // Heap's algorithm for determining permutations
  // https://en.wikipedia.org/wiki/Heap%27s_algorithm
  if k = 1 then
  begin
    Result[Index] := Copy(A, 0, Length(A));
    Inc(Index);
  end
  else
  begin
    // Generate permutations with kth unaltered
    // Initially k == length(A)
    Generate(k - 1, A);

    // Generate permutations for kth swapped with each k-1 initial
    for i := 0 to k-2 do
    begin
      // Swap choice dependent on parity of k (even or odd)
      if not Odd(k) then
        Swap(A[i], A[k-1]) // zero-indexed, the kth is at k-1
      else
        Swap(A[0], A[k-1]);
      Generate(k - 1, A)
    end;
  end;
end;

var i, k, Count: Integer;
begin
k := Length(ASet);
// Number of permutations is the factorial of the length of the set
Count := 1;
for i := 2 to k do
  Count := Count * i;
SetLength(Result, Count);

Index := 0;

Generate(k, ASet);
end;


{-----------------------------------------------------------------------------}
Procedure GenerateSequenceIds(var sequences: DNSequenceSeriesTags);
var modIdx: integer; modStr: string;
begin
for var i := Low(sequences) to High(sequences) do
begin
  if Length(sequences[i].modifications) > 0 then
    begin
      for modIdx := Low(sequences[i].modifications) to High(sequences[i].modifications) do
      begin
        modStr := Format('%s%s', [modStr, sequences[i].modifications[modIdx].modString]);
      end;
    end
    else
    begin
      modStr := 'None';
    end;


  sequences[i].id := Format('%s_%s_%d', [sequences[i].tag.seq1Let, modStr,
                                         sequences[i].precursorCharge]);
end;
end;

Procedure GeneratePossibleDeNovoSequences(var sequences: DNSequenceSeriesTags; seriesSequences: DNSequenceSeriesTags; nlIons: NeutralLossIons; fragIons: FragmentIons; immIons: ImmoniumIons);
begin
  for var i := Low(seriesSequences) to High(seriesSequences) do
  begin
    // Copy the supporting ions
    SetLength(sequences[i].neutralLossIons, Length(nlIons));
    sequences[i].neutralLossIons := Copy(nlIons, 0, Length(nlIons));

    SetLength(sequences[i].fragments, Length(fragIons));
    sequences[i].fragments := Copy(fragIons, 0, Length(fragIons));

    SetLength(sequences[i].neutralLossIons, Length(nlIons));
    sequences[i].neutralLossIons := Copy(nlIons, 0, Length(nlIons));
  end;
  GenerateSequenceIds(sequences);

end;

{-----------------------------------------------------------------------------}
Procedure FindResidueCandidates(spectrum: msmsSpectrum; valueIndex: integer; precision: real; var candidates: DeNovoResCandidates; logWindow : TFormLog;
                                selectNMostIntenseCandidates: integer; autoDeNovo: boolean = False);
var i, count : integer; diff : real;
Procedure SetBasePeak(spectrum: msmsSpectrum; serPoint: integer; var pkPoint : Residue);
begin
  pkPoint := Default(Residue);

  pkPoint.peakIdx := serPoint;
  pkPoint.mz := spectrum[serPoint].mz;
  pkPoint.int := spectrum[serPoint].int;
end;
Procedure SetPeakPoint (spectrum: msmsSpectrum; lvl, serPoint, idx : integer; massDeviation: real; var pkPoint : Residue);
begin
  with pkPoint do
  begin
    level := lvl;
    peakIdx := serPoint;
    mz := spectrum[serPoint].mz;
    int := spectrum[serPoint].int;
    aaNum := ResMassList[idx].aaNum;
    resIdx := idx;
    massDeviation := RoundTo(massDeviation, -4);

    res1 := ResMassList[idx].res1;
    res3 := ResMassList[idx].res3;
    res1mod := ResMassList[idx].res1mod;
    res3mod := ResMassList[idx].res3mod;
    mass := ResMassList[idx].mass;
  end;
end;

Procedure FindPeakPoints (spectrum: msmsSpectrum; idx : integer; diff : real; precision: real; var DNr : DeNovoResArray; var count : integer);
var i, j : integer;
begin
  if (spectrum[idx].available = False) and (autoDeNovo = False) then
    Exit;
  if count < topDN then
    for j := 1 to High(ResMassList) do
      if (Abs (ResMassList[j].mass - diff) < precision) and (count < topDN) then
        begin
          FInc (count);
          SetPeakPoint (spectrum, count, idx, j, (ResMassList[j].mass - diff), DNr [count]);
        end;
  for i := 1 to count - 1 do
    for j := 1 + 1 to count do
      if DNr [i].int < DNr [j].int then
        ExchangeStructs (DNr [i], DNr [j], SizeOf (DNr [j]));
  for i := 1 to count do
    DNr [i].level := i;
end;

Procedure FilterCandidates(direction: integer);
var i: integer;
begin;
  // Blank out the candidates below the lis of most intense peaks
  for i := selectNMostIntenseCandidates + 1 to High(candidates.newPks[direction]) do
  begin
    //
    if candidates.newPks[direction][i].aaNum = candidates.newPks[direction][i-1].aaNum then
      continue;
    candidates.newPks[direction][i] := Default(Residue);
  end;
end;

begin
  FillChar (candidates, SizeOf (candidates), 0);
  candidates.Enabled := True;
  // Get the base peak
  SetBasePeak(spectrum, valueindex, candidates.basePks);
  // Loop over the peaks before the base peak
  count := 0;
  for i := 0 to valueIndex - 1 do
  begin
    diff := candidates.basePks.mz - spectrum[i].mz;
    FindPeakPoints (spectrum, i, diff, precision, candidates.newPks [1], count);
  end;
  // Loop over the peaks before the base peak
  count := 0;
  for i := valueIndex + 1 to Length(spectrum) - 1 do
  begin
    diff := spectrum[i].mz - candidates.basePks.mz;
    FindPeakPoints (spectrum, i, diff, precision, candidates.newPks [2], count);
  end;

  FilterCandidates(1);
  FilterCandidates(2);
end;
{-----------------------------------------------------------------------------}

Function CalculateMassDeviation(peak1mz: real; peak2mz: real; resIdx: integer): real;
var experimentalMass, theoreticalMass: real;
begin
  experimentalMass := peak2Mz - peak1mz;
  theoreticalMass := ResMassList[resIdx].mass;
  result := theoreticalMass - experimentalMass;
end;

end.
