unit FormMain;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  AdvPanel, SpectrumViewForm, AdvOfficeButtons, AdvGlowButton, General, StrGeneral,
  AdvUtil, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, ShellAPI, io_unit, globals,
  System.UITypes, AdvEdit, Vcl.Mask, AdvDropDown, AdvCustomGridDropDown,
  AdvGridDropDown, AdvCombo, ColCombo, Math, ModificationViewForm, GeneralUtils,
  DeNovoSequencingUtils, SpectraUtils, DNovoSequencer, LogForm, DeNovoRecords, ProjectFileUtils,
  advmultibuttonedit, AdvUpDownEdit, DBAdvOfficeButtons, slstbox, System.Generics.Collections,
  MgfSpectrumSelectForm, System.StrUtils, SpectrumTypeSelectForm, iniFiles,
  AdvGroupBox;

  {* "Temporary" code *}
  const n1 : aa_name1_type = ('+','X','A','C','D','E','F','G','H','I','K','L','M','N','P',
           'Q','R','S','T','V','W','Y','-');
      n3 : aa_name3_type = ('H2O','Xxx','Ala','Cys','Asp','Glu','Phe','Gly','His','Ile',
           'Lys','Leu','Met','Asn','Pro','Gln','Arg','Ser','Thr','Val','Trp','Tyr','---');
      nm : aa_name_array = ('Base mass','Unknown','Alanine','Cysteine','Asp. acid','Glu. acid',
           'Phenylala.','Glycine','Histidine','Isoleu.','Lysine','Leucine','Methionine',
           'Asparagine','Proline','Glutamine','Arginine','Serine','Threonine','Valine',
           'Tryptopha.','Tyrosine','Split');
      co : formula_array = ('H2O1','C6H8N1O1','C3H5N1O1','C3H4N1O1S1','C4H5N1O3','C5H7N1O3',
           'C9H9N1O1','C2H3N1O1','C6H7N3O1','C6H11N1O1','C6H12N2O1','C6H11N1O1','C5H9N1O1S1',
           'C4H6N2O2','C5H7N1O1','C5H8N2O2','C6H12N4O1','C3H5N1O2','C4H7N1O2','C5H9N1O1',
           'C11H10N2O1','C9H9N1O2','H2O1');


type
  TMainForm = class (TForm)
    BottomPanel: TAdvPanel;
    CloseBtn: TAdvGlowButton;
    SpectrumOpenDlg: TOpenDialog;
    ResultGrid: TAdvStringGrid;
    SettingsPanel: TAdvPanel;
    ResultPanel: TAdvPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    SequenceResultLabel: TLabel;
    ScoreResultLabel: TLabel;
    PrecursorResultLabel: TLabel;
    ChargeResultLabel: TLabel;
    MassResultLabel: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    FileBasisCTxt: TEdit;
    FileBasisNTxt: TEdit;
    FileModNTxt: TEdit;
    Label13: TLabel;
    Label14: TLabel;
    DeltaMassNTxt: TAdvEdit;
    DeltaMassCTxt: TAdvEdit;
    Label15: TLabel;
    PrecisionDaTxt: TAdvEdit;
    RunBtn: TAdvGlowButton;
    Label11: TLabel;
    TagLengthResultLabel: TLabel;
    ShowLogWindowChk: TAdvOfficeCheckBox;
    ShowSpectrumWindowChk: TAdvOfficeCheckBox;
    Label6: TLabel;
    Label12: TLabel;
    Label18: TLabel;
    ModificationResultLabel: TLabel;
    LeuIleEqualChk: TAdvOfficeCheckBox;
    LysGlnEqualChk: TAdvOfficeCheckBox;
    Label19: TLabel;
    FileProjectTxt: TEdit;
    ProjectOpenDlg: TOpenDialog;
    ProjectSaveDlg: TSaveDialog;
    MinTagLengthUd: TAdvUpDownEdit;
    OpenProjectBtn: TAdvGlowButton;
    EditModificationBtn: TAdvGlowButton;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    SelectModFileBtn: TAdvGlowButton;
    ModOpenDlg: TOpenDialog;
    VarModSelect: TListBox;
    FixModSelect: TListBox;
    BrowseBaseNFileBtn: TAdvGlowButton;
    BrowseModNFileBtn: TAdvGlowButton;
    BrowseBaseCFileBtn: TAdvGlowButton;
    BrowseSaveProjectFileBtn: TAdvGlowButton;
    FileModLabel: TLabel;
    Label27: TLabel;
    MaxMainPeaksUd: TAdvUpDownEdit;
    Label28: TLabel;
    CandidateShowPeaksUd: TAdvUpDownEdit;
    Label29: TLabel;
    Label17: TLabel;
    Label20: TLabel;
    FileModCTxt: TEdit;
    BrowseModCFileBtn: TAdvGlowButton;
    BasisNCSpectraEqualChk: TAdvOfficeCheckBox;
    LoadAllSpectraChk: TAdvOfficeCheckBox;
    SequencingModeCb: TAdvOfficeRadioGroup;
    CTermMassTxt: TAdvEdit;
    Label10: TLabel;
    NTermMassTxt: TAdvEdit;
    Label16: TLabel;
    EnsureTagConnectChk: TAdvOfficeCheckBox;
    procedure CloseBtnClick (Sender: TObject);
    procedure FormCreate (Sender: TObject);
    procedure FormClose (Sender: TObject; var Action: TCloseAction);

    procedure BrowseBaseNFileBtnClick(Sender: TObject);
    procedure BrowseModNFileBtnClick(Sender: TObject);
    procedure BrowseBaseCFileBtnClick(Sender: TObject);

    Procedure GetMgfSpectrum(filename: string; specType: integer);

    procedure RunBtnClick(Sender: TObject);

    procedure ShowLogWindowChkClick(Sender: TObject);
    procedure ShowSpectrumWindowChkClick(Sender: TObject);
    procedure ResultGridClick(Sender: TObject);
    procedure PrecisionDaTxtChange(Sender: TObject);
    procedure BrowseSaveProjectFileBtnClick(Sender: TObject);
    procedure OpenProjectBtnClick(Sender: TObject);
    procedure EditModificationBtnClick(Sender: TObject);
    procedure SelectModFileBtnClick(Sender: TObject);
    procedure VarModSelectClick(Sender: TObject);
    procedure FixModSelectClick(Sender: TObject);
    procedure ResultGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure BasisNCSpectraEqualChkClick(Sender: TObject);
    procedure BrowseModCFileBtnClick(Sender: TObject);
    procedure SequencingModeCbClick(Sender: TObject);
    procedure ResultGridFixedCellClick(Sender: TObject; ACol, ARow: Integer);

  private
    SpectrumWindow : TSpectrumView;                  //spectrum window
    DNSequencer: TDeNovoSequencer;
    LogWindow : TFormLog;

    DNResults : DNSequenceTags;

    basisNMgfSpectrum: msmsSpectrumData;
    modNMgfSpectrum: msmsSpectrumData;
    basisCMgfSpectrum: msmsSpectrumData;
    modCMgfSpectrum: msmsSpectrumData;

    fullModFilePath: string;
    allMods: PossibleModifications;
    selectedMods: PossibleModifications;
    twoFixModsResidiue: boolean;

    sortTypeResultGrid: array of integer;
    resultGridColumnBaseHeaders: array of string;

    Procedure SetSpectrumData(specType: integer; fileName: string; spec: msmsSpectrumData; isMaldiSpec: boolean);

    Function ValidateParameters(var isMaldi: boolean): boolean;
    Procedure ResetResultGrid;
    Procedure FillResultGrid;

    Procedure FillModificationLists;
    Procedure GetSelectedModifications;
  public
    Procedure AfterConstruction; override;
    Procedure WMDropFiles (var msg : TWMDropFiles); message WM_DropFiles;
  end;

