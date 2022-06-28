program S8;

{$APPTYPE CONSOLE}

{$R *.res}

type
  PElement = ^TElement;
  TElement = record
    value : char;
    next  : PElement;
  end;

  TStack = class
    Head : PElement;
    constructor Create;
    procedure Push(val : PElement);
    function  Pop : PElement;
    function  IsEmpty : boolean;
    procedure Show;
    procedure Form(count : integer);
    procedure Sort(S : TStack);
  end;

{ TStack }

constructor TStack.Create;
begin
  Head := nil;
end;

procedure TStack.Form(count: integer);
var
  i : integer;
  p : PElement;
begin
  for i := 1 to count do
  begin
    New(p);
    readln(p^.value);
    Push(p);
  end;
end;

function TStack.IsEmpty: boolean;
begin
  Result := (Head = nil);
end;

function TStack.Pop: PElement;
begin
  Result := Head;
  if not IsEmpty then
    Head := Head^.next;
end;

procedure TStack.Push(val: PElement);
begin
  val^.next := Head;
  Head := val;
end;

procedure TStack.Show;
var
  p : PElement;
begin
  p := Head;
  while Assigned(p) do
  begin
    write(p^.value, ' ');
    p := p^.next;
  end;
  writeln;
end;

procedure TStack.Sort(S: TStack);
var
  i : integer;
  count : integer;
  p : PElement;
begin
  if not Self.IsEmpty then
  begin
    count := 1;
    S.Push(Self.Pop);
    while not Self.IsEmpty do
    begin
      p := Self.Pop;
      i := 0;
      while (i < count) and (S.Head^.value > p^.value) do
      begin
        Inc(i);
        Self.Push(S.Pop);
      end;
      S.Push(p);
      Inc(count);
      while (i > 0) do
      begin
        S.Push(Self.Pop);
        Dec(i);
      end;
    end;
    while (count > 0) do
    begin
      Self.Push(S.Pop);
      Dec(count);
    end;
  end;
end;

var
  Stack1 : TStack;        // Латинские
  Stack2 : TStack;        // Русские
  count  : integer;

procedure Sort;
var
  i : integer;
  count : integer;
  p : PElement;
begin

  while not Stack1.IsEmpty and not (Stack1.Head^.value in ['A'..'Z', 'a'..'z']) do
    Stack2.Push(Stack1.Pop);
  if not Stack1.IsEmpty then
  begin
    count := 0;
    while not Stack1.IsEmpty do
    begin
      while not Stack1.IsEmpty and (Stack1.Head^.value in ['A'..'Z', 'a'..'z'])  do
      begin
        Stack2.Push(Stack1.Pop);
        Inc(count);
      end;
      if not Stack1.IsEmpty then
      begin
        p := Stack1.Pop;
        for i := 1 to count do
          Stack1.Push(Stack2.Pop);
        Stack2.Push(p);
        for i := 1 to count do
          Stack2.Push(Stack1.Pop);
      end;
    end;
    for i := 1 to count do
      Stack1.Push(Stack2.Pop);
  end;

  while not Stack2.IsEmpty and not (Stack2.Head^.value in ['0'..'9']) do
    Stack1.Push(Stack1.Pop);
  if not Stack2.IsEmpty then
  begin
    count := 0;
    while not Stack2.IsEmpty do
    begin
      while not Stack2.IsEmpty and (Stack2.Head^.value in ['0'..'9'])  do
      begin
        Stack1.Push(Stack2.Pop);
        Inc(count);
      end;
      if not Stack2.IsEmpty then
      begin
        p := Stack2.Pop;
        for i := 1 to count do
          Stack2.Push(Stack1.Pop);
        Stack1.Push(p);
        for i := 1 to count do
          Stack1.Push(Stack2.Pop);
      end;
    end;
    for i := 1 to count do
      Stack2.Push(Stack1.Pop);
  end;
end;

begin
  Stack1 := TStack.Create;
  Stack2 := TStack.Create;
  write('Введите число символов в первом стеке: ');
  readln(count);
  Stack1.Form(count);
  write('Введите число символов в первом стеке: ');
  readln(count);
  Stack2.Form(count);
  writeln('Первый стек: ');
  Stack1.Show;
  writeln('Второй стек: ');
  Stack2.Show;
  Sort;
  Stack1.Sort(Stack2);
  Stack2.Sort(Stack1);
  writeln('Первый стек: ');
  Stack1.Show;
  writeln('Второй стек: ');
  Stack2.Show;
  readln;
end.
