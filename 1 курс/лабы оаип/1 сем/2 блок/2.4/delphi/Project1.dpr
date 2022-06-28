program Project8;

{$APPTYPE CONSOLE}

uses
    SysUtils;

type
    TArray = array[0..255,0..255] of Real;

const
    MinSize = 1;
    MaxSize = 128;
    MinInt: Integer = -2147483646;
    MaxInt: Integer = 2147483647;

procedure ChangeMatrix(Size: Byte; var Matrix: TArray);
var
    i, j: Byte;
    Bufer: Real;
    Num: Byte;
begin
    Num := Size div 2;
    for i := 0 to Num do
        for j := 0 to Size do
        begin
            Bufer := Matrix[i][j];
            Matrix[i][j] := Matrix[i + Num + 1][j];
            Matrix[i + Num + 1][j] := Bufer;
        end;
    for i := 0 to Num do
        for j := 0 to Num do
        begin
            Bufer := Matrix[i][j];
            Matrix[i][j] := Matrix[i][Num + j + 1];
            Matrix[i][Num + j + 1] := Bufer;
        end;
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

procedure OutputConsole(Size: Byte; var Matrix: TArray);
var
    i, j: Byte;
begin
    Writeln('Matrix:');
    for i := 0 to Size do
    begin
        for j := 0 to Size do
            Write(Matrix[i][j]:5:2,'    ');
        Writeln;
    end;
end;

procedure ShowMatrixFile(var NewFile: TextFile; Size: Byte; var Matrix: TArray);
var
    i, j: Byte;
begin
    Writeln(NewFile, 'Matrix:');
    for i := 0 to Size do
    begin
        for j := 0 to Size do
            Write(NewFile, Matrix[i][j]:5:2,'    ');
        Writeln(NewFile);
    end;
end;

procedure OutputFile(Size: Byte; var Matrix: TArray);
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
                    ShowMatrixFile(NewFile, Size, Matrix);
                except
                    Write('Access is not allowed. Try again: ');
                    IsCorrect:= false;
                end
            else
                try
                    Append(NewFile);
                    ShowMatrixFile(NewFile, Size, Matrix);
                except
                    Write('Access is not allowed. Try again: ');
                    IsCorrect:= false;
                end;
        end;
    until IsCorrect;
    Close(NewFile);
end;

function CheckInput(Min, Max: Integer): Real;
var
    Number: Real;
    IsCorrect: Boolean;
begin
    IsCorrect := false;
    repeat
        try
            Readln(Number);
            if (Number >= Min) and (Number <= Max) then
                IsCorrect := true
            else
                Writeln('Enter number from interval [', Min, '..', Max, ']: ');
        except
            Writeln('Check entered data. Enter number from interval [', Min, '..', Max, ']: ');
        end;
    until IsCorrect;
    CheckInput := Number;
end;

function CheckSize(Min, Max: Integer): Byte;
var
    Size: Byte;
    IsCorrect: Boolean;
begin
    IsCorrect := false;
    repeat
        try
            Readln(Size);
            if (Size >= Min) and (Size <= Max) then
                IsCorrect := true
            else
                Writeln('Enter number from interval [', Min, '..', Max, ']: ');
        except
            Writeln('Check entered data. Enter number from interval [', Min, '..', Max, ']: ');
        end;
    until IsCorrect;
    CheckSize := Size;
end;

procedure GetDataConsole(var Size: Byte; var Matrix: TArray);
var
    i, j: Byte;
begin
    Write('Enter size of submatrix[', MinSize,'..', MaxSize,'].Your matrix will have size 2 times bigger than this: ');
    Size := CheckSize(MinSize, MaxSize);
    Size := (Size * 2) - 1;
    Writeln('Enter your matrix: ');
    for i := 0 to Size do
        for j := 0 to Size do
        begin
            Write('Element[',i + 1,'][',j + 1,'] = ');
            Matrix[i][j] := CheckInput(MinInt, MaxInt);
        end;
end;

function CheckInputFile(Min, Max: Integer; var MyFile: TextFile): Boolean;
var
    IsCorrect: Boolean;
    Number: Real;
begin
    IsCorrect := true;
    while (not SeekEof(MyFile)) and (IsCorrect) do
        try
            Readln(MyFile, Number);
            if (Number <= Min) or (Number >= Max) then
                IsCorrect := false;
        except
            IsCorrect := false;
        end;
    CheckInputFile := IsCorrect;
end;

function ReadFromFile(var MyFile: TextFile; var Size: Byte; var Matrix: TArray): Boolean;
var
    i, j: Byte;
begin
    if CheckInputFile(MinInt, MaxInt, MyFile) then
    begin
        reset(MyFile);
        i := 0;
        while not Eof(MyFile) do
        begin
            j := 0;
            while not Eoln(MyFile) do
            begin
                Read(MyFile, Matrix[i][j]);
                inc(j);
            end;
            Readln(MyFile);
            inc(i);
        end;
        if i = j then
        begin
            Size := i - 1;
            ReadFromFile := true;
        end
        else
        begin
            Writeln('This is not square matrix. Try again.');
            ReadFromFile := false;
        end;
    end
    else
    begin
        CloseFile(MyFile);
        ReadFromFile := false;
        Write('Check entered data. Enter number from interval ', MinInt, '..', MaxInt, '. Try Again: ');
    end;
end;

procedure GetDataFile(var Size: Byte; var Matrix: TArray);
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
            WriteLn('File does not exist. Try again: ');
            IsCorrect := false;
        end
        else
        begin
            AssignFile(MyFile, NameOfFile);
            reset(MyFile);
            if SeekEof(MyFile) then
            begin
                Writeln('File is empty. Try again: ');
                IsCorrect := false;
            end
            else
                IsCorrect := ReadFromFile(MyFile, Size, Matrix);
        end;
    until IsCorrect;
    CloseFile(MyFile);
end;

procedure Main();
var
    Matrix: TArray;
    Size: Byte;
begin
    Writeln('This program changes entered Matrix is such way: 1 2 3 4 => 4 3 1 2');
    Write('Would you like to use File input instead of Console input? Enter Y(Yes) or N(No): ');
    if ChoiceInput = 'Y' then
        GetDataFile(Size, Matrix)
    else
        GetDataConsole(Size, Matrix);
    OutputConsole(Size, Matrix);
    ChangeMatrix(Size, Matrix);
    Write('Would you like to write down the answer to File instead of Console? Enter Y(Yes) or N(No): ');
    if ChoiceInput = 'Y' then
        OutputFile(Size, Matrix)
    else
        OutputConsole(Size, Matrix);
    Writeln('Press "Enter" to exit.');
    Readln;
end;

begin
    Main;
end.
