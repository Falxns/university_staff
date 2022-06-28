program Project2;

{$APPTYPE CONSOLE}
uses
  SysUtils;

type Ttree=^TSP;
TSP=record
key:integer;
left, right:ttree;
end;

var tree:ttree; kol,n:integer; elem,i:integer; first:pointer;

procedure insert(var x:TTree; y:integer);
begin
if x=nil then
begin
new(x);
x^.key:=y;
x^.left:=nil;
x^.right:=nil;
end
else
if y<=x^.key then insert(x^.left, y)
else insert(x^.right, y);
end;

procedure obhod(x:ttree; level:integer);
begin
if x<>nil then
begin
if level=n then inc(kol);
obhod(x^.left, level+1);
obhod(x^.right, level+1);
end;
end;

begin
writeln('vvedite kol');
readln(n);
new(tree);
first:=tree;
writeln('write xhiclo');
readln(tree^.key);
tree^.left:=nil;
tree^.right:=nil;
for i:=1 to n-1 do
begin
writeln('vvedir chidlo');
readln(elem);
tree:=first;
insert(tree, elem);
end;
writeln('write level');
readln(n);
kol:=0;
obhod(tree, 1);
writeln(kol);
readln;
end.

 