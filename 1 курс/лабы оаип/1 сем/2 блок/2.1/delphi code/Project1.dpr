program Project5;

{$APPTYPE CONSOLE}

const
    Low = 3;
    LowInt = -2147483648;
    HighInt = 2147483647;

var
    x,y : array of integer;
    Num , Number , i , FirstVectorX , FirstVectorY : Integer;
    SecondVectorX , SecondVectorY , Determinator : Integer;
    FirstCounter , SecondCounter : Byte;
    IsCorrect : Boolean;

begin
    Writeln('This program checks, if the polygon is convex.');
    Writeln('Enter the number of sides:');
    IsCorrect := false;
    repeat
        try
            Readln(Num);
            if Num > 2 then
                IsCorrect := true
            else
                Writeln('Its not polygon. Use numbers [',Low ,'..',HighInt,']');
        except
            Writeln('Use numbers [',Low ,'..',HighInt,']');
        end;
    until IsCorrect;
    if Num = 3 then
        Writeln('Triangle is always convex.')
    else
    begin
        SetLength(x,Num + 1);
        SetLength(y,Num + 1);
        Number := Num - 1;
        for i := 0 to Number do
            repeat
                IsCorrect := true;
                try
                    Writeln('Enter the coordinates of point.');
                    Readln(x[i],y[i]);
                except
                    Writeln('Use numbers [',LowInt ,'..',HighInt ,']');
                    IsCorrect := false;
                end;
            until IsCorrect;
        x[Num] := x[0];
        y[Num] := y[0];
        FirstCounter := 0;
        SecondCounter := 0;
        for i := 1 to Number do
        begin
            FirstVectorX := x[i] - x[i - 1];
            FirstVectorY := y[i] - y[i - 1];
            SecondVectorX := x[i + 1] - x[i];
            SecondVectorY := y[i + 1] - y[i];
            Determinator := FirstVectorX * SecondVectorY - FirstVectorY * SecondVectorX;
            if Determinator > 0 then
                inc(FirstCounter)
            else
                inc(SecondCounter);
        end;
        if ((FirstCounter > 0)and(SecondCounter = 0))or((FirstCounter = 0)and(SecondCounter > 0)) then
            Writeln('Polygon is convex.')
        else
            Writeln('Polygon is not convex.');
    end;
    Readln;
end.
