unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  Coordinate=record
    xx,yy:Integer
  end;

  Ptr=^node;
  node=record
    Data:Integer;
    Rtag:Boolean;
    Coord:Coordinate;              //координаты x и y дл€ рисовани€ на канвасе
    Left,Right:Ptr
  end;
  Mas=array[1..100] of Integer;
var
  Form1: TForm1;
  a:Mas;
  num:Integer;
  head,root,Pr1:Ptr;

  procedure Insert(var x:Ptr;y,xxx,yyy:Integer;sh:Integer);
  procedure PrymPrint(x:Ptr);
  procedure Prym_Proshiv(var x:Ptr);
  procedure Make(var root:Ptr;var a:Mas;var num:Integer);
  procedure DrawTree(x:Ptr);

implementation

{$R *.dfm}

//ѕолный пр€мой обход пока еще не прошитого дерева
//(может быть надо было сделать и краткий, но тут полный)
procedure PrymPrint(x:Ptr);
begin
  with Form1.Label4 do
    if x<>nil then
    begin
      Caption:=Caption+'   ('+inttostr(x^.Data)+')   ';  //обрабатываемый элемент
      PrymPrint(x^.Left);
      Caption:=Caption+' '+inttostr(x^.Data)+' ';    //обычный возврат в рекурсию
      PrymPrint(x^.Right);
      Caption:=Caption+' '+inttostr(x^.Data)+' '     //обычный возврат в рекурсию
    end
    else Caption:=Caption+' 0 '                     //указатель на nil
end;

//ѕр€ма€ правосторонн€€ прошивка дерева
procedure Prym_Proshiv(var x:Ptr);
procedure RightSew(var p:Ptr);
begin
  if Pr1<>nil then
  begin
    if Pr1^.Right=nil then    //если правый указатель - nil, то:
    begin
      Pr1^.Rtag:=false;       //логическое поле, отвечающее за нить - false
      Pr1^.Right:=p           //заноситс€ ссылка на следующий элемент
    end
    else Pr1^.Rtag:=true      //логическое поле, отвечающее за обычную св€зь - true
  end;
  Pr1:=p
end;
begin
  if (x<>nil) then
  begin
    RightSew(x);
    Prym_Proshiv(x^.Left);
    if x^.Rtag<>false then Prym_Proshiv(x^.Right)
  end
end;

//¬ставка элемента в дерево
procedure Insert(var x:Ptr;y,xxx,yyy:Integer;sh:Integer);
begin
  if x=nil then
  begin
    new(x);
    x^.Data:=y;
    x^.Left:=nil;
    x^.Right:=nil;
    x^.Coord.xx:=xxx;
    x^.Coord.yy:=yyy
  end
  else begin
    sh:=sh*2;                //сдвиг следующего элемента на канвасе
    if y<=x^.Data then Insert(x^.Left,y,xxx-593 div sh,yyy+50,sh)
                  else Insert(x^.Right,y,xxx+593 div sh,yyy+50,sh)
  end
end;

procedure Make(var root:Ptr;var a:Mas;var num:Integer);
var
  rr:Ptr;
  i,sh:Integer;
begin
  num:=10;
  randomize;
  for i:=1 to num do                      //заполн€етс€ массив из 10 элементов
    a[i]:=random(98)+1;

 { a[1]:=33;a[2]:=58;a[3]:=93;a[4]:=22;a[5]:=94;
  a[6]:=90;a[7]:=46;a[8]:=86;a[9]:=61;a[10]:=5;       }

 // a[1]:=35;a[2]:=11;a[3]:=53;a[4]:=84;a[5]:=72;
 // a[6]:=17;a[7]:=31;a[8]:=32;a[9]:=82;a[10]:=37;

 // a[1]:=91;a[2]:=30;a[3]:=64;a[4]:=8;a[5]:=64;
 // a[6]:=16;a[7]:=65;a[8]:=30;a[9]:=19;a[10]:=18;

 { a[1]:=11;a[2]:=64;a[3]:=14;a[4]:=87;a[5]:=32;
  a[6]:=40;a[7]:=11;a[8]:=66;a[9]:=87;a[10]:=82;   }

  new(root);                               //построение нового дерева
  root^.Data:=a[1];                        //создание первого элемента отдельно
  root^.Left:=nil;
  root^.Right:=nil;
  root^.Coord.xx:=593;
  root^.Coord.yy:=30;
  sh:=1;
  for i:=2 to num do
  begin
    rr:=root;                              //вставка следующих элементов в дерево
    Insert(rr,a[i],rr^.Coord.xx,rr^.Coord.yy,sh)
  end;

  for i:=1 to num do
    with Form1.Label7 do
      Caption:=Caption+inttostr(a[i])+'   '
end;

//рисование дерева на канвасе
procedure DrawTree(x:Ptr);
begin
  with Form1.Image1.Canvas do
    if x<>nil then
    begin
      if x^.Left<>nil then begin
        MoveTo(x^.Coord.xx+15,x^.Coord.yy+15);
        LineTo(x^.Left^.Coord.xx+15,x^.Left^.Coord.yy+15)
      end;
      if x^.Right=nil
      then begin
        Form1.Image1.Canvas.Pen.Color:=clRed;
        Form1.Image1.Canvas.Pen.Style:=psDashDot;
        MoveTo(x^.Coord.xx+15,x^.Coord.yy+15);
        LineTo(x^.Coord.xx+15,root^.Coord.yy+15);
        MoveTo(x^.Coord.xx+15,root^.Coord.yy+15);
        LineTo(root^.Coord.xx+29,root^.Coord.yy+15);
        Form1.Image1.Canvas.Pen.Style:=psSolid;
        Form1.Image1.Canvas.Pen.Color:=clBlack
      end
      else if x^.Rtag<>false
           then begin
             MoveTo(x^.Coord.xx+15,x^.Coord.yy+15);
             LineTo(x^.Right^.Coord.xx+15,x^.Right^.Coord.yy+15)
           end
           else begin
             Form1.Image1.Canvas.Pen.Color:=clRed;
             Form1.Image1.Canvas.Pen.Style:=psDashDot;
             MoveTo(x^.Coord.xx+15,x^.Coord.yy+15);
             LineTo(x^.Right^.Coord.xx+15,x^.Coord.yy+15);
             MoveTo(x^.Right^.Coord.xx+15,x^.Coord.yy+15);
             LineTo(x^.Right^.Coord.xx+15,x^.Right^.Coord.yy+29);
             Form1.Image1.Canvas.Pen.Style:=psSolid;
             Form1.Image1.Canvas.Pen.Color:=clBlack
           end;
      Ellipse(x^.Coord.xx,x^.Coord.yy,x^.Coord.xx+30,x^.Coord.yy+30);
      TextOut(x^.Coord.xx+5,x^.Coord.yy+8,inttostr(x^.Data));
      DrawTree(x^.Left);
      if x^.Rtag<>false then DrawTree(x^.Right)
    end
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Make(root,a,num);      //создание дерева
  PrymPrint(root);       //полный пр€мой обход
  new(head);             //создание головного узла дл€ прошивки дерева
  head^.Left:=root;
  head^.Right:=head;
  head^.Data:=0;
  Pr1:=head;             //доп.указатель,кот.ссылаетс€ на предшествующий узел
  Prym_Proshiv(root);    //пр€ма€ правосторонн€€ прошивка
  DrawTree(root)         //рисование дерева
end;

end.
