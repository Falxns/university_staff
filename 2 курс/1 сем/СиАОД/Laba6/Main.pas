unit Main;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
    TMainF = class(TForm)
        Inp: TEdit;
        OutLbl: TLabel;
        Calc: TButton;
        RankLbl: TLabel;
        procedure CalcClick(Sender: TObject);
    private
        { Private declarations }
    public
        { Public declarations }
end;

const
    Operand: set of Char = ['A'..'Z', 'a'..'z'];
    Operation: set of Char = ['+', '-', '*', '/', '^'];

type
    TStack = ^Stack;

    Stack = record
        data: Char;
        next: TStack;
end;

var
  MainF: TMainF;

implementation

{$R *.dfm}

procedure Add(var Buff: TStack; Value: Char);
var
    Elem: TStack;
begin
    new(Elem);
    Elem^.data := Value;
    Elem^.next := Buff;
    Buff := Elem;
end;

function Get(var Buff: TStack): Char;
begin
    if Buff <> nil then
    begin
        Result := Buff^.data;
        Buff := Buff^.next;
    end
    else
        Result := #0;
end;

function FindRank(Str: String):String;
var
    i, Counter: Integer;
begin
    Counter := 0;
    for i := 1 to Length(Str) do
    begin
        if Str[i] in operand then
            inc(Counter);
        if Str[i] in operation then
            dec(Counter);
    end;
    Result := IntToStr(Counter);
end;

function StackPrior(Buff: Char): Integer;
begin
    case Buff of
        '+', '-':
            Result := 2;
        '*', '/':
            Result := 4;
        '^':
            Result := 5;
        'A'..'Z', 'a'..'z':
            Result := 8;
        '(':
            Result := 0;
        else
            Result := 20;
    end;
end;

function RelatPrior(Buff: Char): Integer;
begin
    case Buff of
        '+', '-':
            Result := 1;
        '*', '/':
            Result := 3;
        '^':
            Result := 6;
        'A'..'Z', 'a'..'z':
            Result := 7;
        '(':
            Result := 9;
        ')':
            Result := 0;
        else
            Result := 20;
    end;
end;

procedure TMainF.CalcClick(Sender: TObject);
var
    Input, Output: String;
    i: Integer;
    Temp: Char;
    Stek: TStack;
begin
    Input := Inp.Text;
    Output := '';
    RankLbl.Caption := 'Rank: ' + FindRank(Input);
    i := 1;
    while i <= Length(Input) do
        if (Stek = nil)or(RelatPrior(Input[i]) > StackPrior(Stek^.data)) then
        begin
            if Input[i] <> ')' then
                Add(Stek, Input[i]);
            inc(i);
        end
        else
        begin
            Temp := Get(Stek);
            if Temp <> '(' then
                Output := Output + Temp
            else
                inc(i);
        end;
    while Stek <> nil do
    begin
        Temp := Get(Stek);
        if (Temp <> '(')and(Temp <> ')') then
            Output := Output + Temp;
    end;
    OutLbl.Caption := Output;
end;

end.
