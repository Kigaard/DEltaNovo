unit DNovoSequencer;

interface

uses System.Generics.Collections, SysUtils, System.Classes, DeNovoRecords, System.Math, StrUtils,
     Globals, General, GeneralUtils, SpectraUtils, DeNovoSequencingUtils, DeNovoScoringUtils, LogForm;

type
  TagGraphNode = record
    nodeIdx, prevNodeIdx: integer;
    peakIdx: integer;
  end;

  TagGraphEdge = record
    node1Idx, node2Idx: integer;
    isUpDirection: boolean;
    resIdx: integer;
    aaNum: integer;
    res1 : string;
    res3 : string;
    res1Mod : string;
    res3Mod : string;
    massDeviation: real;
  end;

  TagGraph = record
    nodes: array of TagGraphNode;
    edges: array of TagGraphEdge;
    possibleTagEdges: array of array of integer;
  end;

  BiDirectionalTagGraph = record
    mainPeakIdx: integer;
    upDirection: TagGraph;
    downDirection: TagGraph;
    possibleTagEdges: array of array of TagGraphEdge;
  end;

  BiDirectionalTagGraphs = array of BiDirectionalTagGraph;

  SeriesWorkingData = record
    name: string;
    isNTerm: boolean;
    spectrumData: msmsSpectrumData;
    charge: integer;

    neutralLossIons: NeutralLossIons;
    fragmentIons: FragmentIons;
    immoniumIons: ImmoniumIons;

    sequenceTagGraphs: BiDirectionalTagGraphs;

    sequenceTags: DNSequenceSeriesTags
  end;

  TDeNovoSequencer = class
    private
      UNUSED_INT: integer;

      logWindow: TFormLog;

      { ---- Settings ----- }
      precision: real;
      settings: SequencerSettings;
      dnSettings: AutoDeNovoSeqSettings;

      { ----- Working data ----- }
      ionMasses: IonMassList;

      basisNSeriesData: SeriesWorkingData;
      modifiedNSeriesData: SeriesWorkingData;
      basisCSeriesData: SeriesWorkingData;
      modifiedCSeriesData: SeriesWorkingData;
      combinedNSeriesData: SeriesWorkingData;
      combinedCSeriesData: SeriesWorkingData;

      { ----- Output ----- }
      sequences: DNSequenceTags;

    private
      Procedure ClearWorkingData();
      Procedure ClearOutputData();

      Procedure SequenceSeries(var workingData: SeriesWorkingData);

      Procedure FindNeutralLossIons(var data: SeriesWorkingData);
      Procedure GenerateSequenceTagGraphs(var data: SeriesWorkingData);
      Procedure TraverseSequenceTagGraphs(var data: SeriesWorkingData);

      Procedure FindFragmentImmoniumIons(var data: SeriesWorkingData);

      Procedure EnsureTagCompleteness(var data: SeriesWorkingData);

      procedure RemoveDuplicateTags(var seqTags: DNSequenceSeriesTags);
      procedure UpdateSequenceTags(var data: SeriesWorkingData);

      Procedure CleanupWorkingData(var data: SeriesWorkingData);
      procedure CombineNCTerminalTags;

      Procedure Score();

      { Utility methods }
      Procedure GetPeakIndicesFromEdge(spectrum: msmsSpectrum; graph: BiDirectionalTagGraph; edge: TagGraphEdge;
                                        var peak1IdxInt: integer; var peak2IdxInt: integer; var peak1Idx: integer; var peak2Idx: integer);
      Function CalculateMassDeviation(spectrum: msmsSpectrumData; internStartPeakIdx: integer; internEndPeakIdx: integer; tag: SequenceTag; terminusMass: real; remainResMass: real): real;
      Procedure CreateDNSeqArray();
    public
      Constructor Create; overload;
      Destructor Destroy; override;
      Procedure InitSequencer(genSettings: SequencerSettings; autoDnSettings: AutoDeNovoSeqSettings; logWin: TFormLog);
      Function PerformSequencing() : DNSequenceTags;
  end;


implementation

{ TDeNovoSequencer }

Constructor TDeNovoSequencer.Create;
begin
  inherited;
end;

Destructor TDeNovoSequencer.Destroy;
begin
  // Clear ion mass table
  ionMasses := Default(IonMassList);
  // Clear the working data
  ClearWorkingData();
  // Clear the output data
  ClearOutputData();
  inherited;
end;

Procedure TDeNovoSequencer.InitSequencer(genSettings: SequencerSettings; autoDnSettings: AutoDeNovoSeqSettings; logWin: TFormLog);
Function CreateWorkingSeriesData(name: string; isNTerm: boolean; spec: msmsSpectrumData) : SeriesWorkingData;
var data: SeriesWorkingData;
begin
  data.name := name;
  data.isNTerm := isNTerm;
  data.spectrumData := spec;
  data.charge := spec.header.charge;
  data.neutralLossIons := nil;
  data.sequenceTagGraphs := nil;
  data.fragmentIons := nil;
  data.immoniumIons := nil;
  Result := data;
end;
var spectra: spectraList;
begin
  ionMasses := CalculateIonMasses();
  settings := genSettings;
  dnSettings := autoDnSettings;
  logWindow := logWin;

  precision := settings.precision;
  SetLength(sequences, 0);

  // Extract ion series
  spectra := ExtractSpectra(settings.fullSpectrum);

  // Create the series
  basisNSeriesData := CreateWorkingSeriesData('Basis N-terminal', True, spectra.basisN);
  modifiedNSeriesData:= CreateWorkingSeriesData('Modified N-terminal', True, spectra.modN);
  basisCSeriesData:= CreateWorkingSeriesData('Basis C-terminal', False, spectra.basisC);
  modifiedCSeriesData:= CreateWorkingSeriesData('Modified C-terminal', False, spectra.modC);

  combinedNSeriesData:= CreateWorkingSeriesData('Combined N-terminal', True, spectra.combinedN);
  combinedCSeriesData:= CreateWorkingSeriesData('Combined C-terminal', False, spectra.combinedC);
end;

{------------------------------------------------------------------------------}

Procedure TDeNovoSequencer.ClearWorkingData;
begin
  settings := Default(SequencerSettings);
  dnSettings := Default(AutoDeNovoSeqSettings);
  basisNSeriesData := Default(SeriesWorkingData);
  modifiedNSeriesData := Default(SeriesWorkingData);
  basisCSeriesData := Default(SeriesWorkingData);
  modifiedCSeriesData := Default(SeriesWorkingData);
  combinedNSeriesData := Default(SeriesWorkingData);
  combinedCSeriesData := Default(SeriesWorkingData);
end;

Procedure TDeNovoSequencer.ClearOutputData;
begin

end;

{------------------------------------------------------------------------------}

Function TDeNovoSequencer.PerformSequencing() : DNSequenceTags;
  { Perform the sequencing }
begin
  logWindow.AddHeader('De novo sequencing');

  { *** Perform sequencing *** }
  //SequenceSeries(basisNSeriesData);
  //SequenceSeries(modifiedNSeriesData);
  //SequenceSeries(basisCSeriesData);
  //SequenceSeries(modifiedCSeriesData);
  SequenceSeries(combinedNSeriesData);
  SequenceSeries(combinedCSeriesData);

  CombineNCTerminalTags;

  logWindow.AddLogMessage('Generated a total of %d possible sequences to be scored',
                          [Length(sequences)]);
  logWindow.AddHeader('Score the sequences');
  Score();

  CreateDNSeqArray();
  Result := sequences;
  logWindow.ClearSystemMessages;
  ClearWorkingData;
end;

