program Project1;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System, SysUtils, Windows;

type
  TList = ^list;
    list = record
      data: integer;
      next: TList;
    end;

procedure Input(var headF, headS: TList);
var
  ElF, ElS: TList;
  inputInt: integer;
  flag: boolean;
  numOfEl: integer;
  i: integer;

begin
  flag := true;
  writeln('Введите количество элементов первого списка:');
  readln(numOfEl);
  writeln;
  writeln('Введите элементы первого списка (', numOfEl, '):');
  for i := 1 to numOfEl do
  begin
    readln(inputInt);
        if flag then
          begin
            new(ElF);
            ElF^.next:= nil;
            ElF^.data:= inputInt;
            flag := false;
            headF:= ElF;
          end
        else
          begin
            new(ElF^.next);
            ElF:= ElF^.next;
            ElF^.next:= nil;
            ElF^.data:= inputInt;
          end;
  end;
  flag := true;
  writeln;
  writeln('Введите количество элементов второго списка:');
  readln(numOfEl);
  writeln;
  writeln('Введите элементы второго списка (', numOfEl, '):');
  for i := 1 to numOfEl do
  begin
    readln(inputInt);
        if flag then
          begin
            new(ElS);
            ElS^.next:= nil;
            ElS^.data:= inputInt;
            flag := false;
            headS:= ElS;
          end
        else
          begin
            new(ElS^.next);
            ElS:= ElS^.next;
            ElS^.next:= nil;
            ElS^.data:= inputInt;
          end;
  end;
end;

procedure Move(var headF, headS: TList);
var
  ElF, ElS, temp, pred: TList;

begin
  ElF := headF;
  pred := nil;
  while ElF <> nil do
    begin
      if ElF^.data >= 0 then
        begin
          new(temp);
          temp^.next:= headS;
          headS:= temp;
          temp^.data:= ElF^.data;
          if ElF = headF then
            begin
              ElF:= ElF^.next;
              Dispose(headF);
              headF:= ElF;
            end
          else
            if ElF^.next = nil then
              begin
                if pred <> nil  then
                  pred^.next:= nil;
                break;
              end
            else
              begin
                pred^.next:= ElF^.next;
                ElF:= ElF^.next;
              end;
        end
      else
        begin
          pred:= ElF;
          ElF:= ElF^.next;
        end;
    end;
  ElS:= headS;
  pred:= nil;
  while ElS <> nil do
    begin
      if ElS^.data < 0 then
        begin
          new(temp);
          temp^.next:= headF;
          headF:= temp;
          temp^.data:= ElS^.data;
          if ElS = headS then
            begin
              ElS:= ElS^.next;
              Dispose(headS);
              headS:= ElS;
            end
          else
            if ElS^.next = nil then
              begin
                if pred <> nil then
                  pred^.next:= nil;
                break;
              end
            else
              begin
                pred^.next:= ElS^.next;
                ElS:= ElS^.next;
              end;
        end
      else
        begin
          pred:= ElS;
          ElS:= ElS^.next;
        end;
    end;
end;

procedure Sort(var headF, headS: TList);
var
  ElF, ElS, temp: TList;
  tempdata: integer;

begin
  new(ElF);
  new(ElS);
  ElF:= headF;
  ElS:= headS;
  if ElF <> nil then
    temp:= ElF^.next;
  while (ElF <> nil) and (ElF^.next <> nil) do
    begin
      while temp <> nil do
        begin
          if ElF^.data > temp^.data then
            begin
              tempdata := ElF^.data;
              ElF^.data := temp^.data;
              temp^.data := tempdata;
            end;
          temp:= temp^.next;
        end;
      ElF:= ElF^.next;
      temp:=ElF^.next;
    end;
  if ElS <> nil then
    temp:= ElS^.next;;
  while (ElS <> nil) and (ElS^.next <> nil) do
    begin
      while temp <> nil do
        begin
          if ElS^.data > temp^.data then
            begin
              tempdata:= ElS^.data;
              ElS^.data:= temp^.data;
              temp^.data:= tempdata;
            end;
          temp:= temp^.next;
        end;
      ElS:= ElS^.next;
      temp:=ElS^.next;
    end;
end;

procedure Output(headF, headS: TList);
var
  ElF, ElS: TList;

begin
  ElF:= headF;
  ElS:= headS;
  writeln;
  writeln('Первый список (отрицательные элементы):');
  while ElF <> nil do
    begin
      writeln(ElF^.data);
      ElF:= ElF^.next;
    end;
  writeln;
  writeln('Второй список (положительные элементы):');
  while ElS <> nil do
    begin
      writeln(ElS^.data);
      ElS:= ElS^.next
    end;
end;

procedure Main;
var
  headF, headS: TList;

begin
  Input(headF, headS);
  Move(headF,headS);
  Sort(headF, headS);
  Output(headF,headS);
end;

begin
try
  SetConsoleCP(1251);
  SetConsoleOutPutCP(1251);
  Main;
  readln;

except
  begin
    writeln('Произошла ошибка. Проверьте введенные данные.');
    readln;
  end;
end;

end.
