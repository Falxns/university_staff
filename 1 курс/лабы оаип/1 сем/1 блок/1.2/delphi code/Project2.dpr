program Project2;

{$APPTYPE CONSOLE}

uses
    System.SysUtils;

const
    Quantity = 12;

var
    Volume,Diameter : real;
    i : byte;

begin
    writeln('Determine the total volume (in liters) of 12 balls nested with each other with walls of 5mm');
    writeln('The internal diameter of the inner ball is 10cm. Consider that the balls are embedded in each other without gaps');
    Diameter := 0.1;
    Volume := Pi * Diameter * Diameter * Diameter / 6;
    for i := 2 to Quantity do
    begin
        Diameter := Diameter + 0.01;
        Volume := Volume + Pi * Diameter * Diameter * Diameter / 6;
    end;
    Volume := 1000 * Volume;
    writeln('The volume of balls is ', Volume:9:5 ,' liters');
    readln;
end.
