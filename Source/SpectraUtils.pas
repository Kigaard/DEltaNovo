unit SpectraUtils;
{*Utilities for handling spectra. *}

interface

uses System.Classes, System.Generics.Collections,
     GeneralUtils, General, StrGeneral, Globals, LogForm;

const MaxDeconSpec = 1001;
type
  msmsPkData = record
      mz, int, massDev : real;
      mode : integer; // Peak mode (0 = Non, 1 = N-term (b), 2=C-term (y), 3=Both N/C-term (b/y). 4=Fragment (Not manual sequencing))
      mark : string;  // Label for peak
      idx : integer;  // Unique index
      end;

  msmsSpectrumData = array of msmsPkData;

  msmsSpectraData = array[0..7] of msmsSpectrumData;
  ionSeriesList = record
    nTermIonSeries: msmsSpectrumData;
    cTermIonSeries: msmsSpectrumData;
    unusedIonSeries: msmsSpectrumData;
    end;


Function ProcessSpectraFiles(fileUnmod: string; fileNTerm: string;
                                        fileCTerm: string; nTermDeltaMass: real;
                                        cTermDeltaMass: real; precision: real; logWindow : TFormLog) : msmsSpectraData;
Function ReadSpectrumFile(fileName: string) : msmsSpectrumData;
Procedure DeconvoluteSpectrum (var spec : msmsSpectrumData; msDelta : real);
Procedure CombineSpectra(unmodSpectrum: msmsSpectrumData; nTermSpectrum: msmsSpectrumData;
                         nTermDeltaMass: real; cTermSpectrum: msmsSpectrumData;
                         cTermDeltaMass: real; precision: real;
                         var combinedSpectrum: msmsSpectrumData);
Function GetIndexOfMostIntensePeak(spectrum : msmsSpectrumData; excludePeaks: TList<integer>; minIntensity: real = -10) : integer; overload;
Function GetIndexOfMostIntensePeak(spectrum : msmsSpectrumData; minIntensity: real = -10) : integer; overload;
Function ExtractIonSeries(spectrum: msmsSpectrumData): ionSeriesList;

implementation
Function ProcessSpectraFiles(fileUnmod: string; fileNTerm: string;
                                        fileCTerm: string; nTermDeltaMass: real;
                                        cTermDeltaMass: real; precision: real; logWindow : TFormLog) : msmsSpectraData;
{* Read and process (Deconvolute and combine) the spectra files. *}
Procedure LogProcessedSpectrumStats(logWindow : TFormLog; spectrumType : string; spectrum: msmsSpectrumData);
var basePeakIdx : integer;
begin
  basePeakIdx := GetIndexOfMostIntensePeak(spectrum);
  logWindow.AddLogMessage('%s contained %d peaks. First peak: %0.3f m/z (Int: %0.0f). Last peak: %0.3f m/z (Int: %0.0f). Base peak: %0.3f m/z (Int: %0.0f)',
                          [spectrumType, Length(spectrum), spectrum[Low(spectrum)].mz, spectrum[Low(spectrum)].int, spectrum[High(spectrum)].mz,
                          spectrum[High(spectrum)].int, spectrum[basePeakIdx].mz, spectrum[basePeakIdx].int]);
end;
Procedure LogIonAssignmentStats(logWindow : TFormLog; spectrum: msmsSpectrumData);
var i, nTermCount, cTermCount, combinedCount: integer;
begin
  nTermCount := 0;
  cTermCount := 0;
  combinedCount := 0;

  for i := Low(spectrum) to High(spectrum) do
  begin
    if spectrum[i].mode = 1 then
      Inc(nTermCount);
    if spectrum[i].mode = 2 then
      Inc(cTermCount);
    if spectrum[i].mode = 3 then
      Inc(combinedCount);
  end;
    logWindow.AddLogMessage('Ion assignment: %d N-terminally ions. %d C-terminally ions. %d N/C-terminally ions.',
                           [nTermCount, cTermCount, combinedCount]);
