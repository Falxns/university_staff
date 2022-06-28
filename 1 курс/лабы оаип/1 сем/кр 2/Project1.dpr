program kr2;

uses
    SysUtils, Math;

type
    TArr = array of Integer;

procedure RadixSort(var DataArr: TArr);
var
    i, j, k: Byte;
    PosArr: array [0..9] of array of Integer;
    TempArray: TArr;
    Dev: Integer;
    MaxOrder: Integer;
begin
    MaxOrder := 2;
    Dev := 1;
    Setlength(TempArray, Length(DataArr));
    repeat
        for i := 0 to High(DataArr) do
        begin
            Setlength(PosArr[(DataArr[i] div Dev) mod 10],
                Length(PosArr[(DataArr[i] div Dev) mod 10]) + 1);
            PosArr[(DataArr[i] div Dev) mod 10]
                [High(PosArr[(DataArr[i] div Dev) mod 10])] := i;
        end;
        Dev := Dev * 10;
        k := 0;
        for i := 0 to High(PosArr) do
            if Length(PosArr[i]) <> 0 then
            begin
                for j := 0 to High(PosArr[i]) do
                begin
                    TempArray[k] := DataArr[PosArr[i][j]];
                    Inc(k);
                end;
                Setlength(PosArr[i], 0);
            end;
        for i := 0 to High(DataArr) do
            DataArr[i] := TempArray[i];
    until Dev = Power(10, MaxOrder);
end;

procedure Main();
var
    Arr: TArr;
    i, N: Integer;
begin
    WriteLn('N:');
    ReadLn(N);
    SetLength(Arr, N);
    for i := 0 to High(Arr) do
        ReadLn(Arr[i]);
    RadixSort(Arr);
    for i := 0 to High(Arr) do
        Write(Arr[i], ' ');
    Readln;
end;

begin
    Main();
end.
