program Project11;

{$APPTYPE CONSOLE}

uses
    SysUtils;

type
    TArr = array[1..100] of Integer;
    TArrCount = array[1..100] of Byte;

const
    MinNumber = 1;
    MaxNumber = 100;

procedure OutputConsole(Number: Byte; MyArray: TArr);
var
    i: Byte;
begin
    for i := 1 to Number do
        Write(MyArray[i],' ');
    Writeln;
end;

procedure ChangeArray(Number: Byte; var MyArray: TArr);
var
    i, j: Byte;
    ArrayofCounters: TArrCount;
    NewArray: TArr;
begin
    for i := 1 to Number do
        ArrayofCounters[i] := 1;
    for i := 1 to Number - 1 do
        for j := i + 1 to Number do
            if MyArray[i] < MyArray[j] then
                inc(ArrayofCounters[j])
            else
                inc(ArrayofCounters[i]);
    NewArray := MyArray;
    for i := 1 to Number do
    begin
         j := ArrayofCounters[i];
         NewArray[j] := MyArray[i];
         Writeln('Step [', i, ']');
         OutputConsole(Number, NewArray);
    end;
    MyArray := NewArray;
end;

function ChoiceInput(): Char;
var
    Input: Char;
    IsCorrect: Boolean;
begin
    repeat
        Readln(Input);
        Input := UpCase(Input);
        if (Input = 'Y')or(Input = 'N') then
            IsCorrect := true
        else
        begin
            IsCorrect := false;
            Write('Incorrect input. Enter Y(Yes) or N(No): ');
        end;
    until IsCorrect;
    ChoiceInput := Input;
end;

procedure ShowAnswerFile(var NewFile: TextFile; Number: Byte; MyArray: TArr);
var
    i: Byte;
begin
    Writeln(NewFile, 'Sorted Array is:');
    for i := 1 to Number do
        Write(NewFile, MyArray[i],' ');
end;

procedure OutputFile(Number: Byte; MyArray: TArr);
var
    IsCorrect: Boolean;
    NewFile: TextFile;
    NameOfFile: String;
begin
    Write('Enter the name of file (.txt): ');
    IsCorrect := false;
    repeat
        Readln(NameOfFile);
        if (not FileExists(NameOfFile)) then
            Write('File does not exist. Try again: ')
        else
        begin
            IsCorrect := true;
            Assign(NewFile, NameOfFile);
            Write('Would you like to rewrite the file? Enter Y(Yes) or N(No): ');
            if ChoiceInput = 'Y' then
                try
                    Rewrite(NewFile);
                    ShowAnswerFile(NewFile, Number, MyArray);
                except
                    Write('Access is not allowed. Try again: ');
                    IsCorrect:= false;
                end
            else
                try
                    Append(NewFile);
                    ShowAnswerFile(NewFile, Number, MyArray);
                except
                    Write('Access is not allowed. Try again: ');
                    IsCorrect:= false;
                end;
        end;
    until IsCorrect;
    Close(NewFile);
end;

function CheckDigit(): Integer;
var
    Digit: Integer;
    IsCorrect: Boolean;
begin
    IsCorrect := false;
    repeat
        try
            Readln(Digit);
            IsCorrect := true;
        except
            Write('Check entered data. Enter number from interval [', Low(Integer), '..', High(Integer), ']: ');
        end;
    until IsCorrect;
    CheckDigit := Digit;
end;

function CheckNumber(): Byte;
var
    Num: Integer;
    IsCorrect: Boolean;
begin
    IsCorrect := false;
    repeat
        try
            Readln(Num);
            if (Num >= MinNumber) and (Num <= MaxNumber) then
                IsCorrect := true
            else
                Write('Enter number from interval [', MinNumber, '..', MaxNumber, ']: ');
        except
            Write('Check entered data. Enter number from interval [', MinNumber, '..', MaxNumber, ']: ');
        end;
    until IsCorrect;
    CheckNumber := Num;
end;

procedure GetDataConsole(var Number: Byte; var MyArray: TArr);
var
    i: Byte;
begin
    Write('Enter number of elements: ');
    Number := CheckNumber();
    for i := 1 to Number do
    begin
        Write('Enter element[', i,']: ');
        MyArray[i] := CheckDigit();
    end;
end;

function CheckDigitFile(var MyFile: TextFile): Integer;
var
    Digit: Integer;
    IsCorrect: Boolean;
begin
    IsCorrect := false;
    repeat
        try
            Read(MyFile, Digit);
            IsCorrect := true;
        except
            Writeln('Check entered data. Enter number from interval [', Low(Integer), '..', High(Integer), ']: ');
        end;
    until IsCorrect;
    CheckDigitFile := Digit;
end;

procedure ReadFromFile(var MyFile: TextFile; var Number: Byte; var MyArray: TArr);
begin
    Reset(MyFile);
    Number := 1;
    while not Eoln(MyFile) do
    begin
        MyArray[Number] := CheckDigitFile(MyFile);
        inc(Number);
    end;
    Dec(Number);
end;

procedure GetDataFile(var Number: Byte; var MyArray: TArr);
var
    IsCorrect: Boolean;
    NameOfFile: String;
    MyFile: TextFile;
begin
    Write('Enter file name(.txt): ');
    repeat
        Readln(NameOfFile);
        if (not FileExists(NameOfFile)) then
        begin
            Write('File does not exist. Try again: ');
            IsCorrect := false;
        end
        else
        begin
            AssignFile(MyFile, NameOfFile);
            Reset(MyFile);
            if SeekEof(MyFile) then
            begin
                Write('File is empty. Try again: ');
                IsCorrect := false;
            end
            else
            begin
                IsCorrect := true;
                ReadFromFile(MyFile, Number, MyArray);
            end;
        end;
    until IsCorrect;
    CloseFile(MyFile);
end;

procedure Main();
var
    MyArray: TArr;
    Number: Byte;
begin
    Writeln('This program sorts array by counting method.');
    Write('Would you like to use File input instead of Console input? Enter Y(Yes) or N(No): ');
    if ChoiceInput = 'Y' then
        GetDataFile(Number, MyArray)
    else
        GetDataConsole(Number, MyArray);
    Writeln('Initial array is: ');
    OutputConsole(Number, MyArray);
    ChangeArray(Number, MyArray);
    Write('Would you like to write down the answer to File instead of Console? Enter Y(Yes) or N(No): ');
    if ChoiceInput = 'Y' then
        OutputFile(Number, MyArray)
    else
    begin
        Writeln('Sorted Array is:');
        OutputConsole(Number, MyArray);
    end;
    Writeln('Press "Enter" to exit.');
    Readln;
end;

begin
    Main();
end.
