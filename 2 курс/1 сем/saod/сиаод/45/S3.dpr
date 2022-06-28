program S3;

{$APPTYPE CONSOLE}

{$R *.res}

  {������������� ����, ��������� ��� ������ (���������� ������� � �������� �������)}

type
  PElement = ^TElement;
  TElement = record   // ������� �����
    value : integer;
    next  : PElement;
  end;

  TStack = class        // ����� ��� �����
    Head : PElement;
    constructor Create;
    procedure Push(val : PElement);
    function  Pop : PElement;
    function  IsEmpty : boolean;
  end;

  TStackWithSort = class     // ������������� ����
    Stack1, Stack2, Stack3 : TStack;    // ��� �����
    constructor Create;
    procedure Enter(count : integer);   // ������ ��������
    procedure Sort;                     // �������������
    procedure Show;                     // � ������� ������� ��� ���
  end;

{ TStack }

constructor TStack.Create;              // �������� �����
begin
  Head := nil;
end;

function TStack.IsEmpty: boolean;       // ���� ���� ����
begin
  Result := (Head = nil);
end;

function TStack.Pop: PElement;          // �������� �������
begin
  Result := Head;
  if not IsEmpty then
    Head := Head^.next;
end;

procedure TStack.Push(val: PElement);   // �������� ���
begin
  val^.next := Head;
  Head := val;
end;

{ TStackWithSort }

constructor TStackWithSort.Create;      // �������� ������������ �����
begin
  Stack1 := TStack.Create;
  Stack2 := TStack.Create;
  Stack3 := TStack.Create;
end;

procedure TStackWithSort.Enter(count: integer);  // ���� ���������� ���-�� ����������
var
  i : integer;
  p : PElement;
begin
  for i := 1 to count do
  begin
    New(p);
    readln(p^.value);
    Stack1.Push(p);
  end;
end;

procedure TStackWithSort.Show;      // ������� ����, ������� ��� ���
var
  p : PElement;
begin
  p := Stack2.Head;
  if (p = nil) then
    writeln('Error! Stack doesn''t sorted or empty');
  while Assigned(p) do
  begin
    write(p^.value, ' ');
    p := p^.next;
  end;
end;

procedure TStackWithSort.Sort;        // ���������� ������ 2.0
var                                   // ������� ��� ���������
  i : integer;                        // �� ���� ����� ���� ������������
begin
  while not Stack1.IsEmpty do         // ���� ���� �������� � ������ �����
  begin
    Stack3.Push(Stack1.Pop);          // ����� ���� ��������� � ������
    while not Stack1.IsEmpty and (Stack3.Head^.value < Stack1.Head^.value) do
      Stack3.Push(Stack1.Pop);        // � ������ ����� ��� � ������ �� �������, ���� � ���
    i := 0;                           // ���������� ��������������� ������������������
    while not Stack3.IsEmpty do       // ������, ���� ��� ������������������ �� �������
    begin                             // ���� ����� ���������� �������� �� ������� �����
      while not Stack2.IsEmpty and (Stack3.Head^.value < Stack2.Head^.value) do
      begin                           // ���������� ��� ����� � ��������������� �����
        Stack1.Push(Stack2.Pop);      // ��� � ������ 1.0, ������ � ����� �� ���������� �� ������� � ������
        Inc(i);                       // � ��� �� ������� ��� �������������� ������������������
      end;
      if Stack2.IsEmpty then          // ���� �� �� ���������� ��������������� ����
        while not Stack3.IsEmpty do   // ��� �� ������ � ������ ��� � ���� �����
        begin
          Stack1.Push(Stack3.Pop);    // �� �� ��������� �� �������� ����� ����� ������ ������ �������� �� ������
          Inc(i);
        end
      else
      begin                          // ���� �� �� ����������, �� ���������� ��������� �������
        Stack1.Push(Stack3.Pop);
        Inc(i);
      end;
    end;
      while (i > 0) do
      begin
        Stack2.Push(Stack1.Pop);     // � �������, ���������� ��, ��� �������� �������
        Dec(i);
      end;
  end;
end;

var
  Stack : TStackWithSort;
  count : integer;

begin
  Stack := TStackWithSort.Create;
  write('Enter count: ');
  readln(count);
  if (count > 0) then
  begin
    Stack.Enter(count);
    Stack.Sort;
    Stack.Show;
  end;
  readln;
end.
