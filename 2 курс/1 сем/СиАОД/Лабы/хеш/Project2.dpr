program ProjectMyedition;
{$APPTYPE CONSOLE}

uses
  SysUtils,
  Windows;

const
  amountOfElements = 100;

type
  termMarker = ^listOfTerms;

  pageMarker = ^listOfPage;

  searchResult = ^listOfSearchResult;

  addressMarker = ^listOfAddress;

  sortTermMarker = ^listOfSortTerms;

  tableWithTerms = array[1..amountOfElements] of TermMarker;

  listOfPage = record
    Page: integer;
    Next: PageMarker;
  end;

  listOfTerms = record
    data: string;
    underterm: tableWithTerms;
    Pages: PageMarker;
    Next: TermMarker;
  end;

  listOfSearchResult = record
    Address: addressMarker;
    Result: TermMarker;
    Next: searchResult;
  end;

  listOfAddress = record
    Point: string;
    Next: addressMarker;
  end;

  listOfSortTerms = record
    data: string;
    SubTerms: sortTermMarker;
    Pages: PageMarker;
    Next: sortTermMarker;
  end;

var
  Content: tableWithTerms;

function HashFunction(term: string): integer;
begin
  result := ord(term[1]) - 223;
end;

procedure CreateTable(var HashTable: tableWithTerms);
var
  i: Integer;
begin
  for i := 1 to amountOfElements do
  begin
    new(HashTable[i]);
    HashTable[i]^.Next := nil;
  end;
end;

function SetPageMarker(page: integer): PageMarker;
begin
  New(result);
  result^.Page := page;
  result^.Next := nil;
end;

procedure AddPage(var first: PageMarker; page: PageMarker);
var
  x: PageMarker;
begin
  x := first;
  while x^.Next <> nil do
    x := x^.Next;
  x^.Next := page;
end;

function SetTermMarker(data: string; page: PageMarker): TermMarker;
begin
  New(result);
  result^.data := data;
  New(result^.Pages);
  result^.Pages^.Next := page;
  CreateTable(result^.underterm);
  result^.Next := nil;
end;

function SetSortTermMarker(data: string; page: PageMarker): sortTermMarker;
begin
  New(result);
  result^.data := data;
  New(result^.Pages);
  result^.Pages^.Next := page;
  New(result^.SubTerms);
  result^.Next := nil;
end;

function LittleFindTerm(term: TermMarker; parrent: tableWithTerms): TermMarker;
var
  x: TermMarker;
begin
  x := parrent[HashFunction(term^.data)]^.Next;
  while (x <> nil) and (x^.data <> term^.data) do
    x := x^.Next;
  result := x;
end;

procedure AddResultsToList(var first: searchResult; var plus: searchResult);
var
  x: searchResult;
begin
  if first = nil then
    first := plus
  else
    first^.Next := plus;
  if plus <> nil then
  begin
    x := plus;
    while x^.Next <> nil do
      x := x^.Next;
    first := x;
  end;
end;

function CopyAddress(x: addressMarker): addressMarker;
var
  y, z: addressMarker;
begin
  New(y);
  result := y;
  while x <> nil do
  begin
    y^.Point := x^.Point;
    z := y;
    New(y);
    z^.Next := y;
    x := x^.Next;
  end;
  z^.Next := nil;
end;

procedure AddAddress(var x, add: addressMarker);
var
  y: addressMarker;
begin
  y := x;
  while y^.Next <> nil do
    y := y.Next;
  y^.Next := add;
end;

function FTerm(Address: addressMarker; term: TermMarker; parrent: tableWithTerms): searchResult;
var
  i: integer;
  x: TermMarker;
  rez, t1, t2, t3: searchResult;
  adr, t: addressMarker;
begin
  x := LittleFindTerm(term, parrent);
  New(rez);
  rez^.Next := nil;
  t1 := rez;
  if x <> nil then
  begin
    New(t2);
    t2^.Address := Address;
    t2^.Result := x;
    t2^.Next := nil;
    AddresultsToList(t1, t2);
  end;
  for i := 1 to amountOfElements do
  begin
    x := parrent[i]^.Next;
    while x <> nil do
    begin
      New(t);
      t^.Point := x^.data;
      t^.Next := nil;
      adr := CopyAddress(Address);
      AddAddress(adr, t);
      t3 := FTerm(adr, term, x^.underterm);
      AddResulTSToList(t1, t3);
      x := x^.Next;
    end;
  end;
  FTerm := rez^.Next;
end;

