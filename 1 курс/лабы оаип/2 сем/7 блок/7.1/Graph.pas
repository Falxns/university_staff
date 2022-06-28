unit Graph;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls;

type
    TGraphF = class(TForm)
        PopupMenu: TPopupMenu;
        MainMenu: TMainMenu;
        FileMenu: TMenuItem;
        Save: TMenuItem;
        SaveFile: TSaveDialog;
        NumEdit: TEdit;
        FindBtn: TButton;
        ResultLbl: TLabel;
    Inf: TMenuItem;
        procedure FormPaint(Sender: TObject);
        procedure SaveClick(Sender: TObject);
        procedure NumEditChange(Sender: TObject);
        procedure NumEditKeyPress(Sender: TObject; var Key: Char);
        procedure FormShow(Sender: TObject);
        procedure FindBtnClick(Sender: TObject);
        function HamiltCycle(k: Byte): String;
    procedure InfClick(Sender: TObject);
    end;

var
    GraphF: TGraphF;

implementation

{$R *.dfm}

uses Main;

var
    Angle: Real;
    VertArr: array[1..5]of array[1..10] of ShortInt;
    BuffArr: array[1..5] of Boolean;
    l: ShortInt;
    ResultL: String;

function TGraphF.HamiltCycle(k: Byte): String;
var
    m: ShortInt;
begin
    m := 1;
    while l <> MainF.SG.RowCount - 1 do
        if (BuffArr[VertArr[k][m]]) then
        begin
            if l <> MainF.SG.RowCount - 2 then
                ResultL := ResultL + IntToStr(VertArr[k][m]) + ' '
            else
                ResultL := ResultL + IntToStr(VertArr[k][m]) + ' ' + NumEdit.Text;
            BuffArr[VertArr[k][m]] := false;
            inc(l);
            Canvas.Brush.Color := RGB(250, 0, 0);
            Canvas.Ellipse(Trunc(Cos(Angle * VertArr[k][m]) * 120 + 200), Trunc(Sin(Angle * VertArr[k][m]) * 120 + 200), Trunc(Cos(Angle * VertArr[k][m]) * 120 + 160), Trunc(Sin(Angle * VertArr[k][m]) * 120 + 160));
            Canvas.Font.Size := 14;
            Canvas.TextOut (Trunc(Cos(Angle * VertArr[k][m]) * 120 + 175), Trunc(Sin(Angle * VertArr[k][m]) * 120 + 168), IntToStr(VertArr[k][m]));
            Sleep(1000);
            HamiltCycle(VertArr[k][m]);
        end
        else
        begin
            if (VertArr[k][m + 1] <> 0)and(m < 30) then
                inc(m)
            else
            begin
                MessageDlg('You are dolboeb! I can''t find Hamilton Cycle.', mtInformation, [mbOk], 0);
                Save.Enabled := false;
                ResultL := '';
                l := MainF.SG.RowCount - 1;
                break;
            end;
        end;
    HamiltCycle := ResultL;
end;

procedure TGraphF.InfClick(Sender: TObject);
begin
    MessageDlg('Use numbers corresponding to vertex numbers.', mtInformation, [mbOk], 0);
end;

procedure TGraphF.FindBtnClick(Sender: TObject);
begin
    Save.Enabled := true;
    NumEdit.Enabled := false;
    FindBtn.Enabled := false;
    l := 1;
    ResultL := 'Hamilton Cycle is: ' + NumEdit.Text + ' ';
    BuffArr[StrToInt(NumEdit.Text)] := false;
    Canvas.Brush.Color := RGB(250, 0, 0);
    Canvas.Ellipse(Trunc(Cos(Angle * StrToInt(NumEdit.Text)) * 120 + 200), Trunc(Sin(Angle * StrToInt(NumEdit.Text)) * 120 + 200), Trunc(Cos(Angle * StrToInt(NumEdit.Text)) * 120 + 160), Trunc(Sin(Angle * StrToInt(NumEdit.Text)) * 120 + 160));
    Canvas.Font.Size := 14;
    Canvas.TextOut (Trunc(Cos(Angle * StrToInt(NumEdit.Text)) * 120 + 175), Trunc(Sin(Angle * StrToInt(NumEdit.Text)) * 120 + 168), IntToStr(StrToInt(NumEdit.Text)));
    Sleep(1000);
    ResultLbl.Caption := HamiltCycle(StrToInt(NumEdit.Text));
