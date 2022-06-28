program Lab2;

{$APPTYPE CONSOLE}

uses
    System.SysUtils;
type
    Pointer = ^TElement;
    TElement = record
        Power, Koef: ShortInt;
        Next: Pointer;
    end;
var
    A, B, C: Pointer;
    x: Integer;

function ReadMN(): Pointer;
var
    rez, x, y: Pointer;
    i, t, n: Integer;
begin
    Write('������� ������� ����������: ');
    Read(n);
    Writeln('������� ������������ ����� ������:');
    new(x);
    rez := x;
    for i := n downto 0 do
    begin
        Read(t);
        if t <> 0 then
        begin
            x^.Koef := t;
            x^.Power := i;
            y := x;
            new(x);
            y^.Next := x;
        end;
    end;
    y^.Next := nil;
    Readln;
    ReadMN := rez;
end;

procedure WriteMN(mn: Pointer);
var
    st: Boolean;
begin
    st := True;
    while mn <> nil do
    begin
        if (mn^.Koef > 0) and (not st) then
            Write(' + ');
        st := False;
        if mn^.Power <> 0 then
            Write(IntToStr(mn^.Koef), 'x(', IntToStr(mn^.Power),')')
        else
            Write(IntToStr(mn^.Koef));
        mn := mn^.Next;
    end;
end;

function Equality(p, q: Pointer): Boolean;
var
    rez: Boolean;
begin
    rez := True;
    while (p <> nil) and (q <> nil) and rez do
    begin
        if (p = nil) and (q = nil) then
            rez := False
        else
        begin
            if (p^.Power <> q^.Power) or (p^.Koef <> q^.Koef) then
                rez := false;
            p := p^.Next;
            q := q^.Next;
        end;
    end;
    Equality := rez;
end;

function Meaning(p: Pointer; x: Integer): Integer;
var
    rez: Integer;
begin
    rez := 0;
    while p <> nil do
    begin
        rez := rez + p^.Koef * Round(exp(p^.Power * ln(x)));
        p := p^.Next;
    end;
    Meaning := rez;
end;

procedure Add(out p: Pointer; q, r: Pointer);
var
    x, y: Pointer;
begin
    new(x);
    p := x;
    while (q <> nil) and (r <> nil) do
    begin
        if q^.Power > r^.Power then
        begin
            x^.Power := q^.Power;
            x^.Koef := q^.Koef;
            q := q^.Next;
        end
        else
            if q^.Power < r^.Power then
            begin
                x^.Power := r^.Power;
                x^.Koef := r^.Koef;
                r := r^.Next;
            end
            else
            begin
                x^.Power := r^.Power;
                x^.Koef := r^.Koef + q^.Koef;
                q := q^.Next;
                r := r^.Next;
            end;
        y := x;
        new(x);
        y^.Next := x;
    end;
    y^.Next := nil;
end;

begin
    A := ReadMN;
    Write('������ ���������: ');
    WriteMN(A);
    Writeln;

    B := ReadMN;
    Write('������ ���������: ');
    WriteMN(B);
    Writeln;

    Write('���������� ');
    if not Equality(A, B) then
        Write('�� ');
    Write('�����.');
    Writeln;

    Write('������� �������� X: ');
    Readln(x);
    Writeln('�������� ������� ����������: ', Meaning(A,x));
    Writeln('�������� ������� ����������: ', Meaning(B,x));
    Add(C, A, B);
    Write('����� �����������: ');
    WriteMN(C);
    Readln;
end.
