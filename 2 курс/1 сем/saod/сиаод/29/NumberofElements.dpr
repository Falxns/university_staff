program NumberofElements;

{$APPTYPE CONSOLE}
uses
  SysUtils, Windows;

type
  TTreePointer=^TTree;
  TTree=record
    key:integer;
    left, right:TTreePointer;
  end;

var
  Tree, Root:TTreePointer; ElementsNumber,Element,i, LevelN:integer;

procedure Insert(var x:TTreePointer; y:integer);
begin
  if x=nil then
  begin
    new(x);
    x^.key:=y;
    x^.left:=nil;
    x^.right:=nil;
  end
  else
    if y<=x^.key then insert(x^.left, y)
    else insert(x^.right, y);
end;

procedure DirectRound(x:TTreePointer; level:integer);
begin
  if x<>nil then
  begin
    if level=LevelN then inc(ElementsNumber);
    DirectRound(x^.left, level+1);
    DirectRound(x^.right, level+1);
  end;
end;

begin
  SetConsoleOutputCp(1251);
  writeln('������� ���������� ���������');
  readln(ElementsNumber);
  new(tree);
  Root:=tree;
  writeln('������� 1-�� �������');
  readln(Tree^.key);
  Tree^.left:=nil;
  Tree^.right:=nil;
  for i:=2 to ElementsNumber do
  begin
    writeln('������� ',i,'-�� �������');
    readln(Element);
    Tree:=Root;
    Insert(Tree, Element);
  end;
  repeat
  writeln('������� ����� ������');
  readln(LevelN);
  if LevelN>0 then
  begin
    ElementsNumber:=0;
    DirectRound(Tree, 1);
    writeln('���������� ��������� �� ������ ',LevelN,' ����� ',ElementsNumber);
    writeln;
  end;
  until LevelN<=0;
  readln;
end.

 