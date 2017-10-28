program RinexGraph;

uses
  Forms,
  uMain in 'uMain.pas' {Form1},
  RegExpr in 'RegExpr.pas',
  RinexFile in 'RinexFile.pas',
  ObservFile in 'ObservFile.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
