program Project1;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

Type
    Arr = array of Byte;

Label
    Cycle, Next, Bigger, Ext;

var
    MyArray: array [1..5] of Byte;
    i, Counter: Byte;
begin
    Writeln('Enter array:');
    for i := 1 to 5 do
        Read(MyArray[i]);
    asm
        mov dh, 7h
        mov ebx, 0

    Cycle:
        mov al, byte [MyArray + ebx]
        cmp al, 5
        jg Bigger

    Next:
        inc ebx
        cmp ebx, 5
        jne Cycle
        jmp Ext

    Bigger:
        mov  Byte[MyArray + ebx] ,5
        inc Counter

        jmp Next

    Ext:

    end;
    Writeln('New array:');
    for i := 1 to 5 do
        Write(MyArray[i],' ');
    Writeln;
    Writeln('Number of replacements:');
    Writeln(Counter);
    Readln;
    Readln;
end.
