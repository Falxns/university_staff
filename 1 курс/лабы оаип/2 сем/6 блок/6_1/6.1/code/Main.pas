unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Grids, Vcl.StdCtrls;

type
    Pointer = ^TText;
    TText = Record
        Data: String[15];
        Next: Pointer;
    end;
    TMainForm = class(TForm)
    SG: TStringGrid;
    MainMenu: TMainMenu;
    PopupMenu: TPopupMenu;
    About: TMenuItem;
    Developer: TMenuItem;
    Info: TMenuItem;
    Add: TButton;
    Delete: TButton;
    Show: TButton;
    Label1: TLabel;
    procedure InfoClick(Sender: TObject);
    procedure DeveloperClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure AddClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DeleteClick(Sender: TObject);
    procedure ShowClick(Sender: TObject);
  public
    Head, CopyHead, Buff: Pointer;
    i: Byte;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses AddText;

procedure TMainForm.AddClick(Sender: TObject);
begin
    Visible := false;
    with AddF as TAddF do
    begin
        TextT.Clear;
        Submit.Enabled := false;
        ShowModal;
    end;
end;

procedure TMainForm.DeleteClick(Sender: TObject);
var
    ButtonSelected, j, k: ShortInt;
    Del, Prev: Pointer;
begin
    if (SG.Row <> 0) then
    begin
        ButtonSelected := MessageDlg('Are you sure you want to delete this record?', mtConfirmation, [mbYes,mbNo], 0);
        if ButtonSelected = mrYes then
        begin
            Del := CopyHead;
            j := 0;
            Head := CopyHead;
            while SG.Row <> j do
            begin
                Del := Del^.Next;
                inc(j);
            end;
            if Del = CopyHead then
            begin
                Head := Del^.Next;
                CopyHead := Head;
                for k := 1 to i - 2 do
                    SG.Cells[0, k] := SG.Cells[0, k + 1];
                SG.Cells[0, i - 1] := '';
            end
            else
            begin
                Prev := Head^.Next;
                while (Prev^.Next <> Del)and(Prev^.Next <> nil) do
                    Prev := Prev^.Next;
                Prev^.Next := Del^.Next;
                for k := j to i - 2 do
                    SG.Cells[0, k] := SG.Cells[0, k + 1];
                SG.Cells[0, i - 1] := '';
            end;
            Dispose(Del);
            SG.RowCount := i - 1;
            dec(i);
        end;
        if SG.RowCount = 1 then
            Delete.Enabled := false;
        if SG.RowCount > 2 then
            Show.Enabled := true
        else
            Show.Enabled := false;
    end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
    i := 1;
    Delete.Enabled := false;
    Show.Enabled := false;
    with SG as TStringGrid do
    begin
        RowCount := 1;
        Cells[0, 0] := 'Text';
    end;
    New(Head);
    Head^.Data := '';
    Head^.Next := nil;
    CopyHead := Head;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
    ButtonSelected: Byte;
begin
    ButtonSelected := MessageDlg('Are you sure you want to exit?', mtConfirmation, [mbYes,mbNo], 0);
    if ButtonSelected <> mrYes then
        CanClose := False;
end;

procedure TMainForm.DeveloperClick(Sender: TObject);
begin
    MessageDlg('This program is developed by Maksim Gladkiy, group 851001.', mtInformation, [mbOk], 0);
end;

procedure TMainForm.InfoClick(Sender: TObject);
begin
    MessageDlg('This program is Single Linked List.' + #10#13 + 'You can add and delete any text in it.' + #10#13 + 'Also it shows number of meetings of selected element.', mtInformation, [mbOk], 0);
end;

procedure TMainForm.ShowClick(Sender: TObject);
var
    Str, Answ: String[15];
    z: Integer;
begin
    if (SG.Row <> 0) then
    begin
        z := 0;
        Head := CopyHead;
        Str := SG.Cells[0, SG.Row];
        while Head <> nil do
        begin
            if Head^.Data = Str then
                inc(z);
            Head := Head^.Next;
        end;
        MessageDlg('This record meets ' + IntToStr(z) + ' times', mtInformation, [mbOk], 0);
    end;
end;

end.
