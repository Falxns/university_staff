unit Unit62;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, VCL.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, System.ImageList, FMX.ImgList,
  FMX.Menus;

type
   PTree = ^Tree;

   Tree = record
      Num, LeftCount, RightCount: Byte;
      Up: PTree;
      Left: PTree;
      Right: PTree;
   end;

   ArrV = array [1..63] of Byte;

   TLab_6_2 = class(TForm)
    AddPanel: TPanel;
    AddRight: TButton;
    AddLeft: TButton;
    Delete: TButton;
    ImageList1: TImageList;
    MainMenu1: TMainMenu;
    Help: TMenuItem;
    AboutTheDeveloper: TMenuItem;
    AboutTheProgram: TMenuItem;
    Find: TButton;
    PointLabel: TLabel;
    Result: TLabel;
    HowToUse: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure AddRightClick(Sender: TObject);
    procedure CirCreate;
    procedure AddLeftClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure AboutTheDeveloperClick(Sender: TObject);
    procedure AboutTheProgramClick(Sender: TObject);
    procedure DrawL;
    procedure FindClick(Sender: TObject);
    procedure UpClick;
    procedure LeftClick;
    procedure RightClick;
    procedure HowToUseClick(Sender: TObject);
   private
      ArrC: array [1..63] of TCircle;
      Root, PTemp: PTree;
      Count, Step, Buffer: Integer;
      Element, k: Byte;
      IsRight: Boolean;
      Values: ArrV;
   public
    { Public declarations }
   end;

var
  Lab_6_2: TLab_6_2;

const
   Wid = 20;
   down = 40;

implementation

   procedure _AddL(var PTemp: PTree;var  Element: Byte); stdcall; external 'TreeLib.dll';
   procedure _AddR(var PTemp: PTree;var  Element: Byte); stdcall; external 'TreeLib.dll';
   procedure _Start(var PTemp, Root: PTree; var Element: Byte); stdcall; external 'TreeLib.dll';
   function _CheckLeft(var PTemp: PTree): Boolean; stdcall; external 'TreeLib.dll';
   function _CheckRight(var PTemp: PTree): Boolean; stdcall; external 'TreeLib.dll';
   function _LeftRightCenter(var P: PTree; var Values: ArrV; var k: Byte): Byte; stdcall; external 'TreeLib.dll';

{$R *.fmx}

procedure TLab_6_2.AboutTheDeveloperClick(Sender: TObject);
begin
   MessageDlg('This program developed by Maksim Gladkiy, gr.851001.',mtInformation, [mbOK], 0);
end;

procedure TLab_6_2.AboutTheProgramClick(Sender: TObject);
begin
   MessageDlg('This program finds vertices, which number of descendants in the left subtree is different from the number of descendants in the right subtree on 1.',mtInformation, [mbOK], 0);
end;

procedure TLab_6_2.AddLeftClick(Sender: TObject);
begin
   AddLeft.Enabled := True;
   AddRight.Enabled := True;
   New(PTemp^.Left);
   _AddL(PTemp, Element);
   IsRight := False;
   CirCreate;
   DrawL;
end;

procedure TLab_6_2.DrawL;
var
   Brush: TStrokeBrush;
begin
   Brush := TStrokeBrush.Create(TBrushKind.Solid, TAlphaColorRec.Black);
   Brush.Thickness := 1;
   with Canvas do
   begin
      BeginScene;
      if not (IsRight) then
         DrawLine(PointF(step + Count * 2 + wid/2, Buffer - 2*down + wid),PointF(Step + wid/2, Buffer - Down),1, Brush)
      else
         DrawLine(PointF(step - Count * 2 + wid/2, Buffer - 2*down + wid),PointF(Step + wid/2, Buffer - Down),1, Brush);
      EndScene;
   end;
end;

procedure TLab_6_2.AddRightClick(Sender: TObject);
begin
   AddLeft.Enabled := True;
   AddRight.Enabled := True;
   New(PTemp^.Right);
   _AddR(PTemp, Element);
   IsRight := True;
   CirCreate;
   DrawL;
end;

