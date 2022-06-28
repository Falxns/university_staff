program Task22;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  EsConsole;

type
  TList=^TListItem;
  TListItem=record
    Next:TList;
    data:integer;
  end;

var
  Head:TList;
  k, comand:LongInt;

procedure InsertContact(Head:TList);
var
  Q, Current:TList;
begin
  New(Q);
  Write('Введите элемент: ');
  Readln(Q^.data);
  Current:=Head;
  while (Current^.Next<>nil) and (Current^.Next^.data<Q^.data) do
  begin
    Current:=Current^.Next;
  end;
  Q^.Next:=Current^.Next;
  Current^.Next:=Q;
end;

procedure Print(Head:TList);
var
  Current:TList;
begin
  Current:=Head;
  while Current^.Next<>nil do
  begin
    Current:=Current^.Next;
    Writeln(Current^.data,' ');
  end;
end;

begin
  New(Head);
  Head^.Next:=nil;
  Writeln('Выбирите операцию: Добавить элемент(1), Вывод списка(2), Выход(3).');
  k:=0;
  while k=0 do
  begin
    readln(comand);
    case comand of
      1: InsertContact(Head);
      3: k:=-1;
      2: Print(Head);
    end;
  end;
end.
