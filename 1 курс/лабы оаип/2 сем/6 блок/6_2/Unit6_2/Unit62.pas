unit Unit62;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, VCL.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, System.ImageList, FMX.ImgList,
  FMX.Menus, MyUnit;

type
   TLab_6_2 = class(TForm)
    AddPanel: TPanel;
    AddRight: TButton;
    AddLeft: TButton;
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
    procedure AddLeftClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ExitClick(Sender: TObject);
    procedure AboutTheDeveloperClick(Sender: TObject);
    procedure AboutTheProgramClick(Sender: TObject);
    procedure FindClick(Sender: TObject);
    procedure HowToUseClick(Sender: TObject);
   private
      Values: MyUnit.ArrV;
   public
    { Public declarations }
   end;

var
  Lab_6_2: TLab_6_2;

implementation

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
var
   Num: Byte;
begin
   AddLeft.Enabled := True;
   AddRight.Enabled := True;
   MyUnit.AddL;
   MyUnit.CirDraw(Lab_6_2);
   MyUnit.DrawL(Lab_6_2);
   Num := MyUnit.PTemp.Num;
   PointLabel.Text := 'You are at the vertex ' + IntToStr(Num);
   if not (MyUnit.CheckDown) then
   begin
      AddRight.Enabled := False;
      AddLeft.Enabled := False;
   end;
end;

procedure TLab_6_2.AddRightClick(Sender: TObject);
var
   Num: Byte;
begin
   AddLeft.Enabled := True;
   AddRight.Enabled := True;
   MyUnit.AddR;
   MyUnit.CirDraw(Lab_6_2);
   MyUnit.DrawL(Lab_6_2);
   Num := MyUnit.PTemp.Num;
   PointLabel.Text := 'You are at the vertex ' + IntToStr(Num);
   if not (MyUnit.CheckDown) then
   begin
      AddRight.Enabled := False;
      AddLeft.Enabled := False;
   end;
end;

procedure TLab_6_2.ExitClick(Sender: TObject);
begin
   Close;
end;

procedure TLab_6_2.FindClick(Sender: TObject);
var
   i: Byte;
begin
   i := 1;
   Values := MyUnit.Find;
   Result.Text := 'Vertex numbers are:';
   while Values[i] <> 0 do
   begin
      Result.Text := Result.Text + ' ' + IntToStr(Values[i]);
      inc(i);
   end;
end;

procedure TLab_6_2.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
   ButtonSelected: Byte;
begin
   ButtonSelected := MessageDlg('Are you sure you want to exit?',mtConfirmation, mbYesNo, 0);
   if ButtonSelected <> mrYes then
      CanClose := False;
end;

procedure TLab_6_2.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
var
   Num: Byte;
begin
   AddRight.Enabled := False;
   AddLeft.Enabled := False;
   Num := MyUnit.PTemp.Num;
   case Key of
      vkUp:
         Num := MyUnit.Up;
      vkLeft:
         Num := MyUnit.Left;
      vkRight:
         Num := MyUnit.Right;
   end;
   PointLabel.Text := 'You are at the vertex ' + IntToStr(Num);
   if MyUnit.CheckLeft then
      AddLeft.Enabled := True;
   if MyUnit.CheckRight then
      AddRight.Enabled := True;
   if not (MyUnit.CheckDown) then
   begin
      AddRight.Enabled := False;
      AddLeft.Enabled := False;
   end;
end;

procedure TLab_6_2.FormShow(Sender: TObject);
begin
   MyUnit.Start(Lab_6_2.Width);
   MyUnit.CirDraw(Lab_6_2);
end;

procedure TLab_6_2.HowToUseClick(Sender: TObject);
begin
   MessageDlg('Use the keys ''Up'', ''Left'', ''Right'' to move around the tree.',mtInformation, [mbOK], 0);
end;

end.