{*
  Add callback functional from SpectrumView to update result grid
  Enable display of results with possibility of viewing spectrum with used peaks
*}

var MainForm: TMainForm;

implementation

{$R *.dfm}

{------------------------------------------------------------------------------}
procedure TMainForm.AfterConstruction;
Procedure WriteMassFile (s, cysComp : string);
  var  f : textFile;
  begin
    AssignFile (f, systemDir + s);
    Rewrite (f);
    for var i := 0 to maxAA do
    begin
      WriteLn (f, n1 [i]);
      WriteLn (f, n3 [i]);
      WriteLn (f, nm [i]);
      if i <> 3 then
        WriteLn (f, co [i])
      else WriteLn (f, cysComp);
    end;
    CloseFile (f);
  end;

Procedure SetDefaultMass (var aaCopy : aaType; mode : integer);
      const defAtom = 20;
      aveDef : array [1..defAtom] of real = (12.0107, 1.00794, 14.00674, 15.9994,
               30.973762, 32.065, 79.904, 35.4527, 18.9984, 126.90447, 39.0983,
               6.941, 22.989769, 40.078, 65.39, 55.845, 63.546, 13.00335 , 2.01410178 , 15.0001088982);
      monDef : array [1..defAtom] of real = (12.0, 1.00782503, 14.003074, 15.9949146,
               30.97376149, 31.9720707, 78.918338, 34.9688527, 18.9984031, 126.90447,
               38.96371, 7.016, 22.989769, 39.9625909, 63.929142, 55.934936, 62.929597,
               13.00335, 2.01410178 , 15.0001088982);
      abbDef : array [1..defAtom] of str2 = ('C','H','N','O','P','S','Br','Cl',
               'F','I','K','Li','Na','Ca','Zn','Fe', 'Cu', 'Cx', 'D', 'Nx');
      namDef : array [1..defAtom] of str12 = ('Carbon', 'Hydrogen', 'Nitrogen',
              'Oxygen', 'Phosphor', 'Sulphur', 'Bromide','Chloride','Fluoride',
              'Iodide','Potassium','Lithium','Sodium','Potassium','Zinc','Iron',
              'Copper', 'Carbon13', 'Deuterium', 'Nitrogen15');

begin
  FillChar (aaCopy.atoms, SizeOf (AtomMassType), 0);
  for var i := 1 to defAtom do
  begin
    aaCopy.atoms.ave [i] := aveDef [i];
    if mode = 1 then
      aaCopy.atoms.ave [1] := 12.011;
    aaCopy.atoms.mono [i] := monDef [i];
    aaCopy.atoms.abbr [i] := abbDef [i];
    aaCopy.atoms.name [i] := namDef [i];
  end;
