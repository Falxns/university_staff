unit Unit31;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus;

type
  TTMaxim = class(TForm)
    MainMenu1: TMainMenu;
    PopupMenu1: TPopupMenu;
    Save: TSaveDialog;
    Open: TOpenDialog;
    N: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Strng: TEdit;
    Result: TLabel;
    Change: TButton;
    File1: TMenuItem;
    Openfile1: TMenuItem;
    Savetofile: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    About1: TMenuItem;
    Info: TMenuItem;
    Developer1: TMenuItem;
    procedure Developer1Click(Sender: TObject);
    procedure InfoClick(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure NKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure NChange(Sender: TObject);
    procedure StrngChange(Sender: TObject);
    procedure ChangeClick(Sender: TObject);
    procedure StrngKeyPress(Sender: TObject; var Key: Char);
    procedure Openfile1Click(Sender: TObject);
    procedure SavetofileClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TMaxim: TTMaxim;

implementation

{$R *.dfm}

procedure TTMaxim.ChangeClick(Sender: TObject);
var
    i, Num: Byte;
    Leng : Integer;
    MyString: String;
begin
    MyString := Strng.Text;
    Num := StrToInt(N.Text);
    Leng := Length(Strng.Text);
    if Num > Leng then
        for i := 1 to Num - Leng do
            Insert('.', MyString, 1)
    else
        Delete(MyString, 1, Leng - Num);
    Result.Caption := 'Changed string is: ' + MyString;
end;


procedure TTMaxim.Developer1Click(Sender: TObject);
begin
    MessageDlg('Developer: Maksim Gladkiy', mtInformation, [mbOk], 0);
end;

procedure TTMaxim.Exit1Click(Sender: TObject);
begin
    Close;
end;

procedure TTMaxim.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
    ButtonSelected: Byte;
begin
    ButtonSelected := MessageDlg('Are you sure you want to exit?', mtConfirmation, [mbYes,mbNo], 0);
    if ButtonSelected <> mrYes then
        CanClose := False;
end;

procedure TTMaxim.FormCreate(Sender: TObject);
begin
    Savetofile.Enabled := false;
    Strng.Enabled := false;
    Change.Enabled := false;
end;

procedure TTMaxim.InfoClick(Sender: TObject);
begin
    MessageDlg('This program converts the entered string into a string of length N as follows If length of the string is greater than N, then discard the first characters, if length of the string is less than N, then add points at the beginning.', mtInformation, [mbOk], 0);
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


procedure TTMaxim.NChange(Sender: TObject);
begin
    Result.Caption := '';
    Change.Enabled := false;
    Strng.Enabled := false;
    if Length(N.Text) > 0 then
        Strng.Enabled := true;
end;

procedure TTMaxim.NKeyPress(Sender: TObject; var Key: Char);
var
    Numerals: set of char;
begin
    Savetofile.Enabled := false;
    Numerals := ['0'..'9', #8];
    with Sender as TEdit do
    begin
        if (Key = #13) and (Change.Enabled) then
            ChangeClick(Sender);
        if not (Key in Numerals) then
            Key := #0;
        if (Length(Text) = 2) and (Key <> #8) then
            Key := #0;
        if (Length(Text) = 0) and (Key = '0') then
            Key := #0;
    end;
end;

procedure TTMaxim.Openfile1Click(Sender: TObject);
var
    InputFile: TextFile;
    Temp: double;
    Buf: String;
begin
    Strng.Clear;
    N.Clear;
    Result.Caption := '';
    if Open.Execute then
    begin
        try
            AssignFile(InputFile, Open.FileName);
            Reset(InputFile);
            if SeekEof(InputFile) then
            begin
                MessageDlg('This file is empty. Try again.', mtError, [mbRetry], 0);
                Strng.Clear;
                N.Clear;
                CloseFile(InputFile);
            end
            else
            begin
                ReadLn(inputFile, Temp);
                N.Text := FloatToStr(Temp);
                NChange(Sender);
                Read(inputFile, Buf);
                Strng.Text := Buf;
                StrngChange(Sender);
                CloseFile(InputFile);
            end;
        except
            MessageDlg('Check entered data. Try again.', mtError, [mbRetry], 0);
            Strng.Clear;
            N.Clear;
            CloseFile(InputFile);
        end;
    end;
end;

procedure TTMaxim.SavetofileClick(Sender: TObject);
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
            NChange(Sender);
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

procedure TTMaxim.StrngChange(Sender: TObject);
begin
    Result.Caption := '';
    Change.Enabled := false;
    if Length(N.Text) > 0 then
        Change.Enabled := true;
end;

procedure TTMaxim.StrngKeyPress(Sender: TObject; var Key: Char);
begin
    Savetofile.Enabled := false;
    with Sender as TEdit do
    begin
        if (Key = #13) and (Change.Enabled) then
            ChangeClick(Sender);
        if (Length(Text) = 40) and (Key <> #8) then
            Key := #0;
    end;
end;

end.
