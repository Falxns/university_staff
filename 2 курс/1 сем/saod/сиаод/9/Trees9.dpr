program Trees9;

{$APPTYPE CONSOLE}

uses
  Windows,
  SysUtils;

type
  Ttree=^rTree;
  rTree=record
    key:integer;
    left,right:Ttree;
    lTag,rTag:boolean;
    level:integer;
  end;

Procedure AddToTree(var head:Ttree; key,level:integer);
begin
  if  head=nil  then
  begin
    new(head);
    head^.key:=key;
    head^.left:=nil;
    head^.right:=nil;
    head^.lTag:=false;
    head^.rTag:=false;
    head^.level:=level;
  end;
  if head^.key<key then
    AddToTree(head^.right,key,level+1);
  if head^.key>key then
    AddToTree(head^.left,key,level+1);
end;

Procedure SymmetricBypassChange(head:Ttree);

Procedure SwapKeys(var a, b: Integer);
var
  temp: integer;
begin
  temp:= a;
  a:=b;
  b:=temp;
end;

begin
  if head<>nil then
  begin
    SymmetricBypassChange(head^.left);
    if (head^.left <> nil) and (head^.right <> nil) then
      SwapKeys(head^.right^.key, head^.left^.key);
    SymmetricBypassChange(head^.right);
  end;
end;

Procedure SymmetricBypass(head:Ttree);
begin
  if head<>nil then
  begin
    SymmetricBypass(head^.left);
    write(head^.key,' ');
    SymmetricBypass(head^.right);
  end;
end;

Procedure EnterTree(var head:Ttree);
var
  c,key:integer;
  s:string;
begin
  readln(s);
  val(s,key,c);
  while c=0 do
    begin
      AddToTree(head,key,0);
      readln(s);
      val(s,key,c);
    end;
end;

var
  head:Ttree;
begin
  SetConsoleCP(1251);
  SetConsoleOutPutCP(1251);
  writeln('Введите дерево (закончите ввод нажатием "Enter"):');
  head:=nil;
  EnterTree(head);
  writeln('Исходное дерево:');
  SymmetricByPass(head);
  writeln;
  writeln('Новое дерево:');
  SymmetricByPassChange(head);
  SymmetricByPass(head);
  writeln;
  readln;
end.
