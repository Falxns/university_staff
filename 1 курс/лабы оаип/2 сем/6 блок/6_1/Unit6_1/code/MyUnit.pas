unit MyUnit;

interface

uses
   Vcl.Grids, Vcl.Dialogs, System.SysUtils;

type
    Pointer = ^TText;
    TText = Record
        Data: String;
        Next: Pointer;
    end;

    procedure HeadCreate;
    procedure DeliteEl(SG: TStringGrid);
    procedure AddEl(St: String);
    procedure ShowAns(SG: TStringGrid);
var
    Head, CopyHead, Buff: Pointer;
    i: Byte;

implementation

procedure HeadCreate;
begin
    i := 1;
    New(Head);
    Head^.Data := '';
    Head^.Next := nil;
    CopyHead := Head;
end;

procedure DeliteEl(SG: TStringGrid);
var
    j, k: ShortInt;
    Del, Prev: Pointer;
begin
    Del := CopyHead;
    j := 0;
    Head := CopyHead;
    while (SG.Row - 1) <> j do
    begin
       Del := Del^.Next;
       inc(j);
    end;
    if Del = CopyHead then
    begin
        Head := Del^.Next;
        CopyHead := Head;
        for k := 1 to i - 2 do
            SG.Cells[0, k] := SG.Cells[0, k + 1];
        SG.Cells[0, i - 1] := '';
    end
    else
    begin
        Prev := Head^.Next;
        while (Prev^.Next <> Del)and(Prev^.Next <> nil) do
            Prev := Prev^.Next;
        Prev^.Next := Del^.Next;
        for k := j + 1 to i - 2 do
            SG.Cells[0, k] := SG.Cells[0, k + 1];
        SG.Cells[0, i - 1] := '';
    end;
    Dispose(Del);
    SG.RowCount := i - 1;
    dec(i);
end;

procedure AddEl(St: String);
begin
   Head := CopyHead;
   while Head^.Next <> nil do
      Head := Head^.Next;
   New(Buff);
   Buff^.Data := St;
   Buff^.Next := nil;
   Head^.Next := Buff;
   Head := Head^.Next;
end;

procedure ShowAns(SG: TStringGrid);
var
   z: ShortInt;
   Str: String;
begin
   z := 0;
   Head := CopyHead;
   Str := SG.Cells[0, SG.Row];
   while Head <> nil do
   begin
       if Head^.Data = Str then
       inc(z);
       Head := Head^.Next;
   end;
   MessageDlg('This record meets ' + IntToStr(z) + ' times', mtInformation, [mbOk], 0);
end;
end.
