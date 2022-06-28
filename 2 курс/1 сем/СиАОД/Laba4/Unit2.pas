unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Unit1;

type
  TAdd = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    NewTerm: TEdit;
    Father: TEdit;
    GrandFather: TEdit;
    Label3: TLabel;
    Action: TButton;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Son: TEdit;
    Label7: TLabel;
    OldPage: TEdit;
    procedure NewTermChange(Sender: TObject);
    procedure ActionClick(Sender: TObject);
    procedure GrandFatherKeyPress(Sender: TObject; var Key: Char);
    procedure FatherKeyPress(Sender: TObject; var Key: Char);
    procedure AddTerm(Sender: TObject);
    procedure SonChange(Sender: TObject);
    procedure AddPage(Sender: TObject);
    procedure ChangeOldTerm(Sender: TObject);
    procedure ChangeOldPage(Sender: TObject);
    procedure DeleteOldTerm(Sender: TObject);
    procedure DeleteOldPage(Sender: TObject);
    procedure FindSubTerm(Sender: TObject; var Poin: TermPoint; Nest: Byte);
    procedure FindTerm(Sender: TObject; var Poin: TermPoint; Nest: Byte);
    procedure SortNewPage(var Poin: PagePoint);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Add: TAdd;

implementation

{$R *.dfm}

procedure TAdd.ActionClick(Sender: TObject);
begin
   case Unit1.Lab_Hesh.State of
      1: AddTerm(Sender);
      2: AddPage(Sender);
      3: ChangeOldTerm(Sender);
      4: ChangeOldPage(Sender);
      5: DeleteOldTerm(Sender);
      6: DeleteOldPage(Sender);
      7:
      begin
         FindSubTerm(Sender, Unit1.Lab_Hesh.Root, 0);
         MessageDlg('��� ���������� ���� �������, ���� ����� �� ���������, ���� ��������� �� ������ � ������' , mtInformation, mbOKCancel, 0);
      end;
      8:
      begin
         FindTerm(Sender, Unit1.Lab_Hesh.Root, 0);
         MessageDlg('��� ������� ���� �������, ���� ����� �� ���������, ���� ������ �� ������ � ������' , mtInformation, mbOKCancel, 0);
      end;
   end;
   Close;
end;

procedure TAdd.FatherKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = ' ' then
      Key := #0;
end;

procedure TAdd.GrandFatherKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = ' ' then
      Key := #0;
end;

procedure TAdd.SortNewPage(var Poin: PagePoint);
var
   Temp: PagePoint;
   Buf: Integer;
   PageArr: Array of Integer;
   i, j, Num: Byte;
begin
   i := 0;
   Temp := Poin;
   while (Temp <> Nil) do
   begin
      inc(i);
      Temp := Temp.NextPage;
   end;
   Temp := Poin;
   SetLength(PageArr,i);
   Num := i - 1;
   i := 0;
   while i <= Num do
   begin
      PageArr[i] := Temp.PageNum;
      inc(i);
      Temp := Temp.NextPage;
   end;
   Temp := Poin;
   i := 0;
   while (i <= Num) do
   begin
      j := 0;
      while (j <= (Num - 1)) do
      begin
         if PageArr[j] > PageArr[j+1] then
         begin
            Buf := PageArr[j];
            PageArr[j] := PageArr[j+1];
            PageArr[j+1] := Buf;
         end;
         inc(j);
      end;
      inc(i);
   end;
   i := 0;
   while Temp <> Nil do
   begin
      Temp.PageNum := PageArr[i];
      inc(i);
      Temp := Temp.NextPage;
   end;
end;

procedure TAdd.FindTerm(Sender: TObject; var Poin: TermPoint; Nest: Byte);
var
   Temp, Fin, Step: TermPoint;
   Buf: String;
begin
   Temp := Poin;
   while (Temp <> nil) and (Temp.Term <> '')do
   begin
      if (Temp.SubTerm <> Nil) and (Temp.Term <> '') then
      begin
          Step := Temp.SubTerm;
          while (Step.Term <> NewTerm.Text) and (Step.NextTerm <> Nil) and (Step.NextTerm.Term <> '') do
             Step := Step.NextTerm;
          if Step.Term = NewTerm.Text then
          begin
             Fin := Temp;
             Buf := Temp.Term;
             MessageDlg('������ ��� �������� ' + NewTerm.Text + ' �������� �����������: ' + Buf, mtInformation, mbOKCancel, 0);
          end
          else
          begin
             Step := Temp.SubTerm;
             case Nest of
                0: FindTerm(Sender, Step, 1);
                1: FindTerm(Sender, Step, 2);
             end;
          end;
      end;
      Temp := Temp.NextTerm;
   end;
end;

procedure TAdd.FindSubTerm(Sender: TObject; var Poin: TermPoint; Nest: Byte);
var
   Temp, Fin: TermPoint;
   Buf: String;
begin
   Temp := Poin;
   Buf := '';
   while (Temp.Term <> NewTerm.Text) and (Temp.NextTerm <> Nil) and (Temp.NextTerm.Term <> '') do
      Temp := Temp.NextTerm;
   if Temp.Term = NewTerm.Text then
   begin
      Fin := Temp.SubTerm;
      while (Fin <> nil) and (Fin.Term <> '') do
      begin
         Buf := Buf + ' ' + Fin.Term;
         Fin := Fin.NextTerm;
      end;
      MessageDlg('����� ������������ ������� ' + Temp.Term + ' ��������: ' + Buf, mtInformation, mbOKCancel, 0);
   end
   else
   begin
      Temp := Poin;
      while (Temp <> Nil) and (Temp.Term <> '') do
      begin
         case Nest of
            0:
            begin
               FindSubTerm(Sender, Temp.SubTerm, 1);
            end;
            1:
            begin
               FindSubTerm(Sender, Temp.SubTerm, 2);
            end;
         end;
         Temp := Temp.NextTerm;
      end;
   end;
end;

procedure TAdd.DeleteOldPage(Sender: TObject);
var
   Temp, Step, Buf: TermPoint;
   TempP, Del: PagePoint;
begin
   Temp := Unit1.Lab_Hesh.Root;
   if Length(GrandFather.Text) > 0 then
   begin
      while (Temp.Term <> GrandFather.Text) and (Temp.NextTerm <> Nil) and (Temp.NextTerm.Term <> '') do
         Temp := Temp.NextTerm;
      if Temp.Term = GrandFather.Text then
      begin
         Step := Temp;
         if Length(Father.Text) <> 0 then
         begin
            Step := Temp.SubTerm;
            while (Step.Term <> Father.Text) and (Step.NextTerm <> Nil) and (Step.NextTerm.Term <> '') do
               Step := Step.NextTerm;
            if Step.Term = Father.Text then
            begin
               if Length(Son.Text) <> 0 then
               begin
                  Buf := Step.SubTerm;
                  while (Buf.Term <> Son.Text) and (Buf.NextTerm <> Nil) and (Buf.NextTerm.Term <> '') do
                     Buf := Buf.NextTerm;
                  if Buf.Term = Son.Text then
                  begin
                      TempP := Buf.TermPage;
                      if TempP <> Nil then
                      begin
                         if TempP.PageNum = StrToInt(NewTerm.Text) then
                         begin
                            Del := TempP;
                            Buf.TermPage := Del.NextPage;
                            Dispose(Del);
                         end
                         else
                         begin
                            while (TempP.NextPage.PageNum <> StrToInt(NewTerm.Text)) and (TempP.NextPage.NextPage <> Nil) and (TempP.NextPage.PageNum <> 0) do
                               TempP := TempP.NextPage;
                            if TempP.NextPage.PageNum = StrToInt(NewTerm.Text) then
                            begin
                               Del := TempP.NextPage;
                               if Del.NextPage <> Nil then
                               begin
                                  TempP.NextPage := Del.NextPage;
                                  Dispose(Del);
                               end
                               else
                                  Dispose(Del);
                            end;
                         end;
                      end
                      else
                         MessageDlg('������������ ����, �������� ��� �������� �� ����������', mtInformation, mbOKCancel, 0);
                  end
                  else
                     MessageDlg('������������ ����, ������ ��� ���������� �������� �� ����������', mtInformation, mbOKCancel, 0);
               end
               else
                  MessageDlg('������������ ����, ������ ��� ���������� �������� �� ����������', mtInformation, mbOKCancel, 0);
            end
            else
               MessageDlg('������������ ����, ��������� �� ����������', mtInformation, mbOKCancel, 0);
         end
         else
         begin
            if Length(Son.Text) <> 0 then
            begin
               Buf := Temp.SubTerm;
               while (Buf.Term <> Son.Text) and (Buf.NextTerm <> Nil) and (Buf.NextTerm.Term <> '') do
                  Buf := Buf.NextTerm;
               if Buf.Term = Son.Text then
               begin
                  TempP := Buf.TermPage;
                  if TempP <> Nil then
                  begin
                     if TempP.PageNum = StrToInt(NewTerm.Text) then
                     begin
                        Del := TempP;
                        Buf.TermPage := Del.NextPage;
                        Dispose(Del);
                     end
                     else
                     begin
                        while (TempP.NextPage.PageNum <> StrToInt(NewTerm.Text)) and (TempP.NextPage.NextPage <> Nil) and (TempP.NextPage.PageNum <> 0) do
                           TempP := TempP.NextPage;
                        if TempP.NextPage.PageNum = StrToInt(NewTerm.Text) then
                        begin
                           Del := TempP.NextPage;
                           if Del.NextPage <> Nil then
                           begin
                              TempP.NextPage := Del.NextPage;
                              Dispose(Del);
                           end
                           else
                              Dispose(Del);
                        end;
                     end;
                  end
                  else
                     MessageDlg('������������ ����, �������� ��� �������� �� ����������', mtInformation, mbOKCancel, 0);
               end
               else
                  MessageDlg('������������ ����, ������ ��� ���������� �������� �� ����������', mtInformation, mbOKCancel, 0);
            end
            else
               MessageDlg('������������ ����, ������ ��� ���������� �������� �� ����������', mtInformation, mbOKCancel, 0);
         end;
      end
      else
         MessageDlg('������������ ����, ������ �� ����������', mtInformation, mbOKCancel, 0);
   end
   else
   begin
      if Length(Father.Text) > 0 then
      begin
         Step := Temp;
         while (Step.Term <> Father.Text) and (Step.NextTerm <> Nil) and (Step.NextTerm.Term <> '') do
            Step := Step.NextTerm;
         if Step.Term = Father.Text then
         begin
            if Length(Son.Text) <> 0 then
            begin
               Buf := Step.SubTerm;
               while (Buf.Term <> Son.Text) and (Buf.NextTerm <> Nil) and (Buf.NextTerm.Term <> '') do
                  Buf := Buf.NextTerm;
               if Buf.Term = Son.Text then
               begin
                  TempP := Buf.TermPage;
                  if TempP <> Nil then
                  begin
                     if TempP.PageNum = StrToInt(NewTerm.Text) then
                     begin
                        Del := TempP;
                        Buf.TermPage := Del.NextPage;
                        Dispose(Del);
                     end
                     else
                     begin
                        while (TempP.NextPage.PageNum <> StrToInt(NewTerm.Text)) and (TempP.NextPage.NextPage <> Nil) and (TempP.NextPage.PageNum <> 0) do
                           TempP := TempP.NextPage;
                        if TempP.NextPage.PageNum = StrToInt(NewTerm.Text) then
                        begin
                           Del := TempP.NextPage;
                           if Del.NextPage <> Nil then
                           begin
                              TempP.NextPage := Del.NextPage;
                              Dispose(Del);
                           end
                           else
                              Dispose(Del);
                        end;
                     end;
                  end
                  else
                     MessageDlg('������������ ����, �������� ��� �������� �� ����������', mtInformation, mbOKCancel, 0);
               end
               else
                  MessageDlg('������������ ����, ������ ��� ���������� �������� �� ����������', mtInformation, mbOKCancel, 0);
            end
            else
               MessageDlg('������������ ����, ������ ��� ���������� �������� �� ����������', mtInformation, mbOKCancel, 0);
         end
         else
            MessageDlg('������������ ����, ��������� �� ����������', mtInformation, mbOKCancel, 0);
      end
      else
      begin
         if Length(Son.Text) <> 0 then
         begin
            Buf := Temp;
            while (Buf.Term <> Son.Text) and (Buf.NextTerm <> Nil) and (Buf.NextTerm.Term <> '') do
               Buf := Buf.NextTerm;
            if Buf.Term = Son.Text then
            begin
               TempP := Buf.TermPage;
               if TempP <> Nil then
               begin
                  if TempP.PageNum = StrToInt(NewTerm.Text) then
                  begin
                     Del := TempP;
                     Buf.TermPage := Del.NextPage;
                     Dispose(Del);
                  end
                  else
                  begin
                     while (TempP.NextPage.PageNum <> StrToInt(NewTerm.Text)) and (TempP.NextPage.NextPage <> Nil) and (TempP.NextPage.PageNum <> 0) do
                        TempP := TempP.NextPage;
                     if TempP.NextPage.PageNum = StrToInt(NewTerm.Text) then
                     begin
                        Del := TempP.NextPage;
                        if Del.NextPage <> Nil then
                        begin
                           TempP.NextPage := Del.NextPage;
                           Dispose(Del);
                        end
                        else
                           Dispose(Del);
                     end;
                  end;
               end
               else
                  MessageDlg('������������ ����, �������� ��� �������� �� ����������', mtInformation, mbOKCancel, 0);
            end
            else
               MessageDlg('������������ ����, ������ ��� ���������� �������� �� ����������', mtInformation, mbOKCancel, 0);
         end
         else
         MessageDlg('������������ ����, ������ ��� ���������� �������� �� ����������', mtInformation, mbOKCancel, 0);
      end;
   end;
end;

procedure TAdd.DeleteOldTerm(Sender: TObject);
var
   Temp, Step, Buf, Del: TermPoint;
begin
   Temp := Unit1.Lab_Hesh.Root;
   if Length(GrandFather.Text) > 0 then
   begin
      while (Temp.Term <> GrandFather.Text) and (Temp.NextTerm <> Nil) and (Temp.NextTerm.Term <> '') do
         Temp := Temp.NextTerm;
      if Temp.Term = GrandFather.Text then
      begin
         Step := Temp;
         if Length(Father.Text) <> 0 then
         begin
            Step := Temp.SubTerm;
            while (Step.Term <> Father.Text) and (Step.NextTerm <> Nil) and (Step.NextTerm.Term <> '') do
               Step := Step.NextTerm;
            if Step.Term = Father.Text then
            begin
               if Length(NewTerm.Text) <> 0 then
               begin
                  Buf := Step.SubTerm;
                  if Buf.Term = NewTerm.Text then
                  begin
                     Del := Buf;
                     Step.SubTerm := Del.NextTerm;
                     Dispose(Del);
                  end
                  else
                  begin
                     while (Buf.NextTerm.Term <> NewTerm.Text) and (Buf.NextTerm.NextTerm <> Nil) and (Buf.NextTerm.Term <> '') do
                        Buf := Buf.NextTerm;
                     if Buf.NextTerm.Term = NewTerm.Text then
                     begin
                        Del := Buf.NextTerm;
                        if (Del.NextTerm <> nil) and (Del.NextTerm.Term <> '') then
                        begin
                           Buf.NextTerm := Del.NextTerm;
                           Dispose(Del);
                        end
                        else
                        begin
                           Dispose(Del);
                           Buf.NextTerm := Nil;
                        end;
                     end
                  else
                     MessageDlg('������������ ����, ������ ��� �������� �� ����������', mtInformation, mbOKCancel, 0);

                  end;
               end
               else
                  MessageDlg('������������ ����, ������ ��� �������� �� ����������', mtInformation, mbOKCancel, 0);
            end
            else
               MessageDlg('������������ ����, ��������� �� ����������', mtInformation, mbOKCancel, 0);
         end
         else
         begin
            if Length(NewTerm.Text) <> 0 then
            begin
               Buf := Step.SubTerm;
               if Buf.Term = NewTerm.Text then
               begin
                  Del := Buf;
                  Step.SubTerm := Del.NextTerm;
                  Dispose(Del);
               end
               else
               begin
                  while (Buf.NextTerm.Term <> NewTerm.Text) and (Buf.NextTerm.NextTerm <> Nil) and (Buf.NextTerm.Term <> '') do
                     Buf := Buf.NextTerm;
                  if Buf.NextTerm.Term = NewTerm.Text then
                  begin
                     Del := Buf.NextTerm;
                     if (Del.NextTerm <> nil) and (Del.NextTerm.Term <> '') then
                     begin
                        Buf.NextTerm := Del.NextTerm;
                        Dispose(Del);
                     end
                     else
                     begin
                        Dispose(Del);
                        Buf.NextTerm := Nil;
                     end;
                  end
               else
                  MessageDlg('������������ ����, ������ ��� �������� �� ����������', mtInformation, mbOKCancel, 0);

               end;
            end
            else
               MessageDlg('������������ ����, ������ ��� �������� �� ����������', mtInformation, mbOKCancel, 0);
         end;
      end
      else
         MessageDlg('������������ ����, ������ �� ����������', mtInformation, mbOKCancel, 0);
   end
   else
   begin
      if Length(Father.Text) > 0 then
      begin
         Step := Temp;
         while (Step.Term <> Father.Text) and (Step.NextTerm <> Nil) and (Step.NextTerm.Term <> '') do
            Step := Step.NextTerm;
         if Step.Term = Father.Text then
         begin
            if Length(NewTerm.Text) <> 0 then
            begin
               Buf := Step.SubTerm;
               if Buf.Term = NewTerm.Text then
               begin
                  Del := Buf;
                  Step.SubTerm := Del.NextTerm;
                  Dispose(Del);
               end
               else
               begin
                  while (Buf.NextTerm.Term <> NewTerm.Text) and (Buf.NextTerm.NextTerm <> Nil) and (Buf.NextTerm.Term <> '') do
                     Buf := Buf.NextTerm;
                  if Buf.NextTerm.Term = NewTerm.Text then
                  begin
                     Del := Buf.NextTerm;
                     if (Del.NextTerm <> nil) and (Del.NextTerm.Term <> '') then
                     begin
                        Buf.NextTerm := Del.NextTerm;
                        Dispose(Del);
                     end
                     else
                     begin
                        Dispose(Del);
                        Buf.NextTerm := Nil;
                     end;
                  end
                  else
                     MessageDlg('������������ ����, ������ ��� �������� �� ����������', mtInformation, mbOKCancel, 0);

               end;
            end
            else
               MessageDlg('������������ ����, ������ ��� �������� �� ����������', mtInformation, mbOKCancel, 0);
         end
         else
            MessageDlg('������������ ����, ��������� �� ����������', mtInformation, mbOKCancel, 0);
      end
      else
      begin
         if Length(NewTerm.Text) <> 0 then
         begin
            Buf := Temp;
            if Buf.Term = NewTerm.Text then
            begin
               Del := Buf;
               Step.SubTerm := Del.NextTerm;
               Dispose(Del);
            end
            else
            begin
               while (Buf.NextTerm.Term <> NewTerm.Text) and (Buf.NextTerm.NextTerm <> Nil) and (Buf.NextTerm.NextTerm.Term <> '') do
                  Buf := Buf.NextTerm;
               if Buf.NextTerm.Term = NewTerm.Text then
               begin
                  Del := Buf.NextTerm;
                  if (Del.NextTerm <> nil) and (Del.NextTerm.Term <> '') then
                  begin
                     Buf.NextTerm := Del.NextTerm;
                     Dispose(Del);
                  end
                  else
                  begin
                     Dispose(Del);
                     Buf.NextTerm := Nil;
                  end;
               end
               else
                  MessageDlg('������������ ����, ������ ��� �������� �� ����������', mtInformation, mbOKCancel, 0);
            end;
         end
         else
         MessageDlg('������������ ����, ������ ��� �������� �� ����������', mtInformation, mbOKCancel, 0);
      end;
   end;
