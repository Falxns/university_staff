program Preobraz;

{$APPTYPE CONSOLE}

uses
  SysUtils;

Type pt=^node;
     node=record
         data:integer; {»нформационное поле}
         left,right:pt; {”казатели на левого и правого потомков}
         end;
 var    m:array[1..8]of integer;
  root  :pt; {”казатель на корень дерева}
      z,i,j,k:integer;
Procedure Insert(var x : pt;  y:integer);//х - указатель на корень дерева, у -
         Begin                             //             вставл€ема€ вершина}
         if x=nil then
             Begin
                 new(x);
                 x^.data:=y;
                 x^.left:=nil;
                 x^.right:=nil;
            End
         else if y<= x^.data then insert (x^.left,y)
                else  insert (x^.right,y);
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
      if  x<> nil then
        Begin
          write (x^.data);
          M[i]:=x^.data;
          inc(i);
          write('  ');
          prym_print(x^.left);

         prym_print(x^.right);
     End;
   End;






   procedure preobrizpriamvsim();
   begin


   end;

   Procedure sim_print(var x:pt);
   Begin
      if  x<> nil then
        Begin
        sim_print(x^.left);
        write (x^.data);
        write('  ');
        sim_print(x^.right);
      End;
   end;



begin
for i:=1 to 7 do
begin
writeln('vvedite el');
readln(z);
insert(root,z);
end;
printtree(root,7);
i:=1;
writeln('priam_obh');
prym_print(root);
writeln;

for i := 1 to 8 do
        for j := 1 to 8-i do
            if M[j] > M[j+1] then begin
                k := M[j];
                M[j] := M[j+1];
                M[j+1] := k
            end;

    write ('sim_obhod:');
    for i := 2 to 8 do
        write (M[i]:4);


writeln;
writeln('proverka:');
sim_print(root);

readln

end.

