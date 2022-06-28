program Lab3;

{$APPTYPE CONSOLE}

uses
  System.SysUtils;

type
    TAbonents = record
        last: string[15];
        Tlph: string[13];
        number: integer;
    end;
    Cell = ^TCell;
    TCell = record
        abonent: TAbonents;
        next: Cell;
    end;

procedure ShowAbon(Head: Cell; i: Shortint);
var
    Buff, sort : Cell;
    j, k, z: Smallint;
    Arr: array[1..100] of Cell;
begin
    if i = 0 then
        writeln('Список абонентов пуст.')
    else
    begin
        Buff := Head;
        j := 1;
        while Buff^.next <> nil do
        begin
            Buff := Buff^.next;
            Arr[j] := Buff;
            inc(j);
        end;
        for z := 1 to j - 2 do
            for k := z + 1 to j - 1 do
                if Arr[k]^.abonent.last < Arr[z]^.abonent.last then
                begin
                    sort := Arr[k];
                    Arr[k] := Arr[z];
                    Arr[z] := sort;
                end;
        for z := 1 to j - 1 do
            writeln(Arr[z]^.abonent.last + ' ' + Arr[z]^.abonent.Tlph);
    end;
end;

procedure AddAbon(var Curr: Cell; Head: Cell; var i: Shortint);
var
    buff: string[15];
begin
    if Curr^.abonent.number <> i then
    begin
        Curr := Head;
        while Curr^.abonent.number <> i do
            Curr := Curr^.next;
    end;
    new(Curr^.next);
    Curr := Curr^.next;
    Curr^.next := nil;
    Writeln('Введите фамилию:');
    Readln(buff);
    Curr^.abonent.last := buff;
    Writeln('Введите номер телефона:');
    Readln(buff);
    Curr^.abonent.Tlph := buff;
    inc(i);
    Curr^.abonent.number := i;
end;

procedure DeleteAbon(Head: Cell; var con: Shortint);
var
    num, i: Shortint;
    buff, abon: Cell;
begin
    Write('Какого по счёту абонента удалить: ');
    Readln(num);
    buff := Head;
    while (buff^.next^.abonent.number <> num) do
        buff := buff^.next;
    abon := buff^.next;
    buff^.next := abon^.next;
    dispose(abon);
    i := 0;
    buff := Head;
    while buff^.next <> nil do
    begin
        buff := buff^.next;
        inc(i);
        buff^.abonent.number := i;
    end;
    con := i;
end;

procedure DetermineAbon(Head: Cell; i: Shortint);
var
    buff: Cell;
    str: string[13];
    bool: Boolean;
begin
    Write('Введите номер телефона: ');
    Readln(str);
    buff := Head^.next;
    bool := false;
    while buff <> nil do
        if buff^.abonent.Tlph = str then
        begin
            writeln('Искомый абонент: ' + Buff^.abonent.last + ' ' + Buff^.abonent.Tlph);
            buff := buff^.next;
            bool := true;
        end
        else
            buff := buff^.next;
    if not bool then
        writeln('Абонента с таким номером телефона нет в базе данных.');
end;

procedure DeterminePhone(Head: Cell; i: Shortint);
var
    buff: Cell;
    str: string[15];
    bool: Boolean;
begin
    Write('Введите фамилию абонента: ');
    Readln(str);
    buff := Head^.next;
    bool := false;
    while buff <> nil do
        if buff^.abonent.last = str then
        begin
            writeln('Искомый абонент: ' + Buff^.abonent.last + ' ' + Buff^.abonent.Tlph);
            buff := buff^.next;
            bool := true;
        end
        else
            buff := buff^.next;
    if not bool then
        writeln('Абонента с такой фамилией нет в базе данных.');
end;

var
    choice, count: Shortint;
    HeadAbon, CurrAbon: Cell;
begin
    choice := 10;
    count := 0;
    new(HeadAbon);
    HeadAbon.abonent.number := 0;
    CurrAbon := HeadAbon;
    CurrAbon^.next := nil;
    while choice <> 0 do
    begin
        Writeln('--------------' + #13#10 + '1 - просмотреть список абонентов.' + #13#10 + '2 - добавить абонента' + #13#10 + '3 - удалить абонента' + #13#10 + '4 - определить абонента по номеру телефона' + #13#10 + '5 - определить номера телефонов по фамилии абонента' + #13#10 + '0 - выход' + #13#10 + '--------------');
        Readln(choice);
        case choice of
            1:
                ShowAbon(HeadAbon, count);
            2:
                AddAbon(CurrAbon, HeadAbon, count);
            3:
                DeleteAbon(HeadAbon, count);
            4:
                DetermineAbon(HeadAbon, count);
            5:
                DeterminePhone(HeadAbon, count);
        end;
    end;
end.
