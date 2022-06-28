program All_Sheet_For_List;

{$APPTYPE CONSOLE}

uses
  SysUtils;

type
  cell=^data;
  data=record
    key:integer;
    next:cell;
  end;
var
  list:cell;
  info:integer;
  numb:byte;

procedure SortInsertToList(key:integer;var list:cell);
var
  p,e:cell;
begin
  if  list=nil  then
    begin
      new(list);
      list^.key:=key;
      list^.next:=nil;
      exit;
    end;
  if  key<list^.key then
    begin
      new(p);
      p^.key:=key;
      p^.next:=list;
      list:=p;
      exit;
    end;
  p:=list;
  while (p^.next<>nil) and(p^.next^.key <= key) do
    p:=p^.next;
  if  p^.next=nil then
    begin
      new(p^.Next);
      p:=p^.next;
      p^.key:=key;
      p^.next:=nil;
      exit;
    end;
  new(e);
  e^.key:=key;
  e^.next:=p^.next;
  p^.next:=e;
end;

procedure AddToList(key:integer;var list:cell);
var
  p:cell;
begin
  if  list=nil  then
    begin
      new(list);
      list^.key:=key;
      list^.next:=nil;
    end
  else
    begin
      p:=list;
      while p^.next<>nil do
        p:=p^.next;
      new(p^.Next);
      p:=p^.next;
      p^.key:=key;
      p^.next:=nil;
    end;
end;

procedure DeleteFromList(key:integer;var list:cell);
var
  p,e:cell;
begin
  if  list=nil  then exit;
  p:=list;
  if  p^.key=key   then
    begin
      list:=list^.next;
      dispose(p);
      exit;
    end;

  while (p^.next<>nil) and (p^.next^.key<>key) do
    p:=p^.next;
  if  p^.next=nil then exit;
  e:=p^.next;
  p^.next:=e^.next;
  dispose(e);
end;

function FindInList(key:integer; list:cell):cell;
var
  p:cell;
begin
  result:=nil;
  if  list=nil  then exit;
  p:=list;
  if  p^.key=key   then
    begin
      result:=list;
      exit;
    end;

  while (p^.next<>nil) and (p^.next^.key<>key) do
    p:=p^.next;
  if  p^.next=nil then exit;
    result:=p^.next;
end;

function FindInSortList(key:integer; list:cell):cell;
var
  p:cell;
begin
  result:=nil;
  if  list=nil  then exit;
  p:=list;
  if  p^.key=key   then
    begin
      result:=list;
      exit;
    end;

  while (p^.next<>nil) and (p^.next^.key<key) do
    p:=p^.next;

  if  p^.next=nil then exit;
  if  p^.next^.key=key  then
    result:=p^.next;

end;

procedure PrintList(list:cell);
var
  p:cell;
begin
  p:=list;
  while p<>nil  do
    begin
      write(p^.key,' ');
      p:=p^.next;
    end;
  writeln;
end;

begin
   list:=nil;
   AddToList(1,list);
   AddToList(7,list);
   AddToList(3,list);
   AddToList(4,list);
   AddToList(9,list);
   AddToList(11,list);
   SortInsertToList(11,list);
   SortInsertToList(7,list);
   SortInsertToList(3,list);
   SortInsertToList(4,list);
   SortInsertToList(9,list);
   SortInsertToList(1,list);
   SortInsertToList(0,list);
   printList(list);


   DeleteFromList(8,list);
   DeleteFromList(9,list);
   DeleteFromList(11,list);
   DeleteFromList(0,list);
   DeleteFromList(4,list);
   DeleteFromList(7,list);
   DeleteFromList(1,list);
   DeleteFromList(3,list);
   if  FindInSortList(0,list)<>nil then
   writeln(FindInSortList(0,list)^.key);
   printList(list);
   readln;
end.
 