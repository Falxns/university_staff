program SwapChildren;
// Построить бинарное дерево.
// Для каждого узла дерева
// поменять местами его левого и правого сыновей, если это возможно,
// а затем вывести на экран узлы дерева,
// обходя его в Симметричном порядке.

{$APPTYPE CONSOLE}

uses
  SysUtils;

type
	PNode = ^TNode;
  TNode = record
  	key: integer;
    ltag, rtag: boolean;
    left, right: PNode;
  end;

function Find(key: integer; root: PNode; var node: PNode): boolean;
var
	P, Q: PNode;
  found: boolean;
begin
	found := false;
	Q:= nil;
  P:= root;
  if (root <> nil) then
		repeat
    	Q:= P;
      if (key = P^.key) then
      	found := true
      else
				if (key < P^.key) then
	      	P:= P^.left
        else
        	P:= P^.right;
    until found or (P = nil);

  node := Q;
  result := found;
end; {Find}

procedure AddNode(var root: PNode; const key: integer);
var
	p, q: PNode;
begin
	if not Find(key, root, q) then
  begin
    new(p);
    p^.key := key;
    p^.left := nil;
    p^.right := nil;
    p^.ltag := false;
    p^.rtag := false;
    
		if (q = nil) then
    	root := p
    else
    	if (key < q^.key) then
      	q^.left := p
      else
      	q^.right := p;
  end;
end; {AddNode}

//**************************************
type
  TProc = procedure(p: PNode);
var
	process: TProc;

//**************************************

procedure ARB(root: PNode);
begin
	if (root = nil) then
  	exit;
  ARB(root^.left);
  process(root);
  ARB(root^.right);
end;

procedure ABR(root: PNode);
begin
	if (root = nil) then
  	exit;
  ABR(root^.left);
  ABR(root^.right);
  process(root);
end;

//------------------------------------------------
procedure swap(p: PNode);
var
	tmp: PNode;
begin
  if (p^.left <> nil) and (p^.right <> nil) then
  begin
    tmp := p^.left;
    p^.left := p^.right;
    p^.right := tmp;
  end;
end; {swap}

procedure SwapChld(root: PNode);
begin
  process := swap;
  ABR(root);
end; {SwapChld}

//------------------------------------------------
procedure WriteNode(p: PNode);
begin
  write(p^.key, ' ');
end; {WriteNode}

procedure WriteARBTree(root: PNode);
begin
	process := WriteNode;
  ARB(root);
end; {WriteARBTree}

function FormTree(N: integer): PNode;
var
	i, k: integer;
begin
  randomize;
	result := nil;
  for i := 1 to N do
  begin
  	read(k);
  	AddNode(result, k);//random(100)+1);
  end;
end; {FormTree}

var
	root: PNode;
  N: integer;
begin
	write('Enter number of nodes: ');
	readln(N);
  writeln('Enter ', N, ' node:');
  root := FormTree(N);

  writeln;
  writeln('Usual ARB walk:');
  WriteARBTree(root);
  writeln;

  SwapChld(root);
  writeln('After Swap:');  
	WriteARBTree(root);
  writeln;
  
  readln;
  readln;
end.
