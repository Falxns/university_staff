program Project9;

{$APPTYPE CONSOLE}

uses
    SysUtils;

const
    MinLength = 1;
    MaxLength = 255;

procedure ChangeString(Num: Byte; var MyString: String);
var
    i: Byte;
    Leng : Integer;
begin
    Leng := Length(MyString);
    if Num > Leng then
        for i := 1 to Num - Leng do
            MyString := '.' + MyString
    else
        for i := 1 to Num do
            MyString[i] := MyString[i + Leng - Num];
        for i := Num + 1 to Leng do
            MyString[i] := ' ';
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

procedure OutputConsole(MyString: String);
begin
    Write('Changed string is: ');
    Writeln(MyString);
end;

procedure ShowAnswerFile(var NewFile: TextFile; MyString: String);
begin
    Write(NewFile, 'Changed string is: ');
    Write(NewFile, MyString);
end;

procedure OutputFile(MyString: String);
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
                    ShowAnswerFile(NewFile, MyString);
                except
                    Write('Access is not allowed. Try again: ');
                    IsCorrect:= false;
                end
            else
                try
                    Append(NewFile);
                    ShowAnswerFile(NewFile, MyString);
                except
                    Write('Access is not allowed. Try again: ');
                    IsCorrect:= false;
                end;
        end;
    until IsCorrect;
    Close(NewFile);
end;

function CheckLength(Min, Max: Byte): Byte;
var
    Length: Integer;
    IsCorrect: Boolean;
begin
    IsCorrect := false;
    repeat
        try
            Readln(Length);
            if (Length >= Min) and (Length <= Max) then
                IsCorrect := true
            else
                Writeln('Enter number from interval [', Min, '..', Max, ']: ');
        except
            Writeln('Check entered data. Enter number from interval [', Min, '..', Max, ']: ');
        end;
    until IsCorrect;
    CheckLength := Length;
end;

function CheckLengthFile(Min, Max: Byte; var MyFile: TextFile): Byte;
var
    Length: Integer;
    IsCorrect: Boolean;
begin
    IsCorrect := false;
    repeat
        try
            Readln(MyFile, Length);
            if (Length >= Min) and (Length <= Max) then
                IsCorrect := true
            else
                Writeln('Enter number from interval [', Min, '..', Max, ']: ');
        except
            Writeln('Check entered data. Enter number from interval [', Min, '..', Max, ']: ');
        end;
    until IsCorrect;
    CheckLengthFile := Length;
end;

procedure GetDataConsole(var Length: Byte; var MyString: String);
begin
    Write('Enter N:');
    Length := CheckLength(MinLength, MaxLength);
    Write('Enter your string: ');
    Readln(MyString);
end;

procedure ReadFromFile(var MyFile: TextFile; var Length: Byte; var MyString: String);
begin
    Reset(MyFile);
    Length := CheckLengthFile(MinLength, MaxLength, MyFile);
    while not Eoln(MyFile) do
        Read(MyFile, MyString);
end;

procedure GetDataFile(var Length: Byte; var MyString: String);
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
            Reset(MyFile);
            if SeekEof(MyFile) then
            begin
                Writeln('File is empty. Try again: ');
                IsCorrect := false;
            end
            else
            begin
                IsCorrect := true;
                ReadFromFile(MyFile, Length, MyString);
            end;
        end;
    until IsCorrect;
    CloseFile(MyFile);
end;

procedure Main();
var
    MyString: String;
    Length: Byte;
begin
    Writeln('This program converts the entered string into a string of length N as follows:');
    Writeln('If length of the string is greater than N, then discard the first characters, if length of the string is less than N, then add points at the beginning.');
    Write('Would you like to use File input instead of Console input? Enter Y(Yes) or N(No): ');
    if ChoiceInput = 'Y' then
        GetDataFile(Length, MyString)
    else
        GetDataConsole(Length, MyString);
    ChangeString(Length, MyString);
    Write('Would you like to write down the answer to File instead of Console? Enter Y(Yes) or N(No): ');
    if ChoiceInput = 'Y' then
        OutputFile(MyString)
    else
        OutputConsole(MyString);
    Writeln('Press "Enter" to exit.');
    Readln;
end;

begin
    Main;
end.
