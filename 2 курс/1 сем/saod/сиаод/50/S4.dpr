program S4;

{$APPTYPE CONSOLE}

{$R *.res}

  {���������� ����� � ������� ���� ��������}

type
  PElement = ^TElement;
  TElement = record   // �������� �������� �������� � �����
    value : integer;
    next  : PElement;
  end;

  TQueue = class       // ����� ��� ��������
    Head, Tail : PElement;    // ��������� �� ������ � ��������� ��������
    count : integer;          // ���-�� ���������
    constructor Create;
    procedure EnQueue(val : PElement);     // �������� � ����� �������
    function  DeQueue : PElement;          // ������ �� ������
    function  IsEmpty : boolean;           // ������ �� �������
  end;

  TStack = class      // ����� ��� �����
    FocusedQueue, NonFocusedQueue : TQueue;   // ��� ������� �� ������� ��� �����
                                              // � �������� ������ ��������� ��������
                                              // ��� Pop ������ �� �������
    constructor Create;
    procedure Push(val : integer);
    function  Pop : PElement;
    function  IsEmpty : boolean;
    procedure Show;             // �������� ����, ������� �� ��� (��� �������)
  private
    procedure Swap;             // �������� ������� �������
                                // ���� ��� ����� ������� ������
  end;

{ TStack }

constructor TStack.Create;       // ��� �������� ����� ������ ��� �������
begin
  FocusedQueue := TQueue.Create;
  NonFocusedQueue := TQueue.Create;
end;

function TStack.IsEmpty: boolean;  // ���� �������� ������� �����, �� � ���� ���� :(
begin
  Result := FocusedQueue.IsEmpty;
end;

function TStack.Pop: PElement;    // �������� ���-��
var
  i : integer;
begin
  if IsEmpty then    // ���� ���� ����
    Result := nil    // �� � ����� ����������
  else
  begin              // �����
    for i := 1 to (FocusedQueue.count - 1) do           // ����������� ��� �������� ����� ���������� ��
      NonFocusedQueue.EnQueue(FocusedQueue.DeQueue);    // �������� ������� � ����������
    Result := FocusedQueue.DeQueue;                     // ��������� ������� �� �������� � ����� ������� ��� Pop
    Swap;                                               // � ����� ��� � ������� ��
  end;
end;

procedure TStack.Push(val: integer);     // �������� ���-��
var
  p : PElement;
begin
  New(p);
  p^.value := val;
  FocusedQueue.EnQueue(p);   // ������ �������� ��� � ����� �������� �������
end;

procedure TStack.Show;          // ������� ����, ������� �� ���
var
  p : PElement;
begin
  p := FocusedQueue.Head;
  if (p = nil) then
    writeln('Error! Stack is empty');
  while Assigned(p) do
  begin
    write(p^.value, ' ');
    p := p^.next;
  end;
end;

procedure TStack.Swap;        // �������� ������� ���������
var                           // *����� � ������
  t : TQueue;
begin
  t := FocusedQueue;
  FocusedQueue := NonFocusedQueue;
  NonFocusedQueue := t;
end;

{ TQueue }

constructor TQueue.Create;    // �������� �������
begin
  Head  := nil;
  Tail  := nil;
  count := 0;
end;

function TQueue.DeQueue: PElement;
begin
  Result := Head;           // ������� ������ ������� �� �������
  if Assigned(Head) then
  begin
    Dec(count);
    Head := Head^.next;
    if (count = 0) then
      Tail := nil;
  end;
end;

procedure TQueue.EnQueue(val: PElement);
begin
  val.next := nil;          // ���������� �������� � ����� �������
  if Assigned(Tail) then
    Tail^.next := val
  else
    Head := val;
  Tail := val;
  Inc(count);
end;

function TQueue.IsEmpty: boolean;     // ���� ����� �������, �� � ���-�� ��������� ����� �������
begin
  Result := (count = 0);
end;

 { Main Part}
var
  Stack  : TStack;
  choose : integer;
  val    : integer;
  p      : PElement;

begin
  Stack := TStack.Create;
  choose := 0;
  while choose <> 4 do
  begin
    writeln('Choose action: ');
    writeln('1 - Push');
    writeln('2 - Pop');
    writeln('3 - Show Stack');
    writeln('4 - Exit');
    write('Enter: ');
    readln(choose);
    if (choose = 1) then
    begin
      write('Enter number: ');
      readln(val);
      Stack.Push(val);
    end;
    if (choose = 2) then
    begin
      p := Stack.Pop;
      if Assigned(p) then
        writeln('Element: ', p^.value)
      else
        writeln('Error! Stack is empty');
    end;
    if (choose = 3) then
    begin
      Stack.Show;
      writeln;
    end;
    writeln('*************');
  end;
end.
