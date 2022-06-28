program DuplicateaBin;
// ������� ��� ��������� �� �������
// ��� ������ ��������� ������ ������

{$APPTYPE CONSOLE}

uses
  SysUtils;

type
	PNode = ^TNode;
  TNode = record
  	key: integer;
    left, right: PNode;
  end;

// �� ������ =)
// true - ���� ������
// fasle - ���� ��� (� node �������� ��������� �������������,
//										�.�. �������� ��� �������)
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

// ���������� ���� (true - ���� ��������� / false - ���� ���)
function AddNode(var root: PNode; const key: integer): boolean;
var
	p, q: PNode;
begin
	result := not Find(key, root, q);
	if result then
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

var
	root: PNode;
  N, i, j: integer;
  a: array[1..100] of integer;
begin
	readln(N);
  for i := 1 to N do
  	read(a[i]);

  root := nil;
  for i := 1 to N do
  	if not AddNode(root, a[i]) then // ���� �� ��������� (�.�. ��� ����)
		begin
    	for j := i+1 to N do	// ������� �������
      	a[j-1] := a[j];		// ��� ������ �������� �������
      dec(N);
    end;

  // ����� ��� ������ ��������...

  writeln;
  writeln('After deleting duplicates:');
  for i := 1 to N do
  	write(a[i], ' ');
  readln;
  readln;
end.
