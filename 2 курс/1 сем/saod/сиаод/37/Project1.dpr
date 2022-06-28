program Project1;

{$APPTYPE CONSOLE}

uses
    SysUtils;

type
    ttree = ^ptree;
    ptree = record
        data : Integer;
        counter : Integer;
        left : ttree;
        right : ttree;
end;
    Adr =^Zveno;
    Zveno = record
        Elem: Integer;
        Adrcled: Adr;
end;

var
    n, x, i: Integer;
    tree: ttree;
    MainAdr, Adrzv: Adr;

procedure Add(var node: ttree; data: Integer);
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
        if (data = node^.data) then
            inc(node^.counter)
        else
            if (data < node^.data) then
                Add(node^.left, data)
            else
                Add(node^.right, data);
    end;
end;

procedure printElement(data, count: Integer);
var
    i : LongInt;
begin
    writeln;
    for i := 1 to count do
        write(data, ' ');
    writeln;
end;

procedure TreeWalk(currentNode: ttree);
begin
    if (currentNode = nil) then
        exit;
    if (currentNode^.counter <> 1) then
        printElement(currentNode^.data, currentNode^.counter);
    TreeWalk(currentNode^.left);
    TreeWalk(currentNode^.right);
end;

begin
    New(MainAdr);
    Adrzv := MainAdr;
    Adrzv^.Adrcled := nil;
    write ('Введите количество элементов списка: ');
    readln(n);
    for i := 1 to n do
    begin
        write('Введите ', i,'-й элемент: ');
        read(x);
        New(Adrzv^.Adrcled);
        Adrzv := Adrzv^.Adrcled;
        Adrzv^.Elem := x;
        Adrzv^.adrcled:=nil;
    end;
    Adrzv := MainAdr;
    for i := 1 to n do
    begin
        Adrzv := Adrzv^.Adrcled;
        Add(tree, Adrzv^.Elem);
    end;
    TreeWalk(tree);
    readln;
    readln;
end.

