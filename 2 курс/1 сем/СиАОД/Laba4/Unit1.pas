unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TermPoint = ^TListTerm;
    PagePoint = ^TPageList;
    TListTerm = record
       Term: String;
       NextTerm: TermPoint;
       SubTerm: TermPoint;
       TermPage: PagePoint;
    end;
    TPageList = record
       PageNum: Integer;
       NextPage: PagePoint;
    end;
    TArrTerm = Array [1..5] of String;
    TArrSubterm = Array [1..3] of String;
    TArrPageNum = Array [1..65] of Integer;

  TLab_Hesh = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    ComandLine: TEdit;
    OkBtn: TButton;
    Content: TMemo;
    Label12: TLabel;
    procedure ComandLineChange(Sender: TObject);
    procedure ComandLineKeyPress(Sender: TObject; var Key: Char);
    procedure OkBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ShowContent(Tabul: Byte; Poin: TermPoint);
    procedure SortPage(Tabul: Byte; Poin: TermPoint);
    procedure SortAlphabet(Tabul: Byte; Poin: TermPoint);
    procedure AddTerm(Sender: TObject);
    procedure AddPage(Sender: TObject);
    procedure ChangeTerm(Sender: TObject);
    procedure ChangePage(Sender: TObject);
    procedure DeleteTerm(Sender: TObject);
    procedure DeletePage(Sender: TObject);
    procedure FindSubTerm(Sender: TObject);
    procedure FindTerm(Sender: TObject);
  private
    { Private declarations }
  public
    Root: TermPoint;
    State: Byte;
  end;

var
  Lab_Hesh: TLab_Hesh;

implementation

{$R *.dfm}

uses Unit2;

const
   TermsArr: TArrTerm = ('�����������','���������','���','�������','');
   FirstArrSubterm: TArrSubterm = ('�����������','������������','');
   FirstArrFrSub: TArrSubterm = ('�������','�������','');
   FirstArrScSub: TArrSubterm = ('�������','��','');
   FirstArrThSub: TArrSubterm = ('','','');
   SecondArrSubterm: TArrSubterm = ('������','','�������');
   SecondArrFrSub: TArrSubterm = ('�������','�����������','��������');
   SecondArrScSub: TArrSubterm = ('','','');
   SecondArrThSub: TArrSubterm = ('�������','','');
   ThirdArrSubterm: TArrSubterm = ('�������','��������','���������');
   ThirdArrFrSub: TArrSubterm = ('����','��������','');
   ThirdArrScSub: TArrSubterm = ('���','','');
   ThirdArrThSub: TArrSubterm = ('�������','��������','����');
   FourArrSubterm: TArrSubterm = ('�������','','');
   FourArrFrSub: TArrSubterm = ('���','����','�����');
   FourArrScSub: TArrSubterm = ('','','');
   FourArrThSub: TArrSubterm = ('','','');
   FifthArrSubterm: TArrSubterm = ('','','');
   FifthArrFrSub: TArrSubterm = ('','','');
   FifthArrScSub: TArrSubterm = ('','','');
   FifthArrThSub: TArrSubterm = ('','','');
   EmptyArr: TArrSubterm = ('','','');

procedure TLab_Hesh.ComandLineChange(Sender: TObject);
begin
   if (Length(ComandLine.Text) <> 0) and (StrToInt(ComandLine.Text) < 12) then
      OkBtn.Enabled := True
   else
      OkBtn.Enabled := False;
end;

