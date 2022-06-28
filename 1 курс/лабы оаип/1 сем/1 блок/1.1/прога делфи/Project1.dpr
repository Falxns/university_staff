program Project1;

{$APPTYPE CONSOLE}

uses
    SysUtils;

var
    Day:byte;
    IsCorrect:boolean;

begin
    WriteLn('This program defines the day of week by entering numbers 1..7');
    repeat
        try
            IsCorrect := True;
            ReadLn(Day);
            if (Day <= 0) or (Day > 7) then
                begin
                    IsCorrect := False;
                    WriteLn('Wrong number');
                end;
        except
            IsCorrect := False;
            WriteLn('Check entered data');
        end;
    until IsCorrect;
    case Day of
        1:WriteLn('This day is Monday');
        2:WriteLn('This day is Tuesday');
        3:WriteLn('This day is Wednesday');
        4:WriteLn('This day is Thursday');
        5:WriteLn('This day is Friday');
        6:WriteLn('This day is Saturday');
        7:WriteLn('This day is Sunday');
    end;
    ReadLn;
end.
