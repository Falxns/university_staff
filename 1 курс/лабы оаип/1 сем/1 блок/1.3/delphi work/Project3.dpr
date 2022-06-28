program Project3;

{$APPTYPE CONSOLE}

uses
    System.SysUtils;

var
    Num10, Num1, Num2, Power : integer;
    IsCorrect : boolean;

begin
    writeln('This program looks for the smallest K for which M to the power K greater than N');
    writeln('Use natural numbers, M should be greater than 1, N should be greater than M');
    IsCorrect := false;
    repeat
        try
            readln(Num10,Num2);
            if (Num10 > 1) and (Num2 > Num10) then
                IsCorrect := true
            else
                writeln('You should use natural numbers, M should be greater than 1, N should be greater than M');
        except
            IsCorrect := false;
            writeln('You should use natural numbers, M should be greater than 1, N should be greater than M');
        end;
    until IsCorrect;
    Num1 := Num10;
    Power := 1;
    while Num1 < Num2 do
    begin
        inc(Power);
        Num1 := Num1 * Num10;
    end;
    writeln('The smallest K for which M to the power K greater than N is:', Power);
    readln;
end.
