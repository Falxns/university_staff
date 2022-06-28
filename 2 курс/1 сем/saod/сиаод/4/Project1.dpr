program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;

type
ttree = ^ptree;
ptree = record
data : LongInt;
counter : longint;
left : ttree;
right : ttree;
end;

var
n, x, i : LongInt;
tree : ttree;

procedure add(var node : ttree; data : LongInt);
begin
if (node = nil) then
begin
New(node);
node^.data := data;
node^.counter := 1;
node^.left := nil;
node^.right := nil;
end
else
begin
if (data = node^.data) then inc(node^.counter)
else
if (data < node^.data) then add(node^.left, data)
else add(node^.right, data);
end;
end;

procedure printElement(data, count : LongInt);
var
i : LongInt;
begin
Writeln;
for i := 1 to count do write(data, ' ');
writeln;
end;

procedure TreeWalk(currentNode : ttree);
begin
if (currentNode = nil) then Exit;
if (currentNode^.counter <> 1) then printElement(currentNode^.data, currentNode^.counter);
TreeWalk(currentNode^.left);
TreeWalk(currentNode^.right);
end;

begin
writeln ('vvedite kolichestvo elementov masiva:');
readln(n);
writeln ('vvedite sami elementy');
for i := 1 to n do begin
readln(x);
Add(tree, x);
end;
TreeWalk(tree);

readln;

end.

