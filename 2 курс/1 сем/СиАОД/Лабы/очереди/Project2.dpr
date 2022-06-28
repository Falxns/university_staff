{
  1. Создание головы и хвоста очереди;
  2. Добавление элементов в очередь;
  3. Ввод значений времени такта и времени простоя;
  4. Выполнение тактов;
  5. Расчет кпд;
  6. Вывод времени простоя процессора и кпд для введенных значений;
  7. Очистка памяти выделенной под очеред;
  8. Вывод шапки таблицы;
  9. Выполнение пунктов 1-7 для значений времени такта(1..10) и времени ввода(1..10);
  10. Занесение полученных результатов кпд  и времени простоя процессора в таблицу;
  11. Вывод таблицы.
}
program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

type
  ptr = ^queue;
  ttr = ^timeList;

  timeList = record
    next: ttr;
    data: integer;
  end;

  queue = record
    next: ptr;
    number, priority, work, input: integer;
    employmentIn: boolean;
    time: ttr;
  end;

  TMatrix = array[1..5, 1..11] of integer;
const
  arrTime: TMatrix =
  ((2,3,2,4,2,1,1,3,3,2,0),
   (4,1,1,1,1,2,2,3,1,1,0),
   (4,5,3,2,1,2,3,4,5,0,0),
   (4,5,3,2,1,1,3,3,8,0,0),
   (6,8,7,5,4,2,3,1,8,0,0));

var
  q, front, rear: ptr;
  downtime: integer;

procedure makeTime(var x: ptr; a: array of integer);
var
  i: integer;
  f: ttr;
begin
  i := 0;
  new(x^.time);
  f := x^.time;
  while a[i] <> 0 do
  begin
    new(x^.time^.next);
    x^.time^.data := a[i];
    x^.time := x^.time^.next;
    x^.time^.next := nil;
    inc(i);
  end;
  x^.time := f;
end;

procedure addElem(var x: ptr; y, p: integer; a: array of integer);
begin
  new(x^.next);
  x := x^.next;
  x^.number := y;
  x^.priority := p;
  x^.next := nil;
  rear := x;
  x^.time := nil;
  makeTime(x, a);
  x^.work := x^.time^.data;
  x^.time := x^.time^.next;
  x^.employmentIn := false;
end;

procedure deleteFromHead;
begin
  q := front;
  q^.next := q^.next^.next;
end;

procedure deleteElem(x: ptr);
begin
  q := front;
  while q^.next <> x do
    q := q^.next;
  q^.next := q^.next^.next;
end;

procedure insertElem(x: ptr);
var
  temp, copy, f: ptr;
begin
  q := front;
  copy := x;
  while q^.next^.priority <= x^.priority do
  begin
    q := q^.next;
    if q^.next = nil then break;
  end;
  if q = rear then
  begin
    f := q;
    deleteFromHead;
    q := f;
    temp := q^.next;
    q^.next := copy;
    copy^.next := temp;
    rear := copy;
  end
  else
  begin
    f := q;
    deleteFromHead;
    q := f;
    temp := q^.next;
    q^.next := copy;
    copy^.next := temp;
  end
end;

function insertToHead(x: ptr): ptr;
var
  temp, copy: ptr;
begin
  copy := x;
  deleteElem(x);
  q := front;
  temp := q^.next;
  q^.next := copy;
  x^.next := temp;
  result := x;
end;

procedure deleteTime(x: ptr);
begin
  x^.time := x^.time^.next;
end;

procedure print(x: ptr);
var
  f: ttr;
begin
  x := front^.next;
  while x <> nil do
  begin
    write(x^.number, '   ', x^.priority, '   ');
    f := x^.time;
    write(x^.work, '   ');
    while x^.time^.next <> nil do
    begin
      write(x^.time^.data, ' ');
      x^.time := x^.time^.next;
    end;
    x^.time := f;
    writeln;
    x := x^.next;
  end;
