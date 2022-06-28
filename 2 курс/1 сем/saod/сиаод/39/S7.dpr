program S7;

{$APPTYPE CONSOLE}

{$R *.res}

  {��������� ������, ������� ������ ����� � �������� ��� � ������
   ������� ������ � ������������� ���, ����� �� ������� ������������ �����.}

type
  PElement = ^TElement;
  TElement = record     // ������� ������
    value : integer;
    left,
    right : PElement;
  end;

  PListElement = ^TListElement;
  TListElement = record      // ������� ������
    value   : integer;
    fictive : boolean;
    used    : boolean;
    next,
    prev    : PListElement;
  end;

  TList = class      // ����� ��� ������
    Head, Tail : PListElement;     // ������ � ����� ������
    constructor Create;
    procedure Add(el : PListElement);  // ���������� ������������ � ����� ������
    procedure SortToSim;     // ���������� � ������������ �����
    procedure Show;          // ������� ������
  end;

  TTree = class     // ����� ��� ������
    Head : PElement;        // ��������� �� �������� �������
    List : TList;           // ���������� ������ ��� ������
    constructor Create;
    procedure Enter(count : integer);  // ���� ������
    procedure Add(el : PElement);      // �������� ������� (�� ����������)
    procedure FormList;                // ������������ ������ �� ������ ������
  end;

{ TTree }

procedure TTree.Add(el: PElement);
var
  p : PElement;          // ������� �������� � ������
  flag : boolean;        // ������ ���� �� ������� :)
begin
  if (Head = nil) then
    Head := el
  else
  begin
    p := Head;
    flag := true;
    while flag do
    begin
      if (p^.value = el^.value) then
        flag := false;
      if (p^.value > el^.value) then
      begin
        if (p^.left = nil) then
        begin
          p^.left := el;
          flag := false
        end
        else
          p := p^.left;
      end
      else
        if (p^.right = nil) then
        begin
          p^.right := el;
          flag := false
        end
        else
          p := p^.right;
    end;
  end;
end;

constructor TTree.Create;    // �������� ������
begin
  Head := nil;
  List := TList.Create;  // ����� ������ ������
end;

procedure TTree.Enter(count: integer);
var                   // ���� ���������� ���-�� ������ � ������
  i : integer;
  p : PElement;
begin
  for i := 1 to count do
  begin
    New(p);
    readln(p^.value);
    p^.left  := nil;
    p^.right := nil;
    Add(p); // �������� ��������
  end;
end;

procedure TTree.FormList;  // ������������ ������ �� ������

  procedure Straight(p : PElement);   // ������ �����
  var
    q : PListElement;  // ����� ������� ������
  begin
    if Assigned(p) then   // ���� �� �� � ������� �������
    begin
      New(q);               // ������ �� ��������� ������� ������
      q^.value := p^.value;
      q^.fictive := false;
      List.Add(q);          // � ��������� ���
      Straight(p^.left);    // ���������� �����
      New(q);               // ������ ��������� ������� ������
      q^.value := p^.value;
      q^.fictive := true;
      List.Add(q);          // � ��������� �
      Straight(p^.right);   // ���������� ������
      New(q);               // ������ ��� ���� ��������� �������
      q^.value := p^.value; // ���� ����� �� ������, �� � ������ ������� ����� ������
      q^.fictive := true;   // ������ ���� �������, ��� �� ������
      List.Add(q);          // ������� ��� ����� ������ �������������
    end;
  end;

begin
  Straight(Head);  // ������ ������ � ��������� ��������
end;

{ TList }

procedure TList.Add(el: PListElement);  // �������� ������� � ����� ������
begin                                   // ���� ������ ���� �� ����
  el^.used := false; // ����� �������� ��� ��� ���������� ����������
  el^.next := nil;
  el^.prev := Tail;
  if (Head = nil) then
  begin
    Head := el;
    Tail := el;
  end
  else
  begin
    Tail^.next := el;
    Tail := el;
  end;
end;

constructor TList.Create;   // �������� ������
begin
  Head := nil;
  Tail := nil;
end;

procedure TList.Show;   // ������� ������
var
  p : PListElement;
begin
  p := Head;          // �������� � ������� ��������
  while Assigned(p) do     // � ��� �� ����� ������
  begin
    if not p^.fictive then   // ���� �������� �� ���������, �� ������� �
      write(p^.value, ' ');
    p := p^.next;
  end;
  writeln;
end;

procedure TList.SortToSim;    // �������������� ������� ������ � ������������
var
  p, q : PListElement;
  i    : integer;
begin                                   // 1 (1) (1) -> (1) 1 (1)
  p := Head;     // �������� � ������� ��������
  while Assigned(p) do  // � ��� �� �����
  begin
    if not p^.fictive and not p^.used then // ���� �������� �� ��������� � �� �������������� �����
    begin                                  // �� ��� ����� ������ ���������
      q := p^.next;                        // �� ��� (��. ���� ����)
      while (q^.value <> p^.value) do      // ���� ������ ��������� (������� ����� ���������)
        q := q^.next;
      q^.fictive := false;       // ������ �� ������� (��. ����)
      p^.fictive := true;
      q^.used := true;           // � �������� ��� ��������������
      p^.used := true;
    end;
    p := p^.next;
  end;
end;

var
  Tree : TTree;    // ������
  count : integer; // ���-�� ������

begin
  Tree := TTree.Create;
  write('Enter count: ');
  readln(count);
  if (count > 0) then
  begin
    Tree.Enter(count);
    Tree.FormList;
    Tree.List.Show;
    Tree.List.SortToSim;
    Tree.List.Show;
  end;
  readln;
end.
