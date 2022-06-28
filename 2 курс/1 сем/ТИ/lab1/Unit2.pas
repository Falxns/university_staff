unit Unit2;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
   TCipher = class(TForm)
      Label1: TLabel;
      CipherKey: TEdit;
      Encrypt: TButton;
      OpenF: TButton;
      OpenFile: TOpenDialog;
      SaveFile: TSaveDialog;
      Decrypt: TButton;
      TC1: TMemo;
      TC2: TMemo;
      SaveF: TButton;
    Label2: TLabel;
    Label3: TLabel;
      procedure EncryptClick(Sender: TObject);
      procedure OpenFClick(Sender: TObject);
      procedure CipherKeyChange(Sender: TObject);
      procedure decryptClick(Sender: TObject);
      procedure SaveFClick(Sender: TObject);
      procedure FirstCipherEncrypt;
      procedure SecondCipherEncrypt;
      procedure ThirdCipherEncrypt;
      procedure FirstCipherDecrypt;
      procedure SecondCipherDecrypt;
      procedure ThirdCipherDecrypt;
      function EnglishLine(St: AnsiString): AnsiString;
      function RussianLine(St: AnsiString): AnsiString;
      function NumberLine(St: String): String;

   private
      Line, EncryptLine: AnsiString;
   public
    { Public declarations }
   end;

var
   Cipher: TCipher;

implementation

{$R *.dfm}

uses
   Unit1;

const
   Alphabet: String = '�����Ũ��������������������������';
   AlCount = 33;

function TCipher.EnglishLine(St: AnsiString): AnsiString;
const
   EnglishSet: Set of Char =['A'..'Z','a'..'z'];
var
   i: Integer;
begin
   Result := '';
   for i := 1 to Length(St) do
      if St[i] in EnglishSet then
         Result := Result + St[i];
end;

function TCipher.NumberLine(St: string): String;
const
   NumSet: Set of Char = ['0'..'9'];
var
   i: Integer;
begin
   Result := '';
   for i := 1 to Length(St) do
      if St[i] in NumSet then
         Result := Result + St[i];
end;

function TCipher.RussianLine(St: AnsiString): AnsiString;
const
   RussianSet: Set of AnsiChar =['�'..'�','�'..'�','�','�'];
var
   i: Integer;
begin
   Result := '';
   for i := 1 to Length(St) do
      if St[i] in RussianSet then
         Result := Result + St[i];
end;

procedure TCipher.FirstCipherEncrypt;
var
   Num, Step, Temp, j, i: Integer;
begin
   Line := TC1.Text;
   Line := EnglishLine(Line);
   if Length(NumberLine(CipherKey.Text)) <> 0 then
   begin
      Num := StrToInt(NumberLine(CipherKey.Text));
      Temp := 0;
      Step := 2 * Num - 2;
      j := 0;
      while (j < Num) and (Step >= 0) do
      begin
         if Step = 0 then
            Step := 1;
         i := 1 + j;
         EncryptLine := EncryptLine + Line[i];
         while (((i + Step) <= Length(Line)) and ((i + Temp) <= Length(Line))) do
         begin
            i := i + Step;
            EncryptLine := EncryptLine + Line[i];
            if (Temp <> 0) and ((i + Temp) <= Length(Line)) then
            begin
               i := i + Temp;
               EncryptLine := EncryptLine + Line[i];
            end;
         end;
         Temp := Temp + 2;
         inc(j);
         Step := Step - 2;
         if (Step <= 0) then
            Step := 2 * Num - 2;
         if Temp = 2 * Num - 2 then
            Temp := 0;
      end;
      TC2.Text := EncryptLine;
      SaveF.Enabled := True;
   end
   else
      MessageDlg('� ����� ��� ���������� ��������, ��������� ����', mtInformation, mbOKCancel, 0);
end;

procedure TCipher.FirstCipherDecrypt;
var
   Num, Step, Temp, j, i, k: Integer;
