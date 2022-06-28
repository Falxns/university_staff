unit Product;

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
    PrName: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    PrSort: TEdit;
    Label3: TLabel;
    PrPrice: TEdit;
    Label4: TLabel;
    Day: TEdit;
    Label5: TLabel;
    Month: TEdit;
    Label6: TLabel;
    Year: TEdit;
    procedure SubmitClick(Sender: TObject);
    procedure HelpClick(Sender: TObject);
    procedure CancelClick(Sender: TObject);
    procedure DayKeyPress(Sender: TObject; var Key: Char);
    procedure DayKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MonthKeyPress(Sender: TObject; var Key: Char);
    procedure MonthKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure YearKeyPress(Sender: TObject; var Key: Char);
    procedure YearKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PrPriceKeyPress(Sender: TObject; var Key: Char);
    procedure PrPriceKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PrSortKeyPress(Sender: TObject; var Key: Char);
    procedure PrNameKeyPress(Sender: TObject; var Key: Char);
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

uses Main, Sorting;

procedure TAddF.SubmitClick(Sender: TObject);
begin
    if Caption = 'Add product' then
        with MainForm as TMainForm do
        begin
            SetLength(ProdList, Length(ProdList) + 1);
            ProdList[High(ProdList)].Title := PrName.Text;
            ProdList[High(ProdList)].Sort := PrSort.Text;
            ProdList[High(ProdList)].Price := PrPrice.Text;
            ProdList[High(ProdList)].Date := Day.Text + '.' + Month.Text + '.' + Year.Text;
            SG.RowCount := SG.RowCount + 1;
            SG.Cells[0, Length(ProdList)] := ProdList[High(ProdList)].Title;
            SG.Cells[1, Length(ProdList)] := ProdList[High(ProdList)].Sort;
            SG.Cells[2, Length(ProdList)] := ProdList[High(ProdList)].Price;
            SG.Cells[3, Length(ProdList)] := ProdList[High(ProdList)].Date;
            Savetofile.Enabled := true;
        end
    else
        with MainForm as TMainForm do
        begin
            ProdList[SG.Row - 1].Title := PrName.Text;
            ProdList[SG.Row - 1].Sort := PrSort.Text;
            ProdList[SG.Row - 1].Price := PrPrice.Text;
            ProdList[SG.Row - 1].Date := Day.Text + '.' + Month.Text + '.' + Year.Text;
            SG.Cells[0, SG.Row] := ProdList[SG.Row - 1].Title;
            SG.Cells[1, SG.Row] := ProdList[SG.Row - 1].Sort;
            SG.Cells[2, SG.Row] := ProdList[SG.Row - 1].Price;
            SG.Cells[3, SG.Row] := ProdList[SG.Row - 1].Date;
        end;
    MainForm.Edit.Enabled := true;
    MainForm.Delete.Enabled := true;
    MainForm.Visible := true;
end;

procedure TAddF.HelpClick(Sender: TObject);
begin
    MessageDlg('Here you can add products to the list.' + #10#13 + 'Name length is [1..15].' + #10#13 + 'Sort is [1..4].' + #10#13 + 'Price is [1..2000].' + #10#13 + 'Date: Day [1..31], Month [1..12], Year [2014..2019].', mtInformation, [mbOk], 0);
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
    if (Length(PrName.Text) > 0)
    and (Length(PrSort.Text) = 1)
    and (Length(PrPrice.Text) > 0)
    and (Length(Day.Text) = 2)
    and (Length(Month.Text) = 2)
    and (Length(Year.Text) = 4)
    then
        Submit.Enabled := true
    else
        Submit.Enabled := false;
end;

procedure TAddF.PrNameKeyPress(Sender: TObject; var Key: Char);
var
    Letters: set of Char;
begin
    Letters := ['A'..'z', '.', '-', ' ', #8];
    with PrName as TEdit do
    begin
        if not(Key in Letters) then
            Key := #0;
        if (Length(Text) <> SelStart) then
            Key := #0;
        if (Length(Text) = 15) and (Key <> #8)then
            Key := #0
    end;
end;

procedure TAddF.PrSortKeyPress(Sender: TObject; var Key: Char);
var
    Numerals: set of Char;
begin
    Numerals := ['1'..'4', #8];
    with PrSort as TEdit do
    begin
        if not(Key in Numerals) then
            Key := #0;
        if (Length(Text) <> SelStart) then
            Key := #0;
        if (Length(Text) = 1) and (Key <> #8)then
            Key := #0;
    end;
end;

procedure TAddF.PrPriceKeyPress(Sender: TObject; var Key: Char);
var
    Numerals: set of Char;
begin
    Numerals := ['0'..'9', #8];
    with PrPrice as TEdit do
    begin
        if not(Key in Numerals) then
            Key := #0;
        if (Length(Text) <> SelStart) then
            Key := #0;
        if (Length(Text) = 0) and (Key = '0')then
            Key := #0;
        if (Length(Text) = 4) and (Key <> #8)then
            Key := #0;
    end;
end;

procedure TAddF.PrPriceKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    with PrPrice as Tedit do
    begin
        if (Length(Text) = 4) and ((StrToInt(Text) > 2000) or (StrToInt(Text) < 1)) then
            Text := '';
    end;
end;

procedure TAddF.DayKeyPress(Sender: TObject; var Key: Char);
var
    Numerals: set of Char;
begin
    Numerals := ['0'..'9', #8];
    with Day as TEdit do
    begin
        if not(Key in Numerals) then
            Key := #0;
        if (Length(Text) <> SelStart) then
            Key := #0;
        if (Length(Text) = 2) and (Key <> #8)then
            Key := #0;
    end;
end;

procedure TAddF.DayKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    with Day as Tedit do
    begin
        if (Length(Text) = 2) and ((StrToInt(Text) > 31) or (StrToInt(Text) = 0)) then
            Text := '';
    end;
end;

procedure TAddF.MonthKeyPress(Sender: TObject; var Key: Char);
var
    Numerals: set of Char;
begin
    Numerals := ['0'..'9', #8];
    with Month as TEdit do
    begin
        if not(Key in Numerals) then
            Key := #0;
        if (Length(Text) <> SelStart) then
            Key := #0;
        if (Length(Text) = 2) and (Key <> #8)then
            Key := #0;
    end;
end;

procedure TAddF.MonthKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    with Month as Tedit do
    begin
        if (Length(Text) = 2) and ((StrToInt(Text) > 12) or (StrToInt(Text) = 0)) then
            Text := '';
    end;
end;

procedure TAddF.YearKeyPress(Sender: TObject; var Key: Char);
var
    Numerals: set of Char;
begin
    Numerals := ['0'..'9', #8];
    with Year as TEdit do
    begin
        if not(Key in Numerals) then
            Key := #0;
        if (Length(Text) <> SelStart) then
            Key := #0;
        if (Length(Text) = 4) and (Key <> #8)then
            Key := #0;
    end;
end;

procedure TAddF.YearKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    with Year as Tedit do
    begin
        if (Length(Text) = 4) and ((StrToInt(Text) > 2019) or (StrToInt(Text) < 2014)) then
            Text := '';
    end;
end;

end.
