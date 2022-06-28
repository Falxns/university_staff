program Lab7_1;

uses
  Vcl.Forms,
  Main in 'Main.pas' {MainF},
  Vcl.Themes,
  Vcl.Styles,
  Graph in 'Graph.pas' {GraphF};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Onyx Blue');
  Application.CreateForm(TMainF, MainF);
  Application.CreateForm(TGraphF, GraphF);
  Application.Run;
end.
