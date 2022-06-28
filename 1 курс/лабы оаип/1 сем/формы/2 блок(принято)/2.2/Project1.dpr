program Project1;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Maksim};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMaksim, Maksim);
  Application.Run;
end.
