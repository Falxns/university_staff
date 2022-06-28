program Project1;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {EDS},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows10');
  Application.CreateForm(TEDS, EDS);
  Application.Run;
end.
