program task23;

{$APPTYPE CONSOLE}

uses
  SysUtils;

const
  N=5;

type
  spis = ^elem;
  elem = record
    data : Integer;
    next : spis
  end;

var
  i,j,x : integer;
  A : array[1..N,1..N] of Integer;
  d : array[1..20] of Integer;
  s : string;
  B : spis;

procedure Insert(var B : spis; k:integer);
var
  temp1,temp2:spis;
begin
  temp1:=B;
  New(temp2);
  temp2^.data:=k;
  while (temp1^.next<>nil) and (temp1^.next^.data>k) do
    temp1:=temp1^.next;
  temp2^.next:=temp1^.next;
  temp1^.next:=temp2;
end;

begin
  s:='';
  for i:=1 to N do
    for j:=1 to N do
      read(a[i,j]);
  Writeln('Vvedite vershiny poiska : ');
  readln(x);
  j:=1;
  for i:=1 to N do
  begin
    if a[x,i]<>0 then
    begin
      if Pos(IntToStr(i),s)=0 then s:=s+' '+IntToStr(i);
      d[j]:=a[x,i];
      Inc(j);
    end;
    if a[i,x]<>0 then
    begin
      if Pos(IntToStr(i),s)=0 then s:=s+' '+IntToStr(i);
      d[j]:=a[i,x];
      Inc(j);
    end;
  end;
  Dec(j);
  New(B);
  for i:=1 to j do
    Insert(B,d[i]);
  Writeln('Vertex : ',x,' smegna s vershinami : ');
  Writeln(s);
  B:=B^.next;
  while B<>nil do
  begin
    write(B^.data,' ');
    B:=B^.next;
  end;
  readln;
end.