end;

var appIni: TIniFile;
begin
  inherited;
  // Create mass file if non-existing
  if FileExists('AA_MASS.mss') = false then
    WriteMassFile ('AA_MASS.mss', 'C3H4N1O1S1');

  SetDefaultMass (aa, 0);
  ProtonMS := 1.00727647;
  LoadMassFile (aa, 'AA_MASS.MSS');
  LogWindow.AddLogMessage('ATTENTION: The program is running in debug mode. ' +
    'More technical message are shown. If not used for devlopment, ' +
    'please use the Release version.', True);
  DragAcceptFiles (Handle, true);
  // Update the state dependent components
  SequencingModeCbClick(nil);
  PrecisionDaTxtChange(nil);

  appIni := TIniFile.Create(ChangeFileExt(Application.ExeName,'.ini'));
  try
    fullModFilePath := appIni.ReadString('Modifications', 'LastModificationFile', '');
    if FileExists(fullModFilePath) = false then
      fullModFilePath := '';
  finally
    appIni.Free;
  end;

  if fullModFilePath <> '' then FillModificationLists;
end;

procedure TMainForm.FormCreate (Sender: TObject);
{* Initalize form *}
var DecimSep: integer;
begin
  // Set decimal character
  DecimSep := Ord(System.SysUtils.FormatSettings.DecimalSeparator = ',');
  Application.UpdateFormatSettings := False;
  // Setup spectrum viewer showing
  SpectrumWindow := TSpectrumView.Create (self);
  SpectrumWindow.Visible := False;
  ShowSpectrumWindowChk.Checked := False;
  ShowSpectrumWindowChk.Enabled := False;
  // Setup log window showing
  LogWindow := TFormLog.Create(self);
  SpectrumWindow.LogWindow := LogWindow;
  LogWindow.Visible := true;
  // Set sequencing mode
  SequencingModeCb.ItemIndex := 1;
  // Create sequencer
  DNSequencer := TDeNovoSequencer.Create;
  // Set show highest candidate maximum
  CandidateShowPeaksUd.MaxValue := High(DeNovoResArray);

  SetLength(sortTypeResultGrid, ResultGrid.ColCount);
  for var i := Low(sortTypeResultGrid) to High(sortTypeResultGrid) do
    Insert(ResultGrid.Cells[i, 0], resultGridColumnBaseHeaders, MaxInt);

  ResultGrid.ColWidths[0] := -1;
end;

{------------------------------------------------------------------------------}
procedure TMainForm.SequencingModeCbClick(Sender: TObject);
begin
  if SequencingModeCb.ItemIndex <> 0 then
    begin
      RunBtn.Caption := 'Run';
      // Enable automatic settings
      MaxMainPeaksUd.Enabled := True;
      MinTagLengthUd.Enabled := True;
      EnsureTagConnectChk.Enabled := True;
    end
  else
    begin
      RunBtn.Caption := 'Manual processing';
      // Disable automatic settings
      MaxMainPeaksUd.Enabled := False;
      MinTagLengthUd.Enabled := False;
      EnsureTagConnectChk.Enabled := False;
    end;
end;

procedure TMainForm.PrecisionDaTxtChange(Sender: TObject);
begin
  // Mass difference between Q and K is 0.036. If below this, allow the user to choose.
  if PrecisionDaTxt.FloatValue <= 0.03 then
    LysGlnEqualChk.Enabled := True
  else
  begin
    // If above this, set it to be equal
    LysGlnEqualChk.Enabled := False;
    LysGlnEqualChk.Checked := True;
  end;
end;

{---------------------------Project file---------------------------------------}
procedure TMainForm.BrowseSaveProjectFileBtnClick(Sender: TObject);
procedure SetDefaultProjectFile(filename: string);
begin
  ProjectSaveDlg.InitialDir := ExtractFilePath(filename);
  ProjectSaveDlg.FileName := ChangeFileExt(ExtractFileName(SplitString(filename, '(')[0]), '');
end;
begin
  if FileBasisNTxt.Text <> '' then
  begin
    SetDefaultProjectFile(FileBasisNTxt.Text);
  end
  else if FileBasisCTxt.Text <> '' then
  begin
    SetDefaultProjectFile(FileBasisCTxt.Text);
  end
  else if FileModNTxt.Text <> '' then
  begin
    SetDefaultProjectFile(FileModNTxt.Text);
  end
  else if FileModCTxt.Text <> '' then
  begin
    SetDefaultProjectFile(FileModCTxt.Text);
  end;


  if ProjectSaveDlg.Execute then
    FileProjectTxt.Text := ProjectSaveDlg.Filename;
end;

procedure TMainForm.OpenProjectBtnClick(Sender: TObject);
begin
  Exit;
end;
{--------------------------Select spectrum files-------------------------------}
procedure TMainForm.WMDropFiles (var msg: TWMDropFiles);
var i, count : integer;      nBuff : array [0..2048] of Char;
    fName, fExt : string; specTypeSelector: TSpectrumTypeSelector; specType: integer;