begin
   Line := TC1.Text;
   Line := EnglishLine(Line);
   if Length(NumberLine(CipherKey.Text)) <> 0 then
   begin
      Num := StrToInt(NumberLine(CipherKey.Text));
      Temp := 0;
      Step := 2 * Num - 2;
      k := 1;
      j := 0;
      for i := 1 to Length(Line) do
         EncryptLine := EncryptLine + ' ';
      while (j < Num) and (Step >= 0) do
      begin
         if Step = 0 then
            Step := 1;
         i := 1 + j;
         EncryptLine[i] := Line[k];
         inc(k);
         while (((i + Step) <= Length(Line)) and ((i + Temp) <= Length(Line))) do
         begin
            i := i + Step;
            EncryptLine[i] := Line[k];
            inc(k);
            if (Temp <> 0) and ((i + Temp) <= Length(Line)) then
            begin
               i := i + Temp;
               EncryptLine[i] := Line[k];
               inc(k);
            end;
         end;
         inc(j);
         Temp := Temp + 2;
         Step := Step - 2;
         if (Step <= 0) then
            Step := 2 * Num - 2;
         if Temp = 2 * Num - 2 then
            Temp := 0;
      end;
      TC2.Text := EncryptLine;
      SaveF.Enabled := True;
   end
   else
      MessageDlg('� ����� ��� ���������� ��������, ��������� ����', mtInformation, mbOKCancel, 0);
end;

procedure TCipher.ThirdCipherDecrypt;
var
   i, j, ShiftCipher: Integer;
   Key: AnsiString;
begin
   Line := AnsiUpperCase(TC1.Text);
   Line := RussianLine(Line);
   Key := AnsiUpperCase(CipherKey.Text);
   Key := RussianLine(Key);
   if (Key <> '') then
   begin
      j := 1;
      for i := 1 to Length(Line) do
      begin
         ShiftCipher := (AlCount + 1 - Pos(Key[j], Alphabet) + Pos(Line[i], Alphabet)) mod AlCount;
         if ShiftCipher = 0 then
            EncryptLine := EncryptLine + Alphabet[AlCount]
         else
            EncryptLine := EncryptLine + Alphabet[ShiftCipher];
         Inc(j);
         if j > Length(Key) then
            j := 1;
      end;
      TC2.Text := EncryptLine;
      SaveF.Enabled := True;
   end
   else
      MessageDlg('� ����� ��� ���������� ��������, ��������� ����', mtInformation, mbOKCancel, 0);
end;

procedure TCipher.SecondCipherEncrypt;
var
   CKey: String;
   Min: Char;
   i, j, k, Num: Integer;
   CipherArr: array of Byte;
   BoolArr: array of Boolean;
begin
   Line := TC1.Text;
   Line := EnglishLine(Line);
   CKey := CipherKey.Text;
   CKey := EnglishLine(CKey);
   if (CKey <> '') then
   begin
      Num := Length(CKey);
      SetLength(BoolArr, Num);
      for i := 0 to Num - 1 do
         BoolArr[i] := False;
      SetLength(CipherArr, Num);
      for i := 1 to Num do
         CKey[i] := UpCase(CKey[i]);
      for k := 0 to Num - 1 do
      begin
         Min := #255;
         for i := 1 to Num do
         begin
            if (Min > CKey[i]) and not(BoolArr[i - 1]) then
               begin
                  Min := CKey[i];
                  j := i;
               end;
         end;
         CipherArr[j - 1] := k + 1;
         BoolArr[j - 1] := True;
      end;
      k := 1;
      j := 1;
      while (k <= Num) do
      begin
         if CipherArr[j - 1] = k then
         begin
            i := j;
            while i <= Length(Line) do
            begin
               EncryptLine := EncryptLine + Line[i];
               i := i + Num;
            end;
            inc(k);
            j := 0;
         end;
         inc(j);
      end;
      TC2.Text := EncryptLine;
      SaveF.Enabled := True;
   end
   else
      MessageDlg('� ����� ��� ���������� ��������, ��������� ����', mtInformation, mbOKCancel, 0);
end;

procedure TCipher.SecondCipherDecrypt;
var
   CKey: String;
   Min: Char;
   i, j, k, m, Num: Integer;
   CipherArr: array of Byte;
   BoolArr: array of Boolean;
