unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Search: TBitBtn;
    ClearSearch: TBitBtn;
    ListView1: TListView;
    AddAbonent: TBitBtn;
    ChangeAbonentInfo: TBitBtn;
    DeleteAbonent: TBitBtn;
    procedure ClearSearchClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AddAbonentClick(Sender: TObject);
    procedure ChangeAbonentInfoClick(Sender: TObject);
    procedure DeleteAbonentClick(Sender: TObject);
    procedure SearchClick(Sender: TObject);
    procedure ListView1ColumnClick(Sender: TObject; Column: TListColumn);
    procedure ListView1Compare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  TAbonents = record
    Surname, Name, Patronymic: string[30];
    TelephoneNumber: string[13];
    number: integer;
    found: boolean;
  end;

  Cell = ^TCell;
  TCell = record
    abonent: TAbonents;
    next: Cell;
  end;

var
  Form1: TForm1;
  FileOfAbonents: file of TAbonents;
  AbonentHead, CurrAbonent: Cell;
  NewAbonent, SearchButton: boolean;
  ArrayOfWords: array [0..99] of string;
  ColumnToSort, SortedColumn: integer;
  Sorted: boolean;

implementation

uses Unit2;

{$R *.dfm}

procedure DrawListView;
var
  i, j: integer;
begin
  New(AbonentHead);
  CurrAbonent := AbonentHead;
  CurrAbonent^.next := nil;

  AssignFile(FileOfAbonents, 'Abonents.dat');
  Reset(FileOfAbonents);
  while Eof(FileOfAbonents) = false do
  begin
    New(CurrAbonent^.next);
    CurrAbonent := CurrAbonent^.next;
    read(FileOfAbonents, CurrAbonent^.abonent);
    CurrAbonent^.next := nil;
  end;
  CloseFile(FileOfAbonents);

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

procedure TForm1.FormCreate(Sender: TObject);
begin
  DrawListView;
  SearchButton := false;
end;

procedure PrepareProfileIcon;
begin
  with Form2 do
  begin
    Show;
    Edit1.Clear;
    Edit2.Clear;
    Edit3.Clear;
    Edit4.Clear;
  end;
end;

procedure BreakIntoWords(var AmountOfWords: integer; str: string; var ArrayOfWords: array of string);
var
  CurrWord: integer;
begin
  CurrWord := 0;
  while pos(' ', str) <> 0 do
  begin
    if pos(' ', str) = 1 then
      delete(str, pos(' ', str), 1)
    else
    begin
      ArrayOfWords[CurrWord] := copy(str, 1, pos(' ', str) - 1);
      delete(str, 1, pos(' ', str));
      inc(CurrWord);
    end;
  end;

  if (str <> ' ') and (length(str) <> 0) then
  begin
    ArrayOfWords[CurrWord] := str;
    inc(CurrWord);
  end;
  AmountOfWords := CurrWord;
end;

procedure TForm1.ClearSearchClick(Sender: TObject);
begin
  SearchButton := false;
  Edit1.Clear;
  DrawListView;
end;

procedure TForm1.AddAbonentClick(Sender: TObject);
begin
  PrepareProfileIcon;
  NewAbonent := true;
end;

procedure TForm1.ChangeAbonentInfoClick(Sender: TObject);
var
  i, j, k: integer;
begin
  try
    i := ListView1.Selected.Index;
    j := strtoint(ListView1.Items.Item[i].Caption);
    CurrAbonent := AbonentHead;
    CurrAbonent := CurrAbonent^.next;
    if SearchButton = false then
    begin
      while CurrAbonent^.abonent.number <> j do
        CurrAbonent := CurrAbonent^.next;
    end
    else
    begin
      k := 0;
      while (CurrAbonent^.abonent.Surname <> ArrayOfWords[k]) and (CurrAbonent^.abonent.Name <> ArrayOfWords[k]) and (CurrAbonent^.abonent.Patronymic <> ArrayOfWords[k]) and (CurrAbonent^.abonent.found = false) do
      begin
        CurrAbonent := CurrAbonent^.next;
        inc(k);
      end;
    end;
    with Form2 do
      begin
        Show;
        NewAbonent := false;
        Edit1.Text := CurrAbonent^.abonent.surname;
        Edit2.Text := CurrAbonent^.abonent.name;
        Edit3.Text := CurrAbonent^.abonent.patronymic;
        Edit4.Text := CurrAbonent^.abonent.TelephoneNumber;
      end;
  except ShowMessage('Выберите абонента');
  end;
