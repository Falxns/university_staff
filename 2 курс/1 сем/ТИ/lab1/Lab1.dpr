program Lab1;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Menu},
  Unit2 in 'Unit2.pas' {Cipher};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMenu, Menu);
  Application.CreateForm(TCipher, Cipher);
  Application.Run;
end.
