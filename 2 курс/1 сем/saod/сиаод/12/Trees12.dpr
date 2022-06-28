program Trees12;

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

var y,z: Ttree;
var
  head, root:Ttree;
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

  {AddToTree(head,7,0);
  AddToTree(head,4,0);
  AddToTree(head,3,0);
  AddToTree(head,5,0);
  AddToTree(head,9,0);
  AddToTree(head,8,0);
  AddToTree(head,11,0);}
end;

procedure sim_print (var x: Ttree);
procedure right_sew  (var p: ttree);
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
    sim_print(x^.left);
    right_sew(x);
    sim_print(x^.right);
  end;
end;

procedure obhod_proshiv (var x: Ttree);
begin
  while x<>head do
  begin
    while x^.left<>nil do x:=x^.left;
    begin
      write (x^.key,' ');
      while x^.rTag=false do begin
        x:=x^.right;
        if x=head then Exit;
        write (x^.key,' ');
        end;
        x:=x^.right;
      end;
    end;
  end;

  procedure samyi_pravyi (var x: Ttree);
  begin
    while x^.right<>nil do x:=x^.right;
    x^.right:=head;
    x^.rtag:=false;
  end;



begin
  SetConsoleCP(1251);
  SetConsoleOutPutCP(1251);
  writeln('¬ведите дерево (закончите ввод нажатием "Enter"):');
  root:=nil;
  EnterTree(root);

  new (head);
  head^.left:=root;
  head^.right:=head;
  writeln('—имметричный обход:');
  writeln;
  y:=nil;
  sim_print (root);
  z:=root;
  samyi_pravyi (z);
  obhod_proshiv (head^.left);
  readln;
end.
