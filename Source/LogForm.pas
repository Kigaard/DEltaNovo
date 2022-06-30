unit LogForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ExtCtrls, AdvPanel, AdvGlowButton;

type
  TFormLog = class(TForm)
    LogList: TListBox;
    ButtomPanel: TAdvPanel;
    SaveBtn: TAdvGlowButton;
    SaveDlg: TSaveDialog;
    ClearBtn: TAdvGlowButton;
    procedure SaveBtnClick(Sender: TObject);
    procedure ClearBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Procedure AddHeader(header: string);
    Procedure AddLogMessage(msgFormat: string; msgArgs: array of const; isDebugMsg: boolean = False); overload;
    Procedure AddLogMessage(msg: string; isDebugMsg: boolean = False); overload;

    Procedure ClearSystemMessages;
  end;

var
  FormLog: TFormLog;

implementation

{$R *.dfm}

{ TFormLog }

Procedure TFormLog.AddHeader(header: string);
begin
  AddLogMessage('***** %s *****', [header]);
end;

Procedure TFormLog.AddLogMessage(msgFormat: string; msgArgs: array of const; isDebugMsg: boolean = False);
var msg: string;
begin
  msg := Format(msgFormat, msgArgs);

  if isDebugMsg then
  begin
    {$IFDEF DEBUG}
    LogList.Items.Add(Format('DEBUG: %s', [msg]));
    {$ENDIF}
  end
  else
  begin
    LogList.Items.Add(msg);
  end;

  LogList.perform(WM_VSCROLL, SB_BOTTOM, 0);
  LogList.perform(WM_VSCROLL, SB_ENDSCROLL, 0);
end;

procedure TFormLog.AddLogMessage(msg: string; isDebugMsg: boolean = False);
begin
  AddLogMessage(msg, [], isDebugMsg);
end;

procedure TFormLog.ClearBtnClick(Sender: TObject);
begin
  LogList.Items.Clear();
end;

procedure TFormLog.SaveBtnClick(Sender: TObject);
begin
  if SaveDlg.Execute() then
  begin
    LogList.Items.SaveToFile(SaveDlg.Filename);
  end;
end;

procedure TFormLog.ClearSystemMessages;
{ Cheating utily which process and clears the current system.
Placed in the log form as almost all forms has access to it.}
begin
  Application.ProcessMessages;
end;

end.
