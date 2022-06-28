program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

type
  ptr = ^queue;

  queue = record
    next: ptr;
    number: integer;
  end;
var
  head, rear, tail: ptr;
  n, i, num: integer;

procedure addElem(var x: ptr; y: integer);
begin
  new(x^.next);
  x := x^.next;
  x^.number := y;
  x^.next := nil;
  rear := x;
end;

procedure sort1(x: ptr);
var
  temp: integer;
  vspom: ptr;
begin
  New(vspom);
  while x <> nil do
  begin
    vspom := x^.next;
    while vspom <> nil do
    begin
      if vspom^.number > x^.number then
      begin
        temp := x^.number;
        x^.number := vspom^.number;
        vspom^.number := temp;
      end;
    vspom := vspom^.Next;
    end;
    x := x^.Next
  end;
end;

begin
  new(head);
  head^.next := nil;
  writeln('Enter a number of elements:');
  readln(n);
  writeln('Enter an elements:');
  tail := head;
  rear := tail;
  for i := 1 to n do
  begin
    readln(num);
    addElem(tail,num);
    rear := tail;
  end;
  tail := head^.next;
  sort1(tail);
  tail := head^.next;
  writeln('Queue:');
  for i := 1 to n do
  begin
    write(tail^.number, ' ');
    tail := tail^.next;
  end;
  writeln;
  writeln('Enter an element to add:');
  tail := rear;
  readln(num);
  addElem(tail,num);
  rear := tail;
  tail := head^.next;
  sort1(tail);
  writeln('Queue:');
  tail := head^.next;
  while tail <> nil do
  begin
    write(tail^.number, ' ');
    tail := tail^.next;
  end;
  readln;
end.
