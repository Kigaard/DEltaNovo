unit ProjectFileUtils;

interface

uses  System.JSON, System.JSON.Writers, System.JSON.Readers, System.JSON.Types,
      System.Classes, SysUtils,
      General,
      SpectraUtils, DeNovoSequencingUtils, DeNovoRecords, GeneralUtils;

Procedure SaveProject(projectFile: string; settings: SequencerSettings;
                      dnSettings: AutoDeNovoSeqSettings; results: DNSequenceTags);

Procedure LoadProject(projectFile: string; var settings: SequencerSettings;
                      var dnSettings: AutoDeNovoSeqSettings; var results: DNSequenceTags);

implementation

Procedure SaveProject(projectFile: string; settings: SequencerSettings;
                      dnSettings: AutoDeNovoSeqSettings;
                      results: DNSequenceTags);
Procedure AddModification(var writer: TJsonTextWriter; modi: PossibleModification);
begin
  writer.WritePropertyName('Name');
  writer.WriteValue(modi.name);

  writer.WritePropertyName('Formula');
  writer.WriteValue(modi.formula);

  writer.WritePropertyName('MassChange');
  writer.WriteValue(Real2Str(modi.massChange, 0, 4));

  writer.WritePropertyName('Residues');
  writer.WriteValue(modi.residues);
end;
Procedure AddSettingsSection(var writer: TJsonTextWriter);
var i: integer;
begin
  writer.WritePropertyName('Settings'); // Write Settings object
  writer.WriteStartObject;

  writer.WritePropertyName('BasisNTerminalSpectrumFilename');
  writer.WriteValue(settings.basisNSpectrumFile);
  writer.WritePropertyName('ModifiedNTerminalSpectrumFilename');
  writer.WriteValue(settings.modNSpectrumFile);
  writer.WritePropertyName('NTermModifiedMassChange');
  writer.WriteValue(Real2Str(settings.nTermDeltaMass, 0, 4));

  writer.WritePropertyName('BasisCTerminalSpectrumFilename');
  writer.WriteValue(settings.basisCSpectrumFile);
  writer.WritePropertyName('ModifiedCTerminalSpectrumFilename');
  writer.WriteValue(settings.modCSpectrumFile);
  writer.WritePropertyName('CTermModifiedMassChange');
  writer.WriteValue(Real2Str(settings.cTermDeltaMass, 0, 4));

  writer.WritePropertyName('Precision');
  writer.WriteValue(Real2Str(settings.precision, 0, 4));

  writer.WritePropertyName('IsLeucineIsoleucineEqual');
  writer.WriteValue(settings.leuIleEqual);
  writer.WritePropertyName('IsLysineGlutamineEqual');
  writer.WriteValue(settings.lysGlnEqual);

  writer.WritePropertyName('ModificationFilename');
  writer.WriteValue(settings.modificationFile);

  writer.WritePropertyName('FixedModifications');  // Write Fixed modification array
  writer.WriteStartArray;
  for i := Low(settings.modifications) to High(settings.modifications) do
  begin
    if settings.modifications[i].fixedModification then
      AddModification(writer, settings.modifications[i]);
  end;
  writer.WriteEndArray; // Write Fixed modification array

  writer.WritePropertyName('VariableModifications');  // Write Variable modification array
  writer.WriteStartArray;
  for i := Low(settings.modifications) to High(settings.modifications) do
  begin
    if settings.modifications[i].fixedModification = False then
      AddModification(writer, settings.modifications[i]);
  end;

  writer.WriteEndArray; // Write Variable modification array
  

  writer.WritePropertyName('SequencingMode');
  writer.WriteValue(settings.sequencingMode);

  if settings.sequencingMode <> 0 then
  begin
    writer.WritePropertyName('MaximumMainPeaks');
    writer.WriteValue(dnSettings.maxMainPeaks);
    writer.WritePropertyName('MinimumTagLength');
    writer.WriteValue(dnSettings.minTagLength);
    writer.WritePropertyName('SelectNMostIntenseCandidates');
    writer.WriteValue(settings.showNMostIntenseCandidates);
  end;
  writer.WriteEndObject; // End Settings object
