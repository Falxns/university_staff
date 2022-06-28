unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Vcl.Grids, Vcl.ExtCtrls;

type
    TMatrix = array of array of Real;
    TMaksim = class(TForm)
    TextOne: TLabel;
    Menu: TMainMenu;
    File1: TMenuItem;
    About: TMenuItem;
    Openfile: TMenuItem;
    Savetofile: TMenuItem;
    Exit: TMenuItem;
    Info: TMenuItem;
    Developer: TMenuItem;
    Size: TEdit;
    Get: TButton;
    Open: TOpenDialog;
    Save: TSaveDialog;
    N1: TMenuItem;
    PopupMenu: TPopupMenu;
    Check: TButton;
    SG: TStringGrid;
    SGR: TStringGrid;
    procedure ExitClick(Sender: TObject);
    procedure InfoClick(Sender: TObject);
    procedure DeveloperClick(Sender: TObject);
    procedure SizeChange(Sender: TObject);
    procedure GetClick(Sender: TObject);
    procedure OpenfileClick(Sender: TObject);
    procedure SavetofileClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure SizeKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure CheckClick(Sender: TObject);
    procedure SGKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
    Maksim: TMaksim;

implementation

{$R *.dfm}

procedure TMaksim.CheckClick(Sender: TObject);
var
    i: Integer;
begin
    if Length(Size.Text) > 0 then
        if (StrToInt(Size.Text) < 2) then
        begin
            ShowMessage('Error. It''s not matrix. Size should be [2..6]');
            Size.Clear;
        end
        else
            if (StrToInt(Size.Text)> 6) then
            begin
                ShowMessage('Error. Size should be [2..6].');
                Size.Clear;
            end
            else
                begin
                    SG.Enabled := true;
                    SG.ColCount := StrToInt(Size.Text);
                    SG.RowCount := StrToInt(Size.Text);
                    SGR.ColCount := StrToInt(Size.Text);
                    SGR.RowCount := StrToInt(Size.Text);
                    Get.Enabled := true;
                end;
end;

procedure TMaksim.DeveloperClick(Sender: TObject);
begin
    MessageDlg('Developer: Maksim Gladkiy', mtInformation, [mbOk], 0);
end;

procedure TMaksim.InfoClick(Sender: TObject);
begin
    MessageDlg('This program performs the Direct course of the Gauss method for the matrix.Size of Matrix should be [2..6]. You can use numbers [-99..99].', mtInformation, [mbOk], 0);
end;

procedure Calc(var Matrix: TMatrix; Siz: Integer);
var
    i, j, k, m: Byte;
    Bufer: Real;
begin
    for k := 0 to Siz - 1 do
    begin
        m := k;
        for i := k + 1 to Siz do
            if abs(Matrix[m][k]) > abs(Matrix[i][k]) then
                m := i;
        if m <> k then
        begin
            for j := 0 to Siz do
            begin
                Bufer := Matrix[m][j];
                Matrix[m][j] := Matrix[k][j];
                Matrix[k][j] := Bufer;
            end;
        end;
        for i := k + 1 to Siz do
        begin
            Bufer := Matrix[i][k] / Matrix[k][k];
            Matrix[i][k] := 0;
            if Bufer <> 0 then
                for j := k + 1 to Siz do
                    Matrix[i][j] := Matrix[i][j] - Bufer * Matrix[k][j];
        end
    end;
    for i := 0 to Siz do
        for k := i + 1 to Siz + 1 do
            if (Matrix[i][i] <> 0)and(Matrix[i][i] <> 1) then
            begin
                Matrix[k][i] := Matrix[k][i] / Matrix[i][i];
                Matrix[i][i] := 1;
            end;
end;

procedure TMaksim.GetClick(Sender: TObject);
var
    Number: Integer;
    Matrix: TMatrix;
    i, j, Siz: Integer;
    Empty: Boolean;
    Buff: String;
begin
    Empty := False;
    Savetofile.Enabled := True;
    Siz := StrToInt(Size.Text);
    SetLength(Matrix, Siz, Siz);
    dec(Siz);
    for i := 0 to Siz do
        for j := 0 to Siz do
        begin
            if (SG.Cells[j,i] = '') then
            begin
                Empty := true;
                SG.Cells[j,i] := '0';
            end;
            Matrix[i,j] := StrToInt(SG.Cells[j,i]);
        end;
    if Empty then
        MessageDlg('Empty cells replaced by zero''s', mtConfirmation, [mbOk], 0);
    Calc(Matrix, Siz);
    for i := 0 to Siz do
        for j := 0 to Siz do
        begin
            Str(Matrix[i,j],Buff);
            Buff := Buff[2] + Buff[3] + Buff[4];
            SGR.Cells[j,i] := Buff;
        end;
    SGR.Visible := true;
end;

procedure TMaksim.SizeChange(Sender: TObject);
var
  i, j: Integer;