begin
   Line := TC1.Text;
   Line := EnglishLine(Line);
   CKey := CipherKey.Text;
   CKey := EnglishLine(CKey);
   if (CKey <> '') then
   begin
      Num := Length(CKey);
      SetLength(BoolArr, Num);
      for i := 0 to Num - 1 do
         BoolArr[i] := False;
      SetLength(CipherArr, Num);
      for i := 1 to Num do
         CKey[i] := UpCase(CKey[i]);
      for k := 0 to Num - 1 do
      begin
         Min := #255;
         for i := 1 to Num do
         begin
            if (Min > CKey[i]) and not(BoolArr[i - 1]) then
               begin
                  Min := CKey[i];
                  j := i;
               end;
         end;
         CipherArr[j - 1] := k + 1;
         BoolArr[j-1] := True;
      end;
      for i := 1 to Length(Line) do
         EncryptLine := EncryptLine + ' ';
      k := 1;
      j := 1;
      m := 1;
      while (k <= Num) do
      begin
         if CipherArr[j - 1] = k then
         begin
            i := j;
            while i <= Length(Line) do
            begin
               EncryptLine[i] := Line[m];
               i := i + Num;
               inc(m);
            end;
            inc(k);
            j := 0;
         end;
         inc(j);
      end;
      TC2.Text := EncryptLine;
      SaveF.Enabled := True;
   end
   else
      MessageDlg('� ����� ��� ���������� ��������, ��������� ����', mtInformation, mbOKCancel, 0);
end;

procedure TCipher.ThirdCipherEncrypt;
var
   Key: AnsiString;
   i, j, ShiftCipher: Integer;
begin
   Line := AnsiUpperCase(TC1.Text);
   Line := RussianLine(Line);
   Key := AnsiUpperCase(CipherKey.Text);
   Key := RussianLine(Key);
   if (Key <> '') then
   begin
      j := 1;
      for i := 1 to Length(Line) do
      begin
         ShiftCipher := (Pos(Key[j], Alphabet) + Pos(Line[i], Alphabet) - 1) mod AlCount;
         if ShiftCipher = 0 then
            EncryptLine := EncryptLine + Alphabet[AlCount]
         else
            EncryptLine := EncryptLine + Alphabet[ShiftCipher];
         Inc(j);
         if j > Length(Key) then
            j := 1;
      end;
      TC2.Text := EncryptLine;
      SaveF.Enabled := True;
   end
   else
      MessageDlg('� ����� ��� ���������� ��������, ��������� ����', mtInformation, mbOKCancel, 0);
end;

function CheckFileName(MyFile: String): String;
var
   i: Byte;
   IsCorrect: Boolean;
begin
   IsCorrect := False;
   i := 1;
   while  not IsCorrect and (i <= Length(MyFile)) do
   begin
      if MyFile[i] = '.' then
         IsCorrect := True;
      Inc(i);
   end;
   if not IsCorrect then
      MyFile := MyFile + '.txt';
   CheckFileName := MyFile;
end;

procedure TCipher.SaveFClick(Sender: TObject);
begin
   if SaveFile.Execute then
   try
      TC2.Lines.SaveToFile(SaveFile.FileName);
   except

   end;
end;

procedure TCipher.EncryptClick(Sender: TObject);
begin
   case Unit1.Menu.CipherNum of
      1:
      FirstCipherEncrypt;
      2:
      SecondCipherEncrypt;
      3:
      ThirdCipherEncrypt;
   end;
   Line := '';
   EncryptLine := '';
end;

procedure TCipher.CipherKeyChange(Sender: TObject);
begin
   if Length(CipherKey.Text) > 0 then
   begin
      Encrypt.Enabled := True;
      Decrypt.Enabled := True;
   end
   else
   begin
      Encrypt.Enabled := False;
      Decrypt.Enabled := False;
   end;
end;

procedure TCipher.DecryptClick(Sender: TObject);
begin
   case Unit1.Menu.CipherNum of
      1:
      FirstCipherDecrypt;
      2:
      SecondCipherDecrypt;
      3:
      ThirdCipherDecrypt;
   end;
   Line := '';
   EncryptLine := '';
end;

procedure TCipher.OpenFClick(Sender: TObject);
var
   InputFile: TextFile;
   Temp: Char;
begin
   Line := '';
   EncryptLine := '';
   if OpenFile.Execute then
   begin
      try
         AssignFile(InputFile, OpenFile.FileName);
         Reset(InputFile);
         if SeekEof(InputFile) then
         begin
            MessageDlg('This file is empty. Try again.', mtError, [mbRetry], 0);
            CloseFile(InputFile);
         end
         else
         begin
            TC1.Lines.LoadFromFile(OpenFile.FileName);
            CipherKey.Enabled := True;
            CloseFile(InputFile);
         end;
      except
         MessageDlg('Check entered data. Try again.', mtError, [mbRetry], 0);
         CloseFile(InputFile);
      end;
   end;
end;

end.
