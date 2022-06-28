unit MyUnit;

interface

uses
   FMX.Forms,FMX.StdCtrls, FMX.Objects, System.UITypes,System.SysUtils, FMX.Graphics, System.Types;

type
   PTree = ^Tree;

   Tree = record
      Num, LeftCount, RightCount: Byte;
      Up: PTree;
      Left: PTree;
      Right: PTree;
   end;

   ArrV = array [1..63] of Byte;

var
   ArrC: array [1..63] of TCircle;
   Root, PTemp: PTree;
   Count, Step, Buffer: Integer;
   Temp: Single;
   Element, k: Byte;
   IsRight: Boolean;
   Values: ArrV;

const
   Wid = 25;
   down = 40;

   procedure AddL;
   procedure Start(Width: Single);
   procedure CirDraw(Form: TForm);
   procedure AddR;
   procedure DrawL(Form: TForm);
   function Find: ArrV;
   function Up: Byte;
   function Left: Byte;
   function Right: Byte;
   function CheckLeft: Boolean;
   function CheckRight: Boolean;
   function CheckDown: Boolean;

implementation

procedure AddR;
begin
   New(PTemp^.Right);
   PTemp^.Right^.Up := PTemp;
   PTemp := PTemp^.Right;
   IsRight := True;
end;

function CheckLeft: Boolean;
begin
   Result := False;
   if PTemp^.Left = nil then
      Result := True;
end;

function CheckRight: Boolean;
begin
   Result := False;
   if PTemp^.Right = nil then
      Result := True;
end;

function CheckDown: Boolean;
begin
   Result := True;
   if (Buffer > (5 * Down)) then
      Result := False;
end;

procedure DrawL(Form: TForm);
var
   Brush: TStrokeBrush;
begin
   Brush := TStrokeBrush.Create(TBrushKind.Solid, TAlphaColorRec.Black);
   Brush.Thickness := 1;
   with Form, Canvas do
   begin
      BeginScene;
      if not (IsRight) then
         DrawLine(PointF(step + Count * 2 + wid/2, Buffer - 2*down + wid),PointF(Step + wid/2, Buffer - Down),1, Brush)
      else
         DrawLine(PointF(step - Count * 2 + wid/2, Buffer - 2*down + wid),PointF(Step + wid/2, Buffer - Down),1, Brush);
      EndScene;
   end;
end;

function Up: Byte;
   var
   i: Byte;
begin
   i := PTemp^.Num;
   if PTemp^.Up <> nil then
   begin
      PTemp := PTemp^.Up;
      i := PTemp^.Num;
      Count := Count * 2;
      Buffer := Buffer - Down;
      Step := Trunc(ArrC[i].Position.X);
   end;
   Result := i;
end;

function Left: Byte;
var
   i: Byte;
begin
   i := PTemp^.Num;
   if PTemp^.Left <> nil then
   begin
      PTemp := PTemp^.Left;
      i := PTemp^.Num;
      Count := Count div 2;
      Buffer := Buffer + Down;
      Step := Trunc(ArrC[i].Position.X);
   end;
   Result := i;
end;

function Right: Byte;
var
   i: Byte;
begin
   i := PTemp^.Num;
   if PTemp^.Right <> nil then
   begin
      PTemp := PTemp^.Right;
      i := PTemp^.Num;
      Count := Count div 2;
      Buffer := Buffer + Down;
      Step := Trunc(ArrC[i].Position.X);
   end;
   Result := i;
end;

procedure AddL;
begin
   New(PTemp^.Left);
   PTemp^.Left^.Up := PTemp;
   PTemp := PTemp^.Left;
   IsRight := False;
end;

procedure Start(Width: Single);
begin
   k := 1;
   Buffer := 0;
   Step := 0;
   Temp := Width;
   Count := Trunc((Width - wid) / 2);
   Element := 1;
   New(Root);
   Root^.Up := nil;
   PTemp := Root;
   IsRight := True;
end;

procedure CirDraw(Form: TForm);
var
   TempC: TCircle;
   TempL: TLabel;
begin
   PTemp^.Num := Element;
   PTemp^.Left := nil;
   PTemp^.Right := nil;
   TempC := TCircle.Create(Form);
   TempC.Parent := Form;
   TempC.Width := Wid;
   TempC.Height := Wid;
   if IsRight then
      TempC.Position.X := Count + Step
   else
      TempC.Position.X := Step - Count;
   Step := Trunc(TempC.Position.X);
   Count := Count div 2;
   TempC.Position.Y := Buffer;
   TempC.Fill.Color := TAlphaColorRec.Pink;
   TempL := TLabel.Create(TempC);
   TempL.Parent := TempC;
   TempL.Width := wid;
   TempL.Height := wid;
   TempL.Position.X := 3;
   TempL.Text := IntToStr(Element);
   ArrC[Element] := TempC;
   Buffer := Buffer + Down;
   Inc(Element);
end;

function LeftRightCenter(P: PTree): Byte;
begin
   if P.Left <> nil then
      P.LeftCount := 1 + LeftRightCenter(P.Left)
   else
      P.LeftCount := 0;
   if P.Right <> nil then
      P.RightCount := 1 + LeftRightCenter(P.Right)
   else
      P.RightCount := 0;
   LeftRightCenter := P.LeftCount + P.RightCount;
   if (P.LeftCount - 1 = P.RightCount)or(P.LeftCount + 1 = P.RightCount) then
   begin
      Values[k] := P.Num;
      inc(k);
   end;
end;

function Find: ArrV;
begin
   LeftRightCenter(Root);
   Result := Values;
   k := 1;
end;

end.
