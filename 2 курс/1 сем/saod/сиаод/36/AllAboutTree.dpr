program AllAboutTree;

{$APPTYPE CONSOLE}

uses
  SysUtils;

type
  Ttree=^rTree;
  rTree=record
    key:integer;
    left,right:Ttree;
    lTag,rTag:boolean;
    level:integer;
  end;

procedure AddToTree(var head:Ttree; key,level:integer);
begin
  if  head=nil  then
    begin
      new(head);
      head^.key:=key;
      head^.left:=nil;
      head^.right:=nil;
      head^.lTag:=false;
      head^.rTag:=false;
      head^.level:=level;
      exit;
    end;
  if head^.key<key then
    AddToTree(head^.right,key,level+1);
  if head^.key>key then
    AddToTree(head^.left,key,level+1);
end;

procedure RightBypass(head:Ttree);      // прямой обход
begin
  if head=nil then exit;
  write(head^.key,' ');
  RightBypass(head^.left);
  RightBypass(head^.right);
end;

procedure SymmetricBypass(head:Ttree);       // симметричный обход
begin
  if head=nil then exit;
  SymmetricBypass(head^.left);
  write(head^.key,' ');
  SymmetricBypass(head^.right);
end;

procedure ReversalBypass(head:Ttree);           // концевой обход
begin
  if head=nil then exit;
  ReversalBypass(head^.left);
  ReversalBypass(head^.right);
  write(head^.key,' ');
end;

function SearchInTree(head:Ttree;key:integer):Ttree;
begin
  result:=nil;
  if head=nil then exit;
  if head^.key=key then
    result:=head
  else
    if head^.key<key then
      result:=SearchInTree(head^.left,key)
    else
      result:=SearchInTree(head^.right,key);
end;

procedure EnterTree(var head:Ttree);
//var
//  c,key:integer;
//  s:string;
begin
{  readln(s);
  val(s,key,c);
  while c=0 do
    begin
      AddToTree(head,key,0);
      readln(s);
      val(s,key,c);
    end;}
      AddToTree(head,4,0);
      AddToTree(head,5,0);
      AddToTree(head,7,0);
      AddToTree(head,2,0);
      AddToTree(head,1,0);
      AddToTree(head,3,0);
      AddToTree(head,6,0);
end;
procedure DeleteFromTree(var Head:ttree;key:integer);
var
  p,e:ttree;
begin
  if  head=nil then exit;
  p:=head;
  if p^.key=key then
    if (p^.left=nil)and(p^.right=nil) then
      begin
        dispose(p);
        head:=nil;
      end
    else
      if p^.left=nil then
        begin
          head:=p^.right;
          dispose(p);
        end
      else
        if p^.right=nil then
          begin
            head:=p^.left;
            dispose(p);
          end
        else
          begin
            p:=p^.left;
            if p^.right=nil then
              begin
                p^.right:=head^.right;
                head:=p;
              end
            else
              begin
                while p^.right^.right<>nil do
                  p:=p^.right;
                e:=p;
                p:=p^.right;
                e^.right:=nil;
                p^.left:=head^.left;
                p^.right:=head^.right;
                dispose(head);
                head:=p;
              end;
          end
    else
      if head^.key>key then
        deletefromtree(head^.left,key)
      else
        deletefromtree(head^.right,key);
end;

Procedure RightSymmetricalSew(head:Ttree);           // правая симметричная прошивка
var
  p:ttree;
Procedure RightSew(head:ttree);
begin
  if head^.left<>nil then
    rightsew(head^.left);            //Левый

    if p<>nil then                  //Центральный
      begin
        p^.rTag:=true;
        p^.right:=head;
        p:=nil;
      end;

  if head^.right<>nil then         //Правый
    rightsew(head^.right)
  else
    P:=head;

end;
begin
  p:=nil;
  if head<>nil then
    rightsew(head);
end;
///////////
Procedure LeftSymmetricalSew(head:Ttree);
var
  p:ttree;
Procedure LeftSew(head:ttree);
begin
  if head^.right<>nil then
    Leftsew(head^.right);

  if p<>nil then
      begin
        p^.lTag:=true;
        p^.left:=head;
        p:=nil;
      end;

  if head^.left<>nil then
    Leftsew(head^.left)
  else
    P:=head;
end;
begin
  p:=nil;
  if head<>nil then
    Leftsew(head);
end;
////////////////////////////////////////////////////////////////////////////////////
Procedure RightRightSew(head:Ttree);
var
  p:ttree;
