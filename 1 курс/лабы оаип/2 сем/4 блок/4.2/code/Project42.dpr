program Project42;

uses
  Vcl.Forms,
  Unit42 in 'Unit42.pas' {Lab_4_2},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows10');
  Application.CreateForm(TLab_4_2, Lab_4_2);
  Application.Run;
end.