end;

procedure processIn(x: ptr; timeOfTact: integer);
begin
  x^.input := x^.input - timeOfTact;
  if x^.input <= 0 then
  begin
    x^.input := 0;
    if x^.time^.next <> nil then
    begin
      x^.work := x^.time^.data;
      deleteTime(x);
    end
    else
    begin
      insertToHead(x);
      deleteFromHead;
    end;
  end;
end;

procedure processWork(x: ptr; timeOfInput, timeOfTact: integer);
var
  t: integer;
begin
  x^.work := x^.work - timeOfTact;
  if x^.work <= 0 then
  begin
    t := abs(x^.work);
    x^.work := 0;
    x^.input := timeOfInput;
    x^.employmentIn := true;
    processIn(x, t);
    inc(downtime, t);
  end;
end;

procedure tact(timeOfInput, TimeOfTact: integer);
begin
  q := front^.next;
  while q <> nil do
  begin
    if q^.employmentIn then
      processIn(q, TimeOfTact);
    q := q^.next;
  end;
  q := front^.next;
  while q <> nil do
  begin
    if not(q^.employmentIn) then
    begin
      if q <> front^.next then
        q := insertToHead(q);
      processWork(q, timeOfInput, timeOfTact);
      if (q^.next <> nil) then
        if (q^.next^.priority <= q^.priority) then
          insertElem(q);
      break;
    end;
    q := q^.next;
  end;
  q := front^.next;
  while q <> nil do
  begin
    if q^.input = 0 then
      q^.employmentIn := false;
    q := q^.next;
  end;
end;

function calculateKPD(timeOfInput, timeOfTact, numberOfTacts: integer): real;
var
  i, j, allTime: integer;
  sum: integer;
begin
  sum := 0;
  for i := 1 to 5 do
    for j := 1 to 11 do
      inc(sum, arrTime[i, j]);
  allTime := timeOfTact*numberOfTacts;
  result := sum/allTime;
end;

var
  kpd: real;
  num: integer;
  tt, ti: integer;
begin
  new(q);
  front := q;
  rear := front;
  q^.next := nil;
  num := 0;
  addElem(q, 1, 1, arrTime[1]);
  addElem(q, 2, 1, arrTime[2]);
  addElem(q, 3, 1, arrTime[3]);
  addElem(q, 4, 2, arrTime[4]);
  addElem(q, 5, 2, arrTime[5]);
  print(q);
  writeln('Enter a time of tact:');
  readln(tt);
  writeln('Enter a time of input:');
  readln(ti);
  writeln;
  downtime := ti;
  while front^.next <> nil do
  begin
    tact(ti,tt);
    inc(num);
  end;
  kpd := calculateKPD(ti,tt,num);
  writeln('The time when processor was down: ',downtime);
  writeln('The efficiency:', kpd:0:2);
  writeln;
  writeln('--------------------------------------------');
  writeln('| Time of | Time of | Efficiecy | Downtime |');
  writeln('|   tact  |  input  |           |          |');
  dispose(q);
  for tt := 1 to 10 do
    for ti := 1 to 10 do
    begin
      num := 0;
      new(q);
      downtime := ti;
      front := q;
      rear := front;
      q^.next := nil;
      addElem(q, 1, 1, arrTime[1]);
      addElem(q, 2, 1, arrTime[2]);
      addElem(q, 3, 1, arrTime[3]);
      addElem(q, 4, 2, arrTime[4]);
      addElem(q, 5, 2, arrTime[5]);
      while front^.next <> nil do
      begin
        tact(ti,tt);
        inc(num);
      end;
      kpd := calculateKPD(ti,tt,num);
      writeln('--------------------------------------------');
      writeln('|   ', tt:2, '    |   ', ti:2,'    |   ',kpd:0:2,'    |   ', downtime:3, '    |');
      dispose(q);
    end;
    writeln('--------------------------------------------');
  readln;
end.