begin
  count := DragQueryFile (msg.Drop, $FFFFFFFF, nil, 0);
  for i := 0 to count - 1 do
  begin
    DragQueryFile (msg.Drop, i, nBuff, SizeOf (nBuff));
    fName := String (nBuff);
    fExt := JustExtension (LowerCase(fName));

    if (fExt <> 'txt') and (fExt <> 'xls') and (fExt <> 'mgf') and (fExt <> 'dnproj') and (fExt <> 'mod') then
    begin
      logWindow.AddLogMessage('File %s had an invalid extension: %s', [fName, fExt]);
      continue;
    end;

    // TODO: Load project file
    if fExt = 'dnproj' then
    begin
      FileProjectTxt.Text := fName;
      continue;
    end;

    if fExt = 'mod' then
    begin
      fullModFilePath := fName;
      FileModLabel.Caption := extractfilename(fullModFilePath);
      FillModificationLists;
      continue;
    end;

    if LoadAllSpectraChk.Checked and (fExt = 'mgf') then
      GetMgfSpectrum(fName, 0)
    else
    begin
      specTypeSelector := TSpectrumTypeSelector.Create(self);
      specTypeSelector.InitSelector(fName);

      if specTypeSelector.ShowModal() = mrOK then
      begin
        specType := specTypeSelector.selectedSpectrumType;

        if fExt = 'mgf' then
          GetMgfSpectrum(fName, specTypeSelector.selectedSpectrumType)
        else
          SetSpectrumData(specTypeSelector.selectedSpectrumType, fName,
                          Default(msmsSpectrumData), True);
      end;
      specTypeSelector.Free;
    end
  end;
end;

procedure TMainForm.BrowseBaseNFileBtnClick(Sender: TObject);
begin
  if SpectrumOpenDlg.Execute then
  begin
  if JustExtension(LowerCase(SpectrumOpenDlg.FileName)) <> 'mgf' then
    SetSpectrumData(0, SpectrumOpenDlg.FileName, Default(msmsSpectrumData), True)
  else
    GetMgfSpectrum(SpectrumOpenDlg.FileName, 0);
  end;
end;

procedure TMainForm.BrowseModNFileBtnClick(Sender: TObject);
begin
  if SpectrumOpenDlg.Execute then
  begin
  if JustExtension(LowerCase(SpectrumOpenDlg.FileName)) <> 'mgf' then
    SetSpectrumData(1, SpectrumOpenDlg.FileName, Default(msmsSpectrumData), True)
  else
    GetMgfSpectrum(SpectrumOpenDlg.FileName, 1);
  end
end;

procedure TMainForm.BrowseBaseCFileBtnClick(Sender: TObject);
begin
  if SpectrumOpenDlg.Execute then
  begin
  if JustExtension(LowerCase(SpectrumOpenDlg.FileName)) <> 'mgf' then
    SetSpectrumData(2, SpectrumOpenDlg.FileName, Default(msmsSpectrumData), True)
  else
    GetMgfSpectrum(SpectrumOpenDlg.FileName, 2);
  end;
end;

procedure TMainForm.BrowseModCFileBtnClick(Sender: TObject);
begin
  if SpectrumOpenDlg.Execute then
  begin
  if JustExtension(LowerCase(SpectrumOpenDlg.FileName)) <> 'mgf' then
    SetSpectrumData(3, SpectrumOpenDlg.FileName, Default(msmsSpectrumData), True)
  else
    GetMgfSpectrum(SpectrumOpenDlg.FileName, 3);
  end;
end;

procedure TMainForm.BasisNCSpectraEqualChkClick(Sender: TObject);
begin
  FileBasisCTxt.Enabled := BasisNCSpectraEqualChk.Checked = false;
  BrowseBaseCFileBtn.Enabled := BasisNCSpectraEqualChk.Checked = false;
end;

Procedure TMainForm.GetMgfSpectrum(filename: string; specType: integer);
var mgfSpectrumSelector : TMgfSpectrumSelector;
begin
  if FileExists(filename) = False then
  begin
    MessageDlg ('The MGF spectrum file does not exist!', mtError, [mbOK],
      0, mbOK);
    Exit;
  end;

  mgfSpectrumSelector := TMgfSpectrumSelector.Create(self);
  mgfSpectrumSelector.logWindow := LogWindow;
  mgfSpectrumSelector.SetLoadAll(LoadAllSpectraChk.Checked);

  if LoadAllSpectraChk.Checked then
    specType := 4;

  if mgfSpectrumSelector.LoadMgfFile(filename, specType) = False then
  begin
    mgfSpectrumSelector.Free;
    Exit;
  end;

  if mgfSpectrumSelector.ShowModal() = mrOK then
  begin
    if LoadAllSpectraChk.Checked then
    begin
      if Length(mgfSpectrumSelector.selectedBasisNSpectrum.spectrum) > 0 then
        SetSpectrumData(0, filename, mgfSpectrumSelector.selectedBasisNSpectrum, False);
      if Length(mgfSpectrumSelector.selectedModNSpectrum.spectrum) > 0 then
        SetSpectrumData(1, filename, mgfSpectrumSelector.selectedModNSpectrum, False);
      if Length(mgfSpectrumSelector.selectedBasisCSpectrum.spectrum) > 0 then
        SetSpectrumData(2, filename, mgfSpectrumSelector.selectedBasisCSpectrum, False);
      if Length(mgfSpectrumSelector.selectedModCSpectrum.spectrum) > 0 then
        SetSpectrumData(3, filename, mgfSpectrumSelector.selectedModCSpectrum, False);
    end
    else
    begin
      SetSpectrumData(specType, filename, mgfSpectrumSelector.selectedSpectrum, False);
    end;
  end;

  mgfSpectrumSelector.Free;

  if (Length(basisNMgfSpectrum.spectrum) > 0) and (Length(modNMgfSpectrum.spectrum) > 0) then
    DeltaMassNTxt.Text := Real2Str(modNMgfSpectrum.header.mass - basisNMgfSpectrum.header.mass, 0, 3);

  if (Length(basisCMgfSpectrum.spectrum) > 0) and (Length(modCMgfSpectrum.spectrum) > 0) then
    DeltaMassCTxt.Text := Real2Str(modCMgfSpectrum.header.mass - basisCMgfSpectrum.header.mass, 0, 3);
