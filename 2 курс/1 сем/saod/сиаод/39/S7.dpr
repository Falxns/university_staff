program S7;

{$APPTYPE CONSOLE}

{$R *.res}

  {Построить дерево, сделать прямой обход и записать его в список
   Вывести список и отсортировать так, чтобы он выдавал симметричный обход.}

type
  PElement = ^TElement;
  TElement = record     // Элемент дерева
    value : integer;
    left,
    right : PElement;
  end;

  PListElement = ^TListElement;
  TListElement = record      // Элемент списка
    value   : integer;
    fictive : boolean;
    used    : boolean;
    next,
    prev    : PListElement;
  end;

  TList = class      // Класс для списка
    Head, Tail : PListElement;     // Начало и конец списка
    constructor Create;
    procedure Add(el : PListElement);  // Добавление производится в конец списка
    procedure SortToSim;     // Сортировка в симметричный обход
    procedure Show;          // Вывести список
  end;

  TTree = class     // Класс для дерева
    Head : PElement;        // Указатель на головной элемент
    List : TList;           // Встроенный список для обхода
    constructor Create;
    procedure Enter(count : integer);  // Ввод дерева
    procedure Add(el : PElement);      // Добавить элемент (не рекурсивно)
    procedure FormList;                // Сформировать список на прямом обходе
  end;

{ TTree }

procedure TTree.Add(el: PElement);
var
  p : PElement;          // Вставка элемента в дерево
  flag : boolean;        // Должно быть всё понятно :)
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

constructor TTree.Create;    // Создание дерева
begin
  Head := nil;
  List := TList.Create;  // Сразу создаём список
end;

procedure TTree.Enter(count: integer);
var                   // Ввод указанного кол-ва вершин в дерево
  i : integer;
  p : PElement;
begin
  for i := 1 to count do
  begin
    New(p);
    readln(p^.value);
    p^.left  := nil;
    p^.right := nil;
    Add(p); // Добавить вершинку
  end;
end;

procedure TTree.FormList;  // Сформировать список на обходе

  procedure Straight(p : PElement);   // Прямой обход
  var
    q : PListElement;  // Новый элемент списка
  begin
    if Assigned(p) then   // Если мы не в нулевой вершине
    begin
      New(q);               // Создаём не фиктивный элемент списка
      q^.value := p^.value;
      q^.fictive := false;
      List.Add(q);          // И добавляем его
      Straight(p^.left);    // Рекурсивно влево
      New(q);               // Создаём фиктивный элемент списка
      q^.value := p^.value;
      q^.fictive := true;
      List.Add(q);          // И добавляем её
      Straight(p^.right);   // Рекурсивно вправо
      New(q);               // Создаём ещё один фиктивный элемент
      q^.value := p^.value; // Если этого не делать, то в списке элемент будет просто
      q^.fictive := true;   // менять свою позицию, что не хорошо
      List.Add(q);          // поэтому его нужно всегда пересоздавать
    end;
  end;

begin
  Straight(Head);  // Начало обхода с головного элемента
end;

{ TList }

procedure TList.Add(el: PListElement);  // Добавить элемент в конец списка
begin                                   // Тоже должно быть всё норм
  el^.used := false; // Важно пометить это для реализации сортировки
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

constructor TList.Create;   // Создание списка
begin
  Head := nil;
  Tail := nil;
end;

procedure TList.Show;   // Вывести список
var
  p : PListElement;
begin
  p := Head;          // Начинаем с первого элемента
  while Assigned(p) do     // и идём до конца списка
  begin
    if not p^.fictive then   // Если вершинка не фиктивная, то выводим её
      write(p^.value, ' ');
    p := p^.next;
  end;
  writeln;
end;

procedure TList.SortToSim;    // Преобразование прямого обхода в симметричный
var
  p, q : PListElement;
  i    : integer;
begin                                   // 1 (1) (1) -> (1) 1 (1)
  p := Head;     // Начинаем с первого элемента
  while Assigned(p) do  // и идём до конца
  begin
    if not p^.fictive and not p^.used then // Если вершинка не фиктивная и не использовалась ранее
    begin                                  // то это будет первое появление
      q := p^.next;                        // из трёх (см. выше суть)
      while (q^.value <> p^.value) do      // Ищем второе появление (которое будет фиктивным)
        q := q^.next;
      q^.fictive := false;       // Меняем их местами (см. выше)
      p^.fictive := true;
      q^.used := true;           // И помечаем как использованные
      p^.used := true;
    end;
    p := p^.next;
  end;
end;

var
  Tree : TTree;    // Дерево
  count : integer; // Кол-во вершин

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
