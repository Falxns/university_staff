unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Unit1;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label4: TLabel;
    Edit4: TEdit;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure DrawListView;
var
  i, j: integer;
begin
  i := 0;
  j := 1;
  CurrAbonent := AbonentHead;
  with Form1 do
  begin
    with ListView1.Items do
    begin
      Clear;
      while CurrAbonent^.next <> nil do
      begin
        CurrAbonent := CurrAbonent^.next;
        CurrAbonent^.abonent.number := j;
        Add.Caption := inttostr(CurrAbonent^.abonent.number);
        Item[i].Subitems.Add(CurrAbonent^.abonent.surname + ' ' + CurrAbonent^.abonent.name + ' ' + CurrAbonent^.abonent.patronymic);
        Item[i].SubItems.Add(CurrAbonent^.abonent.TelephoneNumber);
        inc(i);
        inc(j);
      end;
    end;
  end;
end;


procedure TForm2.BitBtn1Click(Sender: TObject);
begin
  if NewAbonent = true then
  begin
    New(CurrAbonent^.next);
    CurrAbonent := CurrAbonent^.next;
    CurrAbonent^.next := nil;
  end;
  
  with CurrAbonent^.abonent do
  begin
    surname := Edit1.Text;
    name := Edit2.Text;
    patronymic := Edit3.Text;
    TelephoneNumber := Edit4.text;
  end;

  CurrAbonent := AbonentHead;
  AssignFile(FileOfAbonents, 'Abonents.dat');
  Rewrite(FileOfAbonents);
  while CurrAbonent^.next <> nil do
  begin
    CurrAbonent := CurrAbonent^.next;
    write(FileOfAbonents, CurrAbonent^.abonent);
  end;
  CloseFile(FileOfAbonents);
  DrawListView;
  Form2.Hide;
end;

end.
