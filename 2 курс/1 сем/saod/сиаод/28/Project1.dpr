program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils, Windows;

type
  PElem = ^TElem;
  TElem = record
    Symb : Char;
    Next : PElem;
  end;

procedure Push( const Symb : Char; var Head : PElem );
  var
    NewElem : PElem;
  begin
    New(NewElem);
    NewElem^.Symb:= Symb;
    NewElem^.Next:= Head;
    Head:= NewElem;
  end;

function Pop(var Head : PElem) : Char;
  var
    PopEl : PElem;
  begin
    Result:= Head^.Symb ;
    PopEl:= Head;
    Head:= Head^.Next;
    Dispose(PopEl);
  end;

var
  InpStr : String[255];
  i : Integer;
  Head1, Head2, TempHead : PElem;
  Symb : Char;
begin
  SetConsoleCP(1251);
  SetConsoleOutputCP(1251);
  ReadLn(InpStr);
  for i:= 1 to Length(InpStr) do
    Push(InpStr[i], Head1);
  ReadLn(InpStr);
  for i:= 1 to Length(InpStr) do
    Push(InpStr[i], Head2);

  while Head1 <> Nil do
  begin
    Symb:= Pop(Head1);
    case Symb of
      'A'..'Z', 'a'..'z' :
        Push(Symb, Head2);
      'À'..'ß', 'à'..'ÿ' :
        Push(Symb, TempHead);
    end;
  end;

  while Head2 <> Nil do
  begin
    Symb:= Pop(Head2);
    case Symb of
      'A'..'Z', 'a'..'z' :
        Push(Symb, Head1);
      'À'..'ß', 'à'..'ÿ' :
        Push(Symb, TempHead);
    end;
  end;

  Head2:= TempHead;

  while Head1 <> Nil do
    Write(Pop(Head1), ' ');
  Writeln;
  while Head2 <> Nil do
    Write(Pop(Head2), ' ');
  ReadLn;
end.
