{
1. �������� �����;
2. ���������� ��������� ������ ������;
3. ���������� ������� ������ ������;
4. ���������� �������������� ������ ������;
5. ���������� ��������� ������ ������;
6. ������������ ������ �������� ������;
(7). ����� ���������� ��������;
(8). ���������� ������� 2-6.
}
unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids;

const
  R = 15;
  DOWN = 40;
  SIDE = 250;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Button1: TButton;
    StringGrid1: TStringGrid;
    L1: TLabeledEdit;
    Button2: TButton;
    Label1: TLabel;
    me1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  pt = ^TTree;
  TTree = record
    data: integer;
    left, right: pt;
    x, y: integer;
  end;

var
  Form1: TForm1;
  root, tree: pt;
  d: real;
  s: string;
  arr: array of integer;
  k: integer;
  fd: boolean;

procedure Insert(var a: pt; b, x, y: integer);
procedure Build(a: pt);
procedure pryam(var x: pt);
procedure sim(var x: pt);
procedure obr(var x: pt);
procedure prosh;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Image1.Visible := true;
  new(tree);
  tree^.left := nil;
  tree^.right := nil;
  StringGrid1.Cells[0,0] := '15';
  StringGrid1.Cells[1,0] := '12';
  StringGrid1.Cells[2,0] := '11';
  StringGrid1.Cells[3,0] := '13';
  StringGrid1.Cells[4,0] := '17';
  StringGrid1.Cells[5,0] := '19';
  StringGrid1.Cells[6,0] := '16';
  StringGrid1.Cells[7,0] := '10';
  StringGrid1.Cells[8,0] := '21';
  StringGrid1.Cells[9,0] := '14';
  root := tree;
  tree^.data := strToInt(StringGrid1.Cells[0,0]);
  tree^.x := trunc(Image1.Width/2);
  tree^.y := trunc(DOWN);
end;

procedure Insert(var a: pt; b, x, y: integer);
begin
  if a = nil then
  begin
    new(a);
    a^.data := b;
    a^.left := nil;
    a^.right := nil;
    a^.x := x;
    a^.y := y;
  end
  else
    if b <= a^.data then
    begin
      d := d + 1;
      x := x - trunc(SIDE/(2+d));
      y := y + DOWN + 20;
      insert(a^.left, b, x, y);
      d := d - 1;
    end
    else
    begin
      d := d + 1;
      x := x + trunc(SIDE/(2+d));
      y := y + DOWN + 20;
      insert(a^.right, b, x, y);
      d := d - 1;
    end;
end;

procedure Build(a: pt);
begin
  with Form1 do
  begin
    Image1.Canvas.Brush.Color := clLime;
    Image1.Canvas.Pen.Color := clRed;
    Image1.Canvas.Ellipse(a^.x-R, a^.y-R, a^.x+R, a^.y+R);
    Image1.Canvas.TextOut(a^.x-trunc(R/2), a^.y-trunc(R/2), IntToStr(a^.data));
    if a^.left <> nil then
    begin
      Image1.Canvas.MoveTo(a^.x - 13, a^.y + 5);
      Image1.Canvas.LineTo(a^.x - trunc(SIDE/(2+d)), a^.y + DOWN + 20);
      d := d + 1;
      build(a^.left);
      Image1.Canvas.MoveTo(a^.x, a^.y);
      d := d - 1;
    end;
    if a^.right <> nil then
    begin
      Image1.Canvas.MoveTo(a^.x + 13, a^.y + 5);
      Image1.Canvas.LineTo(a^.x + trunc(SIDE/(2+d)), a^.y + DOWN + 20);
      d := d + 1;
      build(a^.right);
      Image1.Canvas.MoveTo(a^.x, a^.y);
      d := d - 1;
    end;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i: integer;