Procedure TDeNovoSequencer.SequenceSeries(var workingData: SeriesWorkingData);
var count: integer;
begin
  logWindow.AddHeader(Format('**Sequence %s series**', [workingData.name]));

  if Length(workingData.spectrumData.spectrum) < 1 then
  begin
    logWindow.AddLogMessage('WARNING: The series is empty and is not sequenced. This could cause issues in the later steps.');
    Exit;
  end;

  { ** Find neutral loss ions ** }
  logWindow.AddHeader('Find neutral loss ions');
  FindNeutralLossIons(workingData);
  logWindow.AddLogMessage('Found %d possible neutral loss ion(s)',
                          [Length(workingData.neutralLossIons)]);

  { ** Find immonium and fragment ions ** }
  logWindow.AddHeader('Find fragment and immonium ions');
  FindFragmentImmoniumIons(workingData);
  logWindow.AddLogMessage('Found %d possible immonium ion(s)',
                          [Length(workingData.immoniumIons)]);
  logWindow.AddLogMessage('Found %d fragment(s)',
                          [Length(workingData.fragmentIons)]);

  { ** Generate the sequence tag graphs ** }
  logWindow.AddHeader('Generate sequence tag graphs');
  GenerateSequenceTagGraphs(workingData);
  logWindow.AddLogMessage('Generated %d sequence tag graphs',
                          [Length(workingData.sequenceTagGraphs)]);

  { ** Traverse sequence tag graphs to generate the possible sequence tags ** }
  logWindow.AddHeader('Traverse sequence tag graphs');
  TraverseSequenceTagGraphs(workingData);
  logWindow.AddLogMessage('Traversed %d graphs and generated %d sequence tags',
                          [Length(workingData.sequenceTagGraphs),
                           Length(workingData.sequenceTags)]);

  // Exit out of sequencing if no sequences are found
  if Length(workingData.sequenceTags) < 1 then
  begin
    CleanupWorkingData(workingData);
    Exit;
  end;

   { ** Remove duplicate sequences** }
  logWindow.AddHeader('Remove duplicate tags');
  GenerateSequenceIds(workingData.sequenceTags);
  count := Length(workingData.sequenceTags);
  RemoveDuplicateTags(workingData.sequenceTags);
  logWindow.AddLogMessage('Removed %d duplicate tags. %d unique tags left',
      [count - Length(workingData.sequenceTags), Length(workingData.sequenceTags)]);

  { ** Ensure connection between the series peaks over the whole spectrum ** }
// TODO: Find a better name. A bit better (EnsureTagConnectivity) but maybe to much assurance that it will find it?
  if dnSettings.ensureTagConnect then
  begin
    logWindow.AddHeader('Ensure connection between series peaks');
    count := Length(workingData.sequenceTags);
    EnsureTagCompleteness(workingData);
    logWindow.AddLogMessage('Tried to connect the tags in a series. Went from %d to %d tags', [count, Length(workingData.sequenceTags)]);

    { ** Remove duplicate sequences** }
    logWindow.AddHeader('Remove duplicate tags');
    GenerateSequenceIds(workingData.sequenceTags);
    count := Length(workingData.sequenceTags);
    RemoveDuplicateTags(workingData.sequenceTags);
    logWindow.AddLogMessage('Removed %d duplicate tags. %d unique tags left',
      [count - Length(workingData.sequenceTags), Length(workingData.sequenceTags)]);
  end;

  { ** Add data and update sequence information ** }
  logWindow.AddHeader('Add data to sequences and update sequence information');
  GeneratePossibleDeNovoSequences(workingData.sequenceTags, workingData.sequenceTags, workingData.neutralLossIons,
                                  workingData.fragmentIons, workingData.immoniumIons);
  UpdateSequenceTags(workingData);

  CleanupWorkingData(workingData);
end;

{------------------------------------------------------------------------------}

Procedure TDeNovoSequencer.FindNeutralLossIons(var data: SeriesWorkingData);
Procedure AddNeutralLossIon(lossPeakIdx: integer; lostFromPeakIdx: integer; lossType: integer; massDev: real);
var ionIdx: integer;
begin
  SetLength(data.neutralLossIons, Length(data.neutralLossIons)+1);
  ionIdx := High(data.neutralLossIons);
  data.neutralLossIons[ionIdx].peakIdx := data.spectrumData.spectrum[lossPeakIdx].peakIdx;
  data.neutralLossIons[ionIdx].lostFromPeakIdx :=  data.spectrumData.spectrum[lostFromPeakIdx].peakIdx;
  data.neutralLossIons[ionIdx].mz := data.spectrumData.spectrum[lostFromPeakIdx].mz;
  data.neutralLossIons[ionIdx].int := data.spectrumData.spectrum[lostFromPeakIdx].int;
  if data.isNTerm then data.neutralLossIons[ionIdx].ionType := 1
  else data.neutralLossIons[ionIdx].ionType := 2;

  data.neutralLossIons[ionIdx].lossType := lossType;
  data.neutralLossIons[ionIdx].massDeviation := RoundTo(massDev, -4);

  if Length(data.spectrumData.spectrum[lossPeakIdx].neutralLossIdx) < 1 then
    data.spectrumData.spectrum[lossPeakIdx].peakUsage := data.spectrumData.spectrum[lossPeakIdx].peakUsage + 4;
  SetLength(data.spectrumData.spectrum[lossPeakIdx].neutralLossIdx, Length(data.spectrumData.spectrum[lossPeakIdx].neutralLossIdx) + 1);
  data.spectrumData.spectrum[lossPeakIdx].neutralLossIdx[High(data.spectrumData.spectrum[lossPeakIdx].neutralLossIdx)] := ionIdx;

end;
Procedure FindNeutralLoss(mainPeakIdx: integer; lossType: integer; mass: real);
begin
  for var lossPeakIdx := Low(data.spectrumData.spectrum) to mainPeakIdx do
  begin
    if (Abs(data.spectrumData.spectrum[mainPeakIdx].mz - data.spectrumData.spectrum[lossPeakIdx].mz - mass)
        < precision) then
    begin
      logWindow.AddLogMessage('Neutral loss: Loss ion idx: %d (m/z %0.3f). Main ion idx: %d (m/z %0.3f). Mass: %0.3f. Diff: %0.3f.',
                              [data.spectrumData.spectrum[lossPeakIdx].peakIdx, data.spectrumData.spectrum[lossPeakIdx].mz, data.spectrumData.spectrum[mainPeakIdx].peakIdx,
                              data.spectrumData.spectrum[mainPeakIdx].mz, mass,
                              Abs(data.spectrumData.spectrum[mainPeakIdx].mz - data.spectrumData.spectrum[lossPeakIdx].mz - mass)], True);
      AddNeutralLossIon(lossPeakIdx, mainpeakIdx, lossType, (data.spectrumData.spectrum[mainPeakIdx].mz - data.spectrumData.spectrum[lossPeakIdx].mz - mass));
    end;
  end;

end;
var ammoniaLoss, waterLoss: real;
begin
  ammoniaLoss := CompositionToMonoMass('N1H3');
  waterLoss := CompositionToMonoMass('H2O1');

  for var i := Low(data.spectrumData.spectrum) to High(data.spectrumData.spectrum) do
  begin
    // Find neutral loss of ammonia (NH3 - 17)
    FindNeutralLoss(i, 17, ammoniaLoss);
    // Find neutral loss of ammonia (H2O - 18)
    FindNeutralLoss(i, 18, waterLoss);
  end;
end;

Procedure TDeNovoSequencer.FindFragmentImmoniumIons(var data: SeriesWorkingData);
Procedure FindImmoniumIons(i: integer);
var ionIdx, newIdx: integer;
begin
for ionIdx := Low(ionMasses.immoniumIons) to High(ionMasses.immoniumIons) do
  begin
    if Abs(data.spectrumData.spectrum[i].mz -
          ionMasses.immoniumIons[ionIdx].mass) < precision  then
    begin
      SetLength(data.immoniumIons, Length(data.immoniumIons) + 1);
      newIdx := High(data.immoniumIons);
      data.immoniumIons[newIdx].peakIdx := data.spectrumData.spectrum[i].peakIdx;
      data.immoniumIons[newIdx].mz := data.spectrumData.spectrum[i].mz;
      data.immoniumIons[newIdx].int := data.spectrumData.spectrum[i].int;
      data.immoniumIons[newIdx].aaNum := ionMasses.immoniumIons[ionIdx].aaNum;
      data.immoniumIons[newIdx].massDeviation :=
        RoundTo(data.spectrumData.spectrum[i].mz - ionMasses.immoniumIons[ionIdx].mass, -4);
      if Length(data.spectrumData.spectrum[i].immoniumIdx) < 1 then
        data.spectrumData.spectrum[i].peakUsage := data.spectrumData.spectrum[i].peakUsage + 8;
      SetLength(data.spectrumData.spectrum[i].immoniumIdx, Length(data.spectrumData.spectrum[i].immoniumIdx) + 1);
      data.spectrumData.spectrum[i].immoniumIdx[High(data.spectrumData.spectrum[i].immoniumIdx)] := newIdx;
    end;
  end;
