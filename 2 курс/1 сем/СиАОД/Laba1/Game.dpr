program Game;

uses
  Vcl.Forms,
  Main in 'Main.pas' {MainF};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainF, MainF);
  Application.Run;
end.