begin
  i := 1;
  tree := root;
  tree^.left := nil;
  tree^.right := nil;
  tree^.data := strToInt(Form1.StringGrid1.Cells[0, 0]);
  while Form1.StringGrid1.Cells[i, 0] <> '' do
  begin
    tree := root;
    d := -2;
    insert(tree, strToInt(Form1.StringGrid1.Cells[i, 0]), tree^.x, tree^.y);
    inc(i);
  end;
  setLength(arr, i);
  d := -1;
  tree := root;
  Image1.Picture.Graphic := nil;
  build(tree);
  s := '';
  tree := root;
  k := 0;
  pryam(tree);
  me1.Lines.Text := '������ �����:' + s + #13#10;
  s := '';
  tree := root;
  sim(tree);
  me1.Lines.Text := me1.Lines.Text + '������������ �����:' + s + #13#10;
  s := '';
  tree := root;
  obr(tree);
  me1.Lines.Text := me1.Lines.Text + '�������� �����:' + s + #13#10;
  prosh;
end;

procedure pryam(var x: pt);
begin
  if x <> nil then
  begin
    s := s + '  (' + intToStr(x^.data) + ')';
    pryam(x^.left);
    s := s + '  ' + intToStr(x^.data);
    pryam(x^.right);
    s := s + '  ' + intToStr(x^.data);
  end
  else
    s := s + '  0';
end;

procedure sim(var x: pt);
begin
  if x <> nil then
  begin
    s := s + '  ' + intToStr(x^.data);
    sim(x^.left);
    arr[k] := x^.data;
    inc(k);
    s := s + '  (' + intToStr(x^.data) + ')';
    sim(x^.right);
    s := s + '  ' + intToStr(x^.data);
  end
  else
    s := s + ' 0';
end;

procedure obr(var x: pt);
begin
  if x <> nil then
  begin
    s := s + '  ' + intToStr(x^.data);
    obr(x^.left);
    s := s + '  ' + intToStr(x^.data);
    obr(x^.right);
    s := s + '  (' + intToStr(x^.data) + ')';
  end
  else
    s := s + '  0';
end;

procedure prosh;
var
  x1, y1, i: integer;
  fl, fa: boolean;

procedure find(x: pt; a: integer);
begin
  if x <> nil then
    if x^.data = a then
      if x^.right = nil then
      begin
        fl := true;
        x1 := x^.x;
        y1 := x^.y;
        fa := true;
      end
      else
      begin
        fl := false;
        fa := true;
      end
    else
    begin
      if not fa then
        find(x^.left, a);
      if not fa then
        find(x^.right, a);
    end;
end;

procedure find1(x: pt; a: integer);
begin
  if x <> nil then
    if x^.data = a then
    begin
      fl := true;
      x1 := x^.x;
      y1 := x^.y;
      fa := true;
    end
    else
    begin
      if not fa then
        find1(x^.left, a);
      if not fa then
        find1(x^.right, a);
    end;
end;

begin
  Form1.Image1.Canvas.Pen.Style := psDashDotDot;
  for i := 0 to length(arr) - 1 do
  begin
    tree := root;
    fl := false;
    fa := false;
    find(tree, arr[i]);
    Form1.Image1.Canvas.MoveTo(x1+15,y1-3);
    if fl then
      if i < length(arr) - 1 then
      begin
        tree := root;
        fa := false;
        find1(tree, arr[i+1]);
        Form1.Image1.Canvas.LineTo(x1-6,y1+13);
      end
      else
      begin
        tree := root;
        Form1.Image1.Canvas.LineTo(x1+13,tree^.y);
        Form1.Image1.Canvas.LineTo(tree^.x+15,tree^.y);
      end;
  end;
end;

procedure findD(x: pt; a: integer);
begin
  if x <> nil then
    if x^.data = a then
    begin
      fd := true;
    end
    else
    begin
      if not fd then
        findD(x^.left, a);
      if not fd then
        findD(x^.right, a);
    end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i: integer;
  n: integer;
begin
  tree := root;
  fd := false;
  findD(tree, strToInt(L1.Text));
  if fd then
  begin
    i := 0;
    while StringGrid1.Cells[i,0] <> L1.Text do
      inc(i);
    StringGrid1.Cells[i,0] := '';
    StringGrid1.Cells[i,0] := StringGrid1.Cells[i+1,0];
    n := i;
    for i := n to StringGrid1.ColCount - 1 do
      StringGrid1.Cells[i,0] := StringGrid1.Cells[i+1,0];
  end
  else
    ShowMessage('������� �� ������.');
end;

end.
