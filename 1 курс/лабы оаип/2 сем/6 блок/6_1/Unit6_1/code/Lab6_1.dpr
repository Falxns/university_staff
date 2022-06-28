program Lab6_1;

uses
  Vcl.Forms,
  Main in 'Main.pas' {MainForm},
  Vcl.Themes,
  Vcl.Styles,
  AddText in 'AddText.pas' {AddF},
  MyUnit in 'MyUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Onyx Blue');
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAddF, AddF);
  Application.Run;
end.
