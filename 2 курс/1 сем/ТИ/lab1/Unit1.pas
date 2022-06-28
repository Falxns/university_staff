unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TMenu = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    CipherNum: Byte;
  end;

var
  Menu: TMenu;

implementation

{$R *.dfm}

uses
   Unit2;

procedure TMenu.Button1Click(Sender: TObject);
begin
   CipherNum := 1;
   Cipher.ShowModal;
end;

procedure TMenu.Button2Click(Sender: TObject);
begin
   CipherNum := 2;
   Cipher.ShowModal;
end;

procedure TMenu.Button3Click(Sender: TObject);
begin
   CipherNum := 3;
   Cipher.ShowModal;
end;

end.
