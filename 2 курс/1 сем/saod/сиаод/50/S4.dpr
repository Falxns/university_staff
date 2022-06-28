program S4;

{$APPTYPE CONSOLE}

{$R *.res}

  {Реализация стека с помощью двух очередей}

type
  PElement = ^TElement;
  TElement = record   // Описание элемента очередей и стека
    value : integer;
    next  : PElement;
  end;

  TQueue = class       // Класс для очередей
    Head, Tail : PElement;    // Указатели на первый и последний элементы
    count : integer;          // Кол-во элементов
    constructor Create;
    procedure EnQueue(val : PElement);     // Добавить в конец очереди
    function  DeQueue : PElement;          // Изъять из начала
    function  IsEmpty : boolean;           // Пустая ли очередь
  end;

  TStack = class      // Класс для стека
    FocusedQueue, NonFocusedQueue : TQueue;   // Две очереди по условия для стека
                                              // в фокусную всегда добавляем элементы
                                              // при Pop меняем их местами
    constructor Create;
    procedure Push(val : integer);
    function  Pop : PElement;
    function  IsEmpty : boolean;
    procedure Show;             // Показать стек, начиная со дня (ибо очереди)
  private
    procedure Swap;             // Поменять местами очереди
                                // понт для более быстрой работы
  end;

{ TStack }

constructor TStack.Create;       // При создании стека создаём обе очереди
begin
  FocusedQueue := TQueue.Create;
  NonFocusedQueue := TQueue.Create;
end;

function TStack.IsEmpty: boolean;  // Если фокусная очередь пуста, то и стек пуст :(
begin
  Result := FocusedQueue.IsEmpty;
end;

function TStack.Pop: PElement;    // Запопить что-то
var
  i : integer;
begin
  if IsEmpty then    // Если стек пуст
    Result := nil    // то и нефиг возвращать
  else
  begin              // иначе
    for i := 1 to (FocusedQueue.count - 1) do           // Перекидывем все элементы кроме последнего из
      NonFocusedQueue.EnQueue(FocusedQueue.DeQueue);    // фокусной очереди в нефокусную
    Result := FocusedQueue.DeQueue;                     // Последний элемент из фокусной и будет искомый для Pop
    Swap;                                               // А потом ещё и свапаем их
  end;
end;

procedure TStack.Push(val: integer);     // Запушить что-то
var
  p : PElement;
begin
  New(p);
  p^.value := val;
  FocusedQueue.EnQueue(p);   // Просто добавить это в конец фокусной очереди
end;

procedure TStack.Show;          // Вывести стек, начиная со дна
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

procedure TStack.Swap;        // Поменять местами указатели
var                           // *магия с лекции
  t : TQueue;
begin
  t := FocusedQueue;
  FocusedQueue := NonFocusedQueue;
  NonFocusedQueue := t;
end;

{ TQueue }

constructor TQueue.Create;    // Создание очереди
begin
  Head  := nil;
  Tail  := nil;
  count := 0;
end;

function TQueue.DeQueue: PElement;
begin
  Result := Head;           // Достать первый элемент из очереди
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
  val.next := nil;          // Добавление элемента в конец очереди
  if Assigned(Tail) then
    Tail^.next := val
  else
    Head := val;
  Tail := val;
  Inc(count);
end;

function TQueue.IsEmpty: boolean;     // Если пуста очередь, то и кол-во элементов будет нулевым
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
