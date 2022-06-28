program Project1;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Lab_Hesh},
  Unit2 in 'Unit2.pas' {Add};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TLab_Hesh, Lab_Hesh);
  Application.CreateForm(TAdd, Add);
  Application.Run;
end.