end;

Procedure TMainForm.SetSpectrumData(specType: integer; fileName: string; spec: msmsSpectrumData; isMaldiSpec: boolean);
// SpecType: 0 = Basis N-term, 1 = Mod N-term, 2 = Basis C-term, 3 = Basis N-term
var fileBoxText: string;
begin
  if isMaldiSpec then
    fileBoxText := fileName
  else if Length(spec.spectrum) > 0 then
    fileBoxText := Format('%s (Precursor m/z: %0.3f)', [filename, spec.header.precursorMz])
  else
    fileBoxText := '';

  case specType of
    0: begin
      FileBasisNTxt.Text := fileBoxText;
      basisNMgfSpectrum := spec;
    end;
    1: begin
      FileModNTxt.Text := fileBoxText;
      modNMgfSpectrum := spec;
    end;
    2: begin
      FileBasisCTxt.Text := fileBoxText;
      basisCMgfSpectrum := spec;
    end;
    3: begin
      FileModCTxt.Text := fileBoxText;
      modCMgfSpectrum := spec;
    end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TMainForm.RunBtnClick(Sender: TObject);
var spectra: msmsSpectrumDataFull; autoDeNovoSettings: AutoDeNovoSeqSettings; seqSettings: SequencerSettings;
  isMaldiSpec: boolean;
begin
if ValidateParameters(isMaldiSpec) = False then
  Exit;

// Get the selected modifications
GenerateResidueMassList(selectedMods,leuIleEqualChk.Checked, lysGlnEqualChk.Checked);

// Reset the result grid
ResetResultGrid;

with seqSettings do
begin
  // Set general sequencing settings
  basisNSpectrumFile := FileBasisNTxt.Text;
  modNSpectrumFile := FileModNTxt.Text;

  if BasisNCSpectraEqualChk.Checked then
    basisCSpectrumFile := basisNSpectrumFile
  else
    basisCSpectrumFile := FileBasisCTxt.Text;

  modCSpectrumFile := FileModCTxt.Text;

  loadedSpectra[0] := basisNSpectrumFile <> '';
  loadedSpectra[1] := modNSpectrumFile <> '';
  loadedSpectra[2] := basisCSpectrumFile <> '';
  loadedSpectra[3] := modCSpectrumFile <> '';

  nTermDeltaMass := DeltaMassNTxt.FloatValue;
  cTermDeltaMass := DeltaMassCTxt.FloatValue;
  nTermMass := NTermMassTxt.FloatValue;
  cTermMass := CTermMassTxt.FloatValue;
  isMaldi := isMaldiSpec;
  precision := PrecisionDaTxt.FloatValue;
  leuIleEqual := leuIleEqualChk.Checked;
  lysGlnEqual := lysGlnEqualChk.Checked;
  showNMostIntenseCandidates :=  Math.Floor(CandidateShowPeaksUd.Value);

  // Set automatic sequencing settings
  sequencingMode := SequencingModeCb.ItemIndex;

  // Set modifications
  modificationFile := FileModLabel.Caption;
  modifications := Copy(selectedMods, 0, 0);
end;

with autoDeNovoSettings do
begin
  maxMainPeaks := Math.Floor(maxMainPeaksUd.Value);
  minTagLength := Math.Floor(MinTagLengthUd.Value);
  ensureTagConnect := EnsureTagConnectChk.Checked;
end;

logWindow.AddLogMessage('Processing spectra...');
// Get the spectra
if seqSettings.isMaldi then
begin
  spectra := ProcessMaldiSpectraFiles(FileBasisNTxt.Text, FileModNTxt.Text,
                                      FileBasisCTxt.Text, FileModCTxt.Text,
                                      seqSettings, logWindow);
end
else
begin
  spectra := ProcessSpectraFiles(basisNMgfSpectrum, modNMgfSpectrum,
                                 basisCMgfSpectrum, modCMgfSpectrum,
                                 seqSettings, logWindow);
end;

logWindow.AddLogMessage('Spectra processed');

SpectrumWindow.InitSpectrumViewer(spectra, seqSettings, SequencingModeCb.ItemIndex = 0);

// If manual sequencing, abort
if seqSettings.sequencingMode = 0 then
  begin
    logWindow.AddLogMessage('Manual de novo sequencing is selected - No automatic sequencing is performed!');
    SetLength(DNResults, 0);
  end