end;

procedure TAdd.ChangeOldPage(Sender: TObject);
var
   Temp, Step, Buf: TermPoint;
   TempP: PagePoint;
begin
   Temp := Unit1.Lab_Hesh.Root;
   if Length(GrandFather.Text) > 0 then
   begin
      while (Temp.Term <> GrandFather.Text) and (Temp.NextTerm <> Nil) and (Temp.NextTerm.Term <> '') do
         Temp := Temp.NextTerm;
      if Temp.Term = GrandFather.Text then
      begin
         Step := Temp;
         if Length(Father.Text) <> 0 then
         begin
            Step := Temp.SubTerm;
            while (Step.Term <> Father.Text) and (Step.NextTerm <> Nil) and (Step.NextTerm.Term <> '') do
               Step := Step.NextTerm;
            if Step.Term = Father.Text then
            begin
               if Length(Son.Text) <> 0 then
               begin
                  Buf := Step.SubTerm;
                  while (Buf.Term <> Son.Text) and (Buf.NextTerm <> Nil) and (Buf.NextTerm.Term <> '') do
                     Buf := Buf.NextTerm;
                  if Buf.Term = Son.Text then
                  begin
                      TempP := Buf.TermPage;
                      while (TempP.PageNum <> StrToInt(OldPage.Text)) and (TempP.NextPage <> Nil) and (TempP.NextPage.PageNum <> 0) do
                         TempP := TempP.NextPage;
                      if TempP.PageNum = StrToInt(OldPage.Text) then
                      begin
                         TempP.PageNum := StrToInt(NewTerm.Text);
                         SortNewPage(Buf.TermPage);
                      end
                      else
                         MessageDlg('������������ ����, ������� �������� �� ����������', mtInformation, mbOKCancel, 0);
                  end
                  else
                     MessageDlg('Incorrect input, term to change page doesnt exist', mtInformation, mbOKCancel, 0);
               end
               else
                  MessageDlg('Incorrect input, term to change page doesnt exist', mtInformation, mbOKCancel, 0);
            end
            else
               MessageDlg('������������ ����, ��������� �� ����������', mtInformation, mbOKCancel, 0);
         end
         else
         begin
            if Length(Son.Text) <> 0 then
            begin
               Buf := Temp.SubTerm;
               while (Buf.Term <> Son.Text) and (Buf.NextTerm <> Nil) and (Buf.NextTerm.Term <> '') do
                  Buf := Buf.NextTerm;
               if Buf.Term = Son.Text then
               begin
                  TempP := Buf.TermPage;
                  while (TempP.PageNum <> StrToInt(OldPage.Text)) and (TempP.NextPage <> Nil) and (TempP.NextPage.PageNum <> 0) do
                     TempP := TempP.NextPage;
                  if TempP.PageNum = StrToInt(OldPage.Text) then
                  begin
                     TempP.PageNum := StrToInt(NewTerm.Text);
                     SortNewPage(Buf.TermPage);
                  end
                  else
                     MessageDlg('������������ ����, ������� �������� �� ����������', mtInformation, mbOKCancel, 0);
               end
               else
                  MessageDlg('Incorrect input, term to change page doesnt exist', mtInformation, mbOKCancel, 0);
            end
            else
               MessageDlg('Incorrect input, term to change page doesnt exist', mtInformation, mbOKCancel, 0);
         end;
      end
      else
         MessageDlg('������������ ����, ������ �� ����������', mtInformation, mbOKCancel, 0);
   end
   else
   begin
      if Length(Father.Text) > 0 then
      begin
         Step := Temp;
         while (Step.Term <> Father.Text) and (Step.NextTerm <> Nil) and (Step.NextTerm.Term <> '') do
            Step := Step.NextTerm;
         if Step.Term = Father.Text then
         begin
            if Length(Son.Text) <> 0 then
            begin
               Buf := Step.SubTerm;
               while (Buf.Term <> Son.Text) and (Buf.NextTerm <> Nil) and (Buf.NextTerm.Term <> '') do
                  Buf := Buf.NextTerm;
               if Buf.Term = Son.Text then
               begin
                  TempP := Buf.TermPage;
                  while (TempP.PageNum <> StrToInt(OldPage.Text)) and (TempP.NextPage <> Nil) and (TempP.NextPage.PageNum <> 0) do
                     TempP := TempP.NextPage;
                  if TempP.PageNum = StrToInt(OldPage.Text) then
                  begin
                     TempP.PageNum := StrToInt(NewTerm.Text);
                     SortNewPage(Buf.TermPage);
                  end
                  else
                     MessageDlg('������������ ����, ������� �������� �� ����������', mtInformation, mbOKCancel, 0);
               end
               else
                  MessageDlg('������������ ����, ������ ��� ��������� �������� �� ����������', mtInformation, mbOKCancel, 0);
            end
            else
               MessageDlg('������������ ����, ������ ��� ��������� �������� �� ����������', mtInformation, mbOKCancel, 0);
         end
         else
            MessageDlg('������������ ����, ��������� �� ����������', mtInformation, mbOKCancel, 0);
      end
      else
      begin
         if Length(Son.Text) <> 0 then
         begin
            Buf := Temp;
            while (Buf.Term <> Son.Text) and (Buf.NextTerm <> Nil) and (Buf.NextTerm.Term <> '') do
               Buf := Buf.NextTerm;
            if Buf.Term = Son.Text then
            begin
               TempP := Buf.TermPage;
               while (TempP.PageNum <> StrToInt(OldPage.Text)) and (TempP.NextPage <> Nil) and (TempP.NextPage.PageNum <> 0) do
                  TempP := TempP.NextPage;
               if TempP.PageNum = StrToInt(OldPage.Text) then
               begin
                  TempP.PageNum := StrToInt(NewTerm.Text);
                  SortNewPage(Buf.TermPage);
               end
               else
                  MessageDlg('������������ ����, ������� �������� �� ����������', mtInformation, mbOKCancel, 0);
            end
            else
               MessageDlg('������������ ����, ������ ��� ��������� �������� �� ����������', mtInformation, mbOKCancel, 0);
         end
         else
         MessageDlg('������������ ����, ������ ��� ��������� �������� �� ����������', mtInformation, mbOKCancel, 0);
      end;
   end;
end;

procedure TAdd.ChangeOldTerm(Sender: TObject);
var
   Temp, Step, Buf: TermPoint;
begin
   Temp := Unit1.Lab_Hesh.Root;
   if Length(GrandFather.Text) > 0 then
   begin
      while (Temp.Term <> GrandFather.Text) and (Temp.NextTerm <> Nil) and (Temp.NextTerm.Term <> '') do
         Temp := Temp.NextTerm;
      if Temp.Term = GrandFather.Text then
      begin
         Step := Temp;
         if Length(Father.Text) <> 0 then
         begin
            Step := Temp.SubTerm;
            while (Step.Term <> Father.Text) and (Step.NextTerm <> Nil) and (Step.NextTerm.Term <> '') do
               Step := Step.NextTerm;
            if Step.Term = Father.Text then
            begin
               if Length(Son.Text) <> 0 then
               begin
                  Buf := Step.SubTerm;
                  while (Buf.Term <> Son.Text) and (Buf.NextTerm <> Nil) and (Buf.NextTerm.Term <> '') do
                     Buf := Buf.NextTerm;
                  if Buf.Term = Son.Text then
                  begin
                      Buf.Term := NewTerm.Text;
                  end
                  else
                     MessageDlg('������������ ����, ������ ��� ��������� �� ����������', mtInformation, mbOKCancel, 0);
               end
               else
                  MessageDlg('������������ ����, ������ ��� ��������� �� ����������', mtInformation, mbOKCancel, 0);
            end
            else
               MessageDlg('������������ ����, ��������� �� ����������', mtInformation, mbOKCancel, 0);
         end
         else
         begin
            if Length(Son.Text) <> 0 then
            begin
               Buf := Temp.SubTerm;
               while (Buf.Term <> Son.Text) and (Buf.NextTerm <> Nil) and (Buf.NextTerm.Term <> '') do
                  Buf := Buf.NextTerm;
               if Buf.Term = Son.Text then
               begin
                  Buf.Term := NewTerm.Text;
               end
               else
                  MessageDlg('������������ ����, ������ ��� ��������� �� ����������', mtInformation, mbOKCancel, 0);
            end
            else
               MessageDlg('������������ ����, ������ ��� ��������� �� ����������', mtInformation, mbOKCancel, 0);
         end;
      end
      else
         MessageDlg('������������ ����, ������ �� ����������', mtInformation, mbOKCancel, 0);
   end
   else
   begin
      if Length(Father.Text) > 0 then
      begin
         Step := Temp;
         while (Step.Term <> Father.Text) and (Step.NextTerm <> Nil) and (Step.NextTerm.Term <> '') do
            Step := Step.NextTerm;
         if Step.Term = Father.Text then
         begin
            if Length(Son.Text) <> 0 then
            begin
               Buf := Step.SubTerm;
               while (Buf.Term <> Son.Text) and (Buf.NextTerm <> Nil) and (Buf.NextTerm.Term <> '') do
                  Buf := Buf.NextTerm;
               if Buf.Term = Son.Text then
               begin
                  Buf.Term := NewTerm.Text;
               end
               else
                  MessageDlg('������������ ����, ������ ��� ��������� �� ����������', mtInformation, mbOKCancel, 0);
            end
            else
               MessageDlg('������������ ����, ������ ��� ��������� �� ����������', mtInformation, mbOKCancel, 0);
         end
         else
            MessageDlg('������������ ����, ��������� �� ����������', mtInformation, mbOKCancel, 0);
      end
      else
      begin
         if Length(Son.Text) <> 0 then
         begin
            Buf := Temp;
            while (Buf.Term <> Son.Text) and (Buf.NextTerm <> Nil) and (Buf.NextTerm.Term <> '') do
               Buf := Buf.NextTerm;
            if Buf.Term = Son.Text then
            begin
               Buf.Term := NewTerm.Text;
            end
            else
               MessageDlg('������������ ����, ������ ��� ��������� �� ����������', mtInformation, mbOKCancel, 0);
         end
         else
            MessageDlg('������������ ����, ������ ��� ��������� �� ����������', mtInformation, mbOKCancel, 0);
      end;
   end;
