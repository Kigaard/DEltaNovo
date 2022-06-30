unit SpectrumViewForm;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, Vcl.Menus,
  AdvMenus, VCLTee.TeEngine, VCLTee.Series, VCLTee.TeeProcs, VCLTee.Chart, Vcl.StdCtrls,
  AdvCombo, AdvOfficeButtons, AdvGlowButton, AdvTrackBar, AdvEdit, AdvToolBtn,
  AdvPageControl, Vcl.ComCtrls, Vcl.ExtCtrls, AdvPanel, General, globals,
  AdvUtil, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, SpectraUtils, GeneralUtils,
  DeNovoSequencingUtils, LogForm, DeNovoRecords, System.Math,
  advmultibuttonedit, AdvUpDownEdit;

type
    tMgfHeader = record
                    mz, mass, intens, retention : real;
                    charge, scan, mzmzCount, stacked, lineNdx, ptNdx : integer;
                    ionSum : int64;
                    specUsed : boolean;
                    mode : packed array [1..4] of byte;
                    title : string;
                    end;

    tMgfFileRec = record
                  header : tMgfHeader;
                  spec : msmsSpectrum;
                  end;

{ Ion colors for spectrum and precision chart }
const OVERALL_COL = clLime;
      FRAGMENT_ION_COL =     clOrange;
      IMMONIUM_ION_COL =     clAqua;

      B_ION_COL =            clBlue;
      B_17_ION_COL =         clTeal;
      B_18_ION_COL =         $00E0C011;

      Y_ION_COL =            clRed;
      Y_17_ION_COL =         clPurple;
      Y_18_ION_COL =         clFuchsia;

