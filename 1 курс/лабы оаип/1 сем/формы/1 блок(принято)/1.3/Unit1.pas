unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus;

type
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
    M: TEdit;
    Get: TButton;
    Result: TLabel;
    Open: TOpenDialog;
    Save: TSaveDialog;
    N1: TMenuItem;
    PopupMenu: TPopupMenu;
    TextTwo: TLabel;
    N: TEdit;
    procedure ExitClick(Sender: TObject);
    procedure InfoClick(Sender: TObject);
    procedure DeveloperClick(Sender: TObject);
    procedure MChange(Sender: TObject);
    procedure GetClick(Sender: TObject);
    procedure OpenfileClick(Sender: TObject);
    procedure SavetofileClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure MKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure NChange(Sender: TObject);
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
    MessageDlg('This program looks for the smallest K for which M to the power K greater than N. M should be greater than 1, N should be greater than M', mtInformation, [mbOk], 0);
end;

procedure TMaksim.GetClick(Sender: TObject);
var
    NumM, NumM0, NumN, Power: Integer;
    Answer: String;
begin
    if Length(M.Text)>0 then
        if (StrToInt(M.Text) < 2) then
        begin
            ShowMessage('Error. M should be bigger than 1.');
            M.Clear;
            N.Clear;
            Get.Enabled := false;
        end
        else
            if Length(N.Text)>0 then
                if (StrToInt(N.Text) < StrToInt(M.Text)) then
                begin
                    ShowMessage('Error. N should be bigger than M.');
                    Get.Enabled := false;
                    N.Clear;
                end
                else
                begin
                    NumM := StrToInt(M.Text);
                    NumN := StrToInt(N.Text);
                    NumM0 := NumM;
                    Power := 1;
                    while NumM < NumN do
                    begin
                        inc(Power);
                        NumM := NumM * NumM0;
                    end;
                    Str(Power, Answer);
                    Answer := 'The smallest K is: ' + Answer;
                    Result.Caption := Answer;
                    Savetofile.Enabled := true;
                end;
end;

procedure TMaksim.MChange(Sender: TObject);
begin
    Result.Caption := '';
    Get.Enabled := false;
    N.Enabled := false;
    if Length(M.Text) > 0 then
        N.Enabled := true;
end;

procedure TMaksim.MKeyPress(Sender: TObject; var Key: Char);
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

procedure TMaksim.NChange(Sender: TObject);
begin
    Get.Enabled := false;
    Result.Caption := '';
    if (Length(N.Text) > 0) then
        Get.Enabled := true;
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
    N.Enabled := false;
    Get.Enabled := false;
end;

procedure TMaksim.OpenfileClick(Sender: TObject);
var
    InputFile: TextFile;
    Temp: double;
begin
    M.Clear;
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
                M.Clear;
                N.Clear;
                CloseFile(InputFile);
            end
            else
            begin
                ReadLn(inputFile, Temp);
                M.Text := FloatToStr(Temp);
                MChange(Sender);
                Read(inputFile, Temp);
                N.Text := FloatToStr(Temp);
                NChange(Sender);
                CloseFile(InputFile);
            end;
        except
            MessageDlg('Check entered data. Try again.', mtError, [mbRetry], 0);
            M.Clear;
            N.Clear;
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
            MChange(Sender);
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
