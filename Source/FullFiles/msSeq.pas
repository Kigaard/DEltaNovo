unit msSeq;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  AdvPanel, SpecViewForm, AdvOfficeButtons, AdvGlowButton, General, StrGeneral,
  AdvUtil, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, ShellAPI, io_unit, globals,
  System.UITypes;

type
  TMsSeqForm = class (TForm)
    BottomPanel: TAdvPanel;
    ViewSpecChk: TAdvOfficeCheckBox;
    CloseBtn: TAdvGlowButton;
    OpenBtn: TAdvGlowButton;
    OpenDlg: TOpenDialog;
    ResultGrid: TAdvStringGrid;
    AdvPanel1: TAdvPanel;
    procedure CloseBtnClick (Sender: TObject);
    procedure FormCreate (Sender: TObject);
    procedure ViewSpecChkClick (Sender: TObject);
    procedure FormClose (Sender: TObject; var Action: TCloseAction);
    procedure OpenBtnClick (Sender: TObject);
  private
    SpecTrumWin : tSpecView;                  //spectrum window
    Procedure OpenSpecFile (fName : string);
  public
    Spectrum : tSpecData;
    Procedure AfterConstruction; override;
    Procedure WMDropFiles (var msg : TWMDropFiles); message WM_DropFiles;
  end;

var MsSeqForm: TMsSeqForm;

implementation

{$R *.dfm}

{------------------------------------------------------------------------------}

procedure TMsSeqForm.AfterConstruction;
begin
  inherited;
  LoadMassFile (aa, 'aa_mass.mss');
end;

{------------------------------------------------------------------------------}

procedure TMsSeqForm.CloseBtnClick (Sender: TObject);
begin
  Close;
end;

{------------------------------------------------------------------------------}

procedure TMsSeqForm.FormClose (Sender: TObject; var Action: TCloseAction);
begin
  if Spectrum <> nil then
    SpectrumWin.Free;
  DragAcceptFiles (self.Handle, false);
end;

{------------------------------------------------------------------------------}

procedure TMsSeqForm.FormCreate (Sender: TObject);
begin
  SpecTrumWin := tSpecView.Create (self);
  SpectrumWin.Visible := true;
  DragAcceptFiles (self.Handle, true);
end;

{------------------------------------------------------------------------------}

procedure TMsSeqForm.OpenBtnClick (Sender: TObject);
begin
  if OpenDlg.Execute then
    OpenSpecFile (OpenDlg.FileName);
end;

{------------------------------------------------------------------------------}

procedure TMsSeqForm.OpenSpecFile (fName: string);
var count, i : integer;            inF : textFile;         s : string;
    inpText : tStringList;
begin
  count := 0;
  inpText := tStringList.Create;
try
  Assignfile (inF, fName);
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
    spectrum [i].pkms := Str2Real (ExtractWord (1, inpText [i], ' '#9), 0);
    spectrum [i].pkint := Str2Real (ExtractWord (2, inpText [i], ' '#9), 0);
  end;
finally
  CloseFile (inF);
  inpText.Free;
  MessageDlg (Format ('File read: %s' + #13#10 + 'Entries: %d', [JustFileName (fName),
                                  Count]), mtInformation, [mbOK], 0, mbOK);
end;
  SpectrumWin.mainSpec.spec := spectrum;
  SpectrumWin.DisplaySpecs;
end;

{------------------------------------------------------------------------------}

procedure TMsSeqForm.ViewSpecChkClick (Sender: TObject);
begin
  SpectrumWin.Visible := ViewSpecChk.Checked;
end;

{------------------------------------------------------------------------------}

procedure TMsSeqForm.WMDropFiles (var msg: TWMDropFiles);
var i, count : integer;      nBuff : array [0..2048] of Char;
    fName : string;
begin
  count := DragQueryFile (msg.Drop, $FFFFFFFF, nil, 0);
  for i := 0 to count - 1 do
  begin
    DragQueryFile (msg.Drop, i, nBuff, SizeOf (nBuff));
    fName := String (nBuff);
//    if JustExtension (UpperCase (fName)) = 'TXT' then      //make spectrum view window
      OpenSpecFile (fName);
  end;
end;

{------------------------------------------------------------------------------}

end.
