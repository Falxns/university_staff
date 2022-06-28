program DuplicateaBin;
// ѕостроить бинарное дерево.
// ¬ывести количество узлов, у которых (3 числа)
// а) только левый сын
// б) только правый сын
// в) оба сына

{$APPTYPE CONSOLE}

uses
  SysUtils;

type
	PNode = ^TNode;
  TNode = record
  	key: integer;
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

function AddNode(var root: PNode; const key: integer): boolean;
var
	p, q: PNode;
begin
	result := not Find(key, root, q);
	if result  then
  begin
    new(p);
    p^.key := key;
    p^.left := nil;
    p^.right := nil;

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

procedure WriteNode(p: PNode);
begin
  write(p^.key, ' ');
end; {WriteNode}

var
	l, r, b: integer;
  
procedure GetSonsNumber(p: PNode);
begin
	if (p^.left <> nil) then
  	if (p^.right <> nil) then
    	inc(b)
    else
    	inc(l)
  else
  	if (p^.right <> nil) then
    	inc(r);
end; {GetSonsNumber}
//**************************************

procedure RAB(root: PNode);
begin		// пр€мой обход
	if (root = nil) then
  	exit;
	process(root);
  RAB(root^.left);
  RAB(root^.right);
end; {RAB}

procedure GetSonsNumberRABTree(root: PNode);
begin
	l := 0;
  r := 0;
  b := 0;
	process := GetSonsNumber;
  RAB(root);
end; {GetSonsNumberRABTree}

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
	readln(N);
  root := FormTree(N);

  GetSonsNumberRABTree(root);

  writeln('l: ', l);  
  writeln('r: ', r);
  writeln('b: ', b);

  readln;
  readln;
end.