end;

procedure TAdd.AddPage(Sender: TObject);
var
   Temp, Step, Buf: TermPoint;
   TempP: PagePoint;
begin
   Temp := Unit1.Lab_Hesh.Root;
   if Length(GrandFather.Text) > 0 then
   begin
      while (Temp.Term <> GrandFather.Text) and (Temp.NextTerm <> Nil) and (Temp.NextTerm.Term <> '') do
         Temp := Temp.NextTerm;
      if Temp.Term = GrandFather.Text then
      begin
         Step := Temp;
         if Length(Father.Text) <> 0 then
         begin
            Step := Temp.SubTerm;
            while (Step.Term <> Father.Text) and (Step.NextTerm <> Nil) and (Step.NextTerm.Term <> '') do
               Step := Step.NextTerm;
            if Step.Term = Father.Text then
            begin
               if Length(Son.Text) <> 0 then
               begin
                  Buf := Step.SubTerm;
                  while (Buf.Term <> Son.Text) and (Buf.NextTerm <> Nil) and (Buf.NextTerm.Term <> '') do
                     Buf := Buf.NextTerm;
                  if Buf.Term = Son.Text then
                  begin
                      TempP := Buf.TermPage;
                      if TempP <> Nil then
                      begin
                         while (TempP.NextPage <> Nil) and (TempP.NextPage.PageNum <> 0) do
                            TempP := TempP.NextPage;
                         New(TempP.NextPage);
                         TempP := TempP.NextPage;
                      end
                      else
                      begin
                         New(Buf.TermPage);
                         TempP := Buf.TermPage;
                      end;
                      TempP.NextPage := Nil;
                      TempP.PageNum := StrToInt(NewTerm.Text);
                      SortNewPage(Buf.TermPage);
                  end
                  else
                     MessageDlg('������������ ����, ������ ��� ���������� �������� �� ����������', mtInformation, mbOKCancel, 0);
               end
               else
                  MessageDlg('������������ ����, ������ ��� ���������� �������� �� ����������', mtInformation, mbOKCancel, 0);
            end
            else
               MessageDlg('������������ ����, ��������� �� ����������', mtInformation, mbOKCancel, 0);
         end
         else
         begin
            if Length(Son.Text) <> 0 then
            begin
               Buf := Temp.SubTerm;
               while (Buf.Term <> Son.Text) and (Buf.NextTerm <> Nil) and (Buf.NextTerm.Term <> '') do
                  Buf := Buf.NextTerm;
               if Buf.Term = Son.Text then
               begin
                  TempP := Buf.TermPage;
                  if TempP <> Nil then
                  begin
                     while (TempP.NextPage <> Nil) and (TempP.NextPage.PageNum <> 0) do
                        TempP := TempP.NextPage;
                     New(TempP.NextPage);
                     TempP := TempP.NextPage;
                  end
                  else
                  begin
                     New(Buf.TermPage);
                     TempP := Buf.TermPage;
                  end;
                  TempP.NextPage := Nil;
                  TempP.PageNum := StrToInt(NewTerm.Text);
                  SortNewPage(Buf.TermPage);
               end
               else
                  MessageDlg('������������ ����, ������ ��� ���������� �������� �� ����������', mtInformation, mbOKCancel, 0);
            end
            else
               MessageDlg('������������ ����, ������ ��� ���������� �������� �� ����������', mtInformation, mbOKCancel, 0);
         end;
      end
      else
         MessageDlg('������������ ����, ������ �� ����������', mtInformation, mbOKCancel, 0);
   end
   else
   begin
      if Length(Father.Text) > 0 then
      begin
         Step := Temp;
         while (Step.Term <> Father.Text) and (Step.NextTerm <> Nil) and (Step.NextTerm.Term <> '') do
            Step := Step.NextTerm;
         if Step.Term = Father.Text then
         begin
            if Length(Son.Text) <> 0 then
            begin
               Buf := Step.SubTerm;
               while (Buf.Term <> Son.Text) and (Buf.NextTerm <> Nil) and (Buf.NextTerm.Term <> '') do
                  Buf := Buf.NextTerm;
               if Buf.Term = Son.Text then
               begin
                  TempP := Buf.TermPage;
                  if TempP <> Nil then
                  begin
                     while (TempP.NextPage <> Nil) and (TempP.NextPage.PageNum <> 0) do
                        TempP := TempP.NextPage;
                     New(TempP.NextPage);
                     TempP := TempP.NextPage;
                  end
                  else
                  begin
                     New(Buf.TermPage);
                     TempP := Buf.TermPage;
                  end;
                  TempP.NextPage := Nil;
                  TempP.PageNum := StrToInt(NewTerm.Text);
                  SortNewPage(Buf.TermPage);
               end
               else
                  MessageDlg('������������ ����, ������ ��� ���������� �������� �� ����������', mtInformation, mbOKCancel, 0);
            end
            else
               MessageDlg('������������ ����, ������ ��� ���������� �������� �� ����������', mtInformation, mbOKCancel, 0);
         end
         else
            MessageDlg('������������ ����, ��������� �� ����������', mtInformation, mbOKCancel, 0);
      end
      else
      begin
         if Length(Son.Text) <> 0 then
         begin
            Buf := Temp;
            while (Buf.Term <> Son.Text) and (Buf.NextTerm <> Nil) and (Buf.NextTerm.Term <> '') do
               Buf := Buf.NextTerm;
            if Buf.Term = Son.Text then
            begin
               TempP := Buf.TermPage;
               if TempP <> Nil then
               begin
                  while (TempP.NextPage <> Nil) and (TempP.NextPage.PageNum <> 0) do
                     TempP := TempP.NextPage;
                  New(TempP.NextPage);
                  TempP := TempP.NextPage;
               end
               else
               begin
                  New(Buf.TermPage);
                  TempP := Buf.TermPage;
               end;
               TempP.NextPage := Nil;
               TempP.PageNum := StrToInt(NewTerm.Text);
               SortNewPage(Buf.TermPage);
            end
            else
               MessageDlg('������������ ����, ������ ��� ���������� �������� �� ����������', mtInformation, mbOKCancel, 0);
         end
         else
         MessageDlg('������������ ����, ������ ��� ���������� �������� �� ����������', mtInformation, mbOKCancel, 0);
      end;
   end;