else
  begin
    seqSettings.fullSpectrum.headers := spectra.headers;
    seqSettings.fullSpectrum.spectrum := SpectrumWindow.FullSpectrum;
    // Initalize the de novo sequencer and start the sequencing
    DNSequencer.InitSequencer(seqSettings, autoDeNovoSettings, logWindow);
    DNResults := DNSequencer.PerformSequencing();

    //SaveProject(FileProjectTxt.Text, seqSettings, autoDeNovoSettings, DNResults);

    if (SequencingModeCb.ItemIndex <> 0) and (Length(DNResults) > 0) then
      FillResultGrid;
  end;

// Enable the viewing of spectra
ShowSpectrumWindowChk.Enabled := True;
end;

Function TMainForm.ValidateParameters(var isMaldi: boolean) : boolean;
var isBasisNMgf, isModNMgf, isBasisCMgf, isModCMgf: bool;
begin
  Result := True;

  if (FileBasisNTxt.Text = '') and (FileModNTxt.Text = '') and
     (FileBasisCTxt.Text = '') and (FileModCTxt.Text = '') then
  begin
    MessageDlg ('At least one spectrum file must be provided!', mtError, [mbOK],
      0, mbOK);
    Result := False;
  end
  else if FileBasisNTxt.Text <> '' then
  begin
    if FileExists(SplitString(FileBasisNTxt.Text, '(')[0]) = False then
    begin
      MessageDlg ('The basis N-terminal spectrum file does not exist!', mtError, [mbOK],
        0, mbOK);
      Result := False;
    end
  end
  else if FileModNTxt.Text <> '' then
  begin
    if FileExists(SplitString(FileModNTxt.Text, '(')[0]) = False then
    begin
      MessageDlg ('The modified N-terminal spectrum file does not exist!', mtError, [mbOK],
        0, mbOK);
      Result := False;
    end
  end
  else if FileBasisCTxt.Text <> '' then
  begin
    if FileExists(SplitString(FileBasisCTxt.Text, '(')[0]) = False then
    begin
      MessageDlg ('The basis C-terminal spectrum file does not exist!', mtError, [mbOK],
        0, mbOK);
      Result := False;
    end
  end
  else if FileModCTxt.Text <> '' then
  begin
    if FileExists(SplitString(FileModCTxt.Text, '(')[0]) = False then
    begin
      MessageDlg ('The modified C-terminal spectrum file does not exist!', mtError, [mbOK],
        0, mbOK);
      Result := False;
    end
  end
  else if (FileProjectTxt.Text = '') then
  begin
    MessageDlg ('The project file is missing!', mtError, [mbOK],
      0, mbOK);
    Result := False;
  end
  else if PrecisionDaTxt.FloatValue < 0.001 then
  begin
    MessageDlg ('The precision must be larger than 0.001 Da!', mtError, [mbOK],
      0, mbOK);
    Result := False;
  end
  else if DeltaMassNTxt.FloatValue = 0 then
  begin
    MessageDlg ('The N-term mass change must not be 0 Da!', mtError, [mbOK],
      0, mbOK);
    Result := False;
  end
  else if DeltaMassCTxt.FloatValue = 0 then
  begin
    MessageDlg ('The C-term mass change must not be 0 Da!', mtError, [mbOK],
      0, mbOK);
    Result := False;
  end
  else if twoFixModsResidiue then
  begin
    MessageDlg ('Two fixed modifications on the same residue!', mtError, [mbOK],
      0, mbOK);
    Result := False;
  end;

  if Result = False then
    Exit;

  isBasisNMgf := (Length(basisNMgfSpectrum.spectrum) > 0) or (FileBasisNTxt.Text = '');
  isModNMgf := (Length(modNMgfSpectrum.spectrum) > 0) or (FileModNTxt.Text = '');
  isBasisCMgf := (Length(basisCMgfSpectrum.spectrum) > 0) or (FileBasisCTxt.Text = '');
  isModCMgf := (Length(modCMgfSpectrum.spectrum) > 0) or (FileModCTxt.Text = '');


  if (isBasisNMgf and ((isModNMgf = False) or (isBasisCMgf = False) or (isModCMgf = false))) or
     ((isBasisNMgf = False) and (isModNMgf or isBasisCMgf or isModCMgf)) then
  begin
    MessageDlg ('The spectra files must be of the same type (MALDI or ESI)!', mtError, [mbOK],
       0, mbOK);
    Result := False;
  end
  else
    Result := True;

  isMaldi := ((Length(basisNMgfSpectrum.spectrum) > 0) or (Length(modNMgfSpectrum.spectrum) > 0) or
              (Length(basisCMgfSpectrum.spectrum) > 0) or (Length(modCMgfSpectrum.spectrum) > 0)) = false;
end;

{-----------------------------Result grid--------------------------------------}
Procedure TMainForm.ResetResultGrid;
begin
SetLength(DNResults, 0);
ResultGrid.RowCount := 2;
ResultGrid.FixedRowAlways := False;

for var i := 0 to ResultGrid.ColCount - 1 do
  ResultGrid.Cells[i, 1] := '';

