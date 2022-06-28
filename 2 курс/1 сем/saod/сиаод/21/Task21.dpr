program Task21;

{$APPTYPE CONSOLE}

uses
  SysUtils;

type
  pnt = ^link;
  link = packed record
  data: char;
  next: pnt;
  prev: pnt;
end;

  Chars = set of char;

var
  head: pnt;


procedure SortVst(var head:pnt);
var p,p1,mp:pnt;
begin
   p1 := head^.next;
   head^.next := nil;
   while p1 <> nil do begin

      p := p1; mp := p;
      while p <> nil do begin

          if p^.data > mp^.data then mp := p;
         p := p^.next;
      end;
      if mp = p1
      then p1 := mp^.next
      else begin
         mp^.prev^.next := mp^.next;
         if mp^.next <> nil
         then mp^.next^.prev := mp^.prev
      end;
      mp^.prev := head;
      mp^.next := head^.next;
      if head^.next <> nil then head^.next^.prev := mp;
      head^.next := mp;
   end;


end;

procedure add (el: char);
var
  x: pnt;
begin
  x:=head;
  while x^.next<>nil do x:=x^.next;
  New(x^.next);
  x^.next^.data:=el;
  x^.next^.next:=nil;
  x^.next^.prev:=x;
end;

procedure Initialize;
var
  n, i: Integer;
  letter: char;
begin
  New (head);
  Writeln ('Enter the number of elements:');
  readln (n);
  for i:=1 to n do
  begin
    Writeln (i, ' link:');
    readln (letter);
    add (letter);
  end;
end;

function duplic (letter: char): Integer;
var
  x: pnt;
begin
  Result:=0;
  x:=head^.next;
  while x<>nil do
  begin
    if x^.data=letter then Inc (Result);
    x:=x^.next;
  end;
end;

procedure prints (x: pnt);
var
  elm: chars;
begin
  elm:=[];
  while x<>nil do
  begin
    if not (x^.data in elm) then
    begin

    elm:=elm+[x^.data];
    write (x^.data,': ');
    Writeln (duplic(x^.data));

  end;
   x:=x^.next;
end;
end;

begin
  Initialize;
  SortVst(head);
  Writeln ('Elements:');
  prints(head^.next);
  Readln
end.

