program S3;

{$APPTYPE CONSOLE}

{$R *.res}

  {Отсортировать стек, используя два других (улучшенный вариант с большими понтами)}

type
  PElement = ^TElement;
  TElement = record   // Элемент стека
    value : integer;
    next  : PElement;
  end;

  TStack = class        // Класс для стека
    Head : PElement;
    constructor Create;
    procedure Push(val : PElement);
    function  Pop : PElement;
    function  IsEmpty : boolean;
  end;

  TStackWithSort = class     // Сортирующийся стек
    Stack1, Stack2, Stack3 : TStack;    // Три стека
    constructor Create;
    procedure Enter(count : integer);   // Ввести элементы
    procedure Sort;                     // Отсортировать
    procedure Show;                     // И вывести начиная ото дна
  end;

{ TStack }

constructor TStack.Create;              // Создание стека
begin
  Head := nil;
end;

function TStack.IsEmpty: boolean;       // Если стек пуст
begin
  Result := (Head = nil);
end;

function TStack.Pop: PElement;          // Запопить элемент
begin
  Result := Head;
  if not IsEmpty then
    Head := Head^.next;
end;

procedure TStack.Push(val: PElement);   // Запушить его
begin
  val^.next := Head;
  Head := val;
end;

{ TStackWithSort }

constructor TStackWithSort.Create;      // Создание сортируемого стека
begin
  Stack1 := TStack.Create;
  Stack2 := TStack.Create;
  Stack3 := TStack.Create;
end;

procedure TStackWithSort.Enter(count: integer);  // Ввод указанного кол-ва переменных
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

procedure TStackWithSort.Show;      // Вывести стек, начиная ото дна
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

procedure TStackWithSort.Sort;        // Сортировка версия 2.0
var                                   // сложнее для понимания
  i : integer;                        // но стек более явно используется
begin
  while not Stack1.IsEmpty do         // Пока есть элементы в первом стеке
  begin
    Stack3.Push(Stack1.Pop);          // Пушим один элементик в третий
    while not Stack1.IsEmpty and (Stack3.Head^.value < Stack1.Head^.value) do
      Stack3.Push(Stack1.Pop);        // а теперь пушим ещё в третий из первого, пока у нас
    i := 0;                           // получается отсортированная последовательность
    while not Stack3.IsEmpty do       // Теперь, пока эта последовательность не иссякла
    begin                             // Ищем место очередного элемента из первого стека
      while not Stack2.IsEmpty and (Stack3.Head^.value < Stack2.Head^.value) do
      begin                           // Отыскиваем его место в отсортированной части
        Stack1.Push(Stack2.Pop);      // как в версии 1.0, только в конце не возвращаем всё обратно в первый
        Inc(i);                       // а как бы сливаем две отсорированные последовательности
      end;
      if Stack2.IsEmpty then          // Если же мы опустошили отсортированный стек
        while not Stack3.IsEmpty do   // или же только в первый раз в него пилим
        begin
          Stack1.Push(Stack3.Pop);    // то всё остальное из третьего стека будет меньше самого верхнего на первом
          Inc(i);
        end
      else
      begin                          // Если же не опустошили, то выпиливаем очередной элемент
        Stack1.Push(Stack3.Pop);
        Inc(i);
      end;
    end;
      while (i > 0) do
      begin
        Stack2.Push(Stack1.Pop);     // И наконец, возвращаем всё, что напушили впустую
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