Procedure RightSew(head:ttree);
begin
  if p<>nil then                  //Центральный
    begin
      p^.rTag:=true;
      p^.right:=head;
      p:=nil;
    end;

  if head^.left<>nil then
    rightsew(head^.left);            //Левый

  if head^.right<>nil then         //Правый
    rightsew(head^.right)
  else
    P:=head;

end;
begin
  p:=nil;
  if head<>nil then
    rightsew(head);
end;
///////////
Procedure LeftRightSew(head:Ttree);
var
  p:ttree;
Procedure LeftSew(head:ttree);
begin
  if head^.right<>nil then
    Leftsew(head^.right);

  if head^.left<>nil then
    Leftsew(head^.left)
  else
    P:=head;

  if p<>nil then
      begin
        p^.lTag:=true;
        p^.left:=head;
        p:=nil;
      end;
end;
begin
  p:=nil;
  if head<>nil then
    Leftsew(head);
end;
//////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
Procedure RightReversalSew(head:Ttree);
var
  p:ttree;
Procedure RightSew(head:ttree);
begin

  if head^.left<>nil then
    rightsew(head^.left);            //Левый

  if head^.right<>nil then         //Правый
    rightsew(head^.right)
  else
    P:=head;

  if p<>nil then                  //Центральный
    begin
      p^.rTag:=true;
      p^.right:=head;
      p:=nil;
    end;
end;
begin
  p:=nil;
  if head<>nil then
    rightsew(head);
end;
///////////
Procedure LeftReversalSew(head:Ttree);
var
  p:ttree;
Procedure LeftSew(head:ttree);
begin
  if p<>nil then
      begin
        p^.lTag:=true;
        p^.left:=head;
        p:=nil;
      end;

  if head^.right<>nil then
    Leftsew(head^.right);

  if head^.left<>nil then
    Leftsew(head^.left)
  else
    P:=head;

end;
begin
  p:=nil;
  if head<>nil then
    Leftsew(head);
end;

procedure RecSymmetricalSewedBypass (head:ttree; flag:boolean;var check:boolean);
begin
  if head=nil then exit;

  if not flag then
    recsymmetricalsewedbypass(head^.left,flag,check);

  if check then
    write(head^.key,' ');

  if head^.right=nil
    then check:=false;
  recsymmetricalsewedbypass(head^.right,head^.rtag,check);
end;

procedure RecRightSewedBypass (head:ttree; flag:boolean;var check:boolean);
begin
  if head=nil then exit;

  if check then
    write(head^.key,' ');

  if not flag then
    recRightsewedbypass(head^.left,flag,check);

  if head^.right=nil
    then check:=false;
  recRightsewedbypass(head^.right,head^.rtag,check);
end;

procedure RecReversalSewedBypass (head:ttree; flag:boolean;var check:boolean);
begin
  if head=nil then exit;

  if not flag then
    recReversalsewedbypass(head^.left,flag,check);

  if head^.right=nil
    then check:=false;
  recReversalsewedbypass(head^.right,head^.rtag,check);

  if check then
    write(head^.key,' ');
end;

{procedure SymmetricalSewedBypass (head:ttree);
var
  p:ttree;
  flag:boolean;
begin
  if head=nil then exit;
  p:=head;
  flag:=false;
  repeat
    if not flag  then
      begin
        while p^.left<>nil do
          p:=p^.left;
        write(p^.key,' ');
      end;
    if p^.right=nil then exit;
    if p^.rTag then
      flag:=true
    else
      flag:=false;
    p:=p^.right;
    write(p^.key,' ');
  until p=nil;
end; }

var
  head:ttree;
  check:boolean;
//  key:integer;
begin
  entertree(head);
  //writeln;
  ///RightBypass(head);
  //writeln;
  //SymmetricBypass(head);
  //writeln;
  //ReversalBypass(head);
  //writeln;
{  readln(key);
  if  SearchInTree(head,key)=nil then
    writeln('Idite Kushat''')
  else
    writeln(SearchInTree(head,key)^.key);
}
  //deletefromtree(head,7);
  ///deletefromtree(head,4);
  //deletefromtree(head,5);
  //deletefromtree(head,2);
  //deletefromtree(head,1);
  //deletefromtree(head,3);
  //deletefromtree(head,6);
  //RightSymmetricalSew(head);
  //check:=true;
  //RecsymmetricalsewedBypass(head,false,check);
  //symmetricalsewedBypass(head);
  //RightRightSew(head);
  //check:=true;
  //RecRightsewedBypass(head,false,check);
  RightReversalSew(head);
  check:=true;
  RecReversalsewedBypass(head,false,check);
  writeln;
  readln;
end.
