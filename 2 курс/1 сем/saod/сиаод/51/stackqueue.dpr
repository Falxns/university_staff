program stackqueue;

{$APPTYPE CONSOLE}

uses
  SysUtils;
type
  Tqueue=^rqueue;
  rqueue=record
    key:integer;
    next:tqueue;
  end;
  Tstack=^rstack;
  rstack=record
    key:integer;
    next:tstack;
  end;

var
  top:tstack;
  head,tail:tqueue;

procedure push (var top:tstack; key:integer);
var
  p:tstack;
begin
  if top=nil then
    begin
      new(top);
      top^.key:=key;
      top^.next:=nil;
      exit;
    end;
  new(p);
  p^.next:=top;
  p^.key:=key;
  top:=p;
end;

function pop (var top:tstack):integer;
var
  p:tstack;
begin
  if top=nil then exit;
  p:=top;
  top:=top^.next;
  result:=p^.key;
  dispose(p);
end;

procedure PrintStack (top:tstack);
begin
  while top<>nil do
    begin
      write(top^.key,' ');
      top:=top^.Next;
    end;
  writeln;
end;

procedure PrintQueue (head:tqueue);
begin
  while head<>nil do
    begin
      write(head^.key,' ');
      head:=head^.Next;
    end;
  writeln;
end;

procedure AddToQueue(var head,tail:tqueue; key:integer);
begin
  if head=nil then
    begin
      new(head);
      tail:=head;
      head^.key:=key;
      head^.next:=nil;
      exit;
    end;
  new(tail^.next);
  tail:=tail^.next;
  tail^.key:=key;
end;

function DeleteFromQueue(var head,tail:tqueue):integer;
var
  p:tqueue;
begin
  if head=nil then exit;
  result:=head^.key;
  p:=head;
  head:=head^.next;
  if p=tail then
    tail:=nil;
  dispose(p);
end;

begin
  top:=nil;
  head:=nil;
  tail:=nil;

  AddToQueue(head,tail,7);
  AddToQueue(head,tail,8);
  AddToQueue(head,tail,4);
  AddToQueue(head,tail,3);
  AddToQueue(head,tail,1);
  AddToQueue(head,tail,9);
  printQueue(head);

  writeln(DeleteFromQueue(head,tail));
  printQueue(head);
    writeln(DeleteFromQueue(head,tail));
  printQueue(head);
    writeln(DeleteFromQueue(head,tail));
  printQueue(head);
  writeln(DeleteFromQueue(head,tail));
  printQueue(head);
    writeln(DeleteFromQueue(head,tail));
  printQueue(head);
    writeln(DeleteFromQueue(head,tail));
  printQueue(head);
  if  head<>nil then
    writeln(DeleteFromQueue(head,tail));
  printQueue(head);
  readln;
end.
