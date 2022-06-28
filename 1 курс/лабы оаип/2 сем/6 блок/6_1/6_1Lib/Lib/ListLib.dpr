library ListLib;

uses
   System.SysUtils,
   System.Classes;

type
   Pointer = ^TText;
   TText = Record
      Data: String;
      Next: Pointer;
   end;

{$R *.res}

procedure _AddHead(var Head, CopyHead: Pointer); stdcall;
begin
   New(Head);
   Head^.Data := '';
   Head^.Next := nil;
   CopyHead := Head;
end;

procedure _AddEl(var Head, Buff: Pointer; var Str: String); stdcall;
begin
   while Head^.Next <> nil do
      Head := Head^.Next;
   New(Buff);
   Buff^.Data := Str;
   Buff^.Next := nil;
   Head^.Next := Buff;
   Head := Head^.Next;
end;

exports
   _AddHead,
   _AddEl;

begin
end.
