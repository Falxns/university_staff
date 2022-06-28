program S1;

{$APPTYPE CONSOLE}

{$R *.res}

  {Сделать из двух стеков очередь}

type
  PElement = ^TElement;
  TElement = record    // Элемент для очереди и стеков
    value : integer;
    next  : PElement;
  end;

  TStack = class       // Класс для стека
    Head : PElement;      // Вершинка
    constructor Create;
    procedure Push(val : PElement);
    function  Pop : PElement;
    function  IsEmpty : boolean;
  end;

  TQueue = class             // Класс для очереди из стеков
    Stack1, Stack2 : TStack;
    constructor Create;
    procedure EnQueue(val : integer);   // Добавить в конец очереди
    function  DeQueue : PElement;       // Достать из начала очереди
    function  IsEmpty : boolean;        // Если пустая очередь
    procedure Show;                     // Показать очередь задом наперёд (ибо стек)
  end;

{ TQueue }

constructor TQueue.Create;              // Создать очередь
begin
  Stack1 := TStack.Create;
  Stack2 := TStack.Create;
end;

function TQueue.DeQueue: PElement;     // Извлечение элемента из очереди
var
  p : PElement;
begin
  if IsEmpty then       // Если ничего нету
    Result := nil       // то и нечего возвращать
  else                                // (с) Кличко
  begin
    while not Stack2.IsEmpty do    // Переворачиваем весь стэк в другой
      Stack1.Push(Stack2.Pop);     // a, b, c -> c, b, a
    Result := Stack1.Pop;          // Верхний элемент и будет искомым
    while not Stack1.IsEmpty do    // И возвращаем обратно (думал в сказку попал?))
      Stack2.Push(Stack1.Pop);     // c, b -> b, c
  end;
end;

procedure TQueue.EnQueue(val: integer);  // Добавление элемента в очередь
var
  p : PElement;
begin
  New(p);
  p^.value := val;
  Stack2.Push(p);       // Просто добавляем элемент на вершинку стека
end;

function TQueue.IsEmpty: boolean;
begin
  Result := Stack2.IsEmpty;    // Если пуст основной стек, то и очередь пуста
end;

procedure TQueue.Show;            // Вывод очереди
var                               // задом наперёд
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

constructor TStack.Create;     // Создание стека
begin
  Head := nil;
end;

function TStack.IsEmpty: boolean;     // Если пуст
begin                                 // то голова указывает в никуда
  Result := (Head = nil);
end;

function TStack.Pop: PElement;     // Достать с вершины стека
begin
  Result := Head;
  if not IsEmpty then
    Head := Head^.next;
end;

procedure TStack.Push(val: PElement);    // Положить на вершинку
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