end;

Procedure FindFragmentIons(i: integer; fragmentIonList: FragmentIonMasses);
var ionIdx, newIdx: integer;
begin
if (data.spectrumData.spectrum[i].mz < fragmentIonList[Low(fragmentIonList)].mass) or
    (data.spectrumData.spectrum[i].mz > fragmentIonList[High(fragmentIonList)].mass) then
    Exit;

for ionIdx := Low(fragmentIonList) to High(fragmentIonList) do
  begin
    if Abs(data.spectrumData.spectrum[i].mz -
            (fragmentIonList[ionIdx].mass + ProtonMs)) < precision  then
    begin
      SetLength(data.fragmentIons, Length(data.fragmentIons)+1);
      newIdx := High(data.fragmentIons);
      data.fragmentIons[newIdx].peakIdx := i;
      data.fragmentIons[newIdx].mz := data.spectrumData.spectrum[i].mz;
      data.fragmentIons[newIdx].int := data.spectrumData.spectrum[i].int;
      data.fragmentIons[newIdx].resIdxs := fragmentIonList[ionIdx].residueIdxs;
      data.fragmentIons[newIdx].resIdxPermutations := fragmentIonList[ionIdx].resIdxPermutations;
      data.fragmentIons[newIdx].massDeviation :=
       RoundTo(data.spectrumData.spectrum[i].mz - (fragmentIonList[ionIdx].mass + ProtonMs), -4);
      if Length(data.spectrumData.spectrum[i].fragmentIdx) < 1 then
        data.spectrumData.spectrum[i].peakUsage := data.spectrumData.spectrum[i].peakUsage + 2;
      SetLength(data.spectrumData.spectrum[i].fragmentIdx, Length(data.spectrumData.spectrum[i].fragmentIdx) + 1);
      data.spectrumData.spectrum[i].fragmentIdx[High(data.spectrumData.spectrum[i].fragmentIdx)] := newIdx;
    end;
  end;
end;
{ Find fragments and immonium ions. }
begin
  for var i := Low(data.spectrumData.spectrum) to High(data.spectrumData.spectrum) do
  begin
    FindImmoniumIons(i);
    FindFragmentIons(i, ionMasses.diPeptideMasses);
    FindFragmentIons(i, ionMasses.triPeptideMasses);
   end;
end;

{------------------------------------------------------------------------------}
Procedure TDeNovoSequencer.GenerateSequenceTagGraphs(var data: SeriesWorkingData);
Procedure AddNodeToGraph(var graph: TagGraph; peakIdx: integer; prevNodeIdx: integer);
var nodeIdx: integer;
begin
  SetLength(graph.nodes, Length(graph.nodes)+1);
  nodeIdx := High(graph.nodes);
  graph.nodes[nodeIdx].nodeIdx := nodeIdx;
  graph.nodes[nodeIdx].prevNodeIdx := prevNodeIdx;
  graph.nodes[nodeIdx].peakIdx := peakIdx;
end;

Procedure AddEdgeToGraph(var graph: TagGraph; node1Idx: integer; node2Idx: integer; resIdx: integer; massDeviation: real; isUpDir: boolean);
var edgeIdx: integer;
begin
  SetLength(graph.edges, Length(graph.edges)+1);
  edgeIdx := High(graph.edges);
  graph.edges[edgeIdx].node1Idx := node1Idx;
  graph.edges[edgeIdx].node2Idx := node2Idx;
  graph.edges[edgeIdx].resIdx := resIdx;
  graph.edges[edgeIdx].aaNum := ResMassList[resIdx].aaNum;
  graph.edges[edgeIdx].res1 := ResMassList[resIdx].res1;
  graph.edges[edgeIdx].res3 := ResMassList[resIdx].res3;
  graph.edges[edgeIdx].res1Mod := ResMassList[resIdx].res1Mod;
  graph.edges[edgeIdx].res3Mod := ResMassList[resIdx].res3Mod;
  graph.edges[edgeIdx].massDeviation := massDeviation;
  graph.edges[edgeIdx].isUpDirection := isUpDir;
end;

Function GetSequenceTag(mainPeakIdx: integer; direction: integer) : TagGraph;
var candidates: DeNovoResCandidates; peak, i: integer; checkCandidatePeakIdx: TList<integer>; prevCandidateNodeIdx : TList<integer>; resIdxs : TList<integer>; massDeviations : TList<real>;
    graph: TagGraph; prevNodeIdx, resIdx: integer; massDeviation: real; visitedPeaks : TList<integer>;
begin
  visitedPeaks := TList<integer>.Create;
  checkCandidatePeakIdx := TList<integer>.Create;
  prevCandidateNodeIdx := TList<integer>.Create;
  resIdxs := TList<integer>.Create;
  massDeviations := TList<real>.Create;

  AddNodeToGraph(graph, mainPeakIdx, -1);

  FindResidueCandidates(data.spectrumData.spectrum, mainPeakIdx, precision, candidates, logWindow, settings.showNMostIntenseCandidates, True);
  for i := Low(candidates.newPks[direction]) to High(candidates.newPks[direction]) do
  begin
    if (candidates.newPks[direction][i].aaNum = 0) then break;

    logWindow.AddLogMessage('Peak candidate to visit: Index: %d. mz: %0.3f. Intensity: %0.3f. Residue: %d (%s. %s)', [candidates.newPks[direction][i].peakIdx, candidates.newPks[direction][i].mz,
    candidates.newPks[direction][i].int, candidates.newPks[direction][i].resIdx, candidates.newPks[direction][i].res1Mod, candidates.newPks[direction][i].res3Mod], True);
    checkCandidatePeakIdx.Insert(0, candidates.newPks[direction][i].peakIdx);
    prevCandidateNodeIdx.Insert(0, 0);
    resIdxs.Insert(0, candidates.newPks[direction][i].resIdx);
    massDeviations.Insert(0, candidates.newPks[direction][i].massDeviation);
  end;

  while checkCandidatePeakIdx.Count > 0 do
  begin
    if Length(graph.nodes) mod 100 = 0 then
    begin
      logWindow.AddLogMessage('Main peak m/z: %0.3f: Found %d nodes',
        [data.spectrumData.spectrum[mainPeakIdx].mz, Length(graph.nodes)]);
    end;

    if Length(graph.nodes) mod 500 = 0 then
      logWindow.ClearSystemMessages;


    // Get the first element and remove it from the list
    peak := checkCandidatePeakIdx[0]; checkCandidatePeakIdx.Delete(0);
    prevNodeIdx := prevCandidateNodeIdx[0]; prevCandidateNodeIdx.Delete(0);
    resIdx := resIdxs[0]; resIdxs.Delete(0);
    massDeviation := massDeviations[0]; massDeviations.Delete(0);

    visitedPeaks.Add(peak);
    data.spectrumData.spectrum[peak].tempTag := True;

    // Add the new node to the graph and create an edge
    AddNodeToGraph(graph, peak, prevNodeIdx);
    AddEdgeToGraph(graph, prevNodeIdx, High(graph.nodes), resIdx, massDeviation, direction = 2);
    logWindow.AddLogMessage('Visit peak candidate: Index: %d. m/z: %0.3f. Intensity: %0.3f. Current node index: %d. Previous node index: %d',
      [data.spectrumData.spectrum[peak].peakIdx, data.spectrumData.spectrum[peak].mz, data.spectrumData.spectrum[peak].int, High(graph.nodes), prevNodeIdx], True);


    // Find the residue candidates and add them to the list of candidate to check. Only add if not already in the list and the residue is valid.
    FindResidueCandidates(data.spectrumData.spectrum, peak, precision, candidates, logWindow, settings.showNMostIntenseCandidates, True);
    for i := Low(candidates.newPks[direction]) to High(candidates.newPks[direction]) do
    begin
      if (candidates.newPks[direction][i].aaNum = 0) then break;

      logWindow.AddLogMessage('Peak candidate to visit: Index: %d. mz: %0.3f. Intensity: %0.3f. Residue: %d (%s. %s)', [candidates.newPks[direction][i].peakIdx, candidates.newPks[direction][i].mz,
      candidates.newPks[direction][i].int, candidates.newPks[direction][i].aaNum, candidates.newPks[direction][i].res1, candidates.newPks[direction][i].res3], True);
      checkCandidatePeakIdx.Insert(0, candidates.newPks[direction][i].peakIdx);
      prevCandidateNodeIdx.Insert(0, High(graph.nodes));
      resIdxs.Insert(0, candidates.newPks[direction][i].resIdx);
      massDeviations.Insert(0, candidates.newPks[direction][i].massDeviation);
    end;
  end;

  Result := graph;
