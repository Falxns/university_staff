program Lab7_2;

uses
  Vcl.Forms,
  Main in 'Main.pas' {MainF},
  List in 'List.pas' {ListF},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Onyx Blue');
  Application.CreateForm(TMainF, MainF);
  Application.CreateForm(TListF, ListF);
  Application.Run;
end.
