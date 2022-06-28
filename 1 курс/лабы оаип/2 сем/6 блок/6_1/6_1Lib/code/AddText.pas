unit AddText;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus;

type
    TAddF = class(TForm)
       Submit: TButton;
       AddMenu: TMainMenu;
       Help: TMenuItem;
       Cancel: TButton;
       TextT: TEdit;
       Label1: TLabel;
       procedure SubmitClick(Sender: TObject);
       procedure HelpClick(Sender: TObject);
       procedure CancelClick(Sender: TObject);
       procedure TextTKeyPress(Sender: TObject; var Key: Char);
       procedure FormClose(Sender: TObject; var Action: TCloseAction);
       procedure PrChange(Sender: TObject);
    private
    { Private declarations }
    public
    { Public declarations }
    end;

var
  AddF: TAddF;

implementation

{$R *.dfm}

uses Main;

procedure TAddF.SubmitClick(Sender: TObject);
var
   Str: String;
begin
    with MainForm as TMainForm do
    begin
        Head := CopyHead;
        Str := TextT.Text;
        _AddEl(Head, Buff, Str);
        SG.RowCount := i + 1;
        SG.Cells[0, i] := TextT.Text;
        inc(i);
        if SG.RowCount > 2 then
            Show.Enabled := true
        else
            Show.Enabled := false;
    end;
    MainForm.Delete.Enabled := true;
    MainForm.Visible := true;
end;

procedure TAddF.HelpClick(Sender: TObject);
begin
    MessageDlg('Here you can add text to the list.' + #10#13 + 'Text length is [1..40].' + #10#13 + 'Use [''A..z'' ; ''-'' ; ''.'']', mtInformation, [mbOk], 0);
end;

procedure TAddF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    MainForm.Visible := true;
end;

procedure TAddF.CancelClick(Sender: TObject);
begin
    MainForm.Visible := true;
end;

procedure TAddF.PrChange(Sender: TObject);
begin
    if Length(TextT.Text) > 0 then
        Submit.Enabled := true
    else
        Submit.Enabled := false;
end;

procedure TAddF.TextTKeyPress(Sender: TObject; var Key: Char);
var
    Letters: set of Char;
begin
    Letters := ['A'..'z', '.', '-', ' ', #8];
    with TextT as TEdit do
    begin
        if not(Key in Letters) then
            Key := #0;
        if (Length(Text) <> SelStart) then
            Key := #0;
        if (Length(Text) = 40) and (Key <> #8)then
            Key := #0
    end;
end;

end.