procedure TLab_6_2.CirCreate;
var
   TempC: TCircle;
   TempL: TLabel;
begin
   TempC := TCircle.Create(Lab_6_2);
   TempC.Parent := Lab_6_2;
   TempC.Width := Wid;
   TempC.Height := Wid;
   if IsRight then
      TempC.Position.X := Count + Step
   else
      TempC.Position.X := Step - Count;
   Step := Trunc(TempC.Position.X);
   Count := Count div 2;
   TempC.Position.Y := Buffer;
   TempC.Fill.Color := TAlphaColorRec.Red;
   TempL := TLabel.Create(TempC);
   TempL.Parent := TempC;
   TempL.Width := wid;
   TempL.Height := wid;
   TempL.Position.X := 3;
   TempL.Text := IntToStr(Element);
   ArrC[Element] := TempC;
   Buffer := Buffer + Down;
   if (Buffer > (5 * Down)) then
   begin
      AddRight.Enabled := False;
      AddLeft.Enabled := False;
   end;
   PointLabel.Text := 'You are at the vertex ' + IntToStr(Element);
   Inc(Element);
end;

procedure TLab_6_2.FindClick(Sender: TObject);
var
   i: Byte;
begin
   _LeftRightCenter(Root, Values, k);
   Result.Text := 'Vertex numbers are:';
   for i := 1 to k - 1 do
   begin
      Result.Text := Result.Text + ' ' + IntToStr(Values[i]);
   end;
   k := 1;
end;

procedure TLab_6_2.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
   ButtonSelected: Byte;
begin
   ButtonSelected := MessageDlg('Are you sure you want to exit?',mtConfirmation, mbYesNo, 0);
   if ButtonSelected <> mrYes then
      CanClose := False;
end;

procedure TLab_6_2.UpClick;
var
   i: Byte;
begin
    if PTemp^.Up <> nil then
    begin
       PTemp := PTemp^.Up;
       i := PTemp^.Num;
       Count := Count * 2;
       Buffer := Buffer - Down;
       Step := Trunc(ArrC[i].Position.X);
       PointLabel.Text := 'You are at the vertex ' + IntToStr(i);
    end;
end;

procedure TLab_6_2.LeftClick;
var
   i: Byte;
begin
   if PTemp^.Left <> nil then
   begin
      PTemp := PTemp^.Left;
      i := PTemp^.Num;
      Count := Count div 2;
      Buffer := Buffer + Down;
      Step := Trunc(ArrC[i].Position.X);
      PointLabel.Text := 'You are at the vertex ' + IntToStr(i);
   end;
end;

procedure TLab_6_2.RightClick;
var
   i: Byte;
begin
   if PTemp^.Right <> nil then
   begin
      PTemp := PTemp^.Right;
      i := PTemp^.Num;
      Count := Count div 2;
      Buffer := Buffer + Down;
      Step := Trunc(ArrC[i].Position.X);
      PointLabel.Text := 'You are at the vertex ' + IntToStr(i);
   end;
end;

procedure TLab_6_2.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
   AddRight.Enabled := False;
   AddLeft.Enabled := False;
   case Key of
      vkUp:
         UpClick;
      vkLeft:
         LeftClick;
      vkRight:
         RightClick;
   end;
   if _CheckLeft(PTemp) then
   begin
      IsRight := False;
      AddLeft.Enabled := True;
   end;
   if _CheckRight(PTemp) then
   begin
      IsRight := True;
      AddRight.Enabled := True;
   end;
   if (Buffer > (5 * Down)) then
   begin
      AddRight.Enabled := False;
      AddLeft.Enabled := False;
   end;
end;

procedure TLab_6_2.FormShow(Sender: TObject);
begin
   k := 1;
   Buffer := 0;
   Step := 0;
   Count := (Lab_6_2.Width - wid) div 2;
   Element := 1;
   New(Root);
   _Start(PTemp, Root, Element);
   IsRight := True;
   CirCreate;
end;

procedure TLab_6_2.HowToUseClick(Sender: TObject);
begin
   MessageDlg('Use the keys ''Up'', ''Left'', ''Right'' to move around the tree.',mtInformation, [mbOK], 0);
end;

end.