end;
var unmodSpectrum, unmodSpectrumDeconv, nTermSpectrum, nTermSpectrumDeconv,
    cTermSpectrum, cTermSpectrumDeconv, combinedSpectrum: msmsSpectrumData;
    spectra: msmsSpectraData;
begin
  // Read the spectra files
  unmodSpectrum := ReadSpectrumFile(fileUnmod);
  unmodSpectrumDeconv := ReadSpectrumFile(fileUnmod);
  nTermSpectrum := ReadSpectrumFile(fileNTerm);
  nTermSpectrumDeconv := ReadSpectrumFile(fileNTerm);
  cTermSpectrum := ReadSpectrumFile(fileCTerm);
  cTermSpectrumDeconv := ReadSpectrumFile(fileCTerm);
  // Deconvolute spectra
  DeconvoluteSpectrum(unmodSpectrumDeconv, precision);
  DeconvoluteSpectrum(nTermSpectrumDeconv, precision);
  DeconvoluteSpectrum(cTermSpectrumDeconv, precision);
  // Combine spectra
  CombineSpectra(unmodSpectrumDeconv, nTermSpectrumDeconv, nTermDeltaMass,
                 cTermSpectrumDeconv, cTermDeltaMass, precision,
                 combinedSpectrum);
  // Log info
  logWindow.AddHeader('Spectrum processing statistics');
  LogProcessedSpectrumStats(logWindow, 'Non-Deconvoluted unmodified spectrum', unmodSpectrum);
  LogProcessedSpectrumStats(logWindow, 'Deconvoluted unmodified spectrum', unmodSpectrumDeconv);
  LogProcessedSpectrumStats(logWindow, 'Non-Deconvoluted N-terminally modified spectrum', nTermSpectrum);
  LogProcessedSpectrumStats(logWindow, 'Deconvoluted N-terminally modified spectrum', nTermSpectrumDeconv);
  LogProcessedSpectrumStats(logWindow, 'Non-Deconvoluted C-terminally modified spectrum', cTermSpectrum);
  LogProcessedSpectrumStats(logWindow, 'Deconvoluted C-terminally modified spectrum', cTermSpectrumDeconv);
  LogIonAssignmentStats(logWindow, combinedSpectrum);

  // Return the spectra
  spectra[0] := unmodSpectrum;
  spectra[1] := nTermSpectrum;
  spectra[2] := cTermSpectrum;
  spectra[3] := unmodSpectrumDeconv;
  spectra[4] := nTermSpectrumDeconv;
  spectra[5] := cTermSpectrumDeconv;
  spectra[6] := combinedSpectrum;
  result := spectra;

end;

Function ReadSpectrumFile(fileName: string) : msmsSpectrumData;
{* Read the spectrum file. *}
var count, i : integer;            inF : textFile;         s : string;
    inpText : tStringList; spectrum: msmsSpectrumData;
begin
  count := 0;
  inpText := tStringList.Create;