ResultGrid.Update;
ResultGrid.FixedRows := 1;
SequenceResultLabel.Caption := '';
TagLengthResultLabel.Caption := '';
ScoreResultLabel.Caption := '';
PrecursorResultLabel.Caption := '';
ChargeResultLabel.Caption := '';
MassResultLabel.Caption := '';
ModificationResultLabel.Caption := '';

end;

procedure TMainForm.FillResultGrid;
Function GetSeriesIndicator(seriesTag: DNSequenceSeriesTag) : string;
begin
  if seriesTag.mainPeakIdx <> 0 then result := 'Y'
  else result := 'N';
end;
Procedure GetSeriesIndicators(tag: DNSequenceTag);
begin
  ResultGrid.Cells[5, ResultGrid.RowCount-1] := GetSeriesIndicator(tag.nTermBasis);
  ResultGrid.Cells[6, ResultGrid.RowCount-1] := GetSeriesIndicator(tag.nTermMod);
  ResultGrid.Cells[7, ResultGrid.RowCount-1] := GetSeriesIndicator(tag.nTermCombined);
  ResultGrid.Cells[8, ResultGrid.RowCount-1] := GetSeriesIndicator(tag.cTermBasis);
  ResultGrid.Cells[9, ResultGrid.RowCount-1] := GetSeriesIndicator(tag.cTermMod);
  ResultGrid.Cells[10, ResultGrid.RowCount-1] := GetSeriesIndicator(tag.cTermCombined);
end;
var i: integer; row: integer;
begin
  ResultGrid.StartUpdate;

  for i := Low(DNResults) to High(DNResults) do
  begin
    row := ResultGrid.RowCount;
    ResultGrid.Cells[0, row-1] := IntToStr(i);
    ResultGrid.Cells[1, row-1] := DNResults[i].tag.seq1LetMod;
    ResultGrid.Cells[2, row-1] := FloatToStr(DNResults[i].score);
    ResultGrid.Cells[3, row-1] := FloatToStr(DNResults[i].tag.precursor);
    ResultGrid.Cells[4, row-1] := FloatToStr(DNResults[i].massDeviation);
    GetSeriesIndicators(DNResults[i]);

    ResultGrid.RowCount := row + 1;
  end;
  ResultGrid.EndUpdate;
  ResultGrid.RowCount := ResultGrid.RowCount - 1;

  ResultGrid.Update;
  ResultGrid.FixedRows := 1;
  ResultGridClick(nil);
end;

procedure TMainForm.ResultGridFixedCellClick(Sender: TObject; ACol,
  ARow: Integer);
Procedure SetDefault;
begin
  ResultGrid.Cells[ACol, 0] := Format('%s', [resultGridColumnBaseHeaders[ACol]]);