end;

{ Generate the sequence tags. }
var mainPeak: integer; downTagGraph, upTagGraph: TagGraph; i: integer; tagAdded: boolean; mainPeakI: integer;
begin
  mainPeak := 0;
  mainPeakI := 0;
  tagAdded := false;
  while (mainPeak <> -1) and (mainPeakI < dnSettings.maxMainPeaks) do
  begin
    // Get the most intense unused peak
    mainPeak := GetIndexOfMostIntensePeak(data.spectrumData.spectrum, True);
    if mainPeak = -1 then
      break;

    data.spectrumData.spectrum[mainPeak].tempTag := True;
    data.spectrumData.spectrum[mainPeak].mainTag := True;
    logWindow.AddLogMessage('Get tags from the main peak (Index: %d. m/z %0.3f) and up',
                            [data.spectrumData.spectrum[mainPeak].peakIdx,  data.spectrumData.spectrum[mainPeak].mz], True);
    upTagGraph := GetSequenceTag(mainPeak, 2); // Get the peaks up (Higher m/z)
    logWindow.AddLogMessage('Get tags from the main peak (Index: %d. m/z %0.3f) and down',
                            [data.spectrumData.spectrum[mainPeak].peakIdx,  data.spectrumData.spectrum[mainPeak].mz], True);
    downTagGraph := GetSequenceTag(mainPeak, 1); // Get the peaks down (Lower m/z)

    // If tag is found in at least one direction add it to the list.
    if (Length(upTagGraph.nodes) > 1) or (Length(downTagGraph.nodes) > 1) then
    begin
      logWindow.AddLogMessage('Found sequence tag with main peak m/z: %0.3f (%0.3f)',
                              [data.spectrumData.spectrum[mainPeak].mz,  data.spectrumData.spectrum[mainPeak].int]);
      SetLength(data.sequenceTagGraphs, Length(data.sequenceTagGraphs)+1);
      data.sequenceTagGraphs[High(data.sequenceTagGraphs)].mainPeakIdx := mainPeak;
      data.sequenceTagGraphs[High(data.sequenceTagGraphs)].upDirection := upTagGraph;
      data.sequenceTagGraphs[High(data.sequenceTagGraphs)].downDirection := downTagGraph;
      tagAdded := True;
    end;

    // Loop over the peaks and if the tag is added and the peak is used, the peak is marked as used.
    for i := Low(data.spectrumData.spectrum) to High(data.spectrumData.spectrum) do
    begin
      if data.spectrumData.spectrum[i].tempTag and tagAdded then
      begin
        SetLength(data.spectrumData.spectrum[i].tagIdx, Length(data.spectrumData.spectrum[i].tagIdx)+1);
        data.spectrumData.spectrum[i].tagIdx[High(data.spectrumData.spectrum[i].tagIdx)] := High(data.sequenceTagGraphs);

        if (Length(data.spectrumData.spectrum[i].tagIdx) < 1) and ((data.spectrumData.spectrum[i].peakUsage mod 2) = 0) then
          data.spectrumData.spectrum[i].peakUsage := data.spectrumData.spectrum[i].peakUsage + 1;
      end;
      data.spectrumData.spectrum[i].tempTag := False;
    end;
    tagAdded := False;
    Inc(mainPeakI);
  end;
end;

{------------------------------------------------------------------------------}

Procedure TDeNovoSequencer.TraverseSequenceTagGraphs(var data: SeriesWorkingData);
Function FindLeafNodes(graph: TagGraph) : TList<integer>;
var nodeIdx, edgeIdx: integer; nodeEdgeCount: integer;
    leafNodes: TList<integer>;
begin
  leafNodes := TList<integer>.Create;
  // 1 instead of Low(graph.nodes) as we don't want the root node to be classified as a leaf node. Even though it technically is.
  for nodeIdx := 1 to High(graph.nodes) do
  begin
    nodeEdgeCount := 0;
    for edgeIdx := Low(graph.edges) to High(graph.edges) do
    begin
      if (graph.nodes[nodeIdx].nodeIdx = graph.edges[edgeIdx].node1Idx) or
      (graph.nodes[nodeIdx].nodeIdx = graph.edges[edgeIdx].node2Idx) then
      begin
        Inc(nodeEdgeCount);
        if nodeEdgeCount > 1 then
          break;
      end;
    end;

    if nodeEdgeCount = 1 then
      leafNodes.Add(graph.nodes[nodeIdx].nodeIdx);

  end;
  Result := leafNodes;
end;

Procedure ReverseEdgeArray(var edges: array of integer);
var temp: integer;
begin
	if Length(edges) > 0 then
	begin
		for var i := Low(edges) to High(edges) div 2 do
		begin
			temp := edges[i];
			edges[i] := edges[High(edges) - i];
			edges[High(edges) - i] := temp;
		end;
	end;
end;

Procedure CreateSequence(var graph: TagGraph; nodeIdx: integer; upDirectionSequence: boolean);
var edgeIdx, prevNodeIdx: integer;
begin
  SetLength(graph.possibleTagEdges, Length(graph.possibleTagEdges) + 1);
  edgeIdx := High(graph.possibleTagEdges);
  while nodeIdx <> -1 do
  begin

    prevNodeIdx := graph.nodes[nodeIdx].prevNodeIdx;
    if prevNodeIdx = -1 then
      break;
    for var i := Low(graph.edges) to High(graph.edges) do
    begin
      if (prevNodeIdx = graph.edges[i].node1Idx) and (nodeIdx = graph.edges[i].node2Idx) then
      begin
        SetLength(graph.possibleTagEdges[edgeIdx], Length(graph.possibleTagEdges[edgeIdx])+1);
        graph.possibleTagEdges[edgeIdx][High(graph.possibleTagEdges[edgeIdx])] := i;
        break;
      end;
    end;
    nodeIdx := prevNodeIdx;
  end;

  if upDirectionSequence then
    ReverseEdgeArray(graph.possibleTagEdges[edgeIdx]);
end;

Procedure TraverseTagGraph(var graph: TagGraph; upDirSequence: boolean);
var leafNodes: TList<integer>;
begin
  leafNodes := FindLeafNodes(graph);
  for var idx in leafNodes do
  begin
    CreateSequence(graph, idx, upDirSequence);
  end;
end;

Procedure CombineGraphDirections(var graph: BiDirectionalTagGraph; graphIdx: integer);
var i, j, downTagIdx, upTagIdx, tagIdx: integer; tagLength, downTagLength: integer;
    downTagsEdges, upTagsEdges: array of array of integer;
    freePeaks: TList<integer>;
