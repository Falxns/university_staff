{
1. ¬водим количество элементов списка;
2. ¬водим элементы списка, тем самым создава€ двунаправленный список номеров телефонов;
3. ¬ыводим этот список, ид€ по нему справа налево;
4. —оздаем новый однонаправленный список, добавл€ем в него номера абонентов из
двунаправленного списка, перебира€ значени€ справа налево;
5. —ортируем однонаправленный список;
6. ¬ыводим однонаправленный список.
}
program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

type
  pt=^elem;
  elem = record
            Data: Integer;
            Prev: pt;
            Next: pt;
  end;
  pt1 = ^elem1;
  elem1 = record
             Data: integer;
             Next: pt1;
  end;

procedure make(var x : pt; m: integer);
var
  y: pt;
  i: integer;
begin
  New(x);
  x^.Prev := nil;
  for i := 1 to m do
  begin
    y := x;
    Readln(y^.Data);
    if i <> m then
    begin
      New(x);
      y^.Next := x;
      x^.Prev := y;
    end
    else
      y^.Next := nil;
  end;
end;

procedure print(x: pt);
begin
  while x <> nil do
  begin
    Write(x^.Data, ' ');
    x := x^.Prev;
  end;
  Writeln;
end;

procedure make1(x: pt; var y: pt1);
var
  F: pt1;
begin
  New(y);
  F := y;
  while x <> nil do
  begin
    if x^.Data > 999 then
    begin
      New(y^.Next);
      y := y^.Next;
      y^.Data := x^.Data;
    end;
    x := x^.Prev;
  end;
  y^.Next := nil;
  y := F;
  y := y^.Next;
end;

procedure sort(x: pt1);
var
  temp: integer;
  vspom: pt1;
begin
  New(vspom);
  while x <> nil do
  begin
    vspom := x^.next;
    while vspom <> nil do
    begin
      if vspom^.Data < x^.Data then
      begin
        temp := x^.Data;
        x^.Data := vspom^.Data;
        vspom^.Data := temp;
      end;
    vspom := vspom^.Next;
    end;
    x := x^.Next
  end;
end;

procedure print1(x: pt1);
begin
  While x <> nil do
  begin
    Write(x^.Data, ' ');
    x := x^.Next;
  end;
end;

var
  first: pt;
  second : pt1;
  m: integer;
begin
  Writeln('Enter a number of elements:');
  readln(m);
  Writeln('Enter an elements:');
  make(first, m);
  Writeln;
  Writeln('The first list:');
  print(first);
  Writeln;
  Writeln('The second list:');
  make1(first, second);
  sort(second);
  print1(second);
  readln;
end.