begin
    Get.Enabled := false;
    Check.Enabled := false;
    SGR.Visible := false;
    SG.Enabled := false;
    for i := 0 to SG.ColCount do
        for j := 0 to SG.RowCount do
            SG.Cells[j,i] := '';
    if Length(Size.Text) > 0 then
        Check.Enabled := true;
end;

procedure TMaksim.SizeKeyPress(Sender: TObject; var Key: Char);
var
    Numerals: set of char;
    I, DotPos: Byte;
    IsFind: Boolean;
begin
    Savetofile.Enabled := false;
    Numerals := ['0'..'9', #8];
    with Sender as TEdit do
    begin
        if (Key = #13) and (Get.Enabled) then
            GetClick(Sender);
        if not (Key in Numerals) then
            Key := #0;
        if (Length(Text) = 1) and (Key <> #8) then
            Key := #0;
        if (Length(Text) = 0) and (Key = '0') then
            Key := #0;
    end;
end;

procedure TMaksim.ExitClick(Sender: TObject);
begin
    Close;
end;

procedure TMaksim.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
    ButtonSelected: Byte;
begin
    ButtonSelected := MessageDlg('Are you sure you want to exit?', mtConfirmation, [mbYes,mbNo], 0);
    if ButtonSelected <> mrYes then
        CanClose := False;
end;

procedure TMaksim.FormCreate(Sender: TObject);
begin
    Savetofile.Enabled := false;
    SG.Enabled := false;
    Get.Enabled := false;
    Check.Enabled := false;
end;

procedure TMaksim.OpenfileClick(Sender: TObject);
var
   InputFile: TextFile;
   Temp, i, j: integer;
begin
   Size.Clear;
   if Open.Execute then
   begin
      try
         AssignFile(InputFile, Open.FileName);
         Reset(InputFile);
         if SeekEof(InputFile) then
         begin
            MessageDlg('This file is empty. Try again.', mtError, [mbRetry], 0);
            CloseFile(InputFile);
         end
         else
         begin
            j := 0;
            repeat
                i := 0;
                repeat
                    Read(InputFile, Temp);
                    SG.Cells[i,j] := IntToStr(Temp);
                    Inc(i);
                until EoLn(InputFile);
                Readln(InputFile);
                Inc(j);
            until EoF(InputFile);
            Size.Text := IntToStr(i);
            CheckClick(Sender);
            GetClick(Sender);
            CloseFile(InputFile);
         end;
      except
         MessageDlg('Check entered data. Try again.', mtError, [mbRetry], 0);
         CloseFile(InputFile);
      end;
   end;
end;

function CheckFileName(MyFile: string): string;
var
   i: byte;
   IsCorrect: boolean;
begin
   IsCorrect := false;
   i := 1;
   while  not IsCorrect and (i <= length(MyFile)) do
   begin
      if MyFile[i] = '.' then
         IsCorrect := true;
      inc(i);
   end;
   if not IsCorrect then
      MyFile := MyFile + '.txt';
   CheckFileName := MyFile;
end;

procedure TMaksim.SavetofileClick(Sender: TObject);
var
    OutputFile: TextFile;
    MyFile: string;
    ButtonSelected: byte;
    i, j: Integer;
begin
    if Save.Execute then
    begin
        MyFile := Save.FileName;
        MyFile := CheckFileName(MyFile);
        if FileExists(MyFile) then
        begin
            ButtonSelected := MessageDlg('Do you want to rewrite the file?', mtConfirmation, [mbYes,mbNo], 0);
            if ButtonSelected = mrYes then
            begin
                AssignFile(OutputFile, MyFile);
                Rewrite(OutputFile);
                for i := 0 to StrToInt(Size.Text) - 1 do
                begin
                    for j := 0 to StrToInt(Size.Text) - 1 do
                        Write(OutputFile, SGR.Cells[j,i] + '   ');
                    Writeln(OutputFile);
                end;
                CloseFile(OutputFile);
            end
            else
                GetClick(Sender);
        end
        else
        begin
            AssignFile(OutputFile, MyFile);
            Rewrite(OutputFile);
            for i := 0 to StrToInt(Size.Text) - 1 do
                begin
                    for j := 0 to StrToInt(Size.Text) - 1 do
                        Write(OutputFile, SGR.Cells[j,i] + '   ');
                    Writeln(OutputFile);
                end;
            CloseFile(OutputFile);
        end;
    end;
end;

procedure TMaksim.SGKeyPress(Sender: TObject; var Key: Char);
var
    Numerals: set of char;
begin
    Numerals := ['0'..'9', #8, '-'];
    if not (Key in Numerals) then
        Key := #0;
    if (Length(SG.Cells[SG.Col, SG.Row]) = 2) and (Key <> #8) then
        Key := #0;
    if (SG.Cells[SG.Col, SG.Row] = '0') and (Key <> #8) then
        Key := #0;
end;

end.