end;
Procedure AddSpectrumSection(var writer: TJsonTextWriter);
var i, j: integer;
begin
  writer.WritePropertyName('Spectrum');
  writer.WriteStartObject;

  writer.WritePropertyName('MzValues'); // Write M/Z-value array
  writer.WriteStartArray;
  for i := Low(settings.fullSpectrum.spectrum) to High(settings.fullSpectrum.spectrum) do
    writer.WriteValue(Real2Str(settings.fullSpectrum.spectrum[i].mz, 0, 4));
  writer.WriteEndArray; // Write M/Z-value array


  writer.WritePropertyName('Intensities'); // Write intensity array array
  writer.WriteStartArray;
  for i := Low(settings.fullSpectrum.spectrum) to High(settings.fullSpectrum.spectrum) do
  begin
    writer.WriteStartArray; // Write intensity array
    for j := Low(settings.fullSpectrum.spectrum[i].intensities) to High(settings.fullSpectrum.spectrum[i].intensities) do
      writer.WriteValue(Real2Str(settings.fullSpectrum.spectrum[i].intensities[j], 0, 0));
    // End intensity array
    writer.WriteEndArray;
  end;

  // End intensity array array
  writer.WriteEndArray;

  writer.WriteEndObject; // End Spectrum object
end;
Procedure AddResultSeriesSection(seriesName: string; seriesTag: DNSequenceSeriesTag; var writer: TJsonTextWriter);
var i: integer;
begin
  writer.WritePropertyName(seriesName);
  writer.WriteStartObject; // Write SeriesName object

  writer.WritePropertyName('MainPeakIdx');
  writer.WriteValue(seriesTag.mainPeakIdx);

  writer.WritePropertyName('OtherMainPeakIdx'); // Write OtherMainPeakIdx object
  writer.WriteStartArray;
  for i := Low(seriesTag.otherMainPeakIdxs) to High(seriesTag.otherMainPeakIdxs) do
    writer.WriteValue(seriesTag.otherMainPeakIdxs[i]);
  writer.WriteEndArray; // End OtherMainPeakIdx object

  writer.WritePropertyName('Score');
  writer.WriteValue(Real2Str(seriesTag.score, 0, 4));

  writer.WritePropertyName('Sequence');
  writer.WriteValue(seriesTag.tag.seq1Let);

  writer.WritePropertyName('Mass');
  writer.WriteValue(Real2Str(seriesTag.tag.mass, 0, 4));

  writer.WritePropertyName('PrecurrsorCharge');
  writer.WriteValue(seriesTag.precursorCharge);

  writer.WritePropertyName('PrecursorMz');
  writer.WriteValue(Real2Str(seriesTag.tag.precursor, 0, 4));

  writer.WritePropertyName('MassDeviation');
  writer.WriteValue(Real2Str(seriesTag.massDeviation, 0, 4));

  writer.WritePropertyName('TagStartPeakIdx');
  writer.WriteValue(seriesTag.startPeakIdx);

  writer.WritePropertyName('TagEndPeakIdx');
  writer.WriteValue(seriesTag.endPeakIdx);

  writer.WritePropertyName('Residues'); // Write Residues object
  writer.WriteStartArray;

  for i := Low(seriesTag.residues) to High(seriesTag.residues) do
  begin

    if seriesTag.residues[i].res1 = #0 then
      continue;

    writer.WriteStartObject; // Write Residue object

    writer.WritePropertyName('PeakIdx');
    writer.WriteValue(seriesTag.residues[i].peakIdx);

    writer.WritePropertyName('ResidueNumber');
    writer.WriteValue(seriesTag.residues[i].aaNum);

    writer.WritePropertyName('Residue');
    writer.WriteValue(seriesTag.residues[i].res1);

    writer.WritePropertyName('MZ-value');
    writer.WriteValue(Real2Str(seriesTag.residues[i].mz, 0, 4));

    writer.WritePropertyName('Intensity');
    writer.WriteValue(Real2Str(seriesTag.residues[i].int, 0, 0));

    writer.WritePropertyName('Mass deviation');
    writer.WriteValue(Real2Str(seriesTag.residues[i].massDeviation, 0, 4));
    writer.WriteEndObject; // End Residue object
  end;
  writer.WriteEndArray; // End Residues object

  writer.WritePropertyName('Modifications'); // Write Modifications object
  writer.WriteStartArray;

  for i := Low(seriesTag.modifications) to High(seriesTag.modifications) do
  begin
    writer.WriteStartObject; // Write Modification object

    writer.WritePropertyName('ModificationName');
    writer.WriteValue(seriesTag.modifications[i].modification);

    writer.WritePropertyName('Position');
    writer.WriteValue(seriesTag.modifications[i].position);

    writer.WritePropertyName('Residue');
    writer.WriteValue(seriesTag.modifications[i].residue);

    writer.WritePropertyName('MassChange');
    writer.WriteValue(Real2Str(seriesTag.modifications[i].massChange, 0, 4));
    writer.WriteEndObject; // End Modification object
  end;

  writer.WriteEndArray; // End Modifications object
  writer.WriteEndObject; // Write SeriesName object

