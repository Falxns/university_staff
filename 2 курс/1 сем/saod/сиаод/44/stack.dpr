program stack;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Windows;

type
  TStack=^Steck;

  Steck=record
    Element:Char;
    Next:TStack;
  end;




Procedure AddToStack (var st:TStack;value:Char);
var
  x :TStack;
begin
  new(x);
  x^.Element:=value;
  x^.next:=st;
  st:=x;
end;


function GetFromStek(var st:TStack):Char;
begin
  if st<> nil then
  begin
    GetFromStek:=st^.Element;
    st := st^.next;
  end
  else
    GetfromStek:=#0;
end;


function StackPriority (c:Char):Integer;
begin
  case c of
    '+','-' : Result := 2;
    '*','/' : Result := 4;
    '^' : Result := 5;
    'a'..'z','A'..'Z' : Result := 8;
    '(' : Result := 0;
  else
      Result := 10;
  end;
end;


function RelativPriority (c:Char):Integer;
begin
  case c of
    '+','-' : Result := 1;
    '*','/' : Result := 3;
    '^' : Result := 6;
    'a'..'z','A'..'Z' : Result := 7;
    '(' : Result := 9;
    ')' : Result := 0;
  else
    Result := 10;
  end;
end;


function CharRang(c:Char):integer;
begin
  if c in ['a'..'z','A'..'Z'] then
    Result:=1
  else
    Result:=-1;
end;

var
  st:TStack;
  input,output:string;
  Rang,i:Integer;
  t:Char;
begin
  st:=nil;
  Rang:=0;
  output:='';

  Write('Инфиксная форма: ');
  Readln(input);

  i:=1;
  while i<=Length(input) do

    if  (st=nil) or (RelativPriority(Input[i]) > StackPriority(st^.Element)) then
    begin
      if Input[i] <> ')' then
        AddToStack(st,input[i]);
      i:=i+1;
    end
    else
    begin
      t:=GetfromStek(st);
      if t <> '(' then
      begin
        output:=output+t;
        Rang := Rang + CharRang(t);
      end;

    end;


  while not (st = nil) do
  begin
    t:=GetfromStek(st);
    if t <> '(' then
      output:=output+t;
  end;

  Write('Постфиксная форма: ');
  Writeln(output);
  Write('Ранг выражения: ');
  Writeln(Rang);
  Readln;
end.
