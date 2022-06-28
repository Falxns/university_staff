program Project1;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Rabina},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Onyx Blue');
  Application.CreateForm(TRabina, Rabina);
  Application.Run;
end.
