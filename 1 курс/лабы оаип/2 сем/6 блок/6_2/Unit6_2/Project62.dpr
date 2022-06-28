program Project62;

uses
  System.StartUpCopy,
  FMX.Forms,
  Unit62 in 'Unit62.pas' {Lab_6_2},
  MyUnit in 'MyUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TLab_6_2, Lab_6_2);
  Application.Run;
end.
