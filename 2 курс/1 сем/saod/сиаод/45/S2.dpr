program S2;

{$APPTYPE CONSOLE}

{$R *.res}

 {Отсортировать стек, используя два других (два на самом деле это много)
  в варианте решения S3 более приколюшный вариант, где его целесообразно использовать}

type
  PElement = ^TElement;
  TElement = record    // Элемент стека
    value : integer;
    next  : PElement;
  end;

  TStack = class       // Класс для стека
    Head : PElement;
    constructor Create;
    procedure Push(val : PElement);
    function  Pop : PElement;
    function  IsEmpty : boolean;
  end;

  TStackWithSort = class     // Стек с сортировкой (тираж ограничен, спешите!)
    Stack1, Stack2, Stack3 : TStack;       // Три стека
    constructor Create;
    procedure Enter(count : integer);      // Ввести исходный стек
    procedure Sort;                        // Отсортировать
    procedure Show;                        // И показать, начиная ото дна
  end;

{ TStack }

constructor TStack.Create;                // Создание стека
begin
  Head := nil;
end;

function TStack.IsEmpty: boolean;         // Пуст ли стек
begin
  Result := (Head = nil);
end;

function TStack.Pop: PElement;            // Изъять с вершины стека
begin
  Result := Head;
  if not IsEmpty then
    Head := Head^.next;
end;

procedure TStack.Push(val: PElement);     // Положить на вершинку
begin
  val^.next := Head;
  Head := val;
end;

{ TStackWithSort }

constructor TStackWithSort.Create;        // Создать сортирующийся стек
begin
  Stack1 := TStack.Create;
  Stack2 := TStack.Create;
  Stack3 := TStack.Create;
end;

procedure TStackWithSort.Enter(count: integer);    // Ввод заданного кол-ва элементов
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

procedure TStackWithSort.Show;   // Показать стек, начиная ото дна
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

procedure TStackWithSort.Sort;   // Отсортировать
var                              // используется метод вставками
  i : integer;
begin
  if not Stack1.IsEmpty then      // Если стек не пуст
    Stack2.Push(Stack1.Pop);      // то переваливаем один элемент во второй стек (начальная отсортированная часть)
  while not Stack1.IsEmpty do     // Пока не перебрали все элементы в исходном стека
  begin
    Stack3.Push(Stack1.Pop);      // Закидываем очередной в третий стек (useless: можно было обойтись переменной)
    i := 0;
    while not Stack2.IsEmpty and (Stack2.Head^.value > Stack3.Head^.value) do
    begin                         // До тех пор, пока элементы на вершине отсортированного стека больше
      Stack1.Push(Stack2.Pop);    // переваливаем их обратно в первый стек
      Inc(i);                     // и помечаем, сколько перевалили, чтобы потом вернуть, ибо негоже
    end;
    Stack2.Push(Stack3.Pop);      // Теперь кидаем новый элементик в отсортированный стек в нужное место
    while (i > 0) do              // И возвращаем назад всё, что перекинули раньше
    begin
      Stack2.Push(Stack1.Pop);
      Dec(i);
    end;
  end;
end;

var
  Stack : TStackWithSort;      // Стек
  count : integer;             // Кол-во элементов

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
