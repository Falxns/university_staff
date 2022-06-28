{
1.������ �������� N;
2.������� ������ �� N �����;
3.������ k(������� k-��� ������� ����� �������);
4.������� ����� ������� �������� ����� �������;
5.������� ����� �������;
6.��������� 4 � 5 ���� �� ��������� ���� �������;
7.������� ����� ���������� ����������� �������;
8.������� ������ ��������� ���������� ����� ��� N = 1..64 � k,���������� �����.
}

program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

type
  pt = ^elem;
  elem = record
    data: integer;
    next: pt;
    prev: pt;
  end;

procedure make(var x : pt; m: integer);
var
  y, f, l: pt;
  i, num: integer;
begin
  num := 1;
  new(x);
  f := x;
  for i := 1 to m do
  begin
    y := x;
    y^.Data := num;
    if i <> m then
    begin
      new(x);
      y^.Next := x;
      x^.Prev := y;
    end
    else
    begin
      y^.Next := f;
      x := f;
      l := y;
      x^.prev := l;
    end;
    inc(num);
  end;
end;

procedure print(x: pt);
begin
  while x <> nil do
  begin
    Write(x^.data, ' ');
    x := x^.next;
  end;
end;

procedure printElem(var x: pt);
begin
  write(x^.data,' ');
end;

procedure deleteElem(var x:pt);
begin
  x^.prev^.next := x^.next;
  x^.next^.prev := x^.prev;
end;

procedure poryadok(var x: pt; b: integer);
var
  count: integer;
begin
  count :=0;
  repeat
    inc(count);
    if (count) mod b = 0  then
    begin
      printElem(x);
      deleteElem(x);
    end;
    x := x^.next;
  until x^.next^.data = x^.data;
end;

procedure lastChild(x: pt; a, b: integer);
var
  count: integer;
begin
  count :=0;
  repeat
    inc(count);
    if (count) mod b = 0  then
    begin
      deleteElem(x);
    end;
    x := x^.next;
  until x^.next^.data = x^.data;
  writeln('| ', a:2, ' | ', x^.data:2, ' | ', b:2, ' |', #13#10, '----------------');
end;

var
  N, k: integer;
  N1: 1..64;
  list, list1: pt;
begin
  writeln('Enter a number of childs:');
  readln(N);
  make(list, N);
  writeln('Enter k:');
  readln(k);
  poryadok(list, k);
  writeln;
  writeln('Last child:');
  writeln(list^.data);
  writeln;
  writeln('----------------', #13#10, '|  N |  t |  k |', #13#10, '----------------' );
  for N1 := 1 to 64 do
  begin
    make(list1, N1);
    lastChild(list1, N1, k);
  end;
  readln;
end.
