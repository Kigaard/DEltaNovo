unit SpecViewForm;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, Vcl.Menus,
  AdvMenus, VCLTee.TeEngine, VCLTee.Series, VCLTee.TeeProcs, VCLTee.Chart, Vcl.StdCtrls,
  AdvCombo, AdvOfficeButtons, AdvGlowButton, AdvTrackBar, AdvEdit, AdvToolBtn,
  AdvPageControl, Vcl.ComCtrls, Vcl.ExtCtrls, AdvPanel, General, globals,
  AdvUtil, Vcl.Grids, AdvObj, BaseGrid, AdvGrid;

const topDN = 12;    MaxDeconSpec = 1001;
type
    tmsmsPkData = record
                  pkmz, pkint, pkPrecis : real;
                  htMode : integer;                 //peak id mode (2=b, 3=b-17, 6=y)
                  pkMark : string;                  //label for peak
                end;
    tmsmsSpectrumData = array of tmsmsPkData;
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
                  spec : tmsmsSpectrumData;
                end;
    tBox = record
           left, right, top, bottom : integer;
         end;
    tDNres = record
             xPos, yPos, level, aaNum : integer;
             mz, int, pkPrecis : real;
             resSt : string [3];
             res1 : ansiChar;
             resBox : tBox;
           end;
    tDNresArray = array [1..topDN] of tDNres;
    tDNresSet = record
                Enabled : boolean;
                basePks : tDNres;
                newPks : array [1..2] of tDNresArray;    //1..2 down..up peaks
              end;
  tDNseqArray = array [1..30] of tDNres;