end;

procedure TGraphF.FormPaint(Sender: TObject);
var
    i, j, k: ShortInt;
begin
    Angle := 2 * Pi / (MainF.SG.RowCount - 1);
    Canvas.Pen.Color := RGB(0, 0, 0);
    for j := 1 to MainF.SG.RowCount do
    begin
        for i := 1 to MainF.SG.ColCount do
            if (MainF.SG.Cells[i, j] = '1') then
                for k := 1 to MainF.SG.RowCount do
                    if (MainF.SG.Cells[i, k] = '1')and(k <> j) then
                    begin
                        Canvas.MoveTo(Trunc(Cos(Angle * j) * 120 + 175), Trunc(Sin(Angle * j) * 120 + 168));
                        Canvas.LineTo(Trunc(Cos(Angle * k) * 120 + 175), Trunc(Sin(Angle * k) * 120 + 168));
                    end;
    end;
    for i := 1 to MainF.SG.RowCount - 1 do
    begin
        Canvas.Brush.Color := RGB(Random(256), Random(256), Random(256));
        Canvas.Ellipse(Trunc(Cos(Angle * i) * 120 + 200), Trunc(Sin(Angle * i) * 120 + 200), Trunc(Cos(Angle * i) * 120 + 160), Trunc(Sin(Angle * i) * 120 + 160));
        Canvas.Font.Size := 14;
        Canvas.TextOut(Trunc(Cos(Angle * i) * 120 + 175), Trunc(Sin(Angle * i) * 120 + 168), IntToStr(i));
    end;
end;

procedure TGraphF.SaveClick(Sender: TObject);
var
    OutputFile: TextFile;
    MyFile: String;
    ButtonSelected: byte;
begin
    if SaveFile.Execute then
    begin
        MyFile := SaveFile.FileName;
        if FileExists(MyFile) then
        begin
            ButtonSelected := MessageDlg('Do you want to rewrite the file?', mtConfirmation, [mbYes,mbNo], 0);
            AssignFile(OutputFile, MyFile);
            if ButtonSelected = MrYes then
                Rewrite(OutputFile)
            else
            begin
                Append(outputFile);
                WriteLn(OutputFile);
            end;
            Write(OutputFile, ResultLbl.Caption);
            CloseFile(OutputFile);
        end;
    end;
end;

procedure TGraphF.FormShow(Sender: TObject);
var
    i, j, k: ShortInt;
begin
    NumEdit.Text := '';
    NumEdit.Enabled := true;
    Save.Enabled := false;
    ResultLbl.Caption := '';
    FindBtn.Enabled := false;
    for j := 1 to MainF.SG.RowCount do
    begin
        l := 1;
        for i := 1 to MainF.SG.ColCount do
            if (MainF.SG.Cells[i, j] = '1') then
                for k := 1 to MainF.SG.RowCount do
                begin
                    if (MainF.SG.Cells[i, k] = '1')and(k <> j) then
                    begin
                        VertArr[j][l] := k;
                        inc(l);
                    end;
                end;
    end;
    for i := 1 to MainF.SG.RowCount do
        BuffArr[i] := true;
end;

procedure TGraphF.NumEditChange(Sender: TObject);
begin
    if Length(NumEdit.Text) = 1 then
        FindBtn.Enabled := true
    else
        FindBtn.Enabled := false;
end;

procedure TGraphF.NumEditKeyPress(Sender: TObject; var Key: Char);
var
    Numerals: set of char;
    i: ShortInt;
begin
    Numerals := [#8];
    for i := 1 to MainF.SG.RowCount - 1 do
        Include(Numerals, AnsiChar(i + 48));
    if not (Key in Numerals) then
        Key := #0;
    if (Length(NumEdit.Text) = 1) and (Key <> #8) then
        Key := #0;
end;

end.
