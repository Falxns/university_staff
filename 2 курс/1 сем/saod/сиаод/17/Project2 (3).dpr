program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

type
PTSetOfTask = ^TSetOfTask;

TDataOfTask = record
id:integer;
end;

TSetOfTask = record
next: PTSetOfTask;
data: TDataOfTask;

end;

var
PFirstTask,Psecondtask,buf1,PThirtTask: PTSetOfTask;
count:integer;
buf:TDataOfTask;


procedure AddInTasks(src: TDataOfTask; var base: PTSetOfTask);
var
buf: PTSetOfTask;
begin
if (base = nil) then
begin

new(base);
base^.data := src;
base^.next := nil;
end
else
begin
buf := PFirsttask;
while (buf^.next <> nil) do
buf := buf^.next;
new(buf^.next);

buf := buf^.next;
buf^.data := src;
buf^.next := nil;

end;
end;

procedure AddInSet2(src: TDataOfTask; var base: PTSetOfTask); // первый элемент пустой для удобства.
//основан на том, что мы ищем нужное место вставки и таким образом получаем отстортированный массив
var
p0, p: PTSetOfTask;
begin

if (base = nil) then
begin
new(base);
base^.next := nil;
end;

new(p0);
p0^.next := nil;
p := base;
p0^.data := src;
while (p^.next <> nil) and (p0^.data.id>p^.next^.data.id) do
p := p^.next;

p0^.next := p^.next;
p^.next := p0;

end;

var
i:integer;

begin
writeln ('Vvedite kolichestvo elementov v 1 spiske') ;
readln(count);

//обнуляем головы
PFirstTask:=nil;
PSecondTask:=nil;
PThirtTask:=nil;

//вводим
for i := 1 to count do
begin
readln(buf.id);
addintasks(buf,PFirstTask);
end;

writeln ('Vvedite kolichestvo elementov vo 2 spiske') ;
readln(count);

for i := 1 to count do
begin
readln(buf.id);
addintasks(buf,PThirtTask);
end;

buf1:=PFirstTask;
//добавляем из 1-го списка
while (buf1<>nil) do
begin
addinset2(buf1.data,psecondtask);
buf1:=buf1^.next;
end;

//добавляем из 2-го списка
buf1:=PThirtTask;
while (buf1<>nil) do
begin
addinset2(buf1.data,psecondtask);
buf1:=buf1^.next;
end;

buf1:=PSecondtask^.next;
writeln('Vivod sort spiska');
//выводим
while (buf1<>nil) do
begin
write(buf1^.data.id:3);

buf1:=buf1^.next;
end;

readln;
end.