function FindPage(first: PageMarker; page: PageMarker; var prev: PageMarker): PageMarker;
begin
  prev := first;
  first := first^.Next;
  while (first <> nil) and (first^.Page <> page^.Page) do
  begin
    prev := prev^.Next;
    first := first^.Next;
  end;
  result := first;
end;

function SetParrent(x: searchResult): tableWithTerms;
var
  adr: addressMarker;
  HashTable: tableWithTerms;
begin
  adr := x^.Address^.Next;
  HashTable := Content;
  while adr <> nil do
  begin
    HashTable := LittleFindTerm(SetTermMarker(adr^.Point, nil), HashTable)^.underterm;
    adr := adr^.Next;
  end;
  result := HashTable;
end;

function SetTermFormFind(x: searchResult): TermMarker;
begin
  result := LittleFindTerm(x^.Result, SetParrent(x));
end;

function FindTerm(term: TermMarker): searchResult;
var
  Adr: addressMarker;
begin
  New(Adr);
  Adr^.Next := nil;
  New(result);
  result^.Next := FTerm(Adr, term, Content);
end;

procedure AddTerm(var HashTable: tableWithTerms; Term: TermMarker);
var
  t: integer;
  prev: TermMarker;
  x: TermMarker;
begin
  t := HashFunction(Term^.data);
  prev := HashTable[t];
  x := prev^.Next;
  while (x <> nil) and (AnsiLowerCase(x^.data) < AnsiLowerCase(Term^.data)) do
  begin
    x := x^.Next;
    prev := prev^.Next;
  end;
  prev^.Next := Term;
  Term^.Next := x;
end;

procedure WritePageList(first: PageMarker);
var
  x: PageMarker;
begin
  x := first^.Next;
  while x <> nil do
  begin
    write(x^.Page);
    x := x^.Next;
    if x <> nil then
      write(',');
  end;
end;

procedure WriteHashTable(table: tableWithTerms; indent: integer); forward;

procedure WriteTerm(term: TermMarker; indent: integer; sub: boolean);
var
  i: integer;
begin
  for i := 1 to indent do
    write('   ');
  write((term^.data), ' ');
  WritePageList(term^.Pages);
  Writeln;
  if sub then
    WriteHashTable(term^.underterm, indent + 1);
end;

procedure WriteHashTable;
var
  i: integer;
  x: TermMarker;
begin
  for i := 1 to amountOfElements do
  begin
    x := table[i]^.Next;
    while x <> nil do
    begin
      WriteTerm(x, indent, true);
      x := x^.Next;
    end;
  end;
end;

procedure WriteFindResult(rez: searchResult; sub: boolean);
var
  i, j, indent: integer;
  x: searchResult;
  y: addressMarker;
begin
  i := 1;
  x := rez^.Next;
  if x = nil then
    Writeln('Термин не найден');
  while x <> nil do
  begin
    Writeln(i, ':');
    i := i + 1;
    indent := 0;
    y := x^.Address^.Next;
    while y <> nil do
    begin
      for j := 1 to indent do
        write('  ');
      indent := indent + 1;
      writeln(y^.Point);
      y := y^.Next;
    end;
    WriteTerm(x^.Result, indent, sub);
    x := x^.Next;
  end;
end;

function FindOneTerm(rez: searchResult): searchResult;
var
  n, i: integer;
  frez: searchResult;
begin
  frez := rez;
  if rez^.Next = nil then
  begin
    result := nil;
    exit;
  end
  else if rez^.Next^.Next = nil then
    frez := rez^.Next
  else
  begin
    Writeln('Были найдены следующие термины: ');
    WriteFindResult(frez, false);
    Write('С каким вы хотите продолжить работу: ');
    Readln(n);
    for i := 1 to n do
      frez := frez^.Next;
  end;
  result := frez;
end;

procedure DeleteTerm(var par: tableWithTerms; frez: TermMarker);
var
  x: TermMarker;
begin
  x := par[HashFunction(frez^.data)];
  while (x^.Next <> nil) and (x^.Next^.data <> frez^.data) do
    x := x^.Next;
  x^.Next := x^.Next^.Next;
end;

procedure WriteSPT(x: sortTermMarker; indent: integer);
var
  i: integer;
begin
  while x <> nil do
  begin
    for i := 1 to indent do
      write('   ');
    write((x^.data), ' ');
    WritePageList(x^.Pages);
    Writeln;
    WriteSPT(x^.SubTerms, indent + 1);
    x := x^.Next;
  end;
end;

function PrSortByPages(HashTable: tableWithTerms): sortTermMarker;
var
  x: TermMarker;
  y, prev, sort: sortTermMarker;
  i: integer;