try
  Assignfile (inF, fileName);
  Reset (inF);
  while not EOF (inF) do
  begin
    ReadLn (inF, s);
    if WordCountL (s, ' '#9) >= 2 then           //contains space or tab
      inpText.Add (s);
  end;
  SetLength (spectrum, inpText.Count);
  for i := 0 to inpText.Count - 1 do
  begin
    Inc (count);
    spectrum [i].mz := Str2Real (ExtractWord (1, inpText [i], ' '#9), 0);
    spectrum [i].int := Str2Real (ExtractWord (2, inpText [i], ' '#9), 0);
  end;
finally
  CloseFile (inF);
  inpText.Free;
  result := spectrum;
end;
end;

{------------------------------------------------------------------------------}
Procedure DeconvoluteSpectrum (var spec : msmsSpectrumData; msDelta : real);
{* Deconvolute the spectrum. *}
Procedure CombineSp (var sp1, sp2 : msmsPkData);                           //ms, int
begin
  sp1.int := sp1.int + sp2.int;
  sp2.int := 0;
  sp2.mz := 0;
end;
Function FirstIsotopeOK (sp1, sp2 : msmsPkData; chrg : integer) : boolean;
var ms1, ms2 : real;
begin
  result := false;
  ms1 := sp1.mz * chrg;            //not correct missing proton
  ms2 := sp2.mz * chrg;
  if Abs (ms2 - ms1 - protonMS) < msDelta then
    if ms1 < 1100 then
      result := (sp1.int * 1.2 > sp2.int)
    else if ms1 > 3000 then
       result := (sp1.int < sp2.int)
    else if ms1 > 2000 then                     //2100 < ms < 3000
       result := (sp1.int * 3 > sp2.int)
    else result := (sp1.int * 1.8 > sp2.int);      //1100 < ms < 2100
end;

var i, j, k, ch2count, ch, isoCount: integer;
    ch2arr, SpecCopy: msmsSpectrumData;                notFound : boolean;
    MHplus : real;                               tmpMsRec : msmsPkData;
begin
  ch2Count := -1;
  SetLength (ch2Arr, MaxDeconSpec);
  for i := 0 to High (spec) - 4 do
    if spec [i].mz > 10 then
      for ch := 4 downto 1 do                                 //charge
        if FirstIsotopeOK (spec [i], spec [i + 1], ch) then   //found an isotope
        begin                                                 //look for the next
          isoCount := 1;                                      //count # isotopes
          for j := 2 to 4 do
            if (Abs (spec [i + j - 1].mz - spec [i + j].mz) - protonMS / ch < msDelta)
              and (spec [i + j - 1].int * 1.5 > spec [i + j].mz) then    //found another isotope
                if isoCount = j - 1 then                                //has the previous been found?
                  Inc (isoCount);
          MHplus := ((spec [i].mz - protonMS) * ch) + protonMS;       //singly charged mass
          if isoCount > 1 then
            for j := 1 to isoCount do                       //combine isotopes
              CombineSp (spec [i], spec [i + j])
          else if ch = 1 then                               //single isotope accepted for ch = 1
              CombineSp (spec [i], spec [i + 1]);
          notFound := true;
          for k := i + 2 to High (spec) - 1 do
            if notFound and (Abs (spec [k].mz - MHplus) < msDelta) then  //singly charged species found
            begin
              CombineSp (spec [k], spec [i]);
              notFound := false;
            end;
          if notFound and (spec [i].mz > 1) and (ch2Count < MaxDeconSpec) then   //insert in mass spectrum after deisotoping   <<<<----
          begin
            ch2arr [FInc (ch2Count)].mz := MHplus;
            ch2arr [ch2Count].int := spec [i].int;
            Spec [i].mz := 0;
          end;
        end;
  for i := 0 to ch2Count - 1 do                     //bubble sort - OK almost sorted already
    for j := i + 1 to ch2Count do
      if ch2arr [i].mz > ch2arr [j].mz then
      begin
        tmpMsRec := ch2arr [j];
        ch2arr [j] := ch2arr [i];
        ch2arr [i] := tmpMsRec;
      end;
  SetLength (specCopy, Length (spec) + 50);        //set copy=spec
  k := -1;
  j := -1;
  for i := 0 to High (spec) do
    if spec [i].mz > 1 then                        //copy all except 0's
    begin
      while (spec [i].mz > ch2arr [j + 1].mz) and (ch2arr [j + 1].mz > 1) and (j < ch2count) do
        specCopy [FInc (k)] := ch2arr [FInc (j)];
      specCopy [FInc (k)] := spec [i];
    end;
  if j < ch2Count then
    for var L := j + 1 to ch2Count do
      specCopy [FInc (k)] := ch2arr [L];
  SetLength (specCopy, k + 1);
  for i := 0  to High (specCopy) do                //copy specCopy to spec
    spec [i] := specCopy [i];
  SetLength (spec, Length (specCopy));
  SetLength (specCopy, 0);                        //clear specCopy
end;

{------------------------------------------------------------------------------}
Procedure CombineSpectra(unmodSpectrum: msmsSpectrumData; nTermSpectrum: msmsSpectrumData;
                         nTermDeltaMass: real; cTermSpectrum: msmsSpectrumData;
                         cTermDeltaMass: real; precision: real;
                         var combinedSpectrum: msmsSpectrumData);
{*Combine the spectra*}
var unmodPeakIdx, nTermPeakIdx, cTermPeakIdx: integer;
begin
  // Loop over the unmod spectrum
  for unmodPeakIdx := 0 to Length(unmodSpectrum) - 1 do
  begin
  (*
      // TODO: Commented out until N-terminally modified peptides are used
      // Loop over the N-terminal modified spectrum and assign the b-ions
      for nTermPeakIdx := 0 to Length(nTermSpectrum) - 1 do
      begin
        if(Abs(nTermSpectrum[nTermPeakIdx].pkmz - unmodSpectrum[unmodPeakIdx].pkmz
           - nTermDeltaMass) <= precision) then
           begin
            unmodSpectrum[unmodPeakIdx].htMode := 1
           end;
      end;
  *)

    // Loop over the C-terminal modified spectrum and assign the y-ions
    for cTermPeakIdx := 0 to Length(cTermSpectrum) - 1 do
    begin
      if(Abs(cTermSpectrum[cTermPeakIdx].mz - unmodSpectrum[unmodPeakIdx].mz
       - cTermDeltaMass) <= precision) then
      begin
        // Check if unassigned.
        if (unmodSpectrum[unmodPeakIdx].mode = 0) or
        (unmodSpectrum[unmodPeakIdx].mode = 2) then // TODO: Works for now - Maybe find out what the issue is later
          begin
            // If it is unassigned (which it should), assign as y-ion
            unmodSpectrum[unmodPeakIdx].mode := 2
          end
        else
          begin
            // If it is not unassigned (assigned as b-ion), assign combination of
            // b-ion and y-ion
          unmodSpectrum[unmodPeakIdx].mode := 3
          end;
      end
    end;
  end;

combinedSpectrum := unmodSpectrum;
end;

{------------------------------------------------------------------------------}
Function GetIndexOfMostIntensePeak(spectrum : msmsSpectrumData; excludePeaks: TList<integer>; minIntensity: real = -10) : integer; overload;
var i, maxIntensityIndex: integer; maxIntensity: real;
begin
i := -1;
maxIntensity := -10;

if Length(spectrum) > 0 then
begin
  for i := Low(spectrum) to High(spectrum) do
  begin
    if (spectrum[i].int > minIntensity) and (spectrum[i].int > maxIntensity) and (excludePeaks.IndexOf(i) = -1) then
      begin
        maxIntensity := spectrum[i].int;
        maxIntensityIndex := i;
      end;
  end;
end;

  result := maxIntensityIndex;
end;

Function GetIndexOfMostIntensePeak(spectrum : msmsSpectrumData; minIntensity: real = -10) : integer; overload;
var peaks: TList<integer>;
begin
  peaks := TList<integer>.Create;
  result := GetIndexOfMostIntensePeak(spectrum, peaks, minIntensity);
end;
{------------------------------------------------------------------------------}
Function ExtractIonSeries(spectrum: msmsSpectrumData): ionSeriesList;
var nTermSeries, cTermSeries, unusedSeries: msmsSpectrumData; ionSerie : ionSeriesList;
i: integer;
begin
for i := Low(spectrum) to High(spectrum) do
begin
  if spectrum[i].mode = 1 then
    begin
      SetLength(nTermSeries, Length(nTermSeries)+1);
      nTermSeries[High(nTermSeries)] := spectrum[i];
    end
  else if spectrum[i].mode = 2 then
    begin
      SetLength(cTermSeries, Length(cTermSeries)+1);
      cTermSeries[High(cTermSeries)] := spectrum[i];
    end
  else if spectrum[i].mode = 0 then
    begin
      SetLength(unusedSeries, Length(unusedSeries)+1);
      unusedSeries[High(unusedSeries)] := spectrum[i];
    end
end;

// Set the series
ionSerie.nTermIonSeries := nTermSeries;
ionSerie.cTermIonSeries := cTermSeries;
ionSerie.unusedIonSeries := unusedSeries;
result := ionSerie;
end;
end.
