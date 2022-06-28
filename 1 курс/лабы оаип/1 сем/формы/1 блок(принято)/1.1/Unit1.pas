unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus;

type
  TMaksim = class(TForm)
    Text: TLabel;
    Menu: TMainMenu;
    File1: TMenuItem;
    About: TMenuItem;
    Openfile: TMenuItem;
    Savetofile: TMenuItem;
    Exit: TMenuItem;
    Info: TMenuItem;
    Developer: TMenuItem;
    Day: TEdit;
    Get: TButton;
    Result: TLabel;
    Open: TOpenDialog;
    Save: TSaveDialog;
    N1: TMenuItem;
    PopupMenu: TPopupMenu;
    procedure ExitClick(Sender: TObject);
    procedure InfoClick(Sender: TObject);
    procedure DeveloperClick(Sender: TObject);
    procedure DayChange(Sender: TObject);
    procedure GetClick(Sender: TObject);
    procedure OpenfileClick(Sender: TObject);
    procedure SavetofileClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DayKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Maksim: TMaksim;

implementation

{$R *.dfm}

procedure TMaksim.DeveloperClick(Sender: TObject);
begin
    MessageDlg('Developer: Maksim Gladkiy', mtInformation, [mbOk], 0);
end;

procedure TMaksim.InfoClick(Sender: TObject);
begin
    MessageDlg('This program defines the day of week by entering numbers 1..7', mtInformation, [mbOk], 0);
end;

procedure TMaksim.GetClick(Sender: TObject);
var
    Number: Byte;
begin
    Number := StrToInt(Day.Text);
    case Number of
        1:Result.Caption := 'This day is Monday';
        2:Result.Caption := 'This day is Tuesday';
        3:Result.Caption := 'This day is Wednesday';
        4:Result.Caption := 'This day is Thursday';
        5:Result.Caption := 'This day is Friday';
        6:Result.Caption := 'This day is Saturday';
        7:Result.Caption := 'This day is Sunday';
    end;
    Savetofile.Enabled := true;
end;

procedure TMaksim.DayChange(Sender: TObject);
begin
    Result.Caption := '';
    if (Length(Day.Text) > 0) then
    begin
        Get.Enabled := true;
        if (StrToInt(Day.Text) > 7) then
        begin
            ShowMessage('Error. The number, you have entered, is too high.');
            Get.Enabled := false;
            Day.Clear;
        end;
    end
    else
        Get.Enabled := false;
end;

procedure TMaksim.DayKeyPress(Sender: TObject; var Key: Char);
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
        if (Length(Text) = 3) and (Key <> #8) then
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
end;

procedure TMaksim.OpenfileClick(Sender: TObject);
var
    inputFile: TextFile;
    Temp: double;
begin
    Day.Clear;
    Result.Caption := '';
    if Open.Execute then
    begin
        try
            AssignFile(inputFile, Open.FileName);
            Reset(inputFile);
            if SeekEof(inputFile) then
            begin
                MessageDlg('This file is empty. Try again.', mtError, [mbRetry], 0);
                Day.Clear;
                CloseFile(inputFile);
            end
            else
            begin
                ReadLn(inputFile, Temp);
                Day.Text := FloatToStr(Temp);
                DayChange(Sender);
                CloseFile(inputFile);
            end;
        except
            MessageDlg('Check entered data. Try again.', mtError, [mbRetry], 0);
            Day.Clear;
            CloseFile(inputFile);
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
            Writeln(OutputFile, result.Caption);
            CloseFile(OutputFile);
         end
         else
            DayChange(Sender);
      end
      else
      begin
         AssignFile(OutputFile, MyFile);
         Rewrite(OutputFile);
         WriteLn(OutputFile, result.Caption);
         CloseFile(OutputFile);
      end;
   end;
end;

end.