end;
Procedure AddResultsSection(var writer: TJsonTextWriter);
begin
  writer.WritePropertyName('Results');  // Write Results object
  writer.WriteStartArray;

  for var resultIdx := Low(results) to High(results) do
  begin
    writer.WriteStartObject; // Write Result object

    writer.WritePropertyName('ID');
    writer.WriteValue(results[resultIdx].id);

    writer.WritePropertyName('Score');
    writer.WriteValue(Real2Str(results[resultIdx].score, 0, 4));

    writer.WritePropertyName('Sequence');
    writer.WriteValue(results[resultIdx].tag.seq1Let);

    writer.WritePropertyName('Mass');
    writer.WriteValue(Real2Str(results[resultIdx].tag.mass, 0, 4));

    writer.WritePropertyName('PrecursorCharge');
    writer.WriteValue(results[resultIdx].tag.charge);

    writer.WritePropertyName('PrecursorMz');
    writer.WriteValue(Real2Str(results[resultIdx].tag.precursor, 0, 4));

    writer.WritePropertyName('MassDeviation');
    writer.WriteValue(Real2Str(results[resultIdx].massDeviation, 0, 4));

    writer.WritePropertyName('SeriesData');
    writer.WriteStartArray;
    if results[resultIdx].nTermBasis.mainPeakIdx = 0 then
      AddResultSeriesSection('NTermBasis', results[resultIdx].nTermBasis, writer);
    if results[resultIdx].nTermMod.mainPeakIdx = 0 then
      AddResultSeriesSection('NTermMod', results[resultIdx].nTermMod, writer);
    if results[resultIdx].cTermBasis.mainPeakIdx = 0 then
      AddResultSeriesSection('CTermBasis', results[resultIdx].cTermBasis, writer);
    if results[resultIdx].cTermMod.mainPeakIdx = 0 then
      AddResultSeriesSection('CTermMod', results[resultIdx].cTermMod, writer);
    if results[resultIdx].nTermCombined.mainPeakIdx = 0 then
      AddResultSeriesSection('NTermCombined', results[resultIdx].nTermCombined, writer);
    if results[resultIdx].nTermCombined.mainPeakIdx = 0 then
      AddResultSeriesSection('CTermCombined', results[resultIdx].nTermCombined, writer);
    writer.WriteEndArray;

    writer.WriteEndObject; // End Result object
  end;

  writer.WriteEndArray; // End Results object
end;

var writer: TJsonTextWriter; streamWriter: TStreamWriter;
begin
  // Create writer
  streamWriter := TStreamWriter.Create(projectFile);
  writer := TJsonTextWriter.Create(streamWriter);
  writer.Formatting := TJsonFormatting.Indented;

  // Add data to writer
  writer.WriteStartObject; // Create root object

  writer.WritePropertyName('ProjectName');
  writer.WriteValue(ChangeFileExt(ExtractFileName(projectFile), ''));

  writer.WritePropertyName('ProjectFilename');
  writer.WriteValue(projectFile);

  AddSettingsSection(writer);
  AddSpectrumSection(writer);

  if (length(results) > 0) and (settings.sequencingMode <> 0) then
    AddResultsSection(writer);

  writer.WriteEndObject; // End root object

  // Write to file
  writer.Flush;
  writer.Close;
  streamWriter.Flush;
  streamWriter.Close;
end;

Procedure LoadProject(projectFile: string; var settings: SequencerSettings;
                      var dnSettings: AutoDeNovoSeqSettings; var results: DNSequenceTags);
var reader: TJsonReader;
begin
  reader := TJsonReader.Create;

end;

end.