type
  TSpectrumView = class (TForm)
    RightPanel: TAdvPanel;
    RightPageCtrl: TAdvPageControl;
    DeNovoTab: TAdvTabSheet;
    HelpLbl: TLabel;
    Label2: TLabel;
    SequenceBtn: TAdvToolButton;
    NewSequenceBtn: TAdvGlowButton;
    CopySeqBtn: TAdvGlowButton;
    TrimSeqNBtn: TAdvGlowButton;
    TrimSeqCBtn: TAdvGlowButton;
    HighlightNTermPeaksChk: TAdvOfficeCheckBox;
    BackPanel: TAdvPanel;
    MainChart: TChart;
    BarSeries: TBarSeries;
    DNSeqCopyTypePop: TAdvPopupMenu;
    CopySeq1: TMenuItem;
    CopySeq3: TMenuItem;
    CopySeqMass: TMenuItem;
    BackupSeqPop: TAdvPopupMenu;
    seqM1: TMenuItem;
    seqM2: TMenuItem;
    seqM3: TMenuItem;
    seqM4: TMenuItem;
    seqM5: TMenuItem;
    CopySpectrumBtn: TAdvGlowButton;
    IonPrecisionChart: TChart;
    IonPrecisionSeries: TPointSeries;
    ViewBasisCSpectrumRadBtn: TRadioButton;
    ViewModNSpectrumRadBtn: TRadioButton;
    ViewModCSpectrumRadBtn: TRadioButton;
    ViewDeconvolutedChk: TAdvOfficeCheckBox;
    Label6: TLabel;
    HighlightCTermPeaksChk: TAdvOfficeCheckBox;
    Label1: TLabel;
    HighlightFragmentPeaksChk: TAdvOfficeCheckBox;
    HighlightNLPeaksChk: TAdvOfficeCheckBox;
    SaveSeqsBtn: TAdvGlowButton;
    SaveDlg: TSaveDialog;
    N1: TMenuItem;
    CopyModSeq1: TMenuItem;
    CopyModSeq3: TMenuItem;
    CopyModSeqMass: TMenuItem;
    HighlightImmoniumPeaksChk: TAdvOfficeCheckBox;
    ViewBasisNSpectrumRadBtn: TRadioButton;
    Label28: TLabel;
    CandidateShowPeaksUd: TAdvUpDownEdit;
    Label29: TLabel;
    SpectrumTab: TAdvTabSheet;
    Label3: TLabel;
    PkWidthDrop: TAdvComboBox;
    ViewCombinedSpectrumChk: TAdvOfficeCheckBox;
    procedure BarSeriesClick (Sender: TChartSeries; ValueIndex: Integer;
                       Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure MainChartAfterDraw (Sender: TObject);
    procedure MainChartClick (Sender: TObject);
    procedure MainChartKeyUp (Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MainChartScroll (Sender: TObject);
    procedure MainChartZoom (Sender: TObject);
    procedure MainChartUndoZoom (Sender: TObject);
    procedure MainChartDblClick (Sender: TObject);
    procedure NewSequenceBtnClick (Sender: TObject);
    procedure SeqLblMouseEnter (Sender: TObject);
    procedure HighlightNTermPeaksChkClick (Sender: TObject);
    procedure PkWidthDropChange (Sender: TObject);
    procedure TrimSeqNBtnClick(Sender: TObject);
    procedure TrimSeqCBtnClick(Sender: TObject);
    procedure CopySeq1Click(Sender: TObject);
    procedure CopySeq3Click(Sender: TObject);
    procedure CopySeqMassClick(Sender: TObject);
    procedure seqM1Click(Sender: TObject);
    procedure seqM2Click(Sender: TObject);
    procedure seqM3Click(Sender: TObject);
    procedure seqM4Click(Sender: TObject);
    procedure seqM5Click(Sender: TObject);
    procedure CopySpectrumBtnClick(Sender: TObject);
    procedure ViewBasisNSpectrumRadBtnClick(Sender: TObject);
    procedure ViewModNSpectrumRadBtnClick(Sender: TObject);
    procedure ViewBasisCSpectrumRadBtnClick(Sender: TObject);
    procedure ViewDeconvolutedChkClick(Sender: TObject);
    procedure HighlightFragmentPeaksChkClick(Sender: TObject);
    procedure HighlightNLPeaksChkClick(Sender: TObject);
    procedure HighlightCTermPeaksChkClick(Sender: TObject);
    procedure SaveSeqsBtnClick(Sender: TObject);

    procedure CopyModSeq1Click(Sender: TObject);
    procedure CopyModSeq3Click(Sender: TObject);
    procedure CopyModSeqMassClick(Sender: TObject);
    procedure ViewCombinedSpectrumChkClick(Sender: TObject);
    procedure ViewModCSpectrumRadBtnClick(Sender: TObject);
    procedure MainChartAllowScroll(Sender: TChartAxis; var AMin, AMax: Double;
      var AllowScroll: Boolean);
  private
    DeNovoCandidates : DeNovoResCandidates;
    seqLen : integer;
    BackupSeq : array [1..5] of DeNovoSeqArray;
    settings: SequencerSettings;
    graphTitle : string;
    baseCaption: string;
    combinedSpectrum: boolean;
    manualDeNovoSeqEnabled: boolean;

    autoDeNovoResult : DNSequenceTag;
    selectAutoDNSeries: DNSequenceSeriesTag;

    rawSpectrumIdx : integer;
    spectrumIdx: integer;

    Function PointInDNBox (tp : tPoint;var n1, n2 : integer) : boolean;
    Procedure FindAAdist (valueIndex : integer);
    Procedure SetSequenceResidue(dir: integer; rank: integer);
    procedure UpdateIonPrecisionChart(totalMassDeviation: real = -9999);
    Procedure BackupSequence(slotIdx: integer; seqMenuItem: TMenuItem;
                             overwriteFilledSlot: boolean);
    Procedure SetNewSpectrum(rawSpecIdx: integer);

  public
    LogWindow : TFormLog;
    Precision: real;
    DNseq : DeNovoSeqArray;             //de novo sequence
    FullSpectrum: msmsSpectrum;
    FullSpectrumHeaders: array[0..9] of msmsHeaderData;
    currentSelectionDirection: integer;
    
    Procedure DisplaySpectrum;
    Procedure AfterConstruction; override;
    Procedure ClearGraph;


    Procedure TransferPeaks (var minX: real; var maxX: real; var maxY: real); virtual;
    Procedure ColorCombinedIons();
    Procedure InitSpectrumViewer(spec: msmsSpectrumDataFull; genSettings: SequencerSettings; manualDeNovo: boolean);
    Procedure CalculatePeakPosition(var peak: Residue);
    Procedure CalculateCandidatePeakPositions();
    Procedure CalculateDeNovoSequencePeakPositions();
    Procedure SetDNResult(res: DNSequenceTag);
    Procedure SetDNResultSeries;
    Procedure UpdateDNResultSeries;
  end;
  procedure GraphLineOut (chrt : tChart; s : string; lvl, col : integer);

var SpectrumView: TSpectrumView;

implementation

{$R *.dfm}
{ TSpecView }
{-----------------------------------------------------------------------------}

procedure GraphLineOut (chrt : tChart; s : string; lvl, col : integer);
var chH, chW, prevCol : integer;
begin
  chW := chrt.Canvas.TextWidth (s) + 5;
  chH := chrt.Canvas.TextHeight ('hy');

  prevCol := chrt.Canvas.Font.Color;
  chrt.Canvas.Font.Color := col;
  if lvl > 0 then
    chrt.Canvas.TextOut (chrt.ChartRect.Right - chW, chrt.ChartRect.Top + (lvl - 1) * chH + 5, s)
  else chrt.Canvas.TextOut (chrt.ChartRect.left + 5, chrt.ChartRect.top + 6, s);

  chrt.Canvas.Font.Color := prevCol;
end;

{-----------------------------------------------------------------------------}

procedure TSpectrumView.AfterConstruction;
begin
  inherited;
  graphTitle := '';
  NewSequenceBtnClick(nil);
  baseCaption := Caption;
  PkWidthDrop.ItemIndex := 1;
  BarSeries.CustomBarWidth := 1;
  CandidateShowPeaksUd.MaxValue := High(DeNovoResArray);
end;

{-----------------------------------------------------------------------------}

procedure TSpectrumView.MainChartAfterDraw(Sender: TObject);
var chX, chY, i, x, y : integer; m : real;
Procedure UpdateGraphTitle;
var specType, seqInfo, addInfo: string; tag: SequenceTag;
begin
  case spectrumIdx of
  0: specType := 'Basis N-terminal';
  1: specType := 'Modified N-terminal';
  2: specType := 'Basis N-terminal (Deconvoluted)';
  3: specType := 'Modified N-terminal (Deconvoluted)';
  4: specType := 'Combined N-terminal';
  5: specType := 'Basis C-terminal';
  6: specType := 'Modified C-terminal';
  7: specType := 'Basis C-terminal (Deconvoluted)';
  8: specType := 'Modified C-terminal (Deconvoluted)';
  9: specType := 'Combined C-terminal';
  end;

  if seqLen < 1 then
  begin
    graphTitle := specType;
    Exit;
  end;

  tag := GetSequenceTagFragment(DNSeq, FullSpectrumHeaders[spectrumIdx].charge, True, spectrumIdx > 5);
  seqInfo := Format('%s (M: %0.3f)', [tag.seq1LetMod, tag.mass]);

  if manualDeNovoSeqEnabled then addInfo := 'Manual De Novo'
  else addInfo := Format('Score %0.3f (Series score: %0.3f)',
        [autoDeNovoResult.score, selectAutoDNSeries.score]);

  graphTitle := Format('%s - %s - %s', [specType, seqInfo, addInfo]);
  specType := '';
  seqInfo := '';
end;
Procedure DrawRes (var DNres : DeNovoResArray; lvl : integer);
var yLvlPos : integer;
begin
  with MainChart.Canvas do
  begin
    yLvlPos := (DNres [lvl].level + 1) * chY;
    Pen.Color := ChargeCol [lvl];
    MoveTo (DeNovoCandidates.basePks.xPos, yLvlPos);
    LineTo (DNres [lvl].xPos, yLvlPos);
    LineTo (DNres [lvl].xPos, DNres [lvl].yPos);
    DNres [lvl].resBox.left := (DeNovoCandidates.basePks.xPos + DNres [lvl].xPos) div 2 - chX;
    DNres [lvl].resBox.top := yLvlPos - (chY div 2);
    DNres [lvl].resBox.bottom := DNres [lvl].resBox.top + chY;
    DNres [lvl].resBox.right := DNres [lvl].resBox.left + TextWidth (DNres [lvl].res3Mod);
    TextOut (DNres [lvl].resBox.left, DNres [lvl].resBox.top, DNres [lvl].res3Mod);
  end;
end;

begin
  //UpdateGraphTitle;
  CalculateCandidatePeakPositions;
  CalculateDeNovoSequencePeakPositions;
//draw zero line
  MainChart.Canvas.Pen.Color := clGray;
  MainChart.Canvas.MoveTo (MainChart.ChartRect.Left, MainChart.LeftAxis.CalcYPosValue (0));
  MainChart.Canvas.LineTo (MainChart.ChartRect.Right, MainChart.LeftAxis.CalcYPosValue (0));
//draw residue options
  with MainChart.Canvas do
  begin
    chY := TextHeight ('hy');
    chX := TextWidth ('w');

    if GraphTitle <> '' then GraphLineOut (MainChart, GraphTitle, 0, clGreen);

    if manualDeNovoSeqEnabled then
    begin
      Pen.Color := clRed;
      Pen.Style := psDot;
      Pen.Style := psDash;
      for i := 1 to 6 do
        if DeNovoCandidates.newPks [1, i].xPos > 0 then
          DrawRes (DeNovoCandidates.newPks [1], i);
      for i := 1 to 6 do
        if DeNovoCandidates.newPks [2, i].xPos > 0 then
          DrawRes (DeNovoCandidates.newPks [2], i);

      if FullSpectrumHeaders[spectrumIdx].charge > 2 then                  //draw charge reduced parent ions
      for i := 2 to FullSpectrumHeaders[spectrumIdx].charge do
      begin
        MainChart.Canvas.Pen.Color := clLime;
        MainChart.Canvas.Pen.Width := 2;
        MainChart.Canvas.Pen.Style := psSolid;
        m := (FullSpectrumHeaders[spectrumIdx].mass + protonms * i) / i;
        x := MainChart.BottomAxis.CalcXPosValue (m);
        y := MainChart.LeftAxis.CalcYPosValue (0) + 2;
        MainChart.Canvas.MoveTo (x, y);
        MainChart.Canvas.LineTo (x, y + 20);
        MainChart.Canvas.Font.Color := clGreen;
        MainChart.Canvas.TextOut (x, y, IntToStr (i));
      end;
    end;

    if seqLen > 0 then                            //draw de novo sequence
    begin
      Pen.Color := clBlue;
      Pen.Style := psDash;
      MoveTo (DNseq [1].xPos, chY * 2);
      LineTo (DNseq [1].xPos, chY);

      for i := 2 to seqLen + 1 do
      begin
        if DNseq [i].xPos > 0 then
        begin
        LineTo (DNseq [i].xPos, chY);
        LineTo (DNseq [i].xPos, chY * 2);
        TextOut ((DNseq [i].xPos + DNseq [i - 1].xPos) div 2 - chX, chY - (chY div 2), DNseq [i-1].res3Mod); // TODO: Center independent of modifications etc.
        MoveTo (DNseq [i].xPos, chY);
        end;
      end;
    end;
  end;
end;

procedure TSpectrumView.MainChartAllowScroll(Sender: TChartAxis; var AMin,
  AMax: Double; var AllowScroll: Boolean);
begin
  AllowScroll := AMin > 0;
end;

{-----------------------------------------------------------------------------}

procedure TSpectrumView.MainChartClick (Sender: TObject);
var tp : tPoint;       x1, x2: integer;      
begin
  tp := MainChart.GetCursorPos;
  if PointInDNBox (tp, x1, x2) then
  begin
    SetSequenceResidue(x1, x2);    
  end;
end;

Procedure TSpectrumView.SetSequenceResidue(dir: integer; rank: integer);
var first, last : Residue;
begin
  if DeNovoCandidates.newPks [dir, rank].mz < DeNovoCandidates.basePks.mz then
    begin
      first := DeNovoCandidates.newPks [dir, rank];                  //down peaks
      last :=  DeNovoCandidates.basePks;
      currentSelectionDirection := 1;
    end else begin                                     //up peaks
      first := DeNovoCandidates.basePks;
      last := DeNovoCandidates.newPks [dir, rank];
      currentSelectionDirection := 2;
    end;
    if seqLen = 0 then
    begin
      DNseq [1] := first;
      DNseq [2] := last;
      seqLen := 1;
    end else
      if Abs (last.mz - DNseq [1].mz) < Precision then
      begin
        for var i := seqLen + 1 downto 1 do
        begin
          DNseq [i + 1] := DNseq [i];
        end;
        DNSeq [1] := first;
        Inc (seqLen);
      end else
        if Abs (first.mz - DNseq [seqLen + 1].mz) < Precision then
          DNseq [FInc (seqLen) + 1] := last;

  UpdateIonPrecisionChart();
  MainChart.Invalidate;
end;
{-----------------------------------------------------------------------------}

procedure TSpectrumView.MainChartDblClick (Sender: TObject);
begin
  FillChar (DeNovoCandidates, SizeOf (DeNovoCandidates), 0);
  MainChart.Invalidate;
end;

{-----------------------------------------------------------------------------}

procedure TSpectrumView.MainChartKeyUp (Sender: TObject; var Key: Word; Shift: TShiftState);
var i: Integer;
begin
  if (SeqLen > 0) and (ssCtrl in Shift) then
    if key = VK_return then
    begin
      SetSequenceResidue(currentSelectionDirection, 1);
    end else
    if key = VK_left then
    begin
      for i := 0 to BarSeries.Count - 1 do
        if Abs (Barseries.XValue [i] - DNSeq [1].mz) < Precision then
          FindAAdist (i);
    end else
    if key = VK_right then
      for i := 0 to BarSeries.Count - 1 do
        if Abs (Barseries.XValue [i] - DNSeq [seqLen + 1].mz) < Precision then
          FindAAdist (i);
end;

{-----------------------------------------------------------------------------}

procedure TSpectrumView.MainChartScroll(Sender: TObject);
begin
  MainChartAfterDraw (sender);
end;

{-----------------------------------------------------------------------------}

procedure TSpectrumView.MainChartUndoZoom(Sender: TObject);
begin
  if ShiftDown then
  begin
    MainChart.BottomAxis.SetMinMax (barSeries.MinXValue - 20, barSeries.MaxXValue + 100);
    MainChart.LeftAxis.SetMinMax (0, barSeries.MaxYValue * 1.05)
  end;
end;

{-----------------------------------------------------------------------------}

procedure TSpectrumView.MainChartZoom (Sender: TObject);
begin
  FillChar (DeNovoCandidates, SizeOf (DeNovoCandidates), 0);
  MainChart.LeftAxis.Minimum := 0;
end;

{-----------------------------------------------------------------------------}

procedure TSpectrumView.PkWidthDropChange (Sender: TObject);
begin
  BarSeries.CustomBarWidth := PkWidthDrop.ItemIndex;
end;

{-----------------------------------------------------------------------------}

function TSpectrumView.PointInDNBox (tp: tPoint; var n1, n2: integer): boolean;
var i, j : integer;
begin
  result := false;
  for i := 1 to 2 do
    for j := 1 to 6 do
      with DeNovoCandidates.newPks [i, j] do
        if (tp.X >= resBox.left) and (tp.X <= resBox.right) and
                           (tp.Y >= resBox.top) and (tp.Y <= resBox.bottom) then
        begin
          result := true;
          n1 := i;                         //up (1) or down (2)
          n2 := j;                         //number in list
        end;
end;

{-----------------------------------------------------------------------------}

procedure TSpectrumView.SeqLblMouseEnter(Sender: TObject);
begin
  DisplaySpectrum;
end;

{-----------------------------------------------------------------------------}
procedure TSpectrumView.SetNewSpectrum(rawSpecIdx: integer);

procedure SetFormCaption(specIdx: integer; combined: boolean; deconvoluted: boolean);
var spectrumTypeTxt, deconvolutionTxt, viewModeTxt: string;
begin
// Get the spectrum type to show in the title
  if specIdx = 0 then
     spectrumTypeTxt := 'Basis N-terminal'
  else if specIdx = 1 then
  begin
    if combined then
      spectrumTypeTxt := 'Combined N-terminal'
    else
      spectrumTypeTxt := 'Modified N-terminal'
  end
  else if specIdx = 5 then
     spectrumTypeTxt := 'Basis C-terminal'
  else if specIdx = 6 then
  begin
    if combined then
      spectrumTypeTxt := 'Combined C-terminal'
    else
      spectrumTypeTxt := 'Modified C-terminal'
  end;

    // Set deconvolution status text
  if deconvoluted then
     deconvolutionTxt := 'Deconvoluted'
  else
     deconvolutionTxt := 'Non-Deconvoluted';

  if manualDeNovoSeqEnabled then
    viewModeTxt := 'Manual De Novo'
  else
    viewModeTxt := 'View only';

    // Set window caption
  Caption := Format('%s - %s spectrum (%s) - %s', [baseCaption, spectrumTypeTxt,
                    deconvolutionTxt, viewModeTxt])
end;

procedure ChangeElementEnablingStatus();
begin
  if combinedSpectrum then
    begin
      // Deconvolution
      ViewDeconvolutedChk.Enabled := False;
      ViewDeconvolutedChk.Checked := True;

      // Series ions
      HighlightNTermPeaksChk.Enabled := True;
      HighlightCTermPeaksChk.Enabled := True;

      // Automatic de novo - Supporting ions (Only show for automatic de novo)
      HighlightFragmentPeaksChk.Enabled := manualDeNovoSeqEnabled = False;
      HighlightFragmentPeaksChk.Checked := manualDeNovoSeqEnabled = False;
      HighlightNLPeaksChk.Enabled := manualDeNovoSeqEnabled = False;
      HighlightNLPeaksChk.Checked := manualDeNovoSeqEnabled = False;
      HighlightImmoniumPeaksChk.Enabled := manualDeNovoSeqEnabled = False;
      HighlightImmoniumPeaksChk.Checked := manualDeNovoSeqEnabled = False;
    end
  else
    begin
      // Deconvolution
      ViewDeconvolutedChk.Enabled := True;

      // Series ions
      HighlightNTermPeaksChk.Enabled := False;
      HighlightCTermPeaksChk.Enabled := False;

      // Automatic de novo - Supporting ions
      HighlightFragmentPeaksChk.Enabled := False;
      HighlightFragmentPeaksChk.Checked := False;
      HighlightNLPeaksChk.Enabled := False;
      HighlightNLPeaksChk.Checked := False;
      HighlightImmoniumPeaksChk.Enabled := False;
      HighlightImmoniumPeaksChk.Checked := False;
    end;
end;

begin
  rawSpectrumIdx := rawSpecIdx;
  combinedSpectrum := ViewCombinedSpectrumChk.Checked;

  if combinedSpectrum then
  begin
    rawSpecIdx := rawSpecIdx + 3;
    ViewDeconvolutedChk.Checked := false;
    ViewDeconvolutedChk.Enabled := false;
  end
  else
  begin
    if ViewDeconvolutedChk.Enabled = false then
      ViewDeconvolutedChk.Enabled := true;
    if ViewDeconvolutedChk.Checked then
      rawSpecIdx := rawSpecIdx + 2;
  end;

  spectrumIdx := rawSpecIdx;

  SetFormCaption(rawSpectrumIdx, combinedSpectrum, ViewDeconvolutedChk.Checked);
  ChangeElementEnablingStatus();
  UpdateDNResultSeries;
  // Set spectrum and trigger update
  FillChar (DeNovoCandidates, SizeOf (DeNovoCandidates), 0);
  DisplaySpectrum;
end;

procedure TSpectrumView.ViewBasisNSpectrumRadBtnClick(Sender: TObject);
begin
  SetNewSpectrum(0);
end;
procedure TSpectrumView.ViewModNSpectrumRadBtnClick(Sender: TObject);
begin
 SetNewSpectrum(1);
end;
procedure TSpectrumView.ViewBasisCSpectrumRadBtnClick(Sender: TObject);
begin
 SetNewSpectrum(5);
end;
procedure TSpectrumView.ViewModCSpectrumRadBtnClick(Sender: TObject);
begin
  SetNewSpectrum(6);
end;

procedure TSpectrumView.ViewDeconvolutedChkClick(Sender: TObject);
begin
  SetNewSpectrum(rawSpectrumIdx);
end;

{-----------------------------------------------------------------------------}
procedure TSpectrumView.HighlightNTermPeaksChkClick(Sender: TObject);
begin
  DisplaySpectrum;
end;

procedure TSpectrumView.HighlightCTermPeaksChkClick(Sender: TObject);
begin
  DisplaySpectrum;
end;

procedure TSpectrumView.HighlightFragmentPeaksChkClick(Sender: TObject);
begin
  DisplaySpectrum;
end;

procedure TSpectrumView.HighlightNLPeaksChkClick(Sender: TObject);
begin
  DisplaySpectrum;
end;

{-----------------------------------------------------------------------------}
Procedure TSpectrumView.InitSpectrumViewer(spec: msmsSpectrumDataFull; genSettings: SequencerSettings; manualDeNovo: boolean);
var peakIdx, specPeakIdx: integer;
begin

for var i := Low(FullSpectrumHeaders) to High(FullSpectrumHeaders) do
  FullSpectrumHeaders[i] := spec.headers[i];

  // Set settings
  manualDeNovoSeqEnabled := manualDeNovo;
  settings := genSettings;
  FullSpectrum := spec.spectrum;
  Precision := settings.precision;
  IonPrecisionChart.BottomAxis.SetMinMax(-Precision, Precision);
  CandidateShowPeaksUd.Value := settings.showNMostIntenseCandidates;

  // Reset and load the spectrum
  ClearGraph;
  for specPeakIdx := Low(FullSpectrum) to High(FullSpectrum) do
  begin
    peakIdx := BarSeries.AddXY(FullSpectrum[specPeakIdx].mz, FullSpectrum[specPeakIdx].int,
                               '', clWhite);
    FullSpectrum[specPeakIdx].peakIdx := peakIdx;
    FullSpectrum[specPeakIdx].available := False;
  end;

  // Only enable show combined spectrum option, if at least one pair exists
  ViewCombinedSpectrumChk.Enabled := (settings.loadedSpectra[0] and settings.loadedSpectra[1]) or
                                     (settings.loadedSpectra[2] and settings.loadedSpectra[3]);
  // Select the first existing spectrum
  if settings.loadedSpectra[0] then
  begin
    ViewBasisNSpectrumRadBtn.Checked := True;
    ViewBasisNSpectrumRadBtnClick(nil);
  end else ViewBasisNSpectrumRadBtn.Enabled := False;
  if settings.loadedSpectra[1] then
  begin
    ViewModNSpectrumRadBtn.Checked := True;
    ViewModNSpectrumRadBtnClick(nil);
  end else ViewModNSpectrumRadBtn.Enabled := False;
  if settings.loadedSpectra[2] then
  begin
    ViewBasisCSpectrumRadBtn.Checked := True;
    ViewBasisCSpectrumRadBtnClick(nil);
  end else ViewBasisCSpectrumRadBtn.Enabled := False;
  if settings.loadedSpectra[3] then
  begin
    ViewModCSpectrumRadBtn.Checked := True;
    ViewModCSpectrumRadBtnClick(nil);
  end else ViewModCSpectrumRadBtn.Enabled := False;
end;

{-----------------------------------------------------------------------------}

Procedure TSpectrumView.SetDNResult(res: DNSequenceTag);
begin
  autoDeNovoResult := res;
  UpdateDNResultSeries;
  // Set sequence
  UpdateIonPrecisionChart(res.massDeviation);
end;

Procedure TSpectrumView.SetDNResultSeries;
begin
  case spectrumIdx of
    0: selectAutoDNSeries := Default(DNSequenceSeriesTag);
    1: selectAutoDNSeries := Default(DNSequenceSeriesTag);
    2: selectAutoDNSeries := autoDeNovoResult.nTermBasis;
    3: selectAutoDNSeries := autoDeNovoResult.nTermMod;
    4: selectAutoDNSeries := autoDeNovoResult.nTermCombined;
    5: selectAutoDNSeries := Default(DNSequenceSeriesTag);
    6: selectAutoDNSeries := Default(DNSequenceSeriesTag);
    7: selectAutoDNSeries := autoDeNovoResult.cTermBasis;
    8: selectAutoDNSeries := autoDeNovoResult.cTermMod;
    9: selectAutoDNSeries := autoDeNovoResult.cTermCombined;
  end;
end;

Procedure TSpectrumView.UpdateDNResultSeries;
begin
  if manualDeNovoSeqEnabled then Exit;
  SetDNResultSeries;
  seqLen := selectAutoDNSeries.internalLength;
  FillChar (DNSeq, SizeOf (DNSeq), 0);
  for var i := Low(DNSeq) to seqLen do
    DNSeq[i] := selectAutoDNSeries.residues[i];

  MainChart.Invalidate;
  DisplaySpectrum;
end;

{-----------------------------------------------------------------------------}

procedure TSpectrumView.BarSeriesClick(Sender: TChartSeries; ValueIndex: Integer;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if manualDeNovoSeqEnabled then
    FindAAdist (valueIndex);
end;

{-----------------------------------------------------------------------------}

procedure TSpectrumView.ClearGraph;
begin
  MainChart.SeriesList.ClearValues;
  BarSeries.Clear;
  NewSequenceBtnClick (nil);
end;

{-----------------------------------------------------------------------------}
procedure TSpectrumView.CopySeq1Click(Sender: TObject);
begin
  CopyStr2Clip(GetSequenceTag(DNseq, FullSpectrumHeaders[spectrumIdx].charge).seq1Let);
end;

procedure TSpectrumView.CopySeq3Click(Sender: TObject);
begin
  CopyStr2Clip(GetSequenceTag(DNseq, FullSpectrumHeaders[spectrumIdx].charge).seq3Let);
end;

procedure TSpectrumView.CopySeqMassClick(Sender: TObject);
var tag: SequenceTag;
begin
  tag := GetSequenceTag(DNseq, FullSpectrumHeaders[spectrumIdx].charge);
  CopyStr2Clip(Format('%s (M: %0.3f)', [tag.seq1Let, tag.mass]));
end;

procedure TSpectrumView.CopyModSeq1Click(Sender: TObject);
begin
    CopyStr2Clip(GetSequenceTag(DNseq, FullSpectrumHeaders[spectrumIdx].charge).seq1LetMod);
end;

procedure TSpectrumView.CopyModSeq3Click(Sender: TObject);
begin
  CopyStr2Clip(GetSequenceTag(DNseq, FullSpectrumHeaders[spectrumIdx].charge).seq3LetMod);
end;

procedure TSpectrumView.CopyModSeqMassClick(Sender: TObject);
var tag: SequenceTag;
begin
  tag := GetSequenceTag(DNseq, FullSpectrumHeaders[spectrumIdx].charge);
  CopyStr2Clip(Format('%s (M: %0.3f)', [tag.seq1LetMod, tag.mass]));
end;

{-----------------------------------------------------------------------------}

procedure TSpectrumView.SaveSeqsBtnClick(Sender: TObject);
Function CreateEntry(title: string; seq: DeNovoSeqArray): SequenceFastaEntry;
var entry: SequenceFastaEntry; tag: SequenceTag;
begin
tag := GetSequenceTag(seq, FullSpectrumHeaders[spectrumIdx].charge);
if Length(tag.seq1Let) < 0 then
  begin
    entry.header := '';
    entry.sequence := '';
  end
else
  begin
    entry.header := Format('%s (M: %0.3f)', [title, tag.mass]);
    entry.sequence := tag.seq1Let;
  end;

Result:= entry;
end;

var entries: SequenceFastaEntries;
var idx: integer;
begin
  if SaveDlg.Execute() then
  begin
    SetLength(entries, Length(BackupSeq)+1);

    entries[0] := CreateEntry('Current sequence', DNSeq);
    for idx := Low(BackupSeq) to High(BackupSeq) do
    begin
      entries[idx] := CreateEntry(Format('Backup sequence %d', [idx]), BackupSeq[idx]);
    end;

   CreateFastaFile(entries, SaveDlg.Filename);
  end;
end;
{-----------------------------------------------------------------------------}
procedure TSpectrumView.NewSequenceBtnClick(Sender: TObject);
begin
  FillChar (DeNovoCandidates, SizeOf (DeNovoCandidates), 0);
  FillChar (DNSeq, SizeOf (DNSeq), 0);
  seqLen := 0;
  UpdateIonPrecisionChart();
  IonPrecisionChart.SeriesList.ClearValues();
  MainChart.Invalidate();
end;

{-----------------------------------------------------------------------------}
procedure TSpectrumView.TrimSeqNBtnClick(Sender: TObject);
var tempDNSeq: DeNovoSeqArray;
begin
  if seqLen > 0 then
  begin
    FillChar (tempDNSeq, SizeOf (tempDNSeq) - 1, 0);
    for var i := Low(DNSeq) + 1 to High(DNSeq) do
      tempDNSeq[i-1] := DNSeq[i];

    DNSeq := tempDNSeq;
    Dec(seqLen);
    FillChar (DeNovoCandidates, SizeOf (DeNovoCandidates), 0);
    UpdateIonPrecisionChart();
    MainChart.Invalidate();
  end;
end;

procedure TSpectrumView.TrimSeqCBtnClick(Sender: TObject);
begin
  if seqLen > 0 then
  begin
    // Set the last actual residue to the placeholder
    DNSeq[seqLen].res1 := aa.name1[0]; DNSeq[seqLen].res1mod := aa.name1[0];
    DNSeq[seqLen].res3 := aa.name3[0]; DNSeq[seqLen].res3mod := aa.name3[0];
    DNSeq[seqLen].massDeviation := 0; DNSeq[seqLen].level := 0;
    DNSeq[seqLen].aaNum := 0; DNSeq[seqLen].resIdx := 0;
    DNSeq[seqLen].resBox := Default(tBox);
    // Reset the last placeholder
    DNSeq[seqLen+1] := Default(Residue);
    Dec(seqLen);

    FillChar (DeNovoCandidates, SizeOf (DeNovoCandidates), 0);
    UpdateIonPrecisionChart();
    MainChart.Invalidate();
  end;
end;
{-----------------------------------------------------------------------------}
procedure TSpectrumView.seqM1Click(Sender: TObject);
begin
  BackupSequence(1, seqM1, CtrlDown);
end;

procedure TSpectrumView.seqM2Click(Sender: TObject);
begin
  BackupSequence(2, seqM2, CtrlDown);
end;

procedure TSpectrumView.seqM3Click(Sender: TObject);
begin
  BackupSequence(3, seqM3, CtrlDown);
end;

procedure TSpectrumView.seqM4Click(Sender: TObject);
begin
  BackupSequence(4, seqM4, CtrlDown);
end;

procedure TSpectrumView.seqM5Click(Sender: TObject);
begin
  BackupSequence(5, seqM5, CtrlDown);
end;

procedure TSpectrumView.BackupSequence(slotIdx: integer; seqMenuItem: TMenuItem; overwriteFilledSlot: boolean);
procedure SaveSequenceInSlot(slotIdx: integer; seqMenuItem: TMenuItem);
var tag: SequenceTag;
begin
  if SeqLen > 0 then
  begin
    tag := GetSequenceTag(DNseq, FullSpectrumHeaders[spectrumIdx].charge);
    seqMenuItem.Caption :=  Format('%d: %s (M+H+: %0.3f)',
                                   [slotIdx, tag.seq1Let, tag.mass]);
    BackupSeq[slotIdx] := DNseq;
  end;
end;

Procedure UpdateSequenceLength();
var seqLength: integer;
begin
  seqLength := 0;
  for var i := Low(DNSeq) to High(DNSeq) do
  begin
    if DNSeq[i].aaNum <> 0 then
      Inc(seqLength);
  end;
  SeqLen := seqLength;
end;

begin
   if seqMenuItem.Caption = Format('&%d:', [slotIdx]) then
     begin
        // Empty slot - Just add sequence
        SaveSequenceInSlot(slotIdx, seqMenuItem);
     end
   else
     begin
     // Filled slot
     if overwriteFilledSlot then
       begin
       // Overwrite the slot
       SaveSequenceInSlot(slotIdx, seqMenuItem);
       end
     else
       begin
        // Load the sequence
        DNseq := BackupSeq[slotIdx];
        UpdateSequenceLength();
        UpdateIonPrecisionChart();
        MainChart.Invalidate();
       end;
     end;
end;

{-----------------------------------------------------------------------------}
procedure TSpectrumView.TransferPeaks (var minX: real; var maxX: real; var maxY: real);
var peakIdx: integer; prevMaxY: real;
begin
minX := Double.MaxValue; maxX := Double.MinValue; maxY := Double.MinValue;

for var i := Low(FullSpectrum) to High(FullSpectrum) do
begin
  peakIdx := FullSpectrum[i].peakIdx;
  if FullSpectrum[i].intensities[spectrumIdx] <> -1 then
  begin
    FullSpectrum[i].available := True;

    BarSeries.ValueColor[peakIdx] := clBlack;
    FullSpectrum[i].int := FullSpectrum[i].intensities[spectrumIdx];
    BarSeries.YValues[peakIdx] := FullSpectrum[i].int;
    BarSeries.ValueMarkText[peakIdx] := Format ('%6.2f', [FullSpectrum[i].mz]);

    //  Color peaks if automatic sequencing and combined mode
    if (manualDeNovoSeqEnabled = False) and combinedSpectrum then
    begin

    end;

    BarSeries.Marks[peakIdx].Visible := True;
    if minX > BarSeries.XValues[peakIdx] then
      minX := BarSeries.XValues[peakIdx];

    if maxX < BarSeries.XValues[peakIdx] then
      maxX := BarSeries.XValues[peakIdx];

    if maxY < BarSeries.YValues[peakIdx] then
      maxY := BarSeries.YValues[peakIdx];
  end
  else
  begin
    FullSpectrum[i].available := False;

    BarSeries.ValueColor[peakIdx] := clWhite;
    BarSeries.ValueMarkText[peakIdx] := '';
    BarSeries.Marks[peakIdx].Visible := False;
    BarSeries.YValues[peakIdx] := 0;
  end;
end;

if minX = Double.MaxValue then minX := 0 else minX := RoundTo(minX, 1);
if maxX = Double.MinValue then maxX := 5 else maxX := RoundTo(maxX, 1);

if maxY = Double.MinValue then maxY := 10
else
begin
  maxX := RoundTo(maxX, 1);
  prevMaxY := maxY;
  maxY := RoundTo(maxY, 4);

  if prevMaxY > maxY then maxY := prevMaxY * 1.2;
end;


end;

Procedure TSpectrumView.ColorCombinedIons();
var i, barColor: integer;
begin
  if combinedSpectrum = False then
      Exit;

  if manualDeNovoSeqEnabled then
  begin
    // Color Y ions if selected
    if HighlightCTermPeaksChk.Checked then
    begin
      for i := Low(FullSpectrum) to High(FullSpectrum) do
      begin
        if FullSpectrum[i].mode = 2 then
          BarSeries.ValueColor[i] := Y_ION_COL;
      end;
    end;

    // Color B ions if selected
    if HighlightNTermPeaksChk.Checked then
    begin
      for i := Low(FullSpectrum) to High(FullSpectrum) do
      begin
        if FullSpectrum[i].mode = 1 then
          BarSeries.ValueColor[i] := B_ION_COL;
      end;
    end;
  end else
  begin
    // Color Y ions if selected
    if HighlightCTermPeaksChk.Checked then
    begin
      for i := Low(DNSeq) to High(DNSeq) do
      begin
        if FullSpectrum[DNSeq[i].peakIdx].mode = 2 then
          BarSeries.ValueColor[DNSeq[i].peakIdx] := Y_ION_COL;
      end;
    end;
    // Color B ions if selected
    if HighlightNTermPeaksChk.Checked then
    begin
      for i := Low(DNSeq) to High(DNSeq) do
      begin
        if FullSpectrum[DNSeq[i].peakIdx].mode = 1 then
          BarSeries.ValueColor[DNSeq[i].peakIdx] := B_ION_COL;
      end;
    end;

    // Color fragment ions if selected
    if HighlightFragmentPeaksChk.Checked then
    begin
      for i := Low(selectAutoDNSeries.fragments) to High(selectAutoDNSeries.fragments) do
        BarSeries.ValueColor[selectAutoDNSeries.fragments[i].peakIdx] := FRAGMENT_ION_COL;
    end;

    // Show neutral loss ions if selected
    if HighlightNLPeaksChk.Checked then
    begin
      for i := Low(selectAutoDNSeries.neutralLossIons) to High(selectAutoDNSeries.neutralLossIons) do
      begin
        if selectAutoDNSeries.neutralLossIons[i].ionType = 1 then
        begin
          // B ions
          if selectAutoDNSeries.neutralLossIons[i].lossType = 17 then
            barColor := B_17_ION_COL
          else
            barColor := B_18_ION_Col;
        end
        else
        begin
          // Y ions
          if selectAutoDNSeries.neutralLossIons[i].lossType = 17 then
            barColor := Y_17_ION_COL
          else
            barColor := Y_18_ION_Col;
        end;
        BarSeries.ValueColor[selectAutoDNSeries.neutralLossIons[i].peakIdx] := barColor;
      end;
    end;

    // Show immonium ions if selected
    if HighlightImmoniumPeaksChk.Checked then
    begin
        for i := Low(selectAutoDNSeries.immonium) to High(selectAutoDNSeries.immonium) do
      BarSeries.ValueColor[selectAutoDNSeries.immonium[i].peakIdx] := IMMONIUM_ION_COL;
    end;

    BarSeries.ValueColor[selectAutoDNSeries.mainPeakIdx] := OVERALL_COL;
  end;
end;

procedure TSpectrumView.ViewCombinedSpectrumChkClick(Sender: TObject);
begin
  if ViewCombinedSpectrumChk.Checked then
  begin
    ViewBasisNSpectrumRadBtn.Enabled := false;
    ViewBasisCSpectrumRadBtn.Enabled := false;

    ViewModNSpectrumRadBtn.Enabled := settings.loadedSpectra[0] and settings.loadedSpectra[1];
    ViewModCSpectrumRadBtn.Enabled := settings.loadedSpectra[2] and settings.loadedSpectra[3];

    if ViewModNSpectrumRadBtn.Enabled then
    begin
      ViewModNSpectrumRadBtn.Checked := True;
      ViewModNSpectrumRadBtnClick(Sender);
    end else if ViewModCSpectrumRadBtn.Enabled then
    begin
      ViewModCSpectrumRadBtn.Checked := True;
      ViewModCSpectrumRadBtnClick(Sender);
    end;
  end
  else
  begin
    ViewBasisNSpectrumRadBtn.Enabled := settings.loadedSpectra[0];
    ViewModNSpectrumRadBtn.Enabled := settings.loadedSpectra[1];
    ViewBasisCSpectrumRadBtn.Enabled := settings.loadedSpectra[2];
    ViewModCSpectrumRadBtn.Enabled := settings.loadedSpectra[3];
  end;

  SetNewSpectrum(rawSpectrumIdx);
end;

procedure TSpectrumView.DisplaySpectrum;
var minX, maxX, maxY: real;
begin
  if Length (FullSpectrum) > 1 then
  begin
    TransferPeaks (minX, maxX, maxY);
    MainChart.BottomAxis.SetMinMax (minX - 20, maxX + 100);
    MainChart.LeftAxis.SetMinMax(0, maxY);
    ColorCombinedIons;
  end;
end;

{-----------------------------------------------------------------------------}
procedure TSpectrumView.FindAAdist(valueIndex: integer);
begin
FindResidueCandidates(FullSpectrum, valueIndex, Precision, DeNovoCandidates, LogWindow, Floor( CandidateShowPeaksUd.Value));
CalculateCandidatePeakPositions();
MainChart.Invalidate;
end;

{-----------------------------------------------------------------------------}
procedure TSpectrumView.CalculateCandidatePeakPositions;
var i: integer;
begin
  CalculatePeakPosition(DeNovoCandidates.basePks);
  for i := Low(DeNovoCandidates.newPks[1]) to High(DeNovoCandidates.newPks[1]) do
    CalculatePeakPosition(DeNovoCandidates.newPks[1][i]);
  for i := Low(DeNovoCandidates.newPks[2]) to High(DeNovoCandidates.newPks[2]) do
    CalculatePeakPosition(DeNovoCandidates.newPks[2][i]);
end;

procedure TSpectrumView.CalculateDeNovoSequencePeakPositions;
begin
  for var i := Low(DNSeq) to High(DNSeq) do
    CalculatePeakPosition(DNSeq[i]);
end;

{-----------------------------------------------------------------------------}
procedure TSpectrumView.UpdateIonPrecisionChart(totalMassDeviation: real = -9999);
var i: Integer;
begin
  IonPrecisionSeries.Clear;
  for i := 1 to seqLen do
  begin
    if DNSeq[i].res1 <> #0 then
      IonPrecisionSeries.AddXY(DNSeq[i].massDeviation, i, '', clBlue);
  end;

  if totalMassDeviation <> -9999 then
    IonPrecisionSeries.AddXY(totalMassDeviation, i , '', OVERALL_COL);
end;

{-----------------------------------------------------------------------------}
procedure TSpectrumView.CalculatePeakPosition(var peak: Residue);
begin
  if peak.internPeakId = -1 then
  begin
    peak.xPos := MainChart.BottomAxis.CalcXPosValue(MainChart.BottomAxis.Minimum);
    peak.yPos := 0;
  end else
  if peak.internPeakId = -99 then
  begin
    peak.xPos := MainChart.BottomAxis.CalcXPosValue(MainChart.BottomAxis.Maximum);
    peak.yPos := 0;
  end else
  if peak.peakIdx = 0 then
  begin
    peak.xPos := 0;
    peak.yPos := 0;
  end
  else
  begin
    peak.xPos := BarSeries.CalcXPos(peak.peakIdx) + 1;
    peak.yPos := BarSeries.CalcYPos(peak.peakIdx) + 1;
  end;
end;

procedure TSpectrumView.CopySpectrumBtnClick(Sender: TObject);
begin
  MainChart.CopyToClipboardBitmap();
end;

end.