begin
  begin
    // Copy arrays into a temporary variable, which is easier to work with
    SetLength(downTagsEdges, Length(graph.downDirection.possibleTagEdges));
    for i := Low(graph.downDirection.possibleTagEdges) to High(graph.downDirection.possibleTagEdges) do
    begin
      SetLength(downTagsEdges[i], Length(graph.downDirection.possibleTagEdges[i]));
      for j := Low(graph.downDirection.possibleTagEdges[i]) to High(graph.downDirection.possibleTagEdges[i]) do
        downTagsEdges[i][j] := graph.downDirection.possibleTagEdges[i][j];
    end;

    SetLength(upTagsEdges, Length(graph.upDirection.possibleTagEdges));
    for i := Low(graph.upDirection.possibleTagEdges) to High(graph.upDirection.possibleTagEdges) do
    begin
      SetLength(upTagsEdges[i], Length(graph.upDirection.possibleTagEdges[i]));
      for j := Low(graph.upDirection.possibleTagEdges[i]) to High(graph.upDirection.possibleTagEdges[i]) do
        upTagsEdges[i][j] := graph.upDirection.possibleTagEdges[i][j];
    end;

    // Create the list of peaks to free.
    freePeaks := TList<integer>.Create;
    // Loop over the tags from both directions. Max is used to ensure at least one loop eventhough the direction is empty.
    for downTagIdx := Low(downTagsEdges) to Max(0, High(downTagsEdges)) do
    for upTagIdx := Low(upTagsEdges) to Max(0, High(upTagsEdges)) do
    begin
      SetLength(graph.possibleTagEdges, Length(graph.possibleTagEdges) + 1);
      tagIdx := High(graph.possibleTagEdges);
      tagLength := 0;

     // Calculate and set the tag length
     if Length(downTagsEdges) < 1 then
       begin
         tagLength := tagLength + 0;
         downTagLength := 0
       end
     else
       begin
         tagLength := tagLength + Length(downTagsEdges[downTagIdx]);
         downTagLength := Length(downTagsEdges[downTagIdx]);
       end;

     if Length(upTagsEdges) < 1 then
       tagLength := tagLength + 0
     else
       tagLength :=  tagLength + Length(upTagsEdges[upTagIdx]);

     SetLength(graph.possibleTagEdges[tagIdx], tagLength);

      // Add the two directions together
      if Length(downTagsEdges) > 0 then
      begin
        for i := Low(downTagsEdges[Max(0, downTagIdx)]) to High(downTagsEdges[Max(0, downTagIdx)]) do
        begin
          graph.possibleTagEdges[tagIdx][i] :=
            graph.downDirection.edges[downTagsEdges[Max(0, downTagIdx)][i]];
        end;
      end;

      if Length(upTagsEdges) > 0 then
      begin
        for i := Low(upTagsEdges[Max(0, upTagIdx)]) to High(upTagsEdges[Max(0, upTagIdx)]) do
        begin
          graph.possibleTagEdges[tagIdx][downTagLength + i] := graph.upDirection.edges[upTagsEdges[Max(0, upTagIdx)][i]];
        end;
      end;
    end;
  end;
end;

Procedure ResolveTags(var graph: BiDirectionalTagGraph);
var tagIdx, seqTagIdx, resIdx, resModIdx: integer; tagResIdxs: array of integer; seqTag: DNSequenceSeriesTag;
    currentEdge: TagGraphEdge; internalPeakIdx, internalPeakIdxEnd: integer;
begin
  for tagIdx := Low(graph.possibleTagEdges) to High(graph.possibleTagEdges) do
  begin
    if Length(graph.possibleTagEdges[tagIdx]) < 1 then
      continue;

    SetLength(data.sequenceTags, Length(data.sequenceTags)+1);
    seqTagIdx := High(data.sequenceTags);

    seqTag := Default(DNSequenceSeriesTag);
    SetLength(tagResIdxs, Length(graph.possibleTagEdges[tagIdx]));
    SetLength(seqTag.tempResidues, Length(graph.possibleTagEdges[tagIdx])+1);
    SetLength(seqTag.modifications, 0);

    // Go through the residues and add them to the tag
    for resIdx := Low(graph.possibleTagEdges[tagIdx]) to High(graph.possibleTagEdges[tagIdx]) do
    begin
      currentEdge := graph.possibleTagEdges[tagIdx][resIdx];
      tagResIdxs[resIdx] := currentEdge.resIdx;
      //GetPeakIndicesFromEdge(data.spectrumData.spectrum, graph, currentEdge, UNUSED_INT, internalPeakIdx, UNUSED_INT, seqTag.tempResidues[resIdx + 1].peakIdx); // TODO: Get the correct peak
      GetPeakIndicesFromEdge(data.spectrumData.spectrum, graph, currentEdge, internalPeakIdx, UNUSED_INT, seqTag.tempResidues[resIdx].peakIdx, UNUSED_INT); // TODO: Get the correct peak
      seqTag.tempResidues[resIdx].internPeakId := internalPeakIdx;
      seqTag.tempResidues[resIdx].aaNum := currentEdge.aaNum;
      seqTag.tempResidues[resIdx].resIdx := currentEdge.resIdx;
      seqTag.tempResidues[resIdx].res1 := currentEdge.res1;
      seqTag.tempResidues[resIdx].res3 := currentEdge.res3;
      seqTag.tempResidues[resIdx].res1Mod := currentEdge.res1Mod;
      seqTag.tempResidues[resIdx].res3Mod := currentEdge.res3Mod;
      seqTag.tempResidues[resIdx].massDeviation := currentEdge.massDeviation;
      seqTag.tempResidues[resIdx].mz := data.spectrumData.spectrum[internalPeakIdx].mz;
      seqTag.tempResidues[resIdx].int := data.spectrumData.spectrum[internalPeakIdx].int;

      // Add Residue modification
      if ResMassList[currentEdge.resIdx].modified then
      begin
        SetLength(seqTag.modifications, Length(seqTag.modifications)+1);
        resModIdx := High(seqTag.modifications);
        seqTag.modifications[resModIdx].modification := ResMassList[currentEdge.resIdx].modName;
        seqTag.modifications[resModIdx].position := resIdx + 1;
        seqTag.modifications[resModIdx].residue := ResMassList[currentEdge.resIdx].res1;
        seqTag.modifications[resModIdx].massChange := ResMassList[currentEdge.resIdx].massChange;
        seqTag.modifications[resModIdx].modString := Format('%s%d(%s%0.3f)', [ResMassList[currentEdge.resIdx].res1, seqTag.modifications[resModIdx].position,
                                                                              Signs[Sign(ResMassList[currentEdge.resIdx].massChange)], ResMassList[currentEdge.resIdx].massChange]);
      end;
    end;

    seqTag.mainPeakIdx := data.spectrumData.spectrum[graph.mainPeakIdx].peakIdx;
    seqTag.precursorCharge := data.spectrumData.header.charge;
    seqTag.tag := GetSequenceTag(tagResIdxs, seqTag.precursorCharge{, data.isNTerm = False});

    // Get the first and the last peak
    GetPeakIndicesFromEdge(data.spectrumData.spectrum, graph, graph.possibleTagEdges[tagIdx][Low(graph.possibleTagEdges[tagIdx])], internalPeakIdx, UNUSED_INT, seqTag.startPeakIdx, UNUSED_INT);
    GetPeakIndicesFromEdge(data.spectrumData.spectrum, graph, graph.possibleTagEdges[tagIdx][High(graph.possibleTagEdges[tagIdx])], UNUSED_INT, internalPeakIdxEnd, UNUSED_INT, seqTag.endPeakIdx);
    seqTag.internStartPeakIdx := internalPeakIdx;
    seqTag.internEndPeakIdx := internalPeakIdxEnd;

    seqTag.tempResidues[0].peakIdx := data.spectrumData.spectrum[internalPeakIdx].peakIdx;


    // Add empty residue in the last part of the temp residues list to get last part of sequence
    seqTag.tempResidues[High(seqTag.tempResidues)].peakIdx := data.spectrumData.spectrum[internalPeakIdxEnd].peakIdx;
    seqTag.tempResidues[High(seqTag.tempResidues)].internPeakId := internalPeakIdxEnd;
    seqTag.tempResidues[High(seqTag.tempResidues)].mz := data.spectrumData.spectrum[internalPeakIdxEnd].mz;
    seqTag.tempResidues[High(seqTag.tempResidues)].int := data.spectrumData.spectrum[internalPeakIdxEnd].int;
    seqTag.tempResidues[High(seqTag.tempResidues)].aaNum := 0;
    seqTag.tempResidues[High(seqTag.tempResidues)].res1 := #0;
    seqTag.tempResidues[High(seqTag.tempResidues)].res3 := '';

    data.sequenceTags[seqTagIdx] := seqTag;
     logWindow.AddLogMessage('Tag %d resolved. Sequence: %s. Start peak: %d (%0.3f). End peak %d (%0.3f). Difference: %0.3f.',
      [seqTagIdx, seqTag.tag.seq1Let, seqTag.startPeakIdx, data.spectrumData.spectrum[internalPeakIdx].mz, seqTag.endPeakIdx, data.spectrumData.spectrum[internalPeakIdxEnd].mz, seqTag.massDeviation], True);

    if (seqTagIdx mod 100 = 0) and (seqTagIdx <> 0) then
      logWindow.AddLogMessage('Resolved %d tags', [seqTagIdx]);
    if seqTagIdx mod 500 = 0 then
      logWindow.ClearSystemMessages;
  end;
end;

