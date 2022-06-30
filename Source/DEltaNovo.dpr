program DEltaNovo;

uses
  Vcl.Forms,
  FormMain in 'FormMain.pas' {TMainForm},
  SpectrumViewForm in 'SpectrumViewForm.pas' {SpectrumView},
  GENERAL in 'GENERAL.PAS',
  Globals in 'Globals.pas',
  IO_UNIT in 'IO_UNIT.PAS',
  StrGeneral in 'StrGeneral.pas',
  SpectraUtils in 'SpectraUtils.pas',
  DeNovoSequencingUtils in 'DeNovoSequencingUtils.pas',
  LogForm in 'LogForm.pas' {FormLog},
  GeneralUtils in 'GeneralUtils.pas',
  DNovoSequencer in 'DNovoSequencer.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
