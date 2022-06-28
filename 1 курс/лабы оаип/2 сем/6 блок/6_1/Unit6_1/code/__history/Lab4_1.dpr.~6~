program Lab4_1;

uses
  Vcl.Forms,
  Main in 'Main.pas' {MainForm},
  Vcl.Themes,
  Vcl.Styles,
  Product in 'Product.pas' {AddF},
  Sorting in 'Sorting.pas' {SortF};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Onyx Blue');
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAddF, AddF);
  Application.CreateForm(TSortF, SortF);
  Application.Run;
end.
