program AllTreesLevels;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

type
  TPNode=^TNode;
  TNode=record
    data:integer;
    right:TPNode;
    left:TPNode;
  end;

  TPList=^TList;
  TList=record
    data:integer;
    next:TPList;
  end;

  TListInfo=record
    head:TPList;
    Current:TPList;
  end;

var List:TListInfo;
    root:TPNode;
    data,lev:integer;
    IsAddingExecute:boolean;
procedure InsertNode(var x: TPNode; const y: integer);
begin
 if x = nil then
  begin
    new(x);
    x^.data := y;
    x^.left := nil;
    x^.right := nil;
  end
  else if y < x^.data then
    InsertNode(x^.left, y)
  else
  if y>x.data then
    InsertNode(x^.right, y);
end;

procedure AddInList(var list:TListInfo; const n:integer);
var Temp:TPList;
begin
  IsAddingExecute:=True;
  New(temp);
  temp^.data:=n;
  Temp^.next:=nil;
  if list.head=nil then
  begin
    list.head:=temp;
  end
  else
    list.Current^.next:=temp;
    list.Current:=temp;
end;

procedure PreOrderTraversal(var x:TPNode; var list:TListInfo; level:integer);
begin
  If x<>nil then
  begin
    if level=lev then
    AddInList(list,x^.data);
    PreOrderTraversal(x^.left,list,level+1);
    PreOrderTraversal(x^.right,list,level+1);
  end;
end;

procedure PrintList(var list:TListInfo);
begin
  List.Current:=List.head;
  while list.Current<>nil do
  begin
    write(List.Current^.data:5);
    List.Current:=List.Current^.next;
  end;
end;

begin
  root:=nil;
  List.head:=nil;
  List.Current:=nil;
  Writeln('Build your tree and put 0 in the end of consequence.');
  readln(data);
  while data<>0 do
  begin
    InsertNode(root,data);
    readln(data);
  end;
  Lev:=0;
  PreorderTraversal(root,list,0);
  while IsAddingExecute do
  begin
    IsAddingExecute:=False;
    inc(lev);
    PreorderTraversal(root,list,0);
  end;
  Writeln('All nodes in required consequence');
  PrintList(list);
  readln;
end.

