unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls;

type
  TMaksim = class(TForm)
    Get: TButton;
    Save: TSaveDialog;
    Menu: TMainMenu;
    File1: TMenuItem;
    About1: TMenuItem;
    SavetoFile: TMenuItem;
    N1: TMenuItem;
    Exit: TMenuItem;
    Info: TMenuItem;
    Developer: TMenuItem;
    Text: TLabel;
    Result: TLabel;
    procedure SavetoFileClick(Sender: TObject);
    procedure ExitClick(Sender: TObject);
    procedure InfoClick(Sender: TObject);
    procedure DeveloperClick(Sender: TObject);
    procedure GetClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Maksim: TMaksim;

implementation

{$R *.dfm}

function CheckFileName(MyFile: string): string;
var
   i: byte;
   IsCorrect: boolean;
begin
   IsCorrect := false;
   i := 1;
   while  not IsCorrect and (i <= Length(MyFile)) do
   begin
      if MyFile[i] = '.' then
         IsCorrect := true;
      inc(i);
   end;
   if not IsCorrect then
      MyFile := MyFile + '.txt';
   CheckFileName := MyFile;
end;

procedure TMaksim.DeveloperClick(Sender: TObject);
begin
    MessageDlg('Developer: Maksim Gladkiy', mtInformation, [mbOk], 0);
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

procedure TMaksim.GetClick(Sender: TObject);
var
    Number, Prev, Step: Int64;
    Digit: Byte;
    Res : String;
begin
    Prev := 0;
    Digit := 2;
    Number := 2;
    Step := 1;
    repeat
        Step := Step * 10;
        Number := Number + Step * (Digit * 2 mod 10 + Prev);
        Prev := Digit * 2 div 10;
        Digit := Number div Step;
    until (Digit = 2) and (Prev = 0);
    Number := Number - Digit * Step;
    Str(Number, Res);
    Result.Caption := Res;
    Savetofile.Enabled := true;
end;

procedure TMaksim.InfoClick(Sender: TObject);
begin
    MessageDlg('This program searches for the smallest number, which, when you rearrange the last digit to the first one, is twice as large as the original.', mtInformation, [mbOk], 0);
end;

procedure TMaksim.SavetoFileClick(Sender: TObject);
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

end.
