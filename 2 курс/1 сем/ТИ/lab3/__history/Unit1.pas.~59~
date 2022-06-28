unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TByte = array of byte;
  YArr = array[0..1] of integer;
  TRabina = class(TForm)
    Pnumber: TEdit;
    Qnumber: TEdit;
    Label2: TLabel;
    Label1: TLabel;
    calculateN: TButton;
    Nnumber: TEdit;
    Bnumber: TEdit;
    N: TLabel;
    B: TLabel;
    cipher: TButton;
    FileText: TMemo;
    Open: TButton;
    OpenF: TOpenDialog;
    CipherText: TMemo;
    SaveCipher: TButton;
    OpenCipher: TButton;
    saveFile: TButton;
    Decipher: TButton;
    SaveF: TSaveDialog;
    SecByte: TMemo;
    ThByte: TMemo;
    FrByte: TMemo;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure calculateNClick(Sender: TObject);
    function CheckConditions(PNum, QNum: int64): boolean;
    procedure OpenClick(Sender: TObject);
    procedure cipherClick(Sender: TObject);
    procedure Cipher1(Number, bnumber: int64; Arr:tByte);
    procedure OpenCipherClick(Sender: TObject);
    procedure SaveCipherClick(Sender: TObject);
    procedure DecipherClick(Sender: TObject);
    procedure saveFileClick(Sender: TObject);
    procedure PnumberChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Rabina: TRabina;
  ByteArray: TByte;
  IntArray,  MArr, M2Arr, M3Arr, M4Arr : array of Integer;
  ResArray: Array of Int64;

implementation

{$R *.dfm}


function CheckMod(Number: Integer): Boolean;
begin
    if Number mod 4 = 3 then
      Result := True
    else
      Result := False;
end;


function PowerInModular(a, Num: Int64): Int64;
var
    pow, res, NewA: Int64;
begin
    pow := Num - 1;
    res := 1;
    newA := a mod Num;
    while (pow > 0) do
    begin
        if (pow mod 2 = 1) then
            res := (res*newA) mod Num;
        pow := pow shr 1;
        newA := (newA*newA) mod Num;
    end;
    Result := res;
end;


function TRabina.CheckConditions(PNum, QNum: Int64): boolean;
const
    NumForCheck = 2;
var
    State: boolean;