end;

procedure TForm1.DeleteAbonentClick(Sender: TObject);
var
  i, j, k: integer;
  Abonent: Cell;
begin
  try
    i := ListView1.Selected.Index;
    j := strtoint(ListView1.Items.Item[i].Caption);
    CurrAbonent := AbonentHead;
    if SearchButton = false then
    begin
      while CurrAbonent^.next^.abonent.number <> j do
        CurrAbonent := CurrAbonent^.next;
    end
    else
    begin
      k := 0;
      while (CurrAbonent^.next^.abonent.Surname <> ArrayOfWords[k]) and (CurrAbonent^.next^.abonent.Name <> ArrayOfWords[k]) and (CurrAbonent^.next^.abonent.Patronymic <> ArrayOfWords[k]) and (CurrAbonent^.next^.abonent.found = false) do
      begin
        CurrAbonent := CurrAbonent^.next;
        inc(k);
      end;
    end;
    
    Abonent := CurrAbonent^.next;
    CurrAbonent^.next := Abonent^.next;
    Dispose(Abonent);

    CurrAbonent := AbonentHead;
    AssignFile(FileOfAbonents, 'Abonents.dat');
    Rewrite(FileOfAbonents);
    while CurrAbonent^.next <> nil do
    begin
      CurrAbonent := CurrAbonent^.next;
      write(FileOfAbonents, CurrAbonent^.abonent);
    end;
  CloseFile(FileOfAbonents);
  except showmessage('Выберите абонента');
  end;
  DrawListView;
end;

procedure TForm1.SearchClick(Sender: TObject);
var
  AmountOfWords: integer;
  i, j, k: integer;
  WordsToSearch: string;
  
begin
  SearchButton := true;
  AmountOfWords := 0;
  WordsToSearch := Edit1.Text;
  BreakIntoWords(AmountOfWords, WordsToSearch, ArrayOfWords);

  if AmountOfWords <> 0 then
  begin
    i := 0;
    j := 1;
    ListView1.Items.Clear;
    CurrAbonent := AbonentHead;
    while CurrAbonent^.next <> nil do
    begin
      CurrAbonent := CurrAbonent^.next;
      CurrAbonent^.abonent.found := false;
    end;
    CurrAbonent := AbonentHead;

    while CurrAbonent^.next <> nil do
    begin
      k := 0;
      CurrAbonent := CurrAbonent^.next;
      while k < AmountOfWords do
      begin
        if ((CurrAbonent^.abonent.found = false)) and ((CurrAbonent^.abonent.Surname = ArrayOfWords[k]) or (CurrAbonent^.abonent.Name = ArrayOfWords[k]) or (CurrAbonent^.abonent.Patronymic = ArrayOfWords[k]) or (CurrAbonent^.abonent.TelephoneNumber = ArrayOfWords[k])) then
        begin
          CurrAbonent^.abonent.found := true;
          CurrAbonent^.abonent.number := j;
          ListView1.Items.Add.Caption := inttostr(CurrAbonent^.abonent.number);
          ListView1.Items.Item[i].SubItems.Add(CurrAbonent^.abonent.Surname + ' ' + CurrAbonent^.abonent.Name + ' ' + CurrAbonent^.abonent.Patronymic);
          ListView1.Items.Item[i].SubItems.Add(CurrAbonent^.abonent.TelephoneNumber);
          inc(j);
          inc(i);
        end;
        inc(k);
      end;
    end;
  end;
end;

procedure TForm1.ListView1ColumnClick(Sender: TObject; Column: TListColumn);
Begin
  ColumnToSort := Column.Index;
  if SortedColumn <> ColumnToSort then
  begin
    SortedColumn := ColumnToSort;
    Sorted := false;
  end
  else
    Sorted := not Sorted;

  (Sender as TCustomListView).AlphaSort;
End;

procedure TForm1.ListView1Compare(Sender: TObject; Item1, Item2: TListItem;
  Data: Integer; var Compare: Integer);
begin
  if ColumnToSort = 0 then
    Compare := CompareText(Item1.Caption, Item2.Caption)
  else
    Compare := CompareText(Item1.SubItems[SortedColumn - 1], Item2.SubItems[SortedColumn - 1]);

  if Sorted then
    Compare := - Compare;
end;

end.
