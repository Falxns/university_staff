unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Grids, Vcl.StdCtrls;

type
    TProduct = Record
        Title: String[15];
        Sort: String[1];
        Price: String[5];
        Date: String[10];
    end;
    TBaseProd = array of TProduct;
    TMainForm = class(TForm)
    SG: TStringGrid;
    MainMenu: TMainMenu;
    PopupMenu: TPopupMenu;
    FileM: TMenuItem;
    About: TMenuItem;
    Openfile: TMenuItem;
    Savetofile: TMenuItem;
    N1: TMenuItem;
    Exit: TMenuItem;
    Developer: TMenuItem;
    Info: TMenuItem;
    Open: TOpenDialog;
    Save: TSaveDialog;
    Add: TButton;
    Edit: TButton;
    Delete: TButton;
    Show: TButton;
    Label1: TLabel;
    procedure InfoClick(Sender: TObject);
    procedure DeveloperClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ExitClick(Sender: TObject);
    procedure AddClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EditClick(Sender: TObject);
    procedure DeleteClick(Sender: TObject);
    procedure ShowClick(Sender: TObject);
    procedure SavetofileClick(Sender: TObject);
    procedure OpenfileClick(Sender: TObject);
  public
    ProdList: TBaseProd;
    NewArr: TBaseProd;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses Product, Sorting;

procedure TMainForm.AddClick(Sender: TObject);
begin
    Visible := false;
    with AddF as TAddF do
    begin
        PrName.Clear;
        PrSort.Clear;
        PrPrice.Clear;
        Day.Clear;
        Month.Clear;
        Year.Clear;
        Submit.Enabled := false;
        Caption := 'Add product';
        Submit.Caption := 'Add';
        ShowModal;
    end;
end;

procedure TMainForm.EditClick(Sender: TObject);
begin
    if (SG.Row <> 0) then
    begin
        Visible := false;
        with AddF as TAddF do
        begin
            Caption := 'Edit product';
            PrName.Text := ProdList[SG.Row - 1].Title;
            PrSort.Text := ProdList[SG.Row - 1].Sort;
            PrPrice.Text := ProdList[SG.Row - 1].Price;
            Day.Text := Copy(ProdList[SG.Row - 1].Date, 1, 2);
            Month.Text := Copy(ProdList[SG.Row - 1].Date, 4, 2);
            Year.Text := Copy(ProdList[SG.Row - 1].Date, 7, 4);
            Submit.Caption := 'Edit';
            ShowModal;
        end;
    end;
end;

procedure TMainForm.DeleteClick(Sender: TObject);
var
    ButtonSelected, i: ShortInt;
begin
    if (SG.Row <> 0) then
    begin
        ButtonSelected := MessageDlg('Are you sure you want to delete this product?', mtConfirmation, [mbYes,mbNo], 0);
        if ButtonSelected = mrYes then
        begin
            for i := (SG.Row - 1) to High(ProdList) - 1 do
                begin
                    ProdList[i] := ProdList[i + 1];
                    with SG as TStringGrid do
                    begin
                        Cells[0, i + 1] := ProdList[i].Title;
                        Cells[1, i + 1] := ProdList[i].Sort;
                        Cells[2, i + 1] := ProdList[i].Price;
                        Cells[3, i + 1] := ProdList[i].Date;
                    end;
                end;
                SetLength(ProdList, Length(ProdList) - 1);
                SG.RowCount := Length(ProdList) + 1;
        end;
        if SG.RowCount = 1 then
        begin
            Delete.Enabled := false;
            Edit.Enabled := false;
            Savetofile.Enabled := false;
            Show.Enabled := false;
        end;
    end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
    Savetofile.Enabled := false;
    Edit.Enabled := false;
    Delete.Enabled := false;
    Show.Enabled := false;
    with SG as TStringGrid do
    begin
        RowCount := 1;
        Cells[0, 0] := 'Product title';
        Cells[1, 0] := 'Sort';
        Cells[2, 0] := 'Price';
        Cells[3, 0] := 'Date of delivery';
    end;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
    ButtonSelected: Byte;
begin
    ButtonSelected := MessageDlg('Are you sure you want to exit?', mtConfirmation, [mbYes,mbNo], 0);
    if ButtonSelected <> mrYes then
        CanClose := False;
end;

procedure TMainForm.ExitClick(Sender: TObject);
begin
    Close;
end;

procedure TMainForm.DeveloperClick(Sender: TObject);
begin
    MessageDlg('This program is developed by Maksim Gladkiy.', mtInformation, [mbOk], 0);
end;

procedure TMainForm.InfoClick(Sender: TObject);
begin
    MessageDlg('This is a prototype of shop.' + #10#13 + 'You can add products, edit their information and delete them.' + #10#13 + 'Program find''s products of first sort, which were brought last month, and sort them in alphabet order.', mtInformation, [mbOk], 0);
end;

procedure TMainForm.OpenfileClick(Sender: TObject);
var
    InputFile: File of TProduct;
    i, j: Byte;
    Temp: SmallInt;
begin
    if Open.Execute then
    begin
        try
            AssignFile(InputFile, Open.FileName);
            Reset(InputFile);
            i := 0;
            repeat
                SetLength(ProdList, i + 1);
                Read(InputFile, ProdList[i]);
                Inc(i);
            until EoF(InputFile);
            SG.RowCount := i + 1;
            with SG as TStringGrid do
            for i := 0 to High(ProdList) do
            begin
                Cells[0, i + 1] := ProdList[i].Title;
                Cells[1, i + 1] := ProdList[i].Sort;
                Cells[2, i + 1] := ProdList[i].Price;
                Cells[3, i + 1] := ProdList[i].Date;
            end;
            CloseFile(InputFile);
            Savetofile.Enabled := true;
            Edit.Enabled := true;
            Delete.Enabled := true;
            if (SG.RowCount > 1) then
                Show.Enabled := true
            else
                Show.Enabled := false;
        except
            MessageDlg('Check entered data. Try again.', mtError, [mbRetry], 0);
            CloseFile(InputFile);
        end;
    end;
end;

procedure TMainForm.SavetofileClick(Sender: TObject);
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
        for i := 0 to High(ProdList) do
            Write(OutputFile, ProdList[i]);
        CloseFile(OutputFile);
    end;
end;

procedure TMainForm.ShowClick(Sender: TObject);
begin
    Visible := false;
    SortF.ShowModal;
end;

end.
