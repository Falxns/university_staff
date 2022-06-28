unit Sorting;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Grids, Vcl.StdCtrls;

type
    TSortF = class(TForm)
    SGR: TStringGrid;
    SortMenu: TMainMenu;
    Help: TMenuItem;
    Close: TButton;
    Save: TSaveDialog;
    SavetoFileS: TMenuItem;
    procedure HelpClick(Sender: TObject);
    procedure CloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SavetoFileSClick(Sender: TObject);
  private
  public
  end;

var
    SortF: TSortF;

implementation

{$R *.dfm}

uses Main, Product;

procedure TSortF.CloseClick(Sender: TObject);
begin
    MainForm.Visible := true;
end;

procedure TSortF.FormShow(Sender: TObject);
var
    i, j: Byte;
    Temp: TProduct;
begin
    with SGR as TStringGrid do
    begin
        RowCount := 10;
        Cells[0, 0] := 'Product title';
        Cells[1, 0] := 'Sort';
        Cells[2, 0] := 'Price';
        Cells[3, 0] := 'Date of delivery';
    end;
    With MainForm as TMainForm do
    begin
        j := 0;
        SetLength(NewArr, High(ProdList) + 1);
        for i := 0 to High(ProdList) do
            if (ProdList[i].Date[4] = '0')and(ProdList[i].Date[5] = '1')and(ProdList[i].Date[7] = '2')and(ProdList[i].Date[8] = '0')and(ProdList[i].Date[9] = '1')and(ProdList[i].Date[10] = '9')and(ProdList[i].Sort = '1') then
            begin
                NewArr[j] := ProdList[i];
                inc(j);
            end;
        for i := 1 to j - 1 do
            if NewArr[i - 1].Title[1] > NewArr[i].Title[1] then
            begin
                Temp := NewArr[i];
                NewArr[i] := NewArr[i - 1];
                NewArr[i - 1] := Temp;
            end;
    end;
    with SGR as TStringGrid do
    begin
        for i := 0 to j do
        begin
            Cells[0, i + 1] := MainForm.NewArr[i].Title;
            Cells[1, i + 1] := MainForm.NewArr[i].Sort;
            Cells[2, i + 1] := MainForm.NewArr[i].Price;
            Cells[3, i + 1] := MainForm.NewArr[i].Date;
        end;
    end;
end;

procedure TSortF.HelpClick(Sender: TObject);
begin
    MessageDlg('This page shows products of 1 sort, which were brought last month, in alphabet order.', mtInformation, [mbOk], 0);
end;

procedure TSortF.SavetoFileSClick(Sender: TObject);
var
    OutputFile: File of TProduct;
    MyFile: String;
    ButtonSelected, i: Byte;
begin
    if Save.Execute then
    begin
        MyFile := Save.FileName;
        AssignFile(OutputFile, MyFile);
        Rewrite(OutputFile);
        for i := 0 to High(MainForm.NewArr) do
            Write(OutputFile, MainForm.NewArr[i]);
        CloseFile(OutputFile);
    end;
end;

end.
