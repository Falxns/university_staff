program simsew_;

{$APPTYPE CONSOLE}

uses
  Windows,
  SysUtils;

type
  ptr=^node;
  node=record
    data:integer;
    left,right:ptr;
    lTag,rTag:boolean;
  end;

var
  head, root:ptr; y,z: ptr; s: string;

Procedure Insert(var x:ptr; key:integer);
begin
  if  x=nil  then
  begin
    new(x);
    x^.data:=key;
    x^.left:=nil;
    x^.right:=nil;
    x^.lTag:=false;
    x^.rTag:=false;
  end;
  if x^.data<key then
    Insert(x^.right,key);
  if x^.data>key then
    Insert(x^.left,key);
end;

Procedure EnterTree(var head:ptr);
var
  c,key:integer;
  s:string;
begin
  readln(s);
  while s<>'' do
    begin
      Insert(head,StrToInt(s));
      readln(s);
    end;
end;

procedure SimSew (var x: ptr);
procedure right_sew  (var p: ptr);
begin
  if y <> nil then
  begin
    if y^.right=nil then
    begin
    y^.rtag:=False;
    y^.right:=p;
  end
  else y^.rtag:=true;
  end;
  y:=p;
end;
begin
  if x<>nil then
  begin
    SimSew(x^.left);
    right_sew(x);
    SimSew(x^.right);
  end;
end;

procedure Print (var x: ptr);
begin
  while x<>head do
  begin
    s:=s+IntToStr(x^.data)+' ';
    while x^.left<>nil do
    begin
      x:=x^.left;
      s:=s+IntToStr(x^.data)+' ';
    end;
    begin
      s:=s+'('+IntToStr(x^.data)+')'+' ';
      while x^.rTag=false do begin
        x:=x^.right;
        s:=s+'-';
        if x=head then begin s:=s+'head'; exit; end;
        s:=s+'('+IntToStr(x^.data)+')'+' ';
        end;
        x:=x^.right;
      end;
    end;
  end;

procedure SimPrintNotSew (var x: ptr);
begin
  if x<>nil then
  begin
    SimPrintNotSew(x^.left);
    write(x^.data:4);
    SimPrintNotSew(x^.right);
  end;
end;

procedure FinalSew (var x: ptr);
begin
  while x^.right<>nil do x:=x^.right;
  x^.right:=head;
  x^.rtag:=false;
end;

begin
  SetConsoleCP(1251);
  SetConsoleOutPutCP(1251);
  writeln('Введите элементы дерева');
  root:=nil;
  EnterTree(root);
  s:='';
  writeln('Обход непрошитого дерева');
  SimPrintNotSew(root);
  new (head);
  head^.left:=root;
  head^.right:=head;
  y:=nil;
  SimSew (root);
  z:=root;
  FinalSew (z);
  writeln;
  writeln;
  writeln('Обход прошитого дерева');
  Print (head^.left);
  writeln;
  writeln(s);
  readln;
end.



