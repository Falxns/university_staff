unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Vcl.Grids, Vcl.ExtCtrls;

type
    TArray = array of Integer;
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
    Result: TLabel;
    Label1: TLabel;
    Label2: TLabel;
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
    procedure SetFRow(Sender: TObject);
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

procedure TMaksim.SetFRow(Sender: TObject);
var
    I: Integer;
begin
    for I := 0 to SG.ColCount - 1  do
    begin
        SG.Cells[I, 0] := IntToStr(I + 1);
    end;
end;

procedure TMaksim.CheckClick(Sender: TObject);
var
    i: Integer;
begin
    if Length(Size.Text) > 0 then
        if (StrToInt(Size.Text) < 3) then
        begin
            ShowMessage('Error. It''s not polygon. Number should be bigger than 3.');
            Size.Clear;
        end
        else
            if (StrToInt(Size.Text) = 3) then
            begin
                ShowMessage('Triangle is always convex.');
                Size.Clear;
            end
            else
                if (StrToInt(Size.Text)> 10) then
                begin
                    ShowMessage('Error. Number should be smaller than 11');
                    Size.Clear;
                end
                else
                    begin
                        SG.Enabled := true;
                        SG.ColCount := StrToInt(Size.Text);
                        SetFRow(Sender);
                        Get.Enabled := true;
                    end;
end;

procedure TMaksim.DeveloperClick(Sender: TObject);
begin
    MessageDlg('Developer: Maksim Gladkiy', mtInformation, [mbOk], 0);
end;

procedure TMaksim.InfoClick(Sender: TObject);
begin
    MessageDlg('This program checks, if the polygon is convex by entering coordinates of it''s points consistently. Use number of sides from 4 to 10.', mtInformation, [mbOk], 0);
end;

function Calc(ArrX, ArrY: TArray): String;
var
    Num, i, FirstVectorX , FirstVectorY, SecondVectorX , SecondVectorY , Determinator: Integer;
    FirstCounter , SecondCounter : Byte;
    Answ: String;
begin
    Num := Length(ArrX) - 1;
    ArrX[Num] := ArrX[0];
    ArrY[Num] := ArrY[0];
    FirstCounter := 0;
    SecondCounter := 0;
    for i := 1 to Num - 1 do
    begin
        FirstVectorX := ArrX[i] - ArrX[i - 1];
        FirstVectorY := ArrY[i] - ArrY[i - 1];
        SecondVectorX := ArrX[i + 1] - ArrX[i];
        SecondVectorY := ArrY[i + 1] - ArrY[i];
        Determinator := FirstVectorX * SecondVectorY - FirstVectorY * SecondVectorX;
        if Determinator > 0 then
            inc(FirstCounter)
        else
            inc(SecondCounter);
    end;
    if ((FirstCounter > 0)and(SecondCounter = 0))or((FirstCounter = 0)and(SecondCounter > 0)) then
        Answ := 'Polygon is convex.'
    else
        Answ := 'Polygon is not convex.';
    Calc := Answ;
end;

procedure TMaksim.GetClick(Sender: TObject);
var
    Number: Integer;
    ArrX, ArrY: TArray;
    i, j, Siz: Integer;
    Empty: Boolean;
begin
    Empty := False;
    Savetofile.Enabled := True;
    Siz := StrToInt(Size.Text);
    SetLength(ArrX, Siz + 1);
    SetLength(ArrY, Siz + 1);
    for j := 1 to 2 do
    begin
        for i := 0 to Siz - 1 do
        begin
            if (SG.Cells[i,j] = '') then
            begin
                Empty := true;
                SG.Cells[i, j] := '0';
            end;
        end;
    end;
    for i := 0 to Siz - 1 do
    begin
        ArrX[i] := StrToInt(SG.Cells[i, 1]);
        ArrY[i] := StrToInt(SG.Cells[i, 2]);
    end;
    if Empty then
        MessageDlg('Empty cells replaced by zero''s', mtConfirmation, [mbOk], 0);
    Result.Caption := Calc(ArrX, ArrY);
end;

procedure TMaksim.SizeChange(Sender: TObject);
begin
    Result.Caption := '';
    Get.Enabled := false;
    Check.Enabled := false;
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
        if (Length(Text) = 2) and (Key <> #8) then
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
   Result.Caption := '';
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
            for j := 1 to 2 do
            begin
                i := 0;
                repeat
                    Read(InputFile, Temp);
                    SG.Cells[i, j] := IntToStr(Temp);
                    Inc(i);
                until EoLn(InputFile);
                Readln(InputFile);
            end;
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
            Writeln(OutputFile, Result.Caption);
            CloseFile(OutputFile);
         end
         else
            GetClick(Sender);
      end
      else
      begin
         AssignFile(OutputFile, MyFile);
         Rewrite(OutputFile);
         WriteLn(OutputFile, Result.Caption);
         CloseFile(OutputFile);
      end;
   end;
end;

procedure TMaksim.SGKeyPress(Sender: TObject; var Key: Char);
var
    Numerals: set of char;
begin
    Result.Caption := '';
    Numerals := ['0'..'9', #8, '-'];
    if not (Key in Numerals) then
        Key := #0;
    if (Length(SG.Cells[SG.Col, SG.Row]) = 2) and (Key <> #8) then
        Key := #0;
    if (SG.Cells[SG.Col, SG.Row] = '0') and (Key <> #8) then
        Key := #0;
end;

end.
