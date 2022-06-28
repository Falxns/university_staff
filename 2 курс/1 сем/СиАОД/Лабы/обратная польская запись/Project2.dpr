program Project2;
{$APPTYPE CONSOLE}

const
  operand: set of char = ['A'..'Z', 'a'..'z'];
  operation: set of char = ['+', '-', '*', '/', '^'];

type
  TPTstek = ^stek;

  stek = record
    data: Char;
    next: TPTstek;
  end;

procedure AddSteck(var st: TPTstek; value: Char);
var
  x: TPTstek;
begin
  new(x);
  x^.data := value;
  x^.next := st;
  st := x;
end;

function GetStek(var st: TPTstek): Char;
begin
  if st <> nil then
  begin
    GEtStek := st^.Data;
    st := st^.next;
  end
  else
    GetStek := #0;
end;

function stekPrior(letter: char): integer;
begin
  case letter of
    '+', '-':
      result := 2;
    '*', '/':
      result := 4;
    '^':
      result := 5;
    'A'..'Z', 'a'..'z':
      result := 8;
    '(':
      result := 0;
  else
    result := 20;
  end;
end;

function relativePrior(letter: Char): Integer;
begin
  case letter of
    '+', '-':
      result := 1;
    '*', '/':
      result := 3;
    '^':
      result := 6;
    'A'..'Z', 'a'..'z':
      result := 7;
    '(':
      result := 9;
    ')':
      result := 0;
  else
    result := 20;
  end;
end;

function Rang(str: string): Integer;
var
  i: Integer;
begin
  result := 0;

  for i := 1 to Length(str) do
  begin
    if STR[i] in operand then
      Inc(result);
    if STR[i] in operation then
      dec(result);
  end;
end;

var
  STRinput, STRoutput: string;
  stek1: TPTstek;
  i: Integer;
  temp: Char;

begin
  STRoutput := '';
  Readln(STRinput);
  Writeln('Rang = ', rang(STRinput));
  i := 1;
  while i <= Length(STRinput) do
  begin
    if (stek1 = nil) or ((relativePrior(strinput[i])) > (stekPrior(stek1^.data))) then
    begin
      if STRinput[i] <> ')' then
        AddSteck(stek1, STRinput[i]);
      Inc(i);
    end
    else
    begin
      temp := GetStek(stek1);
      if (temp <> '(') then
        STRoutput := STRoutput + temp
      else
        Inc(i);
    end;
  end;
  while not (stek1 = nil) do
  begin
    temp := GetStek(stek1);
    if (temp <> '(') and (temp <> ')') then
      STRoutput := STRoutput + temp;
  end;
  Writeln(stroutput);
  readln;
end.

