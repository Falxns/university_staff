library TreeLib;

uses
  System.SysUtils,
  System.Classes;

type
   PTree = ^Tree;

   Tree = record
      Num, LeftCount, RightCount: Byte;
      Up: PTree;
      Left: PTree;
      Right: PTree;
   end;

   ArrV = array [1..63] of Byte;

{$R *.res}

procedure _AddR(var PTemp: PTree; var Element: Byte);  stdcall;
begin
   PTemp^.Right^.Up := PTemp;
   PTemp := PTemp^.Right;
   PTemp^.Num := Element;
   PTemp^.Left := nil;
   PTemp^.Right := nil;
end;

function _CheckLeft(var PTemp: PTree): Boolean; stdcall;
begin
   Result := False;
   if PTemp^.Left = nil then
      Result := True;
end;

function _CheckRight(var PTemp: PTree): Boolean; stdcall;
begin
   Result := False;
   if PTemp^.Right = nil then
      Result := True;
end;

procedure _AddL(var PTemp: PTree; var Element: Byte); stdcall;
begin
   PTemp^.Left^.Up := PTemp;
   PTemp := PTemp^.Left;
   PTemp^.Num := Element;
   PTemp^.Left := nil;
   PTemp^.Right := nil;
end;

procedure _Start(var PTemp, Root: PTree; var Element: Byte); stdcall;
begin
   Root^.Up := nil;
   PTemp := Root;
   Element := 1;
   PTemp^.Num := Element;
   PTemp^.Left := nil;
   PTemp^.Right := nil;
end;

function _LeftRightCenter(var P: PTree; var Values: ArrV; var k: Byte): Byte; stdcall;
begin
   if P.Left <> nil then
      P.LeftCount := 1 + _LeftRightCenter(P.Left, Values, k)
   else
      P.LeftCount := 0;
   if P.Right <> nil then
      P.RightCount := 1 + _LeftRightCenter(P.Right, Values, k)
   else
      P.RightCount := 0;
   _LeftRightCenter := P.LeftCount + P.RightCount;
   if (P.LeftCount - 1 = P.RightCount)or(P.LeftCount + 1 = P.RightCount) then
   begin
      Values[k] := P.Num;
      inc(k);
   end;
end;

exports
   _LeftRightCenter,
   _Start,
   _AddL,
   _CheckRight,
   _CheckLeft,
   _AddR;
begin
end.