end;

procedure TAdd.AddTerm(Sender: TObject);
var
   Temp, Step, Buf: TermPoint;
begin
   Temp := Unit1.Lab_Hesh.Root;
   if Length(GrandFather.Text) > 0 then
   begin
      while (Temp.Term <> GrandFather.Text) and (Temp.NextTerm <> Nil) and (Temp.NextTerm.Term <> '') do
         Temp := Temp.NextTerm;
      if Temp.Term = GrandFather.Text then
      begin
         Step := Temp;
         if Length(Father.Text) <> 0 then
         begin
            Step := Temp.SubTerm;
            while (Step.Term <> Father.Text) and (Step.NextTerm <> Nil) and (Step.NextTerm.Term <> '') do
               Step := Step.NextTerm;
            if Step.Term = Father.Text then
            begin
               Buf := Step.SubTerm;
               if Buf <> Nil then
               begin
                  while (Buf.NextTerm <> Nil) and (Buf.NextTerm.Term <> '') do
                     Buf := Buf.NextTerm;
                  New(Buf.NextTerm);
                  Buf := Buf.NextTerm;
               end
               else
               begin
                  New(Step.SubTerm);
                  Buf := Step.SubTerm
               end;
               Buf.NextTerm := Nil;
               Buf.SubTerm := Nil;
               Buf.TermPage := Nil;
               Buf.Term := NewTerm.Text;
            end
            else
            begin
               MessageDlg('������������ ����, ��������� �� ����������', mtInformation, mbOKCancel, 0);
            end;
         end
         else
         begin
            Buf := Step.SubTerm;
            if Buf <> Nil then
            begin
               while (Buf.NextTerm <> Nil) and (Buf.NextTerm.Term <> '') do
                  Buf := Buf.NextTerm;
               New(Buf.NextTerm);
               Buf := Buf.NextTerm;
            end
            else
            begin
               New(Step.SubTerm);
               Buf := Step.SubTerm
            end;
            Buf.NextTerm := Nil;
            Buf.SubTerm := Nil;
            Buf.TermPage := Nil;
            Buf.Term := NewTerm.Text;
         end;
      end
      else
         MessageDlg('������������ ����, ������ �� ����������', mtInformation, mbOKCancel, 0);
   end
   else
   begin
      Step := Unit1.Lab_Hesh.Root;
      if Length(Father.Text) <> 0 then
      begin
        while (Step.Term <> Father.Text) and (Step.NextTerm <> Nil) and (Step.NextTerm.Term <> '') do
           Step := Step.NextTerm;
        if Step.Term = Father.Text then
        begin
           Buf := Step.SubTerm;
           if Buf <> Nil then
           begin
              while (Buf.NextTerm <> Nil) and (Buf.NextTerm.Term <> '') do
                 Buf := Buf.NextTerm;
              New(Buf.NextTerm);
              Buf := Buf.NextTerm;
           end
           else
           begin
              New(Step.SubTerm);
              Buf := Step.SubTerm
           end;
           Buf.NextTerm := Nil;
           Buf.SubTerm := Nil;
           Buf.TermPage := Nil;
           Buf.Term := NewTerm.Text;
        end
        else
           MessageDlg('������������ ����, ��������� �� ����������', mtInformation, mbOKCancel, 0);
      end
      else
      begin
         while (Step.NextTerm <> Nil) and (Step.NextTerm.Term <> '') do
            Step := Step.NextTerm;
         New(Step.NextTerm);
         Step := Step.NextTerm;
         Step.NextTerm := Nil;
         Step.SubTerm := Nil;
         Step.TermPage := Nil;
         Step.Term := NewTerm.Text;
      end;
   end;
end;

procedure TAdd.NewTermChange(Sender: TObject);
begin
   if Length(NewTerm.Text) > 0 then
   begin
      Father.Enabled := True;
      GrandFather.Enabled := True;
      Action.Enabled := True;
   end
   else
   begin
      Father.Enabled := False;
      GrandFather.Enabled := False;
      Action.Enabled := False;
   end;
end;

procedure TAdd.SonChange(Sender: TObject);
begin
   if Length(Son.Text) > 0 then
      NewTerm.Enabled := True
   else
      NewTerm.Enabled := False;
end;

end.
