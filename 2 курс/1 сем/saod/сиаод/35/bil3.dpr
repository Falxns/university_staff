//Решение задачи, числа считываются из файла derevo.in

Program bil3;

{$APPTYPE CONSOLE}

uses
  SysUtils;

const t=7;

Type pt = ^node;
node = record 
data : integer; {Информационное поле}
left, right : pt; {Указатели на левое и правое поддеревья}
end;

TMAS = array [1..t] of integer;

Var root:pt; {Указатель на корень дерева}
a , b: TMAS;
i, k: integer;

procedure fill (var A:Tmas; n:integer);
var i:integer;
f1:textfile;
begin
assignfile(f1,'derevo.txt');
reset(f1);
for i:=1 to t do
read(f1,a[i]);
closefile(f1);
end;

Procedure Insert(var x : pt; y:integer);{х - указатель на корень дерева, у - }
Begin { вставляемая вершина}
if x=nil then
Begin
new(x);
x^.data:=y;
x^.left:=nil;
x^.right:=nil;
End
else if y<= x^.data then insert (x^.left,y)
else insert (x^.right,y);
End;

procedure printtree(temp:pt; h:integer);
var
i:integer;
begin
if temp<>nil
then
with temp^ do
begin
printtree(right,h+4);
for i:=1 to h do
write(' ');
writeln(data:30);
printtree(left,h+4)
end;
end;

Procedure prym_print(var x:pt);
Begin
if x<> nil then
Begin
b[k]:=x^.data;
inc(k);
if x^.left<>nil then
prym_print(x^.left);
if x^.right<>nil then
prym_print(x^.right);
End;
End;

procedure direct_choice(var a:TMAS; n:integer);
var i,min,k,x: integer;
begin
for k:=1 to (n-1) do
begin
min:=k;
for i:=k+1 to n do
begin
if A[i]<A[min] then min:=i;
end;
x:=A[min];
A[min]:=A[k];
A[k]:=x;
end;
end;

Begin
fill(a,t);
for i:=1 to t do
insert(root,a[i]);
printtree(root,t);
writeln;
k:=1;
writeln('pryamoy obhod:');
prym_print(root);

for i:=1 to t do
write(b[i],' ');
writeln;

direct_choice(b,t);
writeln;
writeln('sim obhod:');

for i:=1 to t do
write(b[i],' ');
writeln;

readln
End.
