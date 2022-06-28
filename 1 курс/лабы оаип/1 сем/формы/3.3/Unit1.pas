unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Vcl.Grids, Vcl.ExtCtrls;

type
    TArray = array of Integer;
    TArrayCount = array of Integer;
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
    Label1: TLabel;
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
   for i := 0 to SG.ColCount - 1  do
   begin
      SG.Cells[i, 0] := 'A' + IntToStr(i + 1);
      SGR.Cells[i, 0] := 'A' + IntToStr(i + 1);
   end;
end;

procedure Calc(var Arr: TArray; Siz: Integer);
var
    i, j: Byte;
    ArrayofCounters: TArrayCount;
    BuffArray: TArray;
begin
    SetLength(ArrayofCounters, Siz + 1);
    SetLength(BuffArray, Siz + 1);
    for i := 0 to Siz do
        ArrayofCounters[i] := 1;
    for i := 0 to Siz - 1 do
        for j := i + 1 to Siz do
            if Arr[i] < Arr[j] then
                inc(ArrayofCounters[j])
            else
                inc(ArrayofCounters[i]);
    for i := 0 to Siz do
    begin
         j := ArrayofCounters[i] - 1;
         BuffArray[j] := Arr[i];
    end;
    Arr := BuffArray;
end;

procedure TMaksim.GetClick(Sender: TObject);
var
    Number: Integer;
    Arr: TArray;
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
        if (SG.Cells[i, 1] = '') then
        begin
            Empty := true;
            SG.Cells[i, 1] := '0';
        end;
        Arr[i] := StrToInt(SG.Cells[i, 1]);
    end;
    if Empty then
        MessageDlg('Empty cells replaced by zero''s', mtConfirmation, [mbOk], 0);
    Calc(Arr, Siz);
    for i := 0 to Siz do
        SGR.Cells[i, 1] := IntToStr(Arr[i]);
    SGR.Visible := true;
end;

procedure TMaksim.CheckClick(Sender: TObject);
var
    i: Integer;
begin
    if Length(Size.Text) > 0 then
        if (StrToInt(Size.Text) < 2) then
        begin
            ShowMessage('Error. It''s not array. Size should be [2..9].');
            Size.Clear;
        end
        else
            if (StrToInt(Size.Text)> 10) then
            begin
                ShowMessage('Error. Size should be [2..9].');
                Size.Clear;
            end
                else
                    begin
                        SG.Enabled := true;
                        SG.ColCount := StrToInt(Size.Text);
                        SGR.ColCount := StrToInt(Size.Text);
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
    SGR.Visible := false;
    SG.Enabled := false;
    if Length(Size.Text) > 0 then
        Check.Enabled := true
    else
        for i := 0 to SG.ColCount do
            SG.Cells[i, 1] := '';
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

procedure TMaksim.DeveloperClick(Sender: TObject);
begin
    MessageDlg('Developer: Maksim Gladkiy', mtInformation, [mbOk], 0);
end;

procedure TMaksim.InfoClick(Sender: TObject);
begin
    MessageDlg('This program sorts array by counting method.' + #13#10 + 'Size is [2..9]. Elements [-9..99].', mtInformation, [mbOk], 0);
end;

procedure TMaksim.OpenfileClick(Sender: TObject);
var
   InputFile: TextFile;
   Temp, i, Sizei: integer;
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
                Read(InputFile, Temp);
                SG.Cells[i,1] := IntToStr(Temp);
                Inc(i);
            until EoLn(InputFile);
            if (i < 10) and (i > 1) then
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
                    SG.Cells[i, 1] := '';
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
            for i := 0 to StrToInt(Size.Text) - 1 do
                Write(OutputFile, SGR.Cells[i, 1] + ' ');
            CloseFile(OutputFile);
        end;
    end;
end;

procedure TMaksim.SGKeyPress(Sender: TObject; var Key: Char);
var
    Numerals: set of char;
begin
    SGR.Visible := false;
    Numerals := ['0'..'9', #8, '-'];
    if not (Key in Numerals) then
        Key := #0;
    if (Length(SG.Cells[SG.Col, SG.Row]) = 2) and (Key <> #8) then
        Key := #0;
    if (SG.Cells[SG.Col, SG.Row] = '0') and (Key <> #8) then
        Key := #0;
end;

procedure TMaksim.SizeKeyPress(Sender: TObject; var Key: Char);
var
    Numerals: set of char;
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

end.
