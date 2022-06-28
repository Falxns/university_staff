program Project1;

uses
  Vcl.Forms,
  MainUn in 'MainUn.pas' {Main},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Onyx Blue');
  Application.CreateForm(TMain, Main);
  Application.Run;
end.
