program Project6;

{$APPTYPE CONSOLE}

type
    TArr = array [2..8] of Int64;

function FindNumber(i: Byte): Int64;
var
    Number, Prev, Step: Int64;
    Digit: Byte;
begin
    Prev := 0;
    Digit := i;
    Number := i;
    Step := 1;
    repeat
        Step := Step * 10;
        Number := Number + Step * (Digit * 2 mod 10 + Prev);
        Prev := Digit * 2 div 10;
        Digit := Number div Step;
    until (Digit = i) and (Prev = 0);
    Number := Number - Digit * Step;
    FindNumber := Number;
end;

function GetArray(): TArr;
var
    i: Byte;
    MyArr: TArr;
begin
    Writeln('This program searches for the smallest number, which, when you rearrange the last digit to the first one, is twice as large as the original');
    Writeln('This is the list of required numbers :');
    for i := 2 to 8 do
    begin
        MyArr[i] := FindNumber(i);
        Writeln(i,' : ',MyArr[i]);
        GetArray[i] := MyArr[i];
    end;
end;

procedure ShowAnswer(BuferArray: TArr);
var
    Min: Int64;
    i: Byte;
begin
    Min := BuferArray[8];
    for i := 2 to 8 do
        if BuferArray[i] < Min then
            Min := BuferArray[i];
    Writeln('Minimum required number is : ', Min);
    Readln;
end;

procedure Main();
var
    NumArr: TArr;
begin
    NumArr := GetArray();
    ShowAnswer(NumArr);
end;

begin
    Main;
end.