end;
Procedure SetAscending;
begin
  ResultGrid.Sort(Acol, AdvGrid.sdAscending);
  ResultGrid.Cells[ACol, 0] := Format('%s%s', [resultGridColumnBaseHeaders[ACol], #9660]);
end;
Procedure SetDecending;
begin
  ResultGrid.Sort(ACol, AdvGrid.sdDescending);
  ResultGrid.Cells[ACol, 0] := Format('%s%s', [resultGridColumnBaseHeaders[ACol], #9650]);
end;
begin
  sortTypeResultGrid[ACol] := (sortTypeResultGrid[ACol] + 1) mod 2;

  for var i := Low(resultGridColumnBaseHeaders) to High(resultGridColumnBaseHeaders) do
  begin
    ResultGrid.Cells[i, 0] := resultGridColumnBaseHeaders[i];
    if i <> ACol then sortTypeResultGrid[i] := -1;
  end;

  case sortTypeResultGrid[ACol] of
  -1: SetDefault;
  0: SetAscending;
  1: SetDecending;
  end;
end;

procedure TMainForm.ResultGridClick(Sender: TObject);
var res: DNSequenceTag; i: integer; modString: string;
begin
  if (ResultGrid.Row = 0) or (ResultGrid.Row > Length(DNResults)) then Exit;

  res := DNResults[StrToInt(ResultGrid.Cells[0, ResultGrid.Row])];
  modString := '';
  if Length(res.modifications) > 0 then
  begin
    for i := Low(res.modifications) to High(res.modifications) do
      modString := Format('%s%s, ', [modString, res.modifications[i].modString]);

    SetLength(modString, Length(modString)-2);
  end;

  // Add data to Main form
  SequenceResultLabel.Caption := res.tag.seq1Let;
  TagLengthResultLabel.Caption := IntToStr(res.tag.length);
  ScoreResultLabel.Caption := FloatToStr(res.score);
  PrecursorResultLabel.Caption := FloatToStr(res.tag.precursor);
  ChargeResultLabel.Caption := FloatToStr(res.tag.charge);
  MassResultLabel.Caption := FloatToStr(res.tag.mass);
  ModificationResultLabel.Caption := modString;
  // Send data to spectrum view
  SpectrumWindow.SetDNResult(res);
end;

procedure TMainForm.ResultGridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
Procedure ColorSeriesIndicator(columnIdx: integer);
begin
  if (ACol <> columnIdx) then Exit;

  if ResultGrid.Cells[ACol, ARow] = 'Y' then
    ResultGrid.Canvas.Brush.Color := clGreen
  else
    ResultGrid.Canvas.Brush.Color := clRed;

  ResultGrid.Canvas.FillRect(Rect);
  ResultGrid.Canvas.TextOut(Rect.Left+2,Rect.Top+2, ResultGrid.Cells[ACol, ARow]);
  ResultGrid.Canvas.Brush.Color := clNone;
end;
begin
  if (ARow = 0) or (ResultGrid.Row > Length(DNResults)) then Exit;

  ColorSeriesIndicator(5);
  ColorSeriesIndicator(6);
  ColorSeriesIndicator(7);
  ColorSeriesIndicator(8);
  ColorSeriesIndicator(9);
  ColorSeriesIndicator(10);
end;

{------------------------------------------------------------------------------}
procedure TMainForm.ShowSpectrumWindowChkClick(Sender: TObject);
begin
  SpectrumWindow.Visible := ShowSpectrumWindowChk.Checked;
end;

procedure TMainForm.ShowLogWindowChkClick(Sender: TObject);
begin
  LogWindow.Visible := ShowLogWindowChk.Checked;
end;

{---------------------------Modifications--------------------------------------}
procedure TMainForm.SelectModFileBtnClick(Sender: TObject);
begin
  if ModOpenDlg.Execute() then
  begin
    fullModFilePath := ModOpenDlg.FileName;
    FillModificationLists;
  end;
end;

procedure TMainForm.EditModificationBtnClick(Sender: TObject);
var modWin : TModificationView;
begin
  modWin := TModificationView.Create(self);
  modWin.Init;
  modWin.logWindow := LogWindow;

  if fullModFilePath <> '' then
    modWin.SetModifications(fullModFilePath, allMods);

  if modWin.ShowModal() = mrOK then
  begin
    modWin.SaveModFileBtnClick(self);
    fullModFilePath := modWin.FileModTxt.Text;
    FileModLabel.Caption := extractfilename(fullModFilePath);
    allMods := modWin.modificationList;
    FillModificationLists;
  end;
  modWin.Free;
end;

procedure TMainForm.FillModificationLists;
var i: Integer; modText: string;
begin
  if LoadModificationFile(fullModFilePath, allMods, logWindow) = False then
  begin
    MessageDlg (Format('Could not load modification file at %s!', [fullModFilePath]), mtError, [mbOK],
      0, mbOK);
    FileModLabel.Caption := '';
    Exit;
  end;

  FileModLabel.Caption := extractfilename(fullModFilePath);
  SetLength(selectedMods, 0);
  VarModSelect.Clear;
  FixModSelect.Clear;
  for i := Low(allMods) to High(allMods) do
  begin
    modText := Format('%s %0.3f [%s]',
      [allMods[i].name, allMods[i].massChange, allMods[i].residues]);

      if allmods[i].fixedModification then
        FixModSelect.AddItem(modText, TObject(i))
      else
        VarModSelect.AddItem(modText, TObject(i))
  end;
end;

procedure TMainForm.FixModSelectClick(Sender: TObject);
begin
  GetSelectedModifications;
end;

procedure TMainForm.VarModSelectClick(Sender: TObject);
begin  
  GetSelectedModifications;
end;

procedure TMainForm.GetSelectedModifications;
Procedure AddModification(modIdx: integer);
begin
  SetLength(selectedMods, Length(selectedMods)+1);
  selectedMods[High(selectedMods)] := allMods[modIdx];
end;
var i, modIdx: integer; fixedModResidues: TList<char>;
    modi: PossibleModification; res: char;
begin

  twoFixModsResidiue := False;
  SetLength(selectedMods, 0);
  fixedModResidues := TLIst<char>.Create;

  for i := 0 to VarModSelect.Items.Count - 1 do
    if VarModSelect.Selected[i] then
    begin
      modIdx := Integer(VarModSelect.Items.Objects[i]);
      AddModification(modIdx);
    end;

  for i := 0 to FixModSelect.Items.Count - 1 do
    if FixModSelect.Selected[i] then
    begin
      modIdx := Integer(FixModSelect.Items.Objects[i]);
      AddModification(modIdx);

      modi := allMods[modIdx];

      for res in modi.residues do
      begin
        if fixedModResidues.IndexOf(res) <> -1 then
          twoFixModsResidiue := True;

        fixedModResidues.Add(res);
      end;
    end;

end;

{------------------------------------------------------------------------------}
procedure TMainForm.CloseBtnClick (Sender: TObject);
begin
  Close;
end;

Procedure TMainForm.FormClose (Sender: TObject; var Action: TCloseAction);
{* Initalize form and free resources *}
var appIni: TIniFile;
begin
  if fullModFilePath <> '' then
  begin
    appIni := TIniFile.Create(ChangeFileExt(Application.ExeName,'.ini'));
    try
      appIni.WriteString('Modifications', 'LastModificationFile', fullModFilePath)
    finally
      appIni.Free;
    end;
  end;

  if SpectrumWindow <> nil then
    SpectrumWindow.Free;
  if ModificationView <> nil then
    ModificationView.Free;
  if DNSequencer <> nil then
    DNSequencer.Free;
  if mgfSpectrumSelector <> nil then
    mgfSpectrumSelector.Free;

  DragAcceptFiles (self.Handle, false);
end;
{------------------------------------------------------------------------------}

end.
