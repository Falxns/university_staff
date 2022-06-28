program Clock;

uses
  Forms,
  Main in 'Main.pas' {MainF};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainF, MainF);
  Application.Run;
end.
