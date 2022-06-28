program r32423423423;

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
PFirstTask,Psecondtask,buf1,buf2: PTSetOfTask;
count:integer;
buf:TDataOfTask;
procedure AddInTasks(src: TDataOfTask; var base: PTSetOfTask); // neypor9d spisok
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
procedure AddInTask(src: TDataOfTask; var base: PTSetOfTask);
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
buf := Psecondtask;
while (buf^.next <> nil) do
buf := buf^.next;
new(buf^.next);
buf := buf^.next;
buf^.data := src;
buf^.next := nil;
end;
end;
procedure AddInSet2(src: TDataOfTask; var base: PTSetOfTask); // ypor9d sp, pervii pystoi
//is4em nyjnoe mesto dl9 vstavki
var
buf: PTSetOfTask;
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
while (p^.next <> nil) and (p0^.data.id<p^.next^.data.id) do
p := p^.next;
p0^.next := p^.next;
p^.next := p0;
end;
var
i:integer;
flag:boolean;
begin
writeln ('vvedite kol-vo v o4eredi') ;
readln(count);
//golovi 0
PFirstTask:=nil;
PSecondTask:=nil;
writeln ('vvedite vesa dl9 kajdogo') ;
//vvodim
for i := 1 to count do
begin
readln(buf.id);
addintasks(buf,PFirstTask);
end;
buf1:=PFirstTask;
//vtoroi otsort sp
while (buf1<>nil) do
begin
addinset2(buf1.data,psecondtask);
buf1:=buf1^.next;
end;
writeln('o4ered` po ybivaniu');
//vivodim
buf1:=PSecondtask^.next;
while (buf1<>nil) do
begin
write(buf1^.data.id:3);
buf1:=buf1^.next;
end;
writeln('dobavim v konec ne naryshiv por9dok');
readln(buf.id);
addinset2(buf,psecondtask);
writeln('vivod o4eredi posle dobavleni9 elemnta v konec');
//vivodim
buf1:=PSecondtask^.next;
while (buf1<>nil) do
begin
write(buf1^.data.id:3);
buf1:=buf1^.next;
end;
readln;
end.

