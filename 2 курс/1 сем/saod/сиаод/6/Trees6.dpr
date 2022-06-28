program Trees6;

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
    head^.lTag:=true;
    head^.rTag:=true;
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


  { AddToTree(head,100,0);
  AddToTree(head,20,0);
  AddToTree(head,120,0);
  AddToTree(head,15,0);
  AddToTree(head,50,0);
  AddToTree(head,30,0);
  AddToTree(head,55,0);
  AddToTree(head,35,0);
  AddToTree(head,25,0);
   AddToTree(head,33,0);
   AddToTree(head,60,0);  }

  {AddToTree(head,7,0);
  AddToTree(head,4,0);
  AddToTree(head,3,0);
  AddToTree(head,5,0);
  AddToTree(head,9,0);
  AddToTree(head,8,0);
  AddToTree(head,11,0); }

  {AddToTree(head,9,0);
  AddToTree(head,5,0);
  AddToTree(head,10,0);
  AddToTree(head,7,0);
  AddToTree(head,6,0);
  AddToTree(head,8,0);}

  {AddToTree(head,8,0);
  AddToTree(head,3,0);
  AddToTree(head,10,0);
  AddToTree(head,1,0);
  AddToTree(head,6,0);
  AddToTree(head,4,0);
  AddToTree(head,7,0);
  AddToTree(head,14,0);
  AddToTree(head,13,0);}

  {AddToTree(head,3,0);
  AddToTree(head,1,0);
  AddToTree(head,2,0); }


end;


  procedure pram (var x: ttree);
  begin
    if x<>nil then
    begin
    writeln (x^.key);
    pram(x^.left);
    pram(x^.right);
  end;
  end;

procedure pram_print (var x: Ttree);
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
   // Writeln ('***');
    //if y<> nil then writeln (y^.key);
    //writeln (x^.key);

   // Writeln ('***');
    right_sew(x);
    pram_print(x^.left);
    if x^.rTag=True then pram_print(x^.right);
  end;
end;



 {while x^.left<>nil do x:=x^.left;
    begin
      write (x^.key,' ');
      while x^.rTag=false do begin
        x:=x^.right;
        if x=head then Exit;
        write (x^.key,' ');
        end;
        x:=x^.right;}

procedure obhod_proshiv (var x: Ttree);
var b, b1: boolean;
begin

  b1:=False;
  while x<>head do
  begin


    repeat
        b:=False;
      if b1=false then write (x^.key,' ');
      b1:=false;
      if x^.left<>nil then x:=x^.left else if (x^.right<>nil) and (x^.rTag=True) then x:=x^.right else b:=true;
    until  b;

    while x^.rTag=false do begin
        if x^.right<>nil then x:=x^.right else if x^.left<>nil then x:=x^.left else begin Exit; end;
        if x=head then Exit;
        write (x^.key,' ');
        b1:=true;

      end;
    end;
  end;

  procedure samyi_pravyi (var x: Ttree);
  var b: boolean;
  begin
    repeat
      b:=False;
      if (x^.right<>nil) and (x^.rTag<>False) then x:=x^.right else if (x^.left<>nil)then x:=x^.right else b:=true;
    until  b;

     //x:=x^.right^.right^.left;
     //x:=x^.left^.left;
    x^.right:=head;
    x^.rtag:=false;
   // Writeln (x^.key);
  end;



begin
  SetConsoleCP(1251);
  SetConsoleOutPutCP(1251);
  writeln('Введите дерево (закончите ввод нажатием "Enter"):');
  root:=nil;
  EnterTree(root);
  //pram(root);
  new (head);
  head^.left:=root;
  head^.right:=head;

  writeln('Прямой обход:');
  writeln;
  y:=nil;
  pram_print (root);
  z:=root;
  samyi_pravyi (z);
 // z:=root^.left^.right^.right^.right;

 // write (z^.right^.key);
  obhod_proshiv (head^.left);

  readln;
end.
