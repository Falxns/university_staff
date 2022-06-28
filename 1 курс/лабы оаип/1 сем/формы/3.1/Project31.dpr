program Project31;

uses
  Vcl.Forms,
  Unit31 in 'Unit31.pas' {TMaxim},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTMaxim, TMaxim);
  Application.Run;
end.
