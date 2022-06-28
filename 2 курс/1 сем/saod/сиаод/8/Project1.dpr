program Project1;

{$APPTYPE CONSOLE}

{написать программу прохождения дерева в порядке уровней.
в список узлов сначала заносится корень дерева, затем все узлы глубины 1,
далее все узлы глубины 2 и тд}

uses
  SysUtils,
  Windows;

type TNode = ^node;
  node = record
    data: integer;
    level: integer;
    left, rigth: TNode;
  end;

procedure symm(var Tree: TNode; const level: integer; var number: integer);
begin
  if tree <> nil then
    begin
      symm(tree^.rigth,level,number);
      if tree^.level = level then
        begin
          write(tree^.data, ' ');
        end;
      symm(tree^.left,level,number);
    end;
end;

procedure processing(var Tree: TNode; var MaxLevel: integer);
var
  level, number: integer;
  I: Integer;
begin
  for I := 1 to maxLevel do
    begin
      writeln;
      write(i, ': ');
      level:= i;
      symm(Tree,level,number);
    end;
end;

procedure addToTree(var Tree: TNode; inputData: integer; var level: integer);
begin
  if tree = nil then
    begin
      new(tree);
      tree^.data:= inputdata;
      tree^.level:= level;
      tree^.left:= nil;
      tree^.rigth:= nil;
    end
  else
    if inputdata > tree^.data then
      begin
        level:= tree^.level + 1;
        addToTree(Tree^.left,inputdata,level);
      end
    else
      begin
        level:= tree^.level + 1;
        addToTree(Tree^.rigth,inputdata,level);
      end;
end;

procedure input(var Tree: TNode; var MaxLevel: integer);
var
  inputInt: integer;
  level: integer;
begin
  SetConsoleCP(1251);
  SetConsoleOutputCP(1251);
  level:= 1;
  tree:= nil;
  writeln('Введите элементы дерева. Если хотите закончить, нажмите 0.');
  repeat
    readln(inputInt);
    if inputint <> 0 then
      begin
        addToTree(tree,inputInt,level);
        if level > maxLevel then
          maxLevel:= level;
      end;
  until (inputInt = 0);
end;

procedure main;
var
  Tree: TNode;
  maxLevel: integer;
begin
  maxLevel:= 0;
  input(Tree, maxLevel);
  processing(tree, maxLevel);
end;

begin
  main;
  readln;
end.