begin
  // Loop over the tag graphs
  for var seqTagGraphIdx := Low(data.sequenceTagGraphs) to High(data.sequenceTagGraphs) do
  begin
    // If there are tag edges in the directions, traverse it.
    if Length(data.sequenceTagGraphs[seqTagGraphIdx].downDirection.edges) > 0 then
      begin
        logWindow.AddLogMessage('--Traverse tag graph %d in down direction--', [seqTagGraphIdx], True);
        TraverseTagGraph(data.sequenceTagGraphs[seqTagGraphIdx].downDirection, False);
      end
    else
      begin
        logWindow.AddLogMessage('--Tag graph %d is empty in down direction--', [seqTagGraphIdx], True);
      end;

    if Length(data.sequenceTagGraphs[seqTagGraphIdx].upDirection.edges) > 0 then
      begin
        logWindow.AddLogMessage('--Traverse tag graph %d in up direction--', [seqTagGraphIdx], True);
        TraverseTagGraph(data.sequenceTagGraphs[seqTagGraphIdx].upDirection, True);
      end
    else
      begin
        logWindow.AddLogMessage('--Tag graph %d is empty in up direction--', [seqTagGraphIdx], True);
      end;

    // Combine the direction in all the possible combinations
    logWindow.AddLogMessage('--Combine the tag graph %d--', [seqTagGraphIdx], True);
    CombineGraphDirections(data.sequenceTagGraphs[seqTagGraphIdx], seqTagGraphIdx);
    // Resolve the tags. Convert it from edges and nodes to actual tags.
    logWindow.AddLogMessage('--Resolve the tag graph %d--', [seqTagGraphIdx], True);
    ResolveTags(data.sequenceTagGraphs[seqTagGraphIdx]);

    logWindow.ClearSystemMessages;
  end;
end;
{------------------------------------------------------------------------------}

procedure TDeNovoSequencer.EnsureTagCompleteness(var data: SeriesWorkingData);
var terminusMass: real;
Procedure CombineTagsWithResidue(seqA: DNSequenceSeriesTag; seqB: DNSequenceSeriesTag; residue: Residue; var seqs: DNSequenceSeriesTags);
var newSeq: DNSequenceSeriesTag; newResidues: Residues;
begin
newSeq := seqA;
newSeq.otherMainPeakIdxs := Concat(newSeq.otherMainPeakIdxs, seqB.otherMainPeakIdxs, [seqB.mainPeakIdx]);
TArray.Sort<integer>(newSeq.otherMainPeakIdxs);
newSeq.modifications := Concat(newSeq.modifications, seqB.modifications);
newSeq.immonium := Concat(newSeq.immonium, seqB.immonium);
newSeq.fragments := Concat(newSeq.fragments, seqB.fragments);
newSeq.endPeakIdx := seqB.endPeakIdx;
newSeq.internEndPeakIdx := seqB.internEndPeakIdx;

SetLength(newResidues, 0);

Insert(seqA.tempResidues, newResidues, 0);
newResidues[High(newResidues)] := residue;
Insert(seqB.tempResidues, newResidues, MaxInt);

newSeq.tempResidues := newResidues;

SetLength(seqs, Length(seqs)+1);
seqs[High(seqs)] := newSeq;
end;
Procedure AddResidueToSeq(seq: DNSequenceSeriesTag; residue: Residue; insertAt: integer; var seqs: DNSequenceSeriesTags);
var newSeq: DNSequenceSeriesTag; newTempResidues: Residues;
begin
newSeq := seq;
newTempResidues := Copy(seq.tempResidues, 0, Length(seq.tempResidues));

if (insertAt = Length(seq.tempResidues) - 1) and (residue.resIdx = -99) then
begin
  newTempResidues[High(newTempResidues)].peakIdx := 0;
  newTempResidues[High(newTempResidues)].internPeakId := -99;
end;

newSeq.tempResidues := newTempResidues;
Insert(residue, newSeq.tempResidues, insertAt);
SetLength(seqs, Length(seqs)+1);
seqs[High(seqs)] := newSeq;
end;
Function AddAllFragments(frag: FragmentIonMass; peak: msmsPeak; intPeakIdx: integer; massDev: real) : Residues;
begin
for var i := Low(frag.resIdxPermutations) to High(frag.resIdxPermutations) do
  Insert(CreateFragmentResidue(frag.resIdxPermutations[i], peak.peakIdx, intPeakIdx, peak.mz, peak.int, RoundTo(massDev, -4)), result, MaxInt);
end;
Function SearchMasses(searchMass: real; internPeakIdx: integer) : Residues;
var i: integer; peak: msmsPeak;
begin
if internPeakIdx < 0 then peak := Default(msmsPeak)
else peak := data.spectrumData.spectrum[internPeakIdx];


for i := Low(ResMassList) + 1 to High(ResMassList) do
begin
  if Abs(searchMass - ResMassList[i].mass) < Precision then
      Insert(CreateResidue(i, peak.peakIdx, internPeakIdx, peak.mz, peak.int, Abs(searchMass - ResMassList[i].mass)), result, MaxInt);
end;

for i := Low(ionMasses.diPeptideMasses) to High(ionMasses.diPeptideMasses) do
begin
  if Abs(searchMass - ionMasses.diPeptideMasses[i].mass) < Precision then
        Insert(AddAllFragments(ionMasses.diPeptideMasses[i], peak, internPeakIdx, Abs(searchMass - ionMasses.diPeptideMasses[i].mass)), result, MaxInt);
end;

for i := Low(ionMasses.triPeptideMasses) to High(ionMasses.triPeptideMasses) do
begin
  if Abs(searchMass - ionMasses.triPeptideMasses[i].mass) < Precision then
    Insert(AddAllFragments(ionMasses.triPeptideMasses[i], peak, internPeakIdx, Abs(searchMass - ionMasses.triPeptideMasses[i].mass)), result, MaxInt);
end;
end;
Procedure FindResiduesBetweenTags(seqA: DNSequenceSeriesTag; seqB: DNSequenceSeriesTag; var seqs: DNSequenceSeriesTags);
var restMass: real; internResidues: Residues; massAddition: real;
begin
SetLength(seqs, Length(seqs)+2);
seqs[High(seqs)-1] := seqA;
seqs[High(seqs)] := seqB;

restMass := data.spectrumData.spectrum[seqB.internStartPeakIdx].mz -
            data.spectrumData.spectrum[seqA.internEndPeakIdx].mz;
if restMass < 0 then Exit;

if data.isNTerm then massAddition := 0 else massAddition := 0;

internResidues := SearchMasses(restMass + massAddition, seqB.internStartPeakIdx - 1);

if Length(internResidues) > 0 then
begin
  for var i := Low(internResidues) to High(internResidues) do
    CombineTagsWithResidue(seqA, seqB, internResidues[i], seqs);
end;
end;
Procedure FindStartingResidues(var seq: DNSequenceSeriesTag; var seqs: DNSequenceSeriesTags);
var startResidues: Residues; massAddition: real;
begin
SetLength(seqs, Length(seqs)+1);
seqs[High(seqs)] := seq;

if data.isNTerm then massAddition := 0
else massAddition := -ProtonMs - aa.mass[3, 0];

startResidues := SearchMasses(data.spectrumData.spectrum[seq.internStartPeakIdx].mz - terminusMass + massAddition, -1);

if Length(startResidues) > 0 then
begin
  for var i := Low(startResidues) to High(startResidues) do
    AddResidueToSeq(seq, startResidues[i], 0, seqs);
end
end;
Procedure FindRemainingResidues(var seq: DNSequenceSeriesTag; var seqs: DNSequenceSeriesTags);
var remainingMass: real; remainingResidues: Residues; i: integer;
begin

SetLength(seqs, Length(seqs)+1);
seqs[High(seqs)] := seq;

remainingMass := data.spectrumData.header.mass - GetSequenceTagFragment(seq.tempResidues, data.charge).mass;

remainingResidues := SearchMasses(remainingMass, seq.tempResidues[High(seq.tempResidues) - 1].internPeakId);

if Length(remainingResidues) > 0 then
begin
for i := Low(remainingResidues) to High(remainingResidues) do
  AddResidueToSeq(seq, remainingResidues[i], Length(seq.tempResidues)-1, seqs);
end
end;
var i: integer; seqs1, seqs2, seqs3, newSeqs: DNSequenceSeriesTags;
begin
if data.isNTerm then terminusMass := settings.nTermMass
else terminusMass := settings.cTermMass;

// Find internal residues between two tags
// TODO: OPTIMIZE - Change so one sequence is only loop over once
for i := Low(data.sequenceTags) to High(data.sequenceTags) do
begin
  for var j := Low(data.sequenceTags) to High(data.sequenceTags) do
  begin
    FindResiduesBetweenTags(data.sequenceTags[i], data.sequenceTags[j], seqs1);
  end;
end;
data.sequenceTags := seqs1;

// Reset the global sequences variable, find the starting residue(s)
for i := Low(data.sequenceTags) to High(data.sequenceTags) do
begin
  FindStartingResidues(data.sequenceTags[i], seqs2);
end;
data.sequenceTags := seqs2;

// Reset the global sequences variable, find the remaining residue(s)
for i := Low(data.sequenceTags) to High(data.sequenceTags) do
begin
  FindRemainingResidues(data.sequenceTags[i], seqs3);
end;

for i := Low(seqs3) to High(seqs3) do seqs3[i].tag := GetSequenceTagFragment(seqs3[i].tempResidues, data.charge);
  

data.sequenceTags := seqs3;

SetLength(seqs1, 0);
SetLength(seqs2, 0);
end;

{------------------------------------------------------------------------------}

procedure TDeNovoSequencer.RemoveDuplicateTags(var seqTags: DNSequenceSeriesTags);
Procedure RemoveDuplicateOtherMainPeaks(var otherMainPeaks: TArray<integer>; mainPeakIdx: integer);
var peakList: TList<integer>;
begin
  peakList := TList<integer>.Create;
  for var i := Low(otherMainPeaks) to High(otherMainPeaks) do
  begin
    if not peakList.Contains(otherMainPeaks[i]) and (otherMainPeaks[i] <> mainPeakIdx) then
      peakList.Add(otherMainPeaks[i]);
  end;

  SetLength(otherMainPeaks, 0);

  if Length(otherMainPeaks) < 1 then Exit;

  peakList.Sort;
  for var i := 0 to peakList.Count - 1 do
    Insert(peakList[i], otherMainPeaks, MaxInt);
end;
var tagsIdx : TDictionary<string, integer>; newSeqTags: DNSequenceSeriesTags;
begin
  tagsIdx := TDictionary<string, integer>.Create;
  // Loop over the sequence tags
  for var i := Low(seqTags) to High(seqTags) do
  begin
    if i mod 500 = 0 then logWindow.ClearSystemMessages;

    if tagsIdx.ContainsKey(seqTags[i].id) then
    begin
      Insert(seqTags[i].mainPeakIdx, newSeqTags[tagsIdx[seqTags[i].id]].otherMainPeakIdxs, MaxInt);
      seqTags[i] := Default(DNSequenceSeriesTag);
    end
    else
    begin
      SetLength(newSeqTags, Length(newSeqTags)+1);
      tagsIdx.Add(seqTags[i].id, High(newSeqTags));
      newSeqTags[High(newSeqTags)] := seqTags[i];
      SetLength(newSeqTags[High(newSeqTags)].otherMainPeakIdxs, 0);
    end;
  end;
  tagsIdx.Free;

  // Loop over the new sequence tags, and remove duplicate duplicate other main idxs
  for var i := Low(newSeqTags) to High(newSeqTags) do
  begin
    if i mod 500 = 0 then logWindow.ClearSystemMessages;
    RemoveDuplicateOtherMainPeaks(newSeqTags[i].otherMainPeakIdxs, newSeqTags[i].mainPeakIdx);
  end;

  seqTags := newSeqTags;
end;

Procedure TDeNovoSequencer.UpdateSequenceTags(var data: SeriesWorkingData);
var terminusMass: real;
Procedure UpdateTagInfo(var seq: DNSequenceSeriesTag);
var remainResMass: real;
begin
  seq.tag := GetSequenceTagFragment(seq.tempResidues, seq.precursorCharge, data.isNTerm = False);
  seq.startPeakIdx := seq.tempResidues[0].peakIdx;
  if seq.tempResidues[0].internPeakId = -1 then seq.internStartPeakIdx := -1
  else seq.internStartPeakIdx := seq.tempResidues[0].internPeakId;
  seq.endPeakIdx := seq.tempResidues[High(seq.tempResidues)].peakIdx;
  seq.internEndPeakIdx := seq.tempResidues[High(seq.tempResidues)].internPeakId;
  if seq.tempResidues[High(seq.tempResidues) - 1].resIdx <> -99 then remainResMass := 0
  else remainResMass := seq.tempResidues[High(seq.tempResidues) - 1].mass;
  seq.isNTerm := data.isNTerm;

  //seq.massDeviation := RoundTo(data.spectrumData.header.mass - seq.tag.mass, -4);
  seq.massDeviation := CalculateMassDeviation(data.spectrumData, seq.internStartPeakIdx, seq.internEndPeakIdx, seq.tag, terminusMass, remainResMass);
end;
var newTags: DNSequenceSeriesTags;
begin
if data.isNTerm then terminusMass := 0
else terminusMass := aa.mass[3, 0];

// Update the tag information
for var i := Low(data.sequenceTags) to High(data.sequenceTags) do
begin
  UpdateTagInfo(data.sequenceTags[i]);

  if data.sequenceTags[i].tag.length >= dnSettings.minTagLength then
    Insert(data.sequenceTags[i], newTags, MaxInt);
end;
data.sequenceTags := newTags;
end;

{------------------------------------------------------------------------------}

Procedure TDeNovoSequencer.CleanupWorkingData(var data: SeriesWorkingData);
begin
  SetLength(data.sequenceTagGraphs, 0);
  for var i := Low(data.spectrumData.spectrum) to High(data.spectrumData.spectrum) do
  begin
    SetLength(data.spectrumData.spectrum[i].tagIdx, 0);
  end;
end;

{------------------------------------------------------------------------------}

Procedure TDeNovoSequencer.CombineNCTerminalTags;
Function CountMatchingIonsSameSeries(currentTag: Residues; seriesTag: Residues; seriesDeltaMass: real): integer;
begin
  Result := 0;
  for var curIdx := Low(currentTag) to High(currentTag) do
  begin
    for var seriesIdx := Low(seriesTag) to High(seriesTag) do
    begin
      if Abs(currentTag[curIdx].mz - (seriesTag[seriesIdx].mz - seriesDeltaMass)) < Precision then
      begin
        Inc(Result);
        continue;
      end;
    end;
  end;

  if result > 0 then
  begin
    logWindow.AddLogMessage('Found %d matching same series ions between current tag (%s) and series tag (%s).',
                            [result, GetSequenceTagFragment(currentTag, 1).seq1LetMod,
                             GetSequenceTagFragment(seriesTag, 1).seq1LetMod], True);  
  end;

end;
Function CountMatchingIonsDifferentSeries(currentTag: Residues; mass: real; seriesTag: Residues; seriesDeltaMass: real): integer;
begin
  result := 0;

  for var curIdx := Low(currentTag) to High(currentTag) do
  begin
    for var seriesIdx := Low(seriesTag) to High(seriesTag) do
    begin
      if Abs(currentTag[curIdx].mz - (seriesTag[seriesIdx].mz - seriesDeltaMass) - mass) < Precision then
      begin
        Inc(Result);
        continue;
      end;
    end;
  end;   
  
  if result > 0 then
  begin
    logWindow.AddLogMessage('Found %d matching different series ions between current tag (%s) and series tag (%s).',
                            [result, GetSequenceTagFragment(currentTag, 1).seq1LetMod,
                             GetSequenceTagFragment(seriesTag, 1).seq1LetMod], True);  
  end;
end;

Procedure FindTag(var tag: DNSequenceSeriesTag; currentTag: DNSequenceSeriesTag; seriesTags : DNSequenceSeriesTags; sameSeries: boolean; deltaMass: real = 0);
var matchingIons: integer;
begin
for var i := Low(seriesTags) to High(seriesTags) do
  begin
    if sameSeries then
      matchingIons := CountMatchingIonsSameSeries(currentTag.tempResidues, seriesTags[i].tempResidues, deltaMass)
    else
      matchingIons := CountMatchingIonsDifferentSeries(currentTag.tempResidues, currentTag.tag.mass, seriesTags[i].tempResidues, deltaMass);

    if matchingIons > 0 then
    begin
      logWindow.AddLogMessage('FOUND TAG MATCH: %d matching ions between current tag (%s) and series tag (%s).',
                              [matchingIons, currentTag.tag.seq1LetMod, seriesTags[i].tag.seq1LetMod]);
      tag := seriesTags[i];
      // TODO: How to handle multiple matches
      Exit;
    end;
  end;
