unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Vcl.Grids, Vcl.ExtCtrls;

type
    TArr = array of String[40];
    TSet = array of Set of Char;
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
    SGC: TStringGrid;
    Result: TLabel;
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
    i: Integer;
begin
    for i := 0 to SG.RowCount - 1  do
    begin
        SGC.Cells[0, i] := 'S' + IntToStr(i + 1);
    end;
end;

function Calc(var Arr: TArr; Siz: Integer): String;
var
    Sets: TSet;
    i, j, Num, Res: Byte;
    IsCorrect: Boolean;
    Answer: String[40];
begin
    SetLength(Sets, Siz + 1);
    for i := 0 to Siz do
    begin
        Sets[i] := [];
        for j := 1 to Length(Arr[i]) do
            Sets[i] := Sets[i] + [Arr[i][j]];
    end;
    Res := 0;
    i := 0;
    while (Res = 0)and(i <= Siz) do
    begin
        j := 0;
        IsCorrect := false;
        while (not IsCorrect)and(j <= Siz) do
        begin
            if i <> j then
                if Sets[i] <= Sets[j] then
                    IsCorrect := false
                else
                    IsCorrect := true;
            inc(j);
        end;
        if not IsCorrect then
            Res := i + 1;
        inc(i);
    end;
    if Res <> 0 then
    begin
        Str(Res, Answer);
        Calc := 'Sequence number is: ' + Answer + #13#10 + 'Set itself is: ' + Arr[Res - 1];
    end
    else
        Calc := 'There is no such set.';
end;

procedure TMaksim.GetClick(Sender: TObject);
var
    Arr: TArr;
    i, Siz: Integer;
    Empty: Boolean;
begin
    Empty := False;
    Savetofile.Enabled := True;
    Siz := StrToInt(Size.Text);
    SetLength(Arr, Siz);
    dec(Siz);
    for i := 0 to Siz do
    begin
        if (SG.Cells[0, i] = '') then
            Empty := true;
        Arr[i] := SG.Cells[0, i];
    end;
    if Empty then
        MessageDlg('Fill all the cells.', mtConfirmation, [mbOk], 0)
    else
        Result.Caption := Calc(Arr, Siz);
end;

procedure TMaksim.CheckClick(Sender: TObject);
var
    i: Integer;
begin
    if Length(Size.Text) > 0 then
        if (StrToInt(Size.Text) < 2) then
        begin
            ShowMessage('Error. It should be more than 1 set. Amount should be [2..9].');
            Size.Clear;
        end
        else
            if (StrToInt(Size.Text)> 10) then
            begin
                ShowMessage('Error. Amount should be [2..9].');
                Size.Clear;
            end
                else
                    begin
                        SG.Enabled := true;
                        SG.RowCount := StrToInt(Size.Text);
                        SGC.RowCount := StrToInt(Size.Text);
                        SetFRow(Sender);
                        Get.Enabled := true;
                    end;
end;

procedure TMaksim.SizeChange(Sender: TObject);
var
  i, j: Integer;
begin
    Get.Enabled := false;
    Check.Enabled := false;
    SG.Enabled := false;
    Result.Caption := '';
    if Length(Size.Text) > 0 then
        Check.Enabled := true
    else
        for i := 0 to SG.RowCount - 1 do
            SG.Cells[0, i] := '';
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
    SGC.Enabled := false;
    Get.Enabled := false;
    Check.Enabled := false;
    Result.Caption := '';
end;

procedure TMaksim.DeveloperClick(Sender: TObject);
begin
    MessageDlg('Developer: Maksim Gladkiy', mtInformation, [mbOk], 0);
end;

procedure TMaksim.InfoClick(Sender: TObject);
begin
    MessageDlg('This program finds a set that is a subset of all other sets. Number of sets [2..9]. Elements in set [1..40].', mtInformation, [mbOk], 0);
end;

procedure TMaksim.OpenfileClick(Sender: TObject);
var
   InputFile: TextFile;
   i, Sizei: integer;
   Temp: String;
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
            i := 0;
            repeat
                Readln(InputFile, Temp);
                SG.Cells[0, i] := Temp;
                Inc(i);
            until EoF(InputFile);
            if (i < 9) and (i > 0) then
            begin
                Size.Text := IntToStr(i);
                CheckClick(Sender);
                GetClick(Sender);
            end
            else
            begin
                Sizei := i;
                MessageDlg('Check entered data. Size should be [2..9].', mtError, [mbRetry], 0);
                for i := 0 to Sizei do
                    SG.Cells[0, i] := '';
            end;
            CloseFile(InputFile);
         end;
      except
         MessageDlg('Check entered data. Try again.', mtError, [mbRetry], 0);
         CloseFile(InputFile);
      end;
   end;
end;

procedure TMaksim.SavetofileClick(Sender: TObject);
var
    OutputFile: TextFile;
    MyFile: string;
    ButtonSelected: byte;
    i: Integer;
begin
    if Save.Execute then
    begin
        MyFile := Save.FileName;
        if FileExists(MyFile) then
        begin
            AssignFile(OutputFile, MyFile);
            ButtonSelected := MessageDlg('Do you want to rewrite the file?', mtConfirmation, [mbYes,mbNo], 0);
            if ButtonSelected = mrYes then
                Rewrite(OutputFile)
            else
            begin
                Append(OutputFile);
                Writeln(OutputFile);
            end;
            Write(OutputFile, Result.Caption);
            CloseFile(OutputFile);
        end;
    end;
end;

procedure TMaksim.SGKeyPress(Sender: TObject; var Key: Char);
begin
    Result.Caption := '';
    Savetofile.Enabled := false;
    with Sender as TStringGrid do
    begin
        if (Key = #13) and (Get.Enabled) then
            GetClick(Sender);
        if (Length(SG.Cells[SG.Col, SG.Row]) = 40) and (Key <> #8) then
            Key := #0;
    end;
end;

procedure TMaksim.SizeKeyPress(Sender: TObject; var Key: Char);
var
    Numerals: set of char;
begin
    Savetofile.Enabled := false;
    Numerals := ['0'..'9', #8];
    with Sender as TEdit do
    begin
        if (Key = #13) and (Check.Enabled) then
            CheckClick(Sender);
        if not (Key in Numerals) then
            Key := #0;
        if (Length(Text) = 1) and (Key <> #8) then
            Key := #0;
    end;
end;

end.
