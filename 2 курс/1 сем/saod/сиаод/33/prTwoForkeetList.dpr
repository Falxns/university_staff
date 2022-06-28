program prTwoForkeetList;

{$APPTYPE CONSOLE}

uses
  SysUtils;

type
  cell=^info;
  info=record
    key:integer;
    next,prev:cell;
  end;

procedure addtolist(var list:cell;key:integer);
var
  p:cell;
begin
  if list=nil  then
    begin
      new(list);
      list^.next:=nil;
      list^.prev:=nil;
      list^.key:=key;
      exit;
    end;
  p:=list;
  while p^.next<>nil do
    p:=p^.next;
  new(p^.next);
  p^.next^.prev:=p;
  p:=p^.next;
  p^.next:=nil;
  p^.key:=key;
end;

procedure insertinsortlist(var list:cell;key:integer);
var
  p,e:cell;
begin
  if list=nil then
    begin
      new(list);
      list^.next:=nil;
      list^.prev:=NIL;
      list^.key:=key;
      exit;
    end;
  if list^.key>key then
    begin
      new(p);
      p^.key:=key;
      p^.prev:=nil;
      p^.next:=list;
      list^.prev:=p;
      list:=p;
      exit;
    end;
  p:=list;
  while (p^.next<>nil)and(p^.next^.key<key) do
    p:=p^.next;
  if p^.next=nil then
    begin
      new(p^.next);
      p^.next^.prev:=p;
      p:=p^.next;
      p^.key:=key;
      exit;
    end;
  new(e);
  e^.key:=key;
  e^.next:=p^.next;
  e^.prev:=p;
  p^.next:=e;
  e^.next^.prev:=e;
end;

procedure deletefromlist(var list:cell;key:integer);
var
  p:cell;
begin
  if list=nil then exit;
  if  list^.key=key then
    begin
      p:=list;
      list^.prev:=nil;
      list:=list^.next;
      dispose(p);
      exit;
    end;
  p:=list;
  while (p<>nil)and(p^.key<>key) do
    P:=P^.next;
  if p=nil then exit;
  if p^.next<>nil then
    p^.next^.prev:=p^.prev;
    p^.prev^.next:=p^.next;
  dispose(p);
end;

function findinlist(list:cell;key:integer):cell;
var
  p:cell;
begin
  result:=nil;
  if list=nil then exit;
  p:=list;
  while (p<>nil)and(p^.key<>key) do
    p:=p^.next;
  if p=nil then exit;
  result:=p;
end;

procedure deleteinsortlist(var list:cell;key:integer);
var
  p:cell;
begin
  if list=nil then exit;
  if  list^.key=key then
    begin
      p:=list;
      list^.prev:=nil;
      list:=list^.next;
      dispose(p);
      exit;
    end;
  p:=list;
  while (p<>nil)and(p^.key<key) do
    P:=P^.next;
  if (p=nil) or (p^.key<>key) then exit;
  if p^.next<>nil then
    p^.next^.prev:=p^.prev;
    p^.prev^.next:=p^.next;
  dispose(p);
end;

function findinsortlist(list:cell;key:integer):cell;
var
  p:cell;
begin
  result:=nil;
  if list=nil then exit;
  p:=list;                       
  while (p<>nil)and(p^.key<key) do
    p:=p^.next;
  if (p=nil)or(p^.key>key) then exit;
  result:=p;
end;

procedure printlist(list:cell);
begin
  while list<>nil do
    begin
      write(list^.key,' ');
      list:=list^.next;
    end;
  writeln;
end;

procedure printlistr(list:cell);
begin
  while list^.next<>nil do
    begin
      list:=list^.next;
    end;
    while list<>nil do
    begin
      write(list^.key,' ');
      list:=list^.prev;
    end;
  writeln;
end;

var
  list:cell;
  p:cell;
begin
   insertinsortlist(list,10);
   insertinsortlist(list,11);
   insertinsortlist(list,1);
   insertinsortlist(list,2);
   insertinsortlist(list,8);
   insertinsortlist(list,7);
   insertinsortlist(list,5);
   insertinsortlist(list,12);
   printlist(list);
   //printlist(list);
  if findinlist(list,12)<>nil then
  writeln(findinlist(list,12)^.key);
  readln;
end.
