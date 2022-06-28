unit Main;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, ExtCtrls;

type
    TMainF = class(TForm)
        Img: TImage;
        Label1: TLabel;
        Time: TTimer;
        procedure TimeTimer(Sender: TObject);
        procedure FormActivate(Sender: TObject);
        procedure Click(Sender: TObject);
    private
        { Private declarations }
    public
        { Public declarations }
    end;

var
    MainF: TMainF;
    ArrA, ArrB: array [1..400, 1..400] of Integer;
    Flag: Boolean;

implementation

{$R *.dfm}

procedure Drawing(k:integer);
var
    i, j: Integer;
begin
    for i := 1 to 200 do
        for j := 1 to 200 do
        begin
            if ArrA[i,j] = 1 then
                MainF.Label1.Canvas.Pixels[i,j] := clYellow
            else
                if ArrA[i,j] = 2 then
                    MainF.Label1.Canvas.Pixels[i,j] := clWhite
                else
                    MainF.Label1.Canvas.Pixels[i,j] := clBlack;
        end;
end;

procedure Initialize;
var
    i, j: Integer;
begin
    for i := 1 to 200 do
        for j := 1 to 200 do
        begin
            if MainF.Label1.Canvas.Pixels[i,j]=clYellow then
                ArrA[i,j] := 1;
            if MainF.Label1.Canvas.Pixels[i,j]=clBlack then
                ArrA[i,j] := 2;
        end;
end;

procedure Moving;
var
    i, j: Integer;
begin
    Flag := true;
    for i := 2 to 199 do
        for j := 198 downto 1 do
        begin
            if ArrA[i,j] = 2 then
                ArrB[i,j] := 2;
            if ArrA[i,j] = 1 then
            begin
                ArrB[i,j] := 1;
                if ArrB[i,j+1] = 0 then
                begin
                    Flag := false;
                    ArrB[i,j] := 0;
                    ArrB[i,j+1] := 1;
                end
                else
                    if Random(2) = 1 then
                    begin
                        if ArrB[i+1,j+1] = 0 then
                        begin
                            Flag := false;
                            ArrB[i,j] := 0;
                            ArrB[i+1,j+1] := 1;
                        end
                    end
                    else
                        if ArrB[i-1,j+1] = 0 then
                        begin
                            Flag := false;
                            ArrB[i,j] := 0;
                            ArrB[i-1,j+1] := 1;
                        end
            end;
        end;
    ArrA:=ArrB;
end;

procedure Turn;
var
    i, j: Integer;
begin
    if Flag then
    begin
        for i := 1 to 200 do
            for j := 1 to 200 do
                ArrB[i,j] := ArrA[i,200-j];
        ArrA := ArrB;
    end;
end;

procedure TMainF.TimeTimer(Sender: TObject);
begin
    Moving;
    Turn;
    Drawing(1);
    Application.ShowMainForm:=false;
end;

procedure TMainF.FormActivate(Sender: TObject);
begin
    MainF.Height := 200;
    MainF.Width := 200;
    Img.Picture.LoadFromFile('send.bmp');
    Label1.Canvas.Draw(0, 0, Img.Picture.Bitmap);
    Initialize;
end;

procedure TMainF.Click(Sender: TObject);
begin
    Close;
end;

end.