procedure TLab_Hesh.ComandLineKeyPress(Sender: TObject; var Key: Char);
const
   NumSet: Set of Char = ['0'..'9', #8];
begin
    if not(Key in NumSet) then
       Key := #0;
end;

procedure CreateSubterms(const SubArr: TArrSubterm; var Poin: TermPoint; Count: Byte);
var
   i: Byte;
   Num, Min: Integer;
   RootP: TermPoint;
   TempP: PagePoint;
begin
   RootP := Poin;
   New(Poin.TermPage);
   TempP := Poin.TermPage;
   i := 1;
   Min := 1;
   if RootP.Term <> '' then
   begin
       while (i < 2) do
       begin
          Num := 1 + random(100);
          if Num > Min then
          begin
              Min := Num;
              TempP.PageNum := Num;
              inc(i);
              if i < 2 then
              begin
                  New(TempP.NextPage);
                  TempP := TempP.NextPage;
              end
              else
                 TempP.NextPage := Nil;
          end;
       end;
   end
   else
      RootP.TermPage := Nil;
   i := 1;
   Poin := RootP;
   New(Poin.SubTerm);
   Poin := Poin.SubTerm;
   while ((SubArr[i] <> '') and (i < 4)) do
   begin
      Poin.Term := SubArr[i];
      if i < 3 then
      begin
         New(Poin.NextTerm);
         Poin := Poin.NextTerm;
      end
      else
         Poin.NextTerm := Nil;
      inc(i);
   end;
   if RootP.SubTerm <> Nil then
   begin
       Poin := RootP.SubTerm;
       case Count of
          1:
          begin
             CreateSubterms(FirstArrFrSub, Poin, 6);
             if RootP.SubTerm.NextTerm <> Nil then
             begin
                 Poin := RootP.SubTerm.NextTerm;
                 CreateSubterms(FirstArrScSub, Poin, 6);
                 if RootP.SubTerm.NextTerm.NextTerm <> Nil then
                 begin
                     Poin := RootP.SubTerm.NextTerm.NextTerm;
                     CreateSubterms(FirstArrThSub, Poin, 6);
                 end;
             end;
          end;
          2:
          begin
             CreateSubterms(SecondArrFrSub, Poin, 6);
             if RootP.SubTerm.NextTerm <> Nil then
             begin
                 Poin := RootP.SubTerm.NextTerm;
                 CreateSubterms(SecondArrScSub, Poin, 6);
                 if RootP.SubTerm.NextTerm.NextTerm <> Nil then
                 begin
                     Poin := RootP.SubTerm.NextTerm.NextTerm;
                     CreateSubterms(SecondArrThSub, Poin, 6);
                 end;
             end;
          end;
          3:
          begin
             CreateSubterms(ThirdArrFrSub, Poin, 6);
             if RootP.SubTerm.NextTerm <> Nil then
             begin
                 Poin := RootP.SubTerm.NextTerm;
                 CreateSubterms(ThirdArrScSub, Poin, 6);
                 if RootP.SubTerm.NextTerm.NextTerm <> Nil then
                 begin
                     Poin := RootP.SubTerm.NextTerm.NextTerm;
                     CreateSubterms(ThirdArrThSub, Poin, 6);
                 end;
             end;
          end;
          4:
          begin
             CreateSubterms(FourArrFrSub, Poin, 6);
             if RootP.SubTerm.NextTerm <> Nil then
             begin
                 Poin := RootP.SubTerm.NextTerm;
                 CreateSubterms(FourArrScSub, Poin, 6);
                 if RootP.SubTerm.NextTerm.NextTerm <> Nil then
                 begin
                     Poin := RootP.SubTerm.NextTerm.NextTerm;
                     CreateSubterms(FourArrThSub, Poin, 6);
                 end;
             end;
          end;
          5:
          begin
             CreateSubterms(FifthArrFrSub, Poin, 6);
             if RootP.SubTerm.NextTerm <> Nil then
             begin
                 Poin := RootP.SubTerm.NextTerm;
                 CreateSubterms(FifthArrScSub, Poin, 6);
                 if RootP.SubTerm.NextTerm.NextTerm <> Nil then
                 begin
                     Poin := RootP.SubTerm.NextTerm.NextTerm;
                     CreateSubterms(FifthArrThSub, Poin, 6);
                 end;
             end;
          end;
          6:
          begin
             CreateSubterms(EmptyArr, Poin, 0);
             if RootP.SubTerm.NextTerm <> Nil then
             begin
                 Poin := RootP.SubTerm.NextTerm;
                 CreateSubterms(EmptyArr, Poin, 0);
                 if RootP.SubTerm.NextTerm.NextTerm <> Nil then
                 begin
                     Poin := RootP.SubTerm.NextTerm.NextTerm;
                     CreateSubterms(EmptyArr, Poin, 0);
                 end;
             end;
          end;
       end;
   end;
end;

procedure TLab_Hesh.FormCreate(Sender: TObject);
var
   Temp: TermPoint;
   i: Byte;
begin
   Content.Clear;
   New(Root);
   Temp := Root;
   for i := 1 to 5 do
   begin
      Temp.Term := TermsArr[i];
      if i < 5 then
      begin
         New(Temp.NextTerm);
         Temp := Temp.NextTerm;
      end
      else
         Temp.NextTerm := nil;
   end;
   Temp := Root;
   CreateSubterms(FirstArrSubterm, Temp, 1);
   Temp := Root.NextTerm;
   CreateSubterms(SecondArrSubterm, Temp, 2);
   Temp := Root.NextTerm.NextTerm;
   CreateSubterms(ThirdArrSubterm, Temp, 3);
   Temp := Root.NextTerm.NextTerm.NextTerm;
   CreateSubterms(FourArrSubterm, Temp, 4);
   Temp := Root.NextTerm.NextTerm.NextTerm.NextTerm;
   CreateSubterms(FifthArrSubterm, Temp, 5);
end;

procedure TLab_Hesh.ShowContent(Tabul: Byte; Poin: TermPoint);
var
   Temp: TermPoint;
   Step: PagePoint;
   Buf: String;
begin
   Temp := Poin;
   if Temp.Term <> '' then
   begin
       Step := Temp.TermPage;
       Buf := Temp.Term;
       while Step <> nil do
       begin
          Buf := Buf + ' ' + IntToStr(Step.PageNum);
          Step := Step.NextPage;
       end;
       case Tabul of
          0:
          Buf := Buf;
          1:
          Buf := '     ' + Buf;
          2: Buf := '          ' + Buf;
       end;
       Content.Lines.Add(Buf);
       if (Temp.SubTerm <> nil) then
       begin
          if Tabul = 0 then
             ShowContent(1, Temp.SubTerm);
          if Tabul = 1 then
             ShowContent(2, Temp.SubTerm);
       end;
       if Temp.NextTerm <> nil then
       begin
       if Tabul = 0 then
          ShowContent(0, Temp.NextTerm);
       if Tabul = 1 then
          ShowContent(1, Temp.NextTerm);
       if Tabul = 2 then
          ShowContent(2, Temp.NextTerm);
       end;
   end;
end;

procedure TLab_Hesh.SortPage(Tabul: Byte; Poin: TermPoint);
var
   Step: PagePoint;
   Temp: TermPoint;
   BufPoin: TermPoint;
   Buf: String;
   PoinArr : array of TermPoint;
   Count, i, j: Byte;
begin
   Temp := Poin;
   Count := 0;
   if (Temp.Term <> '') and (Temp <> nil) then
   begin
      while (Temp <> Nil) and (Temp.Term <> '') do
      begin
         inc(Count);
         Temp := Temp.NextTerm;
      end;
      Temp := Poin;
      SetLength(PoinArr, Count);
      Dec(Count);
      for i := 0 to Count do
      begin
         PoinArr[i] := Temp;
         Temp := Temp.NextTerm;
      end;
      Temp := Poin;
      i := 0;
      while (i <= Count) do
      begin
         j := 0;
         while (j <= Count - 1) do
         begin
            if PoinArr[j].TermPage.PageNum > PoinArr[j+1].TermPage.PageNum then
            begin
               BufPoin := PoinArr[j];
               PoinArr[j] := PoinArr[j + 1];
               PoinArr[j + 1] := BufPoin;
            end;
            inc(j);
         end;
         inc(i);
      end;
      for i := 0 to Count do
      begin
         if (PoinArr[i].Term <> '') and (PoinArr[i] <> Nil) then
         begin
             Temp := PoinArr[i];
             Step := Temp.TermPage;
             Buf := Temp.Term;
             while Step <> nil do
             begin
                Buf := Buf + ' ' + IntToStr(Step.PageNum);
                Step := Step.NextPage;
             end;
             case Tabul of
                0:
                Buf := Buf;
                1:
                Buf := '     ' + Buf;
                2: Buf := '          ' + Buf;
             end;
             Content.Lines.Add(Buf);
             if (Temp.SubTerm <> nil) then
             begin
                if Tabul = 0 then
                   SortPage(1, Temp.SubTerm);
                if Tabul = 1 then
                   SortPage(2, Temp.SubTerm);
             end;
         end;
      end;
   end;
end;

procedure TLab_Hesh.SortAlphabet(Tabul: Byte; Poin: TermPoint);
var
   Step: PagePoint;
   Temp: TermPoint;
   BufPoin: TermPoint;
   Buf: String;
   PoinArr : array of TermPoint;
   Count, i, j: Byte;
begin
   Temp := Poin;
   Count := 0;
   if (Temp.Term <> '') and (Temp <> nil) then
   begin
      while (Temp <> Nil) and (Temp.Term <> '') do
      begin
         inc(Count);
         Temp := Temp.NextTerm;
      end;
      Temp := Poin;
      SetLength(PoinArr, Count);
      Dec(Count);
      for i := 0 to Count do
      begin
         PoinArr[i] := Temp;
         Temp := Temp.NextTerm;
      end;
      Temp := Poin;
      i := 0;
      while (i <= Count) do
      begin
         j := 0;
         while (j <= Count - 1) do
         begin
            if PoinArr[j].Term > PoinArr[j+1].Term then
            begin
               BufPoin := PoinArr[j];
               PoinArr[j] := PoinArr[j + 1];
               PoinArr[j + 1] := BufPoin;
            end;
            inc(j);
         end;
         inc(i);
      end;
      for i := 0 to Count do
      begin
         if (PoinArr[i].Term <> '') and (PoinArr[i] <> Nil) then
         begin
             Temp := PoinArr[i];
             Step := Temp.TermPage;
             Buf := Temp.Term;
             while Step <> nil do
             begin
                Buf := Buf + ' ' + IntToStr(Step.PageNum);
                Step := Step.NextPage;
             end;
             case Tabul of
                0:
                Buf := Buf;
                1:
                Buf := '     ' + Buf;
                2: Buf := '          ' + Buf;
             end;
             Content.Lines.Add(Buf);
             if (Temp.SubTerm <> nil) then
             begin
                if Tabul = 0 then
                   SortAlphabet(1, Temp.SubTerm);
                if Tabul = 1 then
                   SortAlphabet(2, Temp.SubTerm);
             end;
         end;
      end;
   end;
end;

procedure TLab_Hesh.FindTerm(Sender: TObject);
begin
   State := 8;
   Unit2.Add.Label2.Visible := False;
   Unit2.Add.Label3.Visible := False;
   Unit2.Add.Father.Visible := False;
   Unit2.Add.GrandFather.Visible := False;
   Unit2.Add.Son.Visible := False;
   Unit2.Add.Label4.Visible := False;
   Unit2.Add.Label5.Visible := False;
   Unit2.Add.Label6.Visible := False;
   Unit2.Add.Caption := '����� �������';
   Unit2.Add.Label1.Caption := '��������� ��� ������ �������';
   Unit2.Add.Label7.Visible := False;
   Unit2.Add.OldPage.Visible := False;
   Unit2.Add.NewTerm.Enabled := True;
   Unit2.Add.NewTerm.Clear;
   Unit2.Add.Action.Caption := '�����';
   Unit2.Add.ShowModal;
end;

procedure TLab_Hesh.FindSubTerm(Sender: TObject);
begin
   State := 7;
   Unit2.Add.Label2.Visible := False;
   Unit2.Add.Label3.Visible := False;
   Unit2.Add.Father.Visible := False;
   Unit2.Add.GrandFather.Visible := False;
   Unit2.Add.Son.Visible := False;
   Unit2.Add.Label4.Visible := False;
   Unit2.Add.Label5.Visible := False;
   Unit2.Add.Label6.Visible := False;
   Unit2.Add.Caption := '����� ����������';
   Unit2.Add.Label1.Caption := '������ ��� ������ ����������';
   Unit2.Add.Label7.Visible := False;
   Unit2.Add.OldPage.Visible := False;
   Unit2.Add.NewTerm.Enabled := True;
   Unit2.Add.NewTerm.Clear;
   Unit2.Add.Action.Caption := '�����';
   Unit2.Add.ShowModal;
end;

procedure TLab_Hesh.DeletePage(Sender: TObject);
begin
   State := 6;
   Unit2.Add.Caption := '�������� ��������';
   Unit2.Add.Label1.Caption := '��������� ��������';
   Unit2.Add.Label6.Visible := True;
   Unit2.Add.Label6.Caption := '������ ��� �������� ��������';
   Unit2.Add.Label2.Visible := True;
   Unit2.Add.Label3.Visible := True;
   Unit2.Add.Label4.Visible := True;
   Unit2.Add.Label5.Visible := True;
   Unit2.Add.Father.Visible := True;
   Unit2.Add.GrandFather.Visible := True;
   Unit2.Add.Label7.Visible := False;
   Unit2.Add.OldPage.Visible := False;
   Unit2.Add.Son.Visible := True;
   Unit2.Add.Son.Clear;
   Unit2.Add.Father.Enabled := False;
   Unit2.Add.Father.Clear;
   Unit2.Add.GrandFather.Enabled := False;
   Unit2.Add.GrandFather.Clear;
   Unit2.Add.NewTerm.Enabled := False;
   Unit2.Add.NewTerm.Clear;
   Unit2.Add.Action.Caption := '�������';
   Unit2.Add.ShowModal;
   Content.Clear;
   ShowContent(0, Root);
end;

procedure TLab_Hesh.DeleteTerm(Sender: TObject);
begin
   State := 5;
   Unit2.Add.Caption := '�������� �������';
   Unit2.Add.Label1.Caption := '������ ��� ��������';
   Unit2.Add.Label2.Visible := True;
   Unit2.Add.Label3.Visible := True;
   Unit2.Add.Father.Visible := True;
   Unit2.Add.GrandFather.Visible := True;
   Unit2.Add.Label4.Visible := True;
   Unit2.Add.Label5.Visible := True;
   Unit2.Add.Label6.Visible := False;
   Unit2.Add.Label7.Visible := False;
   Unit2.Add.OldPage.Visible := False;
   Unit2.Add.Son.Visible := False;
   Unit2.Add.Son.Clear;
   Unit2.Add.Father.Enabled := False;
   Unit2.Add.Father.Clear;
   Unit2.Add.GrandFather.Clear;
   Unit2.Add.NewTerm.Clear;
   Unit2.Add.NewTerm.Enabled := True;
   Unit2.Add.GrandFather.Enabled := False;
   Unit2.Add.Action.Caption := '�������';
   Unit2.Add.ShowModal;
   Content.Clear;
   ShowContent(0, Root);
end;

procedure TLab_Hesh.AddTerm(Sender: TObject);
begin
   State := 1;
   Unit2.Add.Caption := '���������� �������';
   Unit2.Add.Label1.Caption := '������ ��� ����������';
   Unit2.Add.Label5.Caption := '������ ����� �������� � ��������� ������';
   Unit2.Add.Label2.Visible := True;
   Unit2.Add.Label3.Visible := True;
   Unit2.Add.Father.Visible := True;
   Unit2.Add.Label4.Visible := True;
   Unit2.Add.Label5.Visible := True;
   Unit2.Add.GrandFather.Visible := True;
   Unit2.Add.Label6.Visible := False;
   Unit2.Add.Label7.Visible := False;
   Unit2.Add.OldPage.Visible := False;
   Unit2.Add.Son.Visible := False;
   Unit2.Add.Son.Clear;
   Unit2.Add.Father.Enabled := False;
   Unit2.Add.Father.Clear;
   Unit2.Add.GrandFather.Clear;
   Unit2.Add.NewTerm.Clear;
   Unit2.Add.NewTerm.Enabled := True;
   Unit2.Add.GrandFather.Enabled := False;
   Unit2.Add.Action.Caption := '��������';
   Unit2.Add.ShowModal;
   Content.Clear;
   ShowContent(0, Root);
end;

procedure TLab_Hesh.ChangePage(Sender: TObject);
begin
   State := 4;
   Unit2.Add.Caption := '��������� ��������';
   Unit2.Add.Label1.Caption := '����� ��������';
   Unit2.Add.Label6.Visible := True;
   Unit2.Add.Label6.Caption := '������ ��� ��������� ��������';
   Unit2.Add.Label2.Visible := True;
   Unit2.Add.Label4.Visible := True;
   Unit2.Add.Label5.Visible := True;
   Unit2.Add.Label3.Visible := True;
   Unit2.Add.Father.Visible := True;
   Unit2.Add.GrandFather.Visible := True;
   Unit2.Add.Label7.Visible := True;
   Unit2.Add.OldPage.Visible := True;
   Unit2.Add.OldPage.Clear;
   Unit2.Add.Son.Visible := True;
   Unit2.Add.Son.Clear;
   Unit2.Add.Father.Enabled := False;
   Unit2.Add.Father.Clear;
   Unit2.Add.GrandFather.Enabled := False;
   Unit2.Add.GrandFather.Clear;
   Unit2.Add.NewTerm.Enabled := False;
   Unit2.Add.NewTerm.Clear;
   Unit2.Add.Action.Caption := '��������';
   Unit2.Add.ShowModal;
   Content.Clear;
   ShowContent(0, Root);
end;

procedure TLab_Hesh.ChangeTerm(Sender: TObject);
begin
   State := 3;
   Unit2.Add.Caption := '��������� �������';
   Unit2.Add.Label1.Caption := '����� ������';
   Unit2.Add.Label6.Visible := True;
   Unit2.Add.Label6.Caption := '������ ������';
   Unit2.Add.Label4.Visible := True;
   Unit2.Add.Label5.Visible := True;
   Unit2.Add.Label2.Visible := True;
   Unit2.Add.Label3.Visible := True;
   Unit2.Add.Father.Visible := True;
   Unit2.Add.GrandFather.Visible := True;
   Unit2.Add.Label7.Visible := False;
   Unit2.Add.OldPage.Visible := False;
   Unit2.Add.Son.Visible := True;
   Unit2.Add.Son.Clear;
   Unit2.Add.Father.Enabled := False;
   Unit2.Add.Father.Clear;
   Unit2.Add.GrandFather.Enabled := False;
   Unit2.Add.GrandFather.Clear;
   Unit2.Add.NewTerm.Enabled := False;
   Unit2.Add.NewTerm.Clear;
   Unit2.Add.Action.Caption := '��������';
   Unit2.Add.ShowModal;
   Content.Clear;
   ShowContent(0, Root);
end;

procedure TLab_Hesh.AddPage(Sender: TObject);
begin
   State := 2;
   Unit2.Add.Caption := '���������� ��������';
   Unit2.Add.Label1.Caption := '����������� ��������';
   Unit2.Add.Label6.Visible := True;
   Unit2.Add.Label6.Caption := '������ ����������� ��������';
   Unit2.Add.Label4.Visible := True;
   Unit2.Add.Label5.Visible := True;
   Unit2.Add.Label2.Visible := True;
   Unit2.Add.Label3.Visible := True;
   Unit2.Add.Father.Visible := True;
   Unit2.Add.GrandFather.Visible := True;
   Unit2.Add.Label7.Visible := False;
   Unit2.Add.OldPage.Visible := False;
   Unit2.Add.Son.Visible := True;
   Unit2.Add.Son.Clear;
   Unit2.Add.Father.Enabled := False;
   Unit2.Add.Father.Clear;
   Unit2.Add.GrandFather.Enabled := False;
   Unit2.Add.GrandFather.Clear;
   Unit2.Add.NewTerm.Enabled := False;
   Unit2.Add.NewTerm.Clear;
   Unit2.Add.Action.Caption := '��������';
   Unit2.Add.ShowModal;
   Content.Clear;
   ShowContent(0, Root);
end;

procedure TLab_Hesh.OkBtnClick(Sender: TObject);
var
   ComandNum: Byte;
begin
   ComandNum := StrToInt(ComandLine.Text);
   case ComandNum of
      1:
      begin
         Content.Clear;
         ShowContent(0, Root);
      end;
      2:
      begin
         Content.Clear;
         SortPage(0, Root);
      end;
      3:
      begin
         Content.Clear;
         SortAlphabet(0, Root);
      end;
      4:
      AddTerm(Sender);
      5:
      AddPage(Sender);
      6:
      ChangeTerm(Sender);
      7:
      ChangePage(Sender);
      8:
      FindTerm(Sender);
      9:
      DeleteTerm(Sender);
      10:
      DeletePage(Sender);
      11:
      FindSubTerm(Sender);
   end;
end;


end.