begin
  New(sort);
  sort^.Next := nil;
  for i := 1 to amountOfElements do
  begin
    x := HashTable[i]^.Next;
    while x <> nil do
    begin
      y := sort^.Next;
      prev := sort;
      while (y <> nil) and (y^.Pages^.Next^.Page < x^.Pages^.Next^.Page) do
      begin
        prev := prev^.Next;
        y := y^.Next;
      end;
      prev^.Next := SetSortTermMarker(x^.data, x^.Pages^.Next);
      prev^.Next^.Next := y;
      prev^.Next^.SubTerms := PrSortByPages(x^.underterm);
      x := x^.Next;
    end;
  end;
  result := sort^.Next;
end;

procedure SortByPages;
begin
  WriteSPT(PrSortByPages(Content), 0);
end;

procedure WriteHelp;
begin
  writeln('Введите номер соответствующей команды:');
  writeln('   0)   содержание отсортированное по страницам');
  writeln('   1)   содержание отсортированное по алфавиту');
  writeln('   2)   показать содержание');
  writeln('   3)   добавить термин(подтермин)');
  writeln('   4)   добавить страницу для термина(подтермина)');
  writeln('   5)   изменить термин(подтермин)');
  writeln('   6)   изменить страницу для термина(подтермина)');
  writeln('   7)   поиск термина(подтермина)');
  writeln('   8)   удалить термин(подтермин)');
  writeln('   9)   удалить страницу');
  writeln('   10)  выйти из программы');
end;

var
  instruction: integer;
  upterm, p: string;
  frez: TermMarker;
  find: searchResult;
  AddHashTable: tableWithTerms;
  page, prev: PageMarker;

