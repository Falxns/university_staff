program Project1;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System, SysUtils, Windows;

{
  Задача

  Даны два списка. Отсортировать и распределить в них элементы таким образом, чтобы
  в первом остались только неотрицательные элементы, а во втором - только отрицательные.
  Затем списки вывести на экран.

   }

type
  TList = ^list;
    list = record
      data: integer;
      next: TList;
    end;

procedure sort(headFirst, headSecond: TList);
var
  PFirst, PSecond, temp: TList;
  tempdata: integer;
begin
  PFirst:= headFirst;
  PSecond:= headSecond;
  temp:= PFirst^.next;
  while PFirst^.next <> nil do
    begin
      while temp <> nil do
        begin
          if PFirst^.data < temp^.data then
            begin
              tempdata:= PFirst^.data;
              PFirst^.data:= temp^.data;
              temp^.data:= tempdata;
            end;
          temp:= temp^.next;
        end;
      PFirst:= PFirst^.next;
      temp:=PFirst^.next;
    end;
  temp:= PSecond^.next;
  while PSecond^.next <> nil do
    begin
      while temp <> nil do
        begin
          if PSecond^.data > temp^.data then
            begin
              tempdata:= PSecond^.data;
              PSecond^.data:= temp^.data;
              temp^.data:= tempdata;
            end;
          temp:= temp^.next;
        end;
      PSecond:= PSecond^.next;
      temp:=PSecond^.next;
    end;
end;

procedure output(headFirst, headSecond: TList);
var
  PFirst, PSecond: TList;
begin
  PFirst:= headFirst;
  PSecond:= headSecond;
  writeln('Первый список:');
  while PFirst <> nil do
    begin
      writeln(PFirst^.data);
      PFirst:= PFirst^.next;
    end;
  writeln('Второй список:');
  while PSecond <> nil do
    begin
      writeln(PSecond^.data);
      PSecond:= PSecond^.next
    end;
end;

procedure processing(var headFirst, headSecond: TList);
var
  PFirst, PSecond, temp, pred: TList;
begin
  PFirst:= headFirst;
  while PFirst <> nil do
    begin
      if PFirst^.data >= 0 then
        begin
          new(temp);
          temp^.next:= headSecond;
          headSecond:= temp;
          temp^.data:= PFirst^.data;
          if PFirst = headFirst then
            begin
              PFirst:= PFirst^.next;
              headFirst:= PFirst;
            end
          else
            if PFirst^.next = nil then
              begin
                pred^.next:= nil;
                break;
              end
            else
              begin
                pred^.next:= PFirst^.next;
                PFirst:= PFirst^.next;
              end;
        end
      else
        begin
          pred:= PFirst;
          PFirst:= PFirst^.next;
        end;
    end;
  PSecond:= headSecond;
  pred:= nil;
  while PSecond <> nil do
    begin
      if PSecond^.data < 0 then
        begin
          new(temp);
          temp^.next:= headFirst;
          headFirst:= temp;
          temp^.data:= PSecond^.data;
          if PSecond = headSecond then
            begin
              PSecond:= PSecond^.next;
              headSecond:= PSecond;
            end
          else
            if PSecond^.next = nil then
              begin
                pred^.next:= nil;
                break;
              end
            else
              begin
                pred^.next:= PSecond^.next;
                PSecond:= PSecond^.next;
              end;
        end
      else
        begin
          pred:= PSecond;
          PSecond:= PSecond^.next;
        end;
    end;
end;

procedure input(var headFirst, headSecond: TList);
var
  PFirst, PSecond: TList;
  inputInt: integer;
  number: byte;
begin
  number:= 1;
  writeln('Введите элементы первого списка. Для того, чтобы закончить, нажмите 0.');
  repeat
    readln(inputInt);
    if inputInt <> 0 then
      begin
        if number = 1 then
          begin
            new(PFirst);
            PFirst^.next:= nil;
            PFirst^.data:= inputInt;
            inc(number);
            headFirst:= PFirst;
          end
        else
          begin
            new(PFirst^.next);
            PFirst:= PFirst^.next;
            PFirst^.next:= nil;
            PFirst^.data:= inputInt;
          end;
      end;
  until inputInt = 0;
  number:= 1;
  writeln('Введите элементы второго списка. Для того, чтобы закончить, нажмите 0.');
  repeat
    readln(inputInt);
    if inputInt <> 0 then
      begin
        if number = 1 then
          begin
            new(PSecond);
            PSecond^.next:= nil;
            PSecond^.data:= inputInt;
            inc(number);
            headSecond:= PSecond;
          end
        else
          begin
            new(PSecond^.next);
            PSecond:= PSecond^.next;
            PSecond^.next:= nil;
            PSecond^.data:= inputInt;
          end;
      end;
  until inputInt = 0;
end;

procedure main;
var
  headFirst, headSecond: TList;
begin
  input(headFirst, headSecond);
  processing(headFirst,headSecond);
  sort(headFirst, headSecond);
  output(headFirst,headSecond);
end;

begin
  SetConsoleCP(1251);
  SetConsoleOutPutCP(1251);
  main;
  readln;
end.
