program S1;

{$APPTYPE CONSOLE}

{$R *.res}

  {������� �� ���� ������ �������}

type
  PElement = ^TElement;
  TElement = record    // ������� ��� ������� � ������
    value : integer;
    next  : PElement;
  end;

  TStack = class       // ����� ��� �����
    Head : PElement;      // ��������
    constructor Create;
    procedure Push(val : PElement);
    function  Pop : PElement;
    function  IsEmpty : boolean;
  end;

  TQueue = class             // ����� ��� ������� �� ������
    Stack1, Stack2 : TStack;
    constructor Create;
    procedure EnQueue(val : integer);   // �������� � ����� �������
    function  DeQueue : PElement;       // ������� �� ������ �������
    function  IsEmpty : boolean;        // ���� ������ �������
    procedure Show;                     // �������� ������� ����� ������ (��� ����)
  end;

{ TQueue }

constructor TQueue.Create;              // ������� �������
begin
  Stack1 := TStack.Create;
  Stack2 := TStack.Create;
end;

function TQueue.DeQueue: PElement;     // ���������� �������� �� �������
var
  p : PElement;
begin
  if IsEmpty then       // ���� ������ ����
    Result := nil       // �� � ������ ����������
  else                                // (�) ������
  begin
    while not Stack2.IsEmpty do    // �������������� ���� ���� � ������
      Stack1.Push(Stack2.Pop);     // a, b, c -> c, b, a
    Result := Stack1.Pop;          // ������� ������� � ����� �������
    while not Stack1.IsEmpty do    // � ���������� ������� (����� � ������ �����?))
      Stack2.Push(Stack1.Pop);     // c, b -> b, c
  end;
end;

procedure TQueue.EnQueue(val: integer);  // ���������� �������� � �������
var
  p : PElement;
begin
  New(p);
  p^.value := val;
  Stack2.Push(p);       // ������ ��������� ������� �� �������� �����
end;

function TQueue.IsEmpty: boolean;
begin
  Result := Stack2.IsEmpty;    // ���� ���� �������� ����, �� � ������� �����
end;

procedure TQueue.Show;            // ����� �������
var                               // ����� ������
  p : PElement;
begin
  p := Stack2.Head;
  if (p = nil) then
    writeln('Error! Queue is empty');
  while Assigned(p) do
  begin
    write(p^.value, ' ');
    p := p^.next;
  end;
end;

{ TStack }

constructor TStack.Create;     // �������� �����
begin
  Head := nil;
end;

function TStack.IsEmpty: boolean;     // ���� ����
begin                                 // �� ������ ��������� � ������
  Result := (Head = nil);
end;

function TStack.Pop: PElement;     // ������� � ������� �����
begin
  Result := Head;
  if not IsEmpty then
    Head := Head^.next;
end;

procedure TStack.Push(val: PElement);    // �������� �� ��������
begin
  val^.next := Head;
  Head := val;
end;


 { Main Part}
var
  Queue  : TQueue;
  choose : integer;
  val    : integer;
  p      : PElement;

begin
  Queue := TQueue.Create;
  choose := 0;
  while choose <> 4 do
  begin
    writeln('Choose action: ');
    writeln('1 - EnQueue');
    writeln('2 - DeQueue');
    writeln('3 - Show Queue');
    writeln('4 - Exit');
    write('Enter: ');
    readln(choose);
    if (choose = 1) then
    begin
      write('Enter number: ');
      readln(val);
      Queue.EnQueue(val);
    end;
    if (choose = 2) then
    begin
      p := Queue.DeQueue;
      if Assigned(p) then
        writeln('Element: ', p^.value)
      else
        writeln('Error! Queue is empty');
    end;
    if (choose = 3) then
    begin
      Queue.Show;
    end;
    writeln('*************');
  end;
end.