type
  TSpecView = class (TForm)
    RightPanel: TAdvPanel;
    RightPageCtrl: TAdvPageControl;
    DeNovoTab: TAdvTabSheet;
    HelpLbl: TLabel;
    Label2: TLabel;
    SequenceBtn: TAdvToolButton;
    LimitPeaksTrack: TAdvTrackBar;
    NewSequenceBtn: TAdvGlowButton;
    CopySeqBtn: TAdvGlowButton;
    NoLowMassLabelChk: TAdvOfficeCheckBox;
    DeNovoChk: TAdvOfficeCheckBox;
    LimitPeaksChk: TAdvOfficeCheckBox;
    TrimSeqNBtn: TAdvGlowButton;
    TrimSeqCBtn: TAdvGlowButton;
    ColorPeaksChk: TAdvOfficeCheckBox;
    PkWidthDrop: TAdvComboBox;
    BackPanel: TAdvPanel;
    MainChart: TChart;
    BarSeries: TBarSeries;
    DNSeqCopyTypePop: TAdvPopupMenu;
    CopySequence1lett: TMenuItem;
    Copysequence3lett: TMenuItem;
    CopySequenceAndMass: TMenuItem;
    BackupSeqPop: TAdvPopupMenu;
    seqM1: TMenuItem;
    seqM2: TMenuItem;
    seqM3: TMenuItem;
    seqM4: TMenuItem;
    seqM5: TMenuItem;
    CopySpectrumBtn: TAdvGlowButton;
    ShowAAdistChk: TAdvOfficeCheckBox;
    IonPrecisionChart: TChart;
    IonPrec: TPointSeries;
    procedure BarSeriesClick (Sender: TChartSeries; ValueIndex: Integer;
                       Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure BarSeriesGetMarkText (Sender: TChartSeries; ValueIndex: Integer;
                                                          var MarkText: string);
    procedure MainChartAfterDraw (Sender: TObject);
    procedure MainChartClick (Sender: TObject);
    procedure MainChartKeyUp (Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MainChartScroll (Sender: TObject);
    procedure MainChartZoom (Sender: TObject);
    procedure MainChartUndoZoom (Sender: TObject);
    procedure MainChartDblClick (Sender: TObject);
    procedure NewSequenceBtnClick (Sender: TObject);
    procedure CopySpectrumBtnClick (Sender: TObject);
    procedure LimitPeaksTrackChange (Sender: TObject);
    procedure LimitPeaksChkClick (Sender: TObject);
    procedure SeqLblMouseEnter (Sender: TObject);
    procedure NoLowMassLabelChkClick (Sender: TObject);
    procedure DeNovoChkClick (Sender: TObject);
    procedure ColorPeaksChkClick (Sender: TObject);
//    procedure seqMrestoreClick (Sender: TObject);
    procedure PkWidthDropChange (Sender: TObject);
    procedure TrimSeqNBtnClick(Sender: TObject);
    procedure TrimSeqCBtnClick(Sender: TObject);
    procedure CopySequence1lettClick(Sender: TObject);
    procedure CopySequence3lettClick(Sender: TObject);
    procedure CopySequenceAndMassClick(Sender: TObject);
  private
    DNset : tDNresSet;
    seqLen : integer;
    BackupSeq : array [1..5] of tDNseqArray;
    mzH20, mzNH3 : real;
    graphTitle : string;
    Procedure UpdateDNseq;
    Function PointInDNBox (tp : tPoint;var n1, n2 : integer) : boolean;
    Procedure FindAAdist (valueIndex : integer);
    Function GetDeNovoSequence(tSeq: tDNseqArray) : string;
  public
    Precision: real;
    DNseq : tDNseqArray;             //de novo sequence
    mainSpec : tMgfFileRec;
    Prec : real;
    //parentMgf : tMgf;
    mzmzData : tmsmsSpectrumData;
    EnableAAfind : boolean;
//    Constructor Create1 (AOwner : tForm; par : tMgf);
    Procedure DisplaySpecs;
    Procedure AfterConstruction; override;
    Procedure ClearGraph;
//    procedure SetMain (sp: tmzmzPeaks; h: tMgfHeader); virtual;
    Function FindPeakColor (mz : real) : tColor; virtual;
    Procedure TransferPeaks (specCopy : tmsmsSpectrumData); virtual;
  end;
  procedure GraphLineOut (chrt : tChart; s : string; lvl, col : integer);

var SpecView: TSpecView;

implementation

{$R *.dfm}
{ TSpecView }
{-----------------------------------------------------------------------------}

procedure GraphLineOut (chrt : tChart; s : string; lvl, col : integer);
var chH, chW : integer;
begin
  chW := chrt.Canvas.TextWidth (s) + 5;
  chH := chrt.Canvas.TextHeight ('hy');
  chrt.Canvas.Font.Color := col;
  if lvl > 0 then
    chrt.Canvas.TextOut (chrt.ChartRect.Right - chW, chrt.ChartRect.Top + (lvl - 1) * chH + 5, s)
  else chrt.Canvas.TextOut (chrt.ChartRect.left + 5, chrt.ChartRect.top + 6, s);
end;

{-----------------------------------------------------------------------------}

procedure TSpecView.AfterConstruction;
begin
  inherited;
   graphTitle := '';
  seqLen := 0;
  FillChar (DNseq, SizeOf (DNseq), 0);
  DeNovoChk.Checked := true;
  mzH20 := ComposStr2Defms ('H2O1', 3);
  mzNH3 := ComposStr2Defms ('H3N1', 3);
  //EnableAAfind := ShowAAdistChk.Checked;
end;

{-----------------------------------------------------------------------------}

procedure TSpecView.LimitPeaksChkClick(Sender: TObject);
begin
  DisplaySpecs;
end;

{-----------------------------------------------------------------------------}

procedure TSpecView.LimitPeaksTrackChange(Sender: TObject);
begin
  if LimitPeaksChk.Checked then
    DisplaySpecs;
end;

{-----------------------------------------------------------------------------}

procedure TSpecView.MainChartAfterDraw(Sender: TObject);
var chX, chY, i, x, y : integer;             m : real;              s : string;

Procedure DrawRes (var DNres : tDNresArray; lvl : integer);
var yLvlPos : integer;
begin
  with MainChart.Canvas do
  begin
    yLvlPos := (DNres [lvl].level + 1) * chY;
    Pen.Color := ChargeCol [lvl];
    MoveTo (DNset.basePks.xPos, yLvlPos);
    LineTo (DNres [lvl].xPos, yLvlPos);
    LineTo (DNres [lvl].xPos, DNres [lvl].yPos);
    DNres [lvl].resBox.left := (DNset.basePks.xPos + DNres [lvl].xPos) div 2 - chX;
    DNres [lvl].resBox.top := yLvlPos - (chY div 2);
    DNres [lvl].resBox.bottom := DNres [lvl].resBox.top + chY;
    DNres [lvl].resBox.right := DNres [lvl].resBox.left + TextWidth (DNres [lvl].resSt);
    TextOut (DNres [lvl].resBox.left, DNres [lvl].resBox.top, DNres [lvl].resSt);
  end;
end;

begin
  UpdateDNseq;
//draw zero line
  MainChart.Canvas.Pen.Color := clGray;
  MainChart.Canvas.MoveTo (MainChart.ChartRect.Left, MainChart.LeftAxis.CalcYPosValue (0));
  MainChart.Canvas.LineTo (MainChart.ChartRect.Right, MainChart.LeftAxis.CalcYPosValue (0));
//draw residue options
  if DeNovoChk.Checked then
    with MainChart.Canvas do
    begin
      chY := TextHeight ('hy');
      chX := TextWidth ('w');
      Pen.Color := clRed;
      Pen.Style := psDot;
      Pen.Style := psDash;
      for i := 1 to 6 do
        if DNset.newPks [1, i].xPos > 0 then
          DrawRes (DNset.newPks [1], i);
      for i := 1 to 6 do
        if DNset.newPks [2, i].xPos > 0 then
          DrawRes (DNset.newPks [2], i);
      if seqLen > 0 then                            //draw de novo sequence
      begin
        Pen.Color := clBlue;
        Pen.Style := psDash;
        MoveTo (DNseq [1].xPos, chY * 2);
        LineTo (DNseq [1].xPos, chY);
        for i := 2 to seqLen + 1 do
        begin
          LineTo (DNseq [i].xPos, chY);
          LineTo (DNseq [i].xPos, chY * 2);
          TextOut ((DNseq [i].xPos + DNseq [i - 1].xPos) div 2 - chX, chY - (chY div 2), DNseq [i].resSt);
          MoveTo (DNseq [i].xPos, chY);
        end;
      end;
    end;
  if mainSpec.header.charge > 2 then                  //draw charge reduced parent ions
    for i := 2 to mainSpec.header.charge do
    begin
      MainChart.Canvas.Pen.Color := clLime;
      MainChart.Canvas.Pen.Width := 2;
      MainChart.Canvas.Pen.Style := psSolid;
      m := (mainSpec.header.mass + protonms * i) / i;
      x := MainChart.BottomAxis.CalcXPosValue (m);
      y := MainChart.LeftAxis.CalcYPosValue (0) + 2;
      MainChart.Canvas.MoveTo (x, y);
      MainChart.Canvas.LineTo (x, y + 20);
      MainChart.Canvas.Font.Color := clGreen;
      MainChart.Canvas.TextOut (x, y, IntToStr (i));
    end;
  if GraphTitle <> '' then
    GraphLineOut (MainChart, GraphTitle, 0, clBlue);
end;

{-----------------------------------------------------------------------------}

procedure TSpecView.MainChartClick (Sender: TObject);
var tp : tPoint;       x1, x2, i : integer;      first, last : tDNres;
begin
  tp := MainChart.GetCursorPos;
  if PointInDNBox (tp, x1, x2) then
  begin
    if DNset.newPks [x1, x2].mz < DNset.basePks.mz then
    begin
      first := DNset.newPks [x1, x2];                  //down peaks
      last :=  DNset.basePks;
      last.resSt := DNset.newPks [x1, x2].resSt;
    end else begin                                     //up peaks
      first := DNset.basePks;
      last := DNset.newPks [x1, x2];
      first.resSt := DNset.newPks [x1, x2].resSt;
    end;
    if seqLen = 0 then
    begin
      DNseq [1] := first;
      DNseq [2] := last;
      seqLen := 1;
    end else
      if Abs (last.mz - DNseq [1].mz) < Precision then
      begin
        for i := seqLen + 1 downto 1 do
          DNseq [i + 1] := DNseq [i];
        DNSeq [1] := first;
        DNSeq [2].resSt := DNSeq [1].resSt;
        Inc (seqLen);
      end else
        if Abs (first.mz - DNseq [seqLen + 1].mz) < Precision then
          DNseq [FInc (seqLen) + 1] := last;
    MainChart.Invalidate;
  end;
end;

{-----------------------------------------------------------------------------}

procedure TSpecView.MainChartDblClick (Sender: TObject);
begin
  FillChar (DNset, SizeOf (DNset), 0);
  MainChart.Invalidate;
end;

{-----------------------------------------------------------------------------}

procedure TSpecView.MainChartKeyUp (Sender: TObject; var Key: Word; Shift: TShiftState);
var i: Integer;
begin
  if (SeqLen > 0) and (ssCtrl in Shift){(RightPageCtrl.ActivePage = DeNovoTab)} then
    if key = VK_left then
    begin
      for i := 0 to BarSeries.Count - 1 do
        if Abs (Barseries.XValue [i] - DNSeq [1].mz) < 0.01 then
          FindAAdist (i);
    end else
    if key = VK_right then
      for i := 0 to BarSeries.Count - 1 do
        if Abs (Barseries.XValue [i] - DNSeq [seqLen + 1].mz) < 0.01 then
          FindAAdist (i);
end;

{-----------------------------------------------------------------------------}

procedure TSpecView.MainChartScroll(Sender: TObject);
begin
  MainChartAfterDraw (sender);
end;

{-----------------------------------------------------------------------------}

procedure TSpecView.MainChartUndoZoom(Sender: TObject);
begin
  if ShiftDown then
  begin
    MainChart.BottomAxis.SetMinMax (barSeries.MinXValue - 20, barSeries.MaxXValue + 100);
    MainChart.LeftAxis.SetMinMax (0, barSeries.MaxYValue * 1.05)
  end;
end;

{-----------------------------------------------------------------------------}

procedure TSpecView.MainChartZoom (Sender: TObject);
begin
  FillChar (DNset, SizeOf (DNset), 0);
  mainChart.LeftAxis.Minimum := 0;
end;

{-----------------------------------------------------------------------------}

procedure TSpecView.NewSequenceBtnClick(Sender: TObject);
begin
  Exit;
end;

procedure TSpecView.NoLowMassLabelChkClick (Sender: TObject);
begin
  MainChart.Invalidate;
end;

{-----------------------------------------------------------------------------}

procedure TSpecView.PkWidthDropChange (Sender: TObject);
begin
  BarSeries.CustomBarWidth := PkWidthDrop.ItemIndex;
end;

{-----------------------------------------------------------------------------}

function TSpecView.PointInDNBox (tp: tPoint; var n1, n2: integer): boolean;
var i, j : integer;
begin
  result := false;
  for i := 1 to 2 do
    for j := 1 to 6 do
      with DNset.newPks [i, j] do
        if (tp.X >= resBox.left) and (tp.X <= resBox.right) and
                           (tp.Y >= resBox.top) and (tp.Y <= resBox.bottom) then
        begin
          result := true;
          n1 := i;                         //up (1) or down (2)
          n2 := j;                         //number in list
        end;
end;

{-----------------------------------------------------------------------------}

procedure TSpecView.SeqLblMouseEnter(Sender: TObject);
begin
  DisplaySpecs;
end;

{-----------------------------------------------------------------------------}

procedure TSpecView.UpdateDNseq;
begin
// MANGLER
end;

{-----------------------------------------------------------------------------}

procedure TSpecView.BarSeriesClick(Sender: TChartSeries; ValueIndex: Integer;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
//
  if ShowAAdistChk.Checked then
    FindAAdist (valueIndex);
end;

{-----------------------------------------------------------------------------}

procedure TSpecView.BarSeriesGetMarkText (Sender: TChartSeries; ValueIndex: Integer;
                                                          var MarkText: string);
begin
  if NoLowMassLabelChk.Checked then                       //remove low mass labels
    if BarSeries.YValue [ValueIndex] < (MainChart.LeftAxis.Maximum / 4) then
      MarkText := '';
end;

{-----------------------------------------------------------------------------}

procedure TSpecView.ClearGraph;
begin
  FillChar (DNset, SizeOf (DNset), 0);
  MainChart.SeriesList.ClearValues;
  prec := 0.05;
//  NewSequenceBtnClick (nil);
end;

{-----------------------------------------------------------------------------}

procedure TSpecView.ColorPeaksChkClick(Sender: TObject);
begin
  DisplaySpecs;
end;

{-----------------------------------------------------------------------------}
function TSpecView.GetDeNovoSequence(tSeq: tDNseqArray): string;
begin

end;

procedure TSpecView.CopySequence1lettClick(Sender: TObject);
begin

  CopyStr2Clip('PEPTIDE')
end;

procedure TSpecView.CopySequence3lettClick(Sender: TObject);
begin
  CopyStr2Clip('ProGluProThrIleAspGlu')
end;

procedure TSpecView.CopySequenceAndMassClick(Sender: TObject);
begin
  CopyStr2Clip('PEPTIDE (M+H+: 800.367)')
end;

{-----------------------------------------------------------------------------}
procedure TSpecView.CopySpectrumBtnClick(Sender: TObject);
begin
  Exit;
end;

{-----------------------------------------------------------------------------}

procedure TSpecView.DeNovoChkClick(Sender: TObject);
begin
  DisplaySpecs;
end;

{-----------------------------------------------------------------------------}

procedure TSpecView.TransferPeaks (specCopy: tmsmsSpectrumData);
var i : integer;            colArr : array of integer;
begin
  SetLength (colArr, Length (specCopy));
  for i := Low (specCopy) to High (specCopy) do
    colArr [i] := clBlack;
  if ColorPeaksChk.Checked and (DNseq [1].mz > 10) then
    for i := Low (specCopy) to High (specCopy) do
      colArr [i] := FindPeakColor (specCopy [i].pkmz);
  for i := 0 to High (specCopy) do
    if specCopy [i].pkmz > 1 then
      BarSeries.AddXY (specCopy [i].pkmz, specCopy [i].pkint / 1000,
                              Format ('%6.2f', [specCopy [i].pkmz]), colArr [i]);
end;

{-----------------------------------------------------------------------------}
procedure TSpecView.TrimSeqCBtnClick(Sender: TObject);
begin
  Exit;
end;

procedure TSpecView.TrimSeqNBtnClick(Sender: TObject);
begin
  Exit;
end;

{-----------------------------------------------------------------------------}

procedure TSpecView.DisplaySpecs;
var specCopy : tmsmsSpectrumData;
begin
  BarSeries.Clear;
  SetLength (specCopy, Length (MainSpec.spec));
  specCopy := Copy (MainSpec.spec, Low (MainSpec.spec), Length (MainSpec.spec));
//  if MainSpec.header.mzmzCount > 0 then
  if Length (specCopy) > 1 then
  begin
//    if LimitPksChk.Checked then                                  //Reduce number of peaks
//      parentMgf.ReduceSize (specCopy, LimitTrack.Position);
    TransferPeaks (specCopy);
    MainChart.BottomAxis.SetMinMax (barSeries.MinXValue - 20, barSeries.MaxXValue + 100);
  end;
end;

{-----------------------------------------------------------------------------}

procedure TSpecView.FindAAdist(valueIndex: integer);
var i, count : integer;             diff : real;

Procedure SetPkPoint (lvl, serPoint, aaNum : integer;var pkPoint : tDNres);
begin
  pkPoint.level := lvl;
  pkPoint.xPos := BarSeries.CalcXPos (serPoint) + 1;
  pkPoint.yPos := BarSeries.CalcYPos (serPoint) + 1;
  pkPoint.mz := BarSeries.XValue [serPoint];
  pkPoint.int := BarSeries.YValue [serPoint];
  pkPoint.aaNum := aaNum;
  if aa.name1 [aaNum] = 'L' then
    pkPoint.resSt := 'L/I'
  else pkPoint.resSt := aa.name3 [aaNum];
  pkPoint.res1 := aa.name1 [aaNum];
end;

Procedure FindPkPoints (ndx : integer; diff : real; var DNr : tDNresArray;var count : integer);
var i, j : integer;
begin
  if (diff > 56) and (diff < 187) and (count < topDN) then
    for j := 2 to 21 do
      if (Abs (aa.mass [3, j] - diff) < 0.05) and (count < topDN) and (aa.name1 [j] <> 'I') then
      begin
        FInc (count);
        SetPkPoint (count, ndx, j, DNr [count]);
      end;
  for i := 1 to count - 1 do
    for j := 1 + 1 to count do
      if DNr [i].int < DNr [j].int then
        ExchangeStructs (DNr [i], DNr [j], SizeOf (DNr [j]));
  for i := 1 to count do
    DNr [i].level := i;
end;

begin
  FillChar (DNset, SizeOf (DNset), 0);
  DNset.Enabled := DeNovoChk.Checked;
  SetPkPoint (0, valueindex, 0, DNset.basePks);
  count := 0;
  for i := 0 to valueIndex - 1 do
  begin
    diff := DNset.basePks.mz - BarSeries.XValue [i];
    FindPkPoints (i, diff, DNset.newPks [1], count);
  end;
  count := 0;
  for i := valueIndex + 1 to BarSeries.XValues.Count - 1 do
  begin
    diff := BarSeries.XValue [i] - DNset.basePks.mz;
    FindPkPoints (i, diff, DNset.newPks [2], count);
  end;
  MainChart.Invalidate;
end;

{-----------------------------------------------------------------------------}

function TSpecView.FindPeakColor (mz: real): tColor;
var byIonMass : real;
begin
  result := clBlack;
  byIonMass := mainSpec.header.mass - mz + protonms * 2;
  for var i := 1 to Min (seqLen + 1, 30) do
  begin
    if Abs (mz - DNseq [i].mz) < Precision  then
      result := clAqua;
    if Abs (mz - DNseq [i].mz + mzH20) < Precision  then
      result := clFuchsia;
    if Abs (mz - DNseq [i].mz + mzNH3) < Precision  then
      result := clFuchsia;
  end;
  for var i := 1 to Min (seqLen + 1, 30) do
    if Abs (byIonMass - DNseq [i].mz) < Precision * 5 then
      result := clOrange;
end;

end.