begin
  SetConsoleOutputCP(1251);
  SetConsoleCP(1251);
  CreateTable(Content);
  AddTerm(Content, SetTermMarker(('растения'), SetPageMarker(250)));
  AddPage(Content[HashFunction(('растения'))]^.Next^.Pages, SetPageMarker(252));
  AddPage(Content[HashFunction(('растения'))]^.Next^.Pages, SetPageMarker(870));
  AddPage(Content[HashFunction(('растения'))]^.Next^.Pages, SetPageMarker(963));
  AddTerm(Content[HashFunction(('растения'))]^.Next^.underterm, SetTermMarker('водоросли', SetPageMarker(542)));
  AddTerm(Content[HashFunction(('растения'))]^.Next^.underterm, SetTermMarker('споровые', SetPageMarker(987)));
  AddTerm(Content[HashFunction(('растения'))]^.Next^.underterm, SetTermMarker('семенные', SetPageMarker(570)));
  AddTerm(FindTerm(SetTermMarker('семенные', nil))^.Next^.Result^.underterm, SetTermMarker(('папоротники'), SetPageMarker(590)));
  AddTerm(FindTerm(SetTermMarker('семенные', nil))^.Next^.Result^.underterm, SetTermMarker(('хвойные'), SetPageMarker(603)));
  AddTerm(FindTerm(SetTermMarker('семенные', nil))^.Next^.Result^.underterm, SetTermMarker(('покрытосеменные'), SetPageMarker(634)));

  AddTerm(Content, SetTermMarker(('животные'), nil));
  AddPage(Content[HashFunction(('животные'))]^.Next^.Pages, SetPageMarker(180));
  AddPage(Content[HashFunction(('животные'))]^.Next^.Pages, SetPageMarker(258));
  AddPage(Content[HashFunction(('животные'))]^.Next^.Pages, SetPageMarker(300));
  AddTerm(Content[HashFunction(('животные'))]^.Next^.underterm, SetTermMarker('птицы', SetPageMarker(400)));
  AddTerm(Content[HashFunction(('животные'))]^.Next^.underterm, SetTermMarker('млекопитающие', SetPageMarker(580)));
  AddTerm(Content[HashFunction(('животные'))]^.Next^.underterm, SetTermMarker('рыбы', SetPageMarker(503)));

  AddTerm(Content, SetTermMarker(('грибы'), SetPageMarker(980)));
  AddPage(Content[HashFunction(('грибы'))]^.Next^.Pages, SetPageMarker(1105));
  AddPage(Content[HashFunction(('грибы'))]^.Next^.Pages, SetPageMarker(1200));
  AddTerm(Content[HashFunction(('грибы'))]^.Next^.underterm, SetTermMarker('зигомицеты', SetPageMarker(1150)));
  AddTerm(Content[HashFunction(('грибы'))]^.Next^.underterm, SetTermMarker('хитридиомицеты', SetPageMarker(1206)));

  AddTerm(Content, SetTermMarker(('протисты'), SetPageMarker(195)));

  AddTerm(Content, SetTermMarker(('бактерии'), SetPageMarker(200)));

  WriteHelp;
  Writeln;
  writeln('Номер команды: ');
  Readln(instruction);
  Writeln;
  while instruction <> 10 do
  begin
    case instruction of
      0:
        SortByPages;
      1:
        WriteHashTable(Content, 0);
      2:
        WriteHashTable(Content, 0);
      3:
        begin
          writeln('Введите надтермин добавляемого термина', #13, #10'(Нажмите enter если хотите добавить ТЕРМИН)');
          Readln(upterm);
          if upterm = '' then
            AddHashTable := Content
          else
          begin
            frez := SetTermFormFind(FindOneTerm(FindTerm(SetTermMarker(upterm, nil))));
            if frez = nil then
            begin
              writeln('Надтермин не найден');
              continue;
            end;
            AddHashTable := frez^.underterm;
          end;
          writeln('Введите добавляемый термин: ');
          Readln(upterm);
          if LittleFindTerm(SetTermMarker(upterm, nil), AddHashTable) = nil then
          begin
            writeln('Введите номер страницы: ');
            Readln(p);
            AddTerm(AddHashTable, SetTermMarker(upterm, SetPageMarker(StrToInt(p))));
            writeln('Термин  добавлен');
          end
          else
            writeln('Такой термин уже есть');
        end;
      4:
        begin
          writeln('Введите термин: ');
          Readln(upterm);
          frez := SetTermFormFind(FindOneTerm(FindTerm(SetTermMarker(upterm, nil))));
          if frez = nil then
            writeln('Термин не найден')
          else
          begin
            writeln('Введите номер страницы: ');
            Readln(upterm);
            AddPage(frez^.Pages, SetPageMarker(StrToInt(upterm)));
            writeln('Страница  добавлена');
          end;
        end;
      5:
        begin
          writeln('Введите термин: ');
          Readln(upterm);
          find := FindOneTerm(FindTerm(SetTermMarker(upterm, nil)));
          frez := SetTermFormFind(find);
          if frez = nil then
            writeln('Термин не найден')
          else
          begin
            writeln('Введите новое значение: ');
            Readln(upterm);
            AddHashTable := SetParrent(find);
            DeleteTerm(AddHashTable, frez);
            frez^.data := upterm;
            AddTerm(AddHashTable, frez);
            writeln('Термин  изменён');
          end;
        end;
      6:
        begin
          writeln('Введите термин: ');
          Readln(upterm);
          frez := SetTermFormFind(FindOneTerm(FindTerm(SetTermMarker(upterm, nil))));
          if frez = nil then
            writeln('Термин не найден')
          else
          begin
            writeln('Введите старое значение: ');
            Readln(upterm);
            page := FindPage(frez^.Pages, SetPageMarker(StrToInt(upterm)), prev);
            if page = nil then
              writeln('Страница не найдена')
            else
            begin
              writeln('Введите новое значение: ');
              Readln(upterm);
              page^.Page := StrToInt(upterm);
              writeln('Страница  изменёна');
            end;
          end;
        end;
      7:
        begin
          writeln('Введите термин: ');
          Readln(upterm);
          WriteFindResult(FindTerm(SetTermMarker(upterm, nil)), true);
        end;
      8:
        begin
          writeln('Введите термин: ');
          Readln(upterm);
          find := FindOneTerm(FindTerm(SetTermMarker(upterm, nil)));
          frez := SetTermFormFind(find);
          if frez = nil then
            writeln('Термин не найден')
          else
          begin
            AddHashTable := SetParrent(find);
            DeleteTerm(AddHashTable, frez);
            writeln('Термин удалён ')
          end;
        end;
      9:
        begin
          writeln('Введите термин: ');
          Readln(upterm);
          frez := SetTermFormFind(FindOneTerm(FindTerm(SetTermMarker(upterm, nil))));
          if frez = nil then
            writeln('Термин не найден')
          else if frez^.Pages^.Next^.Next = nil then //Удалить последнюю страницу нельзя
            writeln('Невозможно удалить единственную страницу')
          else
          begin
            writeln('Введите номер страницы: ');
            Readln(upterm);
            page := FindPage(frez^.Pages, SetPageMarker(StrToInt(upterm)), prev);
            if page = nil then
              writeln('Страница не найдена')
            else
            begin
              prev^.Next := page^.Next;
              writeln('Страница удалена');
            end;
          end;
        end;
    end;
    Writeln;
    writeln('Номер команды: ');
    Readln(instruction);
  end;
end.