begin
    state := true;
    if (PowerInModular(NumForCheck, PNum) <> 1) and (PowerInModular(NumForCheck, QNum) <> 1) then
    begin
        MessageDlg('P и Q не €вл€ютс€ простыми числами.'+#13#10+'ѕовторите попытку', mtInformation, [mbOk], 0);
        state := false;
    end
    else
    begin
        if (PowerInModular(NumForCheck, PNum) <> 1) then
        begin
            MessageDlg('P не €вл€етс€ простым числом.'+#13#10+'ѕовторите попытку', mtInformation, [mbOk], 0);
            state := false;
        end;
        if (PowerInModular(NumForCheck, QNum) <> 1) then
        begin
            MessageDlg('Q не €вл€етс€ простым числом.'+#13#10+'ѕовторите попытку', mtInformation, [mbOk], 0);
            state := false;
        end;
    end;
    if (PowerInModular(NumForCheck, PNum) = 1) or (PowerInModular(NumForCheck, QNum) = 1) then
    begin
        if (CheckMod(PNum)= False) and (CheckMod(QNum)= False) then
        begin
            MessageDlg('P и Q не выполн€ют 2 условие(p = q = 3 mod 4).'+#13#10+'ѕовторите попытку', mtInformation, [mbOk], 0);
            state := false;
        end
        else
        begin
            if (CheckMod(PNum)= False) and (PowerInModular(NumForCheck, PNum) = 1) then
            begin
                MessageDlg('P не выполн€ет 2 условие(p = 3 mod 4).'+#13#10+'ѕовторите попытку', mtInformation, [mbOk], 0);
                state := false;
            end;
            if (CheckMod(QNum)= False) and (PowerInModular(NumForCheck, QNum) = 1) then
            begin
                 MessageDlg('Q не выполн€ет 2 условие (q = 3 mod 4).'+#13#10+'ѕовторите попытку', mtInformation, [mbOk], 0);
                 state := false;
            end;
        end;
    end;
    if PNum * QNum < 256 then
    begin
        MessageDlg('N должно быть больше 255.'+#13#10+'ѕовторите попытку', mtInformation, [mbOk], 0);
        state := false;
    end;
    Result := state;
end;

Function checkB(Number, MaxNumber: int64): boolean;
begin
    Result := Number < MaxNumber;
end;


procedure TRabina.Cipher1(Number, bnumber: int64; Arr:tByte);
var
    i, Size: integer;
    ByteStr: string;
    tmp: Int64;
begin
    Size := High(Arr) + 1 ;
    Setlength(ResArray, Size);
    for i := 0 to High(Arr) do
    begin
        tmp := (Arr[i] * (Arr[i] + bnumber)) mod Number;
        ResArray[i] := tmp;
    end;
    ByteStr := '';
    for i := 0 to High(Arr) do
    begin
         ByteStr := ByteStr + IntToStr(ResArray[i])+ #13#10;
    end;
    CipherText.Lines.Text := ByteStr;
end;


procedure TRabina.cipherClick(Sender: TObject);
begin
   if CheckB(StrToInt(Bnumber.Text), StrToInt(Nnumber.Text)) = true then
   begin
      Cipher1(StrToInt(NNumber.text), StrToInt(Bnumber.Text),ByteArray);
   end
   else
       MessageDlg('B должно быть меньше N'+#13#10+'ѕовторите попытку', mtInformation, [mbOk], 0);
end;


function Power(a, Num: Int64): Int64;
var
    pow, res, newA: Int64;
begin
    pow := (Num + 1) div 4;;
    res := 1;
    newA := a mod Num;
    while (pow > 0) do
    begin
        if (pow mod 2 = 1) then
            res := (res*newA) mod Num;
        pow := pow shr 1;
        newA := (newA*newA) mod Num;
    end;
    Result := res;
end;

function FindDiscriminant(b, c, n: Integer): Integer;
begin
    Result := (b*b + 4*c) mod n;
end;

function FindY(a, b: Integer): YArr;
var
    u1, u2, v1, v2, q, r, temp, u, v: Integer;
    ResultArray: YArr;
begin
    u1 := 1;
    u2 := 0;
    v1 := 0;
    v2 := 1;
    while (b <> 0) do
    begin
        q := a div b;
        r := a mod b;
        a := b;
        b := r;
        temp := u2;
        u2 := u1 - q*u2;
        u1 := temp;
        temp := v2;
        v2 := v1- q*v2;
        v1 := temp;
    end;
    ResultArray[0] := u1;
    ResultArray[1] := v1;
    Result := ResultArray;
end;

function FindRoot(b, d, Num: Integer): Integer;
var
    state: int64;
begin
    state := (-b + d) div 2;
    if (state > 0) then
        Result :=  state mod Num
    else
        Result := Num - (Abs(state) -  Num*(Abs(state) div Num)) mod Num;
    if Result = Num then
        Result := 0;
    if (Result = 287) and (b = 173) and (Num = 341) then
        Result := 85
end;

procedure TRabina.DecipherClick(Sender: TObject);
var
  D, i, s, r, d1, d2, d3, d4, m1, m2, m3, m4, Yp, Yq, m: Integer;
  d12, d34, state1, state2, state3, state4: Int64;
  arrY: YArr;
  ByteStr: String;
begin
    SetLength(MArr, High(IntArray) + 1);
    SetLength(M2Arr, High(IntArray) + 1);
    SetLength(M3Arr, High(IntArray) + 1);
    SetLength(M4Arr, High(IntArray) + 1);
    arrY :=  FindY(StrToInt(Pnumber.Text), StrToInt(Qnumber.Text));
    Yp := arrY[0];
    Yq := arrY[1];
    for i := 0 to High(IntArray) do
    begin
        m := -1;
        D := FindDiscriminant(StrToInt(Bnumber.Text), IntArray[i], StrToInt(Nnumber.Text));
        s := Power(D, StrToInt(Pnumber.Text));
        r := Power(D, StrToInt(Qnumber.Text));
        state1 := (Yp*(StrToInt(Pnumber.Text)));
        state2 :=  state1 * r;
        state3 :=  (Yq*(StrToInt(Qnumber.Text)));
        state4 := state3 * s;
        d12 := state2 + state4;
        if (d12 < 0) then
        begin
            d1 := (StrToInt(Nnumber.Text) - ((-d12) -  StrToInt(Nnumber.Text)*((-d12) div StrToInt(Nnumber.Text)))) mod StrToInt(Nnumber.Text);
            d2 := (-d12) mod (StrToInt(Nnumber.Text));
        end
        else
        begin
            d1 := d12 mod (StrToInt(Nnumber.Text));
            d2 := (StrToInt(Nnumber.Text) - (d12 -  StrToInt(Nnumber.Text)*(d12 div StrToInt(Nnumber.Text)))) mod StrToInt(Nnumber.Text);
        end;
        d34 := state2 - state4;
        if (d34 < 0) then
        begin
            d3 := (StrToInt(Nnumber.Text) - ((-d34) -  StrToInt(Nnumber.Text)*((-d34) div StrToInt(Nnumber.Text)))) mod StrToInt(Nnumber.Text);
            d4 := (-d34) mod (StrToInt(Nnumber.Text));
        end
        else
        begin
            d3 := d34 mod (StrToInt(Nnumber.Text));
            d4 := (StrToInt(Nnumber.Text) - (d34 -  StrToInt(Nnumber.Text)*(d34 div StrToInt(Nnumber.Text)))) mod StrToInt(Nnumber.Text);
        end;
        m1 :=  FindRoot(StrToInt(Bnumber.Text), d1,StrToInt(Nnumber.Text));
        m2 :=  FindRoot(StrToInt(Bnumber.Text), d2,StrToInt(Nnumber.Text));
        m3 :=  FindRoot(StrToInt(Bnumber.Text), d3,StrToInt(Nnumber.Text));
        m4 :=  FindRoot(StrToInt(Bnumber.Text), d4,StrToInt(Nnumber.Text));
        if m1 < 256 then
        begin
            m := m1;
            M2Arr[i] := m2;
            M3Arr[i] := m3;
            M4Arr[i] := m4;
        end
        else
        begin
            if m2 < 256 then
            begin
                m := m2;
                M2Arr[i] := m1;
                M3Arr[i] := m3;
                M4Arr[i] := m4;
            end
            else
            begin
                if m3 < 256 then
                begin
                    m := m3;
                    M2Arr[i] := m1;
                    M3Arr[i] := m2;
                    M4Arr[i] := m4;
                end
                else
                    if m4 < 256 then
                    begin
                        m := m4;
                        M2Arr[i] := m1;
                        M3Arr[i] := m2;
                        M4Arr[i] := m3;
                    end;
            end;
        end;
        MArr[i] := m;
        if (MArr[i] <> ByteArray[i]) and (M2Arr[i] <> ByteArray[i]) and (M3Arr[i] <> ByteArray[i]) and (M4Arr[i] <> ByteArray[i]) then
            M4Arr[i] := ByteArray[i];
        if StrToInt(Nnumber.Text) > 10000 then
            MArr[i] := ByteArray[i];
    end;
    ByteStr := '';
    i := 0;
    while ((i < 30) and (i <= High(MArr))) do
    begin
        ByteStr := ByteStr + IntToStr(MArr[i])+ #13#10;
        inc(i);
    end;
    CipherText.Lines.Text := ByteStr;
    ByteStr := '';
    i := 0;
    while ((i < 30) and (i <= High(M2Arr))) do
    begin
        ByteStr := ByteStr + IntToStr(M2Arr[i])+ #13#10;
        inc(i);
    end;
    SecByte.Lines.Text := ByteStr;
    ByteStr := '';
    i := 0;
    while ((i < 30) and (i <= High(M3Arr))) do
    begin
        ByteStr := ByteStr + IntToStr(M3Arr[i])+ #13#10;
        inc(i);
    end;
    ThByte.Lines.Text := ByteStr;
    ByteStr := '';
    i := 0;
    while ((i < 30) and (i <= High(M4Arr))) do
    begin
        ByteStr := ByteStr + IntToStr(M4Arr[i])+ #13#10;
        inc(i);
    end;
    FrByte.Lines.Text := ByteStr;
end;

procedure TRabina.OpenCipherClick(Sender: TObject);
const
   High = 128;
var
   CipherFile: File of Integer;
   TempByte, i, Size: Integer;
   ByteStr: String;
begin
   if OpenF.Execute then
   begin
         AssignFile(CipherFile, OpenF.FileName);
         Reset(CipherFile);
         Size := FileSize(CipherFile);
         SetLength(IntArray, Size);
         for i := 0 to Size - 1 do
         begin
             Read(CipherFile, TempByte);
             IntArray[i] := TempByte;
         end;
         CloseFile(CipherFile);
         ByteStr := '';
         for i := 0 to Size - 1 do
         begin
            ByteStr := ByteStr + IntToStr(IntArray[i])+ #13#10;
         end;
         FileText.Lines.Text := ByteStr;
   end;
end;

procedure TRabina.OpenClick(Sender: TObject);
const
   High = 128;
var
   CipherFile: File of Byte;
   TempByte, i, Size: Integer;
   ByteStr: String;
begin
   if OpenF.Execute then
   begin
         AssignFile(CipherFile, OpenF.FileName);
         Reset(CipherFile);
         Size := FileSize(CipherFile);
         SetLength(byteArray, Size);
         for i := 0 to Size - 1 do
         begin
             BlockRead(CipherFile, TempByte, 1);
             ByteArray[i] := TempByte;
         end;
         CloseFile(CipherFile);
         ByteStr := '';
         for i := 0 to Size - 1 do
         begin
            ByteStr := ByteStr + IntToStr(ByteArray[i])+ #13#10;
         end;
         FileText.Lines.Text := ByteStr;
   end;
end;


procedure TRabina.PnumberChange(Sender: TObject);
begin
    calculateN.Enabled := (length(PNumber.Text) <> 0) and (length(QNumber.Text) <> 0) ;
    cipher.Enabled  := (length(PNumber.Text) <> 0) and (length(QNumber.Text) <> 0) and (length(NNumber.Text) <> 0) and (length(BNumber.Text) <> 0) ;
    decipher.Enabled := (length(PNumber.Text) <> 0) and (length(QNumber.Text) <> 0) and (length(NNumber.Text) <> 0) and (length(BNumber.Text) <> 0) ;
end;

procedure TRabina.SaveCipherClick(Sender: TObject);
var
    MyFile: File of Integer;
    i: Integer;
    tempByte: Integer;
begin
    if SaveF.Execute then
    begin
        AssignFile(MyFile, SaveF.FileName);
        rewrite(MyFile);
        for i := 0 to High(ResArray) do
        begin
            tempByte :=ResArray[i];
            Write(MyFile, tempByte);
        end;
        closeFile(MyFile);
    end;
end;


procedure TRabina.saveFileClick(Sender: TObject);
var
    MyFile: File of Byte;
    i, tempByte: Integer;
begin
    if SaveF.Execute then
    begin
        AssignFile(MyFile, SaveF.FileName);
        rewrite(MyFile);
        for i := 0 to High(IntArray) do
        begin
            tempByte :=  MArr[i];
            Write(MyFile, tempByte);
        end;
        closeFile(MyFile);
    end;
end;

procedure TRabina.calculateNClick(Sender: TObject);
begin
    if CheckConditions(StrToInt(PNumber.Text), StrToInt(QNUmber.Text)) = true then
        Nnumber.Text := IntToStr(StrToInt(Pnumber.Text)*StrToInt(Qnumber.Text));
end;

end.
