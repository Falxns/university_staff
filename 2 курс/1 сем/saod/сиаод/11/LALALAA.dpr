program LALALAA;

{$APPTYPE CONSOLE}

uses
  SysUtils;

Type
  EXO = ^O;
  O = record
       Data : integer;
       Next : EXO;
  end;

  List1=^TList1;
  TList1=record
    Data : integer;
    Next : List1;
  end;

  tmas = array[1..20] of integer;

Var
BeginO, EndO : EXO;
stack1,stack2 : List1;
a,b,c:tmas;
n1,n2,i,j:integer;

Procedure writeO(Var BeginO, EndO : EXO; c : integer);
Var
  u : EXO;
Begin
  new(u);
  u^.Data := c;
  //u^.Next := EndO;
  u^.Next:= EndO^.Next;
  EndO^.Next := u;
End;

Procedure readO(Var BeginO, EndO : EXO; Var c : integer);
Var
  u,temp : EXO;

Begin
  u:=EndO;
  while u^.Next^.Next<>beginO do u:=u^.Next;
  c:= u^.next^.data;
  temp:= u^.Next;
  u^.Next:=u^.Next^.Next;
  dispose(temp);
  {if BeginO=nil
    then
      writeln('Ochered pusta')
    else
      begin
        c := BeginO^.Data;
        u := BeginO;
        BeginO := BeginO^.Next;
        dispose(u);
      end;}
End;

procedure Pop (var s: List1; c: integer);
 var p: List1;
 begin
   if s = nil then begin
     writeln(' Stek pustoi'); exit;
   end;
   c:=s^.Data;
   p:=s; s:= s^.next; dispose(p);
 end;

procedure Push (var s: List1; c: integer);
 var p: List1;
 begin
   new(p);
   p^.Data:=c;
   p^.Next:=s;
   s:=p;
 end;
begin
  new(BeginO);
  new(EndO);
  new(stack1);
  new(stack2);
  BeginO:=nil;
  EndO^.Next:=BeginO;
  stack1:=nil;
  stack2:=nil;
  writeln('vvedite kol-vo elementov 1 steka');
  readln(n1);
  writeln('vvedite elementy 1 steka: ');
  for i:=1 to n1 do begin read(a[i]); push(stack1,a[i]); end;
  writeln;

  for i:=n1 downto 1 do begin pop(stack1,a[i]); end;
  writeln;
  for i:=1 to n1 do begin push(stack2,a[i]); end;
  for i:=n1 downto 1 do begin pop(stack2,a[i]); end;
  //for j:=n2 downto 1 do begin pop(stack2,b[i]); write(b[i],' '); end;

  for i:=1 to (n1) do writeO(BeginO,EndO,a[i]);
  //for j:=1 to n2 do readO(BeginO,EndO,b[i]);

  writeln('elementy ocheredi: ');
  for i:=1 to (n1) do begin readO(BeginO,EndO,c[i]); write(c[i],' '); end;
  readln;
  readln;
  readln;
end.