end;

Procedure FindTags(data: SeriesWorkingData);
var tempTag: DNSequenceTag; nDeltaMass, cDeltaMass: real;
begin
  for var i := Low(data.sequenceTags) to High(data.sequenceTags) do
  begin
    if i mod 500 = 0 then logWindow.ClearSystemMessages;
    tempTag := Default(DNSequenceTag);

    tempTag.tag := data.sequenceTags[i].tag;
    tempTag.id := data.sequenceTags[i].id;
    tempTag.massDeviation := data.sequenceTags[i].massDeviation;


    if data.isNTerm then
    begin
      nDeltaMass := settings.nTermDeltaMass;
      cDeltaMass := (settings.cTermMass - settings.nTermMass) - settings.cTermDeltaMass;

      tempTag.nTermCombined := data.sequenceTags[i];
      FindTag(tempTag.cTermCombined, data.sequenceTags[i],
        combinedCSeriesData.sequenceTags, False, cDeltaMass + settings.cTermDeltaMass);

    end else
    begin
      nDeltaMass := (settings.nTermMass - settings.cTermMass) - settings.nTermDeltaMass;
      cDeltaMass := settings.cTermDeltaMass;

      tempTag.cTermCombined := data.sequenceTags[i];
      FindTag(tempTag.nTermCombined, data.sequenceTags[i],
        combinedNSeriesData.sequenceTags, False, nDeltaMass + settings.nTermDeltaMass);

    end;

    FindTag(tempTag.nTermBasis, data.sequenceTags[i],
      basisNSeriesData.sequenceTags, data.isNTerm);
    FindTag(tempTag.nTermMod, data.sequenceTags[i],
      modifiedNSeriesData.sequenceTags, data.isNTerm, nDeltaMass);

    FindTag(tempTag.cTermBasis, data.sequenceTags[i],
      basisCSeriesData.sequenceTags, data.isNTerm = False);
    FindTag(tempTag.cTermMod, data.sequenceTags[i],
      modifiedCSeriesData.sequenceTags, data.isNTerm = False, cDeltaMass);

    Insert(tempTag, sequences, 0);
  end;
end;
begin
FindTags(combinedNSeriesData);
FindTags(combinedCSeriesData);
end;

{------------------------------------------------------------------------------}

Procedure TDeNovoSequencer.Score;
Procedure CalculateTagScore(var seq: DNSequenceTag);
{ Calculate the main score for the tag sequence }
begin
  seq.score := seq.tag.length;

end;
Procedure CalculateSeriesScore(var seq: DNSequenceSeriesTag);
{ Calculate the score for the series sequence }
begin
seq.score := seq.tag.length;
end;
Procedure ScoreSeries(var seq: DNSequenceSeriesTag);
begin
ScoreNeutralLossIons(seq, logWindow);
ScoreFragmentIons(seq, logWindow);
CalculateSummedIntensity(seq, logWindow);
CalculateSeriesScore(seq);

// Series dependent scoring
if seq.isNTerm = False then
begin
  // Reward no fragment found as y1
  if (seq.tempResidues[0].internPeakId = -1) and (seq.tempResidues[0].resIdx <> -99) then
  begin
    seq.score := seq.score + 5;
  end;
end;

end;
begin
// Loop through each sequence
for var seqIdx := Low(sequences) to High(sequences) do
begin
  if sequences[seqIdx].nTermBasis.mainPeakIdx <> 0 then
    ScoreSeries(sequences[seqIdx].nTermBasis);
  if sequences[seqIdx].nTermMod.mainPeakIdx <> 0 then
    ScoreSeries(sequences[seqIdx].nTermMod);
  if sequences[seqIdx].cTermBasis.mainPeakIdx <> 0 then
    ScoreSeries(sequences[seqIdx].cTermBasis);
  if sequences[seqIdx].cTermMod.mainPeakIdx <> 0 then
    ScoreSeries(sequences[seqIdx].cTermMod);
  if sequences[seqIdx].nTermCombined.mainPeakIdx <> 0 then
    ScoreSeries(sequences[seqIdx].nTermCombined);
  if sequences[seqIdx].nTermCombined.mainPeakIdx <> 0 then
    ScoreSeries(sequences[seqIdx].nTermCombined);

 CalculateTagScore(sequences[seqIdx]);
end;

end;

{----------------------------Utility methods-----------------------------------}

Procedure TDeNovoSequencer.GetPeakIndicesFromEdge(spectrum: msmsSpectrum; graph: BiDirectionalTagGraph; edge: TagGraphEdge;
                                                  var peak1IdxInt: integer; var peak2IdxInt: integer; var peak1Idx: integer; var peak2Idx: integer);
var dirGraph: TagGraph; peak1Int, peak2Int, peak1, peak2: integer;
begin
  if edge.isUpDirection then
    dirGraph := graph.upDirection
  else
    dirGraph := graph.downDirection;

  peak1Int := Min(dirGraph.nodes[edge.node1Idx].peakIdx, dirGraph.nodes[edge.node2Idx].peakIdx);
  peak2Int := Max(dirGraph.nodes[edge.node1Idx].peakIdx, dirGraph.nodes[edge.node2Idx].peakIdx);

  peak1 := spectrum[peak1Int].peakIdx;
  peak2 := spectrum[peak2Int].peakIdx;

  peak1IdxInt := peak1Int;
  peak2IdxInt := peak2Int;
  peak1Idx := peak1;
  peak2Idx := peak2;
end;

Function TDeNovoSequencer.CalculateMassDeviation(spectrum: msmsSpectrumData; internStartPeakIdx: integer; internEndPeakIdx: integer; tag: SequenceTag;
                                                 terminusMass: real; remainResMass: real): real;
var startMz, endMz: real;
begin
  if internEndPeakIdx = -99 then
  begin
    result := RoundTo(spectrum.header.mass - tag.mass, -4);
    Exit;
  end;

  endMz := spectrum.spectrum[internEndPeakIdx].mz;
  if internStartPeakIdx = -1 then
  begin
   startMz := 0;
   terminusMass := -ProtonMs;
  end else startMz := spectrum.spectrum[internStartPeakIdx].mz;
  result := RoundTo(tag.mass - (endMz - startMz) - terminusMass - remainResMass, -4);
end;

Procedure TDeNovoSequencer.CreateDNSeqArray();
Procedure CreateSeriesDNSeqArray(var seq: DNSequenceSeriesTag);
var resIdx, resetStartIdx: integer;
begin
if Length(seq.tempResidues) > Length(seq.residues) then
begin
seq := default(DNSequenceSeriesTag);
Exit;
end;

seq.internalLength := Length(seq.tempResidues);
if seq.tempResidues[0].mz > seq.tempResidues[High(seq.tempResidues)].mz then
  TUtility.ReverseSequenceArray<Residue>(seq.tempResidues);

for resIdx := Low(seq.tempResidues) to High(seq.tempResidues) do
  seq.residues[resIdx + 1] := seq.tempResidues[resIdx];

resetStartIdx := resIdx + 1;
for resIdx := resetStartIdx to High(seq.residues) do
  seq.residues[resIdx] := Default(Residue);
end;
begin
for var seqIdx := Low(sequences) to High(sequences) do
begin
  if sequences[seqIdx].nTermBasis.mainPeakIdx <> 0 then
    CreateSeriesDNSeqArray(sequences[seqIdx].nTermBasis);
  if sequences[seqIdx].nTermMod.mainPeakIdx <> 0 then
    CreateSeriesDNSeqArray(sequences[seqIdx].nTermMod);
  if sequences[seqIdx].cTermBasis.mainPeakIdx <> 0 then
    CreateSeriesDNSeqArray(sequences[seqIdx].cTermBasis);
  if sequences[seqIdx].cTermMod.mainPeakIdx <> 0 then
    CreateSeriesDNSeqArray(sequences[seqIdx].cTermMod);
  if sequences[seqIdx].nTermCombined.mainPeakIdx <> 0 then
    CreateSeriesDNSeqArray(sequences[seqIdx].nTermCombined);
  if sequences[seqIdx].cTermCombined.mainPeakIdx <> 0 then
    CreateSeriesDNSeqArray(sequences[seqIdx].cTermCombined);
end;
end;

end.
