unit Main;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Grids, Vcl.StdCtrls;

type
    TMainF = class(TForm)
        SG: TStringGrid;
        MainMenu: TMainMenu;
        OpenFile: TOpenDialog;
        PopupMenu: TPopupMenu;
        FileMenu: TMenuItem;
        Open: TMenuItem;
        Help: TMenuItem;
        Info: TMenuItem;
        Developer: TMenuItem;
        TransformBtn: TButton;
        SetSizeBtn: TButton;
        VerticesLbl: TLabel;
        VertEdit: TEdit;
        EdgesLbl: TLabel;
        EdgeEdit: TEdit;
        procedure InfoClick(Sender: TObject);
        procedure DeveloperClick(Sender: TObject);
        procedure OpenClick(Sender: TObject);
        procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
        procedure SGKeyPress(Sender: TObject; var Key: Char);
        procedure FormCreate(Sender: TObject);
        procedure TransformBtnClick(Sender: TObject);
        procedure VertEditChange(Sender: TObject);
        procedure VertEditKeyPress(Sender: TObject; var Key: Char);
        procedure SetSizeBtnClick(Sender: TObject);
        procedure EdgeEditChange(Sender: TObject);
        procedure EdgeEditKeyPress(Sender: TObject; var Key: Char);
    procedure EdgeEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    end;

var
    MainF: TMainF;

implementation

{$R *.dfm}

uses Graph;

procedure TMainF.DeveloperClick(Sender: TObject);
begin
    MessageDlg('Developer: Gladkiy Maksim, gp.851001', mtInformation, [mbOk], 0);
end;

procedure TMainF.InfoClick(Sender: TObject);
begin
    MessageDlg('This program finds Hamiltonian cycle in the graph.' + #13#10 + 'Vertices[3..5].' + #13#10 + 'Edges[3..10].' + #13#10 + 'In table cells use 0 or 1.', mtInformation, [mbOk], 0);
end;

procedure TMainF.TransformBtnClick(Sender: TObject);
var
    i, j: ShortInt;
    IsEmpty: Boolean;
begin
    IsEmpty := false;
    for j := 1 to SG.RowCount - 1 do
        for i := 1 to SG.ColCount - 1 do
            if (SG.Cells[i, j] = '') then
            begin
                IsEmpty := true;
                SG.Cells[i, j] := '0';
            end;
    if IsEmpty then
        MessageDlg('Empty cells were filled with zeros.', mtConfirmation, [mbOk], 0);
    GraphF.Showmodal;
end;

procedure TMainF.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
    ButtonSelected: Byte;
begin
    ButtonSelected := MessageDlg('Are you sure you want to exit?', mtConfirmation, [mbYes,mbNo], 0);
    if ButtonSelected <> mrYes then
        CanClose := False;
end;

procedure TMainF.FormCreate(Sender: TObject);
var
    i: ShortInt;
begin
    for i := 1 to 5 do
        SG.Cells[0, i] := IntToStr(i);
    for i := 1 to 10 do
        SG.Cells[i, 0] := IntToStr(i);
    SG.Cells[0, 0] := 'H';
    SG.FixedCols := 1;
    SG.FixedRows := 1;
end;

procedure TMainF.OpenClick(Sender: TObject);
var
    InputFile: TextFile;
    i, j, Temp: ShortInt;
    IsCorrect: Boolean;
begin
    if OpenFile.Execute then
    begin
        VertEdit.Text := '';
        EdgeEdit.Text := '';
        try
            AssignFile(InputFile, OpenFile.FileName);
            Reset(InputFile);
            if EoF(InputFile) then
            begin
                MessageDlg('This file is empty. Try again.', mtError, [mbRetry], 0);
                CloseFile(InputFile);
            end
            else
            begin
                repeat
                    Read(InputFile, Temp);
                    if (Temp <> 0) and (Temp <> 1) then
                        IsCorrect := false
                until EoF(InputFile) or not(IsCorrect);
                if IsCorrect then
                begin
                    Reset(InputFile);
                    j := 0;
                    repeat
                        i := 0;
                        repeat
                            Read(InputFile, Temp);
                            Inc(i);
                        until EoLn(InputFile);
                        inc(j);
                    until EoF(InputFile);
                    VertEdit.Text := IntToStr(j);
                    EdgeEdit.Text := IntToStr(i);
                    SetSizeBtn.Click;
                    Reset(InputFile);
                    for j := 1 to SG.RowCount - 1 do
                        for i := 1 to SG.ColCount - 1 do
                        begin
                            Read(InputFile, Temp);
                            SG.Cells[i, j] := IntToStr(Temp);
                        end;
                    TransformBtn.Click;
                    CloseFile(InputFile);
                end
                else
                begin
                    MessageDlg('Check entered data. Try again.', mtError, [mbRetry], 0);
                    CloseFile(InputFile);
                end;
            end;
        except
            MessageDlg('Check entered data. Try again.', mtError, [mbRetry], 0);
            CloseFile(InputFile);
        end;
    end;
end;

procedure TMainF.SetSizeBtnClick(Sender: TObject);
begin
    SG.ColCount := StrToInt(EdgeEdit.Text) + 1;
    SG.RowCount := StrToInt(VertEdit.Text) + 1;
    SetSizeBtn.Enabled := false;
    SG.Enabled := true;
    TransformBtn.Enabled := true;
end;

procedure TMainF.SGKeyPress(Sender: TObject; var Key: Char);
begin
    if (Length(SG.Cells[SG.Col, SG.Row]) = 1) and (Key <> #8) then
        Key := #0;
    if (Key <> '0') and (Key <> '1') and (Key <> #8) then
        Key := #0;
end;

procedure TMainF.VertEditChange(Sender: TObject);
var
    i, j: ShortInt;
begin
    TransformBtn.Enabled := false;
    SG.Enabled := false;
    for j := 1 to SG.RowCount - 1 do
        for i := 1 to SG.ColCount - 1 do
            SG.Cells[i, j] := '';
    if (Length(VertEdit.Text) = 1)and(Length(EdgeEdit.Text) > 0) then
        SetSizeBtn.Enabled := true
    else
        SetSizeBtn.Enabled := false;
end;

procedure TMainF.EdgeEditChange(Sender: TObject);
var
    i, j: ShortInt;
begin
    TransformBtn.Enabled := false;
    SG.Enabled := false;
    for j := 1 to SG.RowCount - 1 do
        for i := 1 to SG.ColCount - 1 do
            SG.Cells[i, j] := '';
    if (Length(VertEdit.Text) = 1)and(Length(EdgeEdit.Text) > 0) then
        SetSizeBtn.Enabled := true
    else
        SetSizeBtn.Enabled := false;
end;

procedure TMainF.EdgeEditKeyPress(Sender: TObject; var Key: Char);
var
    Numerals: set of char;
begin
    Numerals := ['0', '1', '3'..'9', #8];
    if not (Key in Numerals) then
        Key := #0;
    if (Length(EdgeEdit.Text) = 2) and (Key <> #8) then
        Key := #0;
    if (Length(EdgeEdit.Text) = 0) and (Key = '0') then
        Key := #0;
end;

procedure TMainF.EdgeEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    if (Length(EdgeEdit.Text) > 1) and (StrToInt(EdgeEdit.Text) > 10) then
        EdgeEdit.Clear;
end;

procedure TMainF.VertEditKeyPress(Sender: TObject; var Key: Char);
var
    Numerals: set of char;
begin
    Numerals := ['3'..'5', #8];
    if not (Key in Numerals) then
        Key := #0;
    if (Length(VertEdit.Text) = 1) and (Key <> #8) then
        Key := #0;
end;

end.
