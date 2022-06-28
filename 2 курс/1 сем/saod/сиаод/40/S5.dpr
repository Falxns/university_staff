program S5;

{$APPTYPE CONSOLE}

{$R *.res}

  {����� ����� �������� ������ (������ �� ������)}

type
  PElement = ^TElement;
  TElement = record     // ������� ������
    value : integer;
    left,
    right : PElement;
  end;

  TTree = class
    Head : PElement;
    constructor Create;
    procedure Enter(count : integer); // ���� ��������� ������
    procedure Add(el : PElement);     // �������� ��������
    function FindLeavesSum : integer;  // ����� ����� ��������
  end;

{ TTree }

procedure TTree.Add(el: PElement);  // ���������� �������� � ������
var
  p : PElement;
  flag : boolean;
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

constructor TTree.Create;          // �������� ������
begin
  Head := nil;
end;

procedure TTree.Enter(count: integer);     // ���� ��������� ���-�� ��������� � ������
var
  i : integer;
  p : PElement;
begin
  for i := 1 to count do
  begin
    New(p);
    readln(p^.value);
    p^.left  := nil;
    p^.right := nil;
    Add(p);
  end;
end;

function TTree.FindLeavesSum: integer;   // ���� ����� �� ������
var
  sum : integer;

  procedure Sim(p : PElement);    // ��������� ������������ �����
  begin
    if Assigned(p) then
    begin
      Sim(p^.left);
      if (p^.left = nil) and (p^.right = nil) then   // ���� ���� ��������, �� �� ������ :)
        Inc(sum, p^.value);                          // � ���� ���������� � ����� �����
      Sim(p^.right);
    end;
  end;

begin
  sum := 0;     // ����� - ����
  Sim(Head);    // �������� �����
  Result := sum; // ���������� �����
end;

var
  Tree : TTree;
  count : integer;

begin
  Tree := TTree.Create;
  write('Enter count: ');
  readln(count);
  if (count > 0) then
  begin
    Tree.Enter(count);
    writeln('Sum of leaves: ', Tree.FindLeavesSum);
  end;
  readln;
end.
