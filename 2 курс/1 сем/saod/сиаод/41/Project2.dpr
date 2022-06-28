program Project2;

{$APPTYPE CONSOLE}

uses
SysUtils;

Type pt=^node;
node=record
data:integer; {Информационное поле}
left,right:pt; {Указатели на левого и правого потомков}
end;

Mas=array[1..100] of integer;
var y,i,n,sum1,sum2 :integer;
x: pt;
A: Mas;
str: string;

Procedure Insert(var x : pt; y:integer);{х - указатель на корень дерева, у - вставляемая вершина}
Begin
if x=nil then
Begin
new(x);
x^.data:=a[i];
x^.left:=nil;
x^.right:=nil;

write(str);
write (a[i]);
End
else if y<= x^.data then
begin
delete(str,1,4); insert (x^.left,y);
end
else
begin
str:=str+' ';insert(x^.right,y);
end;

End;

Procedure prym_print(var x:pt;var sum:integer);
Begin
if x<> nil then
Begin
write ('(',x^.data,') ');
prym_print(x^.left,sum);
sum:=sum+x^.data;

prym_print(x^.right,sum);

End
else write ('');
End;



begin
x:= nil;
writeln ('vvedite kolichestvo elementov');
read (n);
writeln ('vvedite sami elementy');
for i:=1 to n do
read (A[i]);
write (str);
for i:=1 to n do begin
str:=(' ');
writeln (''); insert (x,a[i]); end; writeln('');
writeln ('pryamoj obhod dereva: ');
sum1:=0;
prym_print (x,sum1);

sum2:=0;
prym_print(x^.right,sum2);
writeln;
writeln(sum2);
readln;
readln;
end.

