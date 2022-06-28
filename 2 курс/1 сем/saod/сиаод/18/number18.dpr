program number18;
{$APPTYPE CONSOLE}
{
���� ����� �������� ��������� (� ������� �� ���� ������ ������� ��� �� �������).
������� � ������� �������� �������, ������� ������ (�� ���� ��������� �������������).
}


Const
  N=6; //������� ��� ����� ����� ������
Type
  Binary = 0..1; //���������� �������� �������� ��� ������� ���������
  TMatrix = array[1..N, 1..N] of Binary;

{���� �������:               ��� ����:
   1 2 3 4 5 6               1 - - -2
  ------------               | \  / |
1| 0 1 0 1 0 1               5  /   3
2| 1 0 1 0 1 0               |/   \ |
3| 0 1 0 1 0 1               6 - - -4
4| 1 0 1 0 1 0
5| 0 1 0 1 0 1
6| 1 0 1 0 1 0                      
}

//������� ����� �������� ���������:
Procedure InputMatrix(var Matrix: TMatrix);
Var
  i,j: integer;
Begin
  for i:=1 to N do
    for j:=1 to N do
      if (i mod 2 = 0) and (j mod 2 = 0) then
        Matrix[i,j]:=0
      else if (i mod 2 = 0) and (j mod 2 > 0) then
        Matrix[i,j]:=1
      else if (i mod 2 > 0) and (j mod 2 = 0) then
        Matrix[i,j]:=1
      else if (i mod 2 > 0) and (j mod 2 > 0) then
        Matrix[i,j]:=0;
End;

Procedure AskUser(Var Point: integer);
Begin
  Write('Enter the number of point: ');
  Readln(point);
End;

Procedure OutPut(Matrix: TMatrix; Point: Integer);
Const
  Size=3; //� ����� ������ ������� ����� ���� ������ �������� � ����� ���������
Var
  I,J,Buffer: integer;
  PointArray: array[1..Size] of Integer;
Begin
  for i:=1 to Size do
    PointArray[i]:=0;
  i:=1;
  for j:=1 to N do
    if Matrix[point, j] = 1 then
    begin
      PointArray[i]:=j;
      inc(i);
    end;
//���������� �� �������� ���������:
  for i:=1 to Size-1 do
    for j:=Size downto i do
      if PointArray[j]>PointArray[j-1] then
      begin
        Buffer:=PointArray[j-1];
        PointArray[j-1]:=PointArray[j];
        PointArray[j]:=Buffer;
      end;
  Writeln('============');
  Writeln('Your points:');
//����� ������ (��� ����, ���� ������ ���� ������ ����, � ������� ����� ������� ���� ���� - ��� ����������):
  for i:=1 to Size do
    if(PointArray[i]>0) then
      writeln(i,') ',PointArray[i]);
End;

Procedure Exec;
Var
  Matrix: TMatrix; //������� ���������
  Point: Integer; //������������ �������
Begin
  InputMatrix(Matrix); //������� �������� ��� ������� ������������
  AskUser(Point); //������ � ������������, ����� ������� ��� ����������
  OutPut(Matrix, Point); //������� ������� � ������ �������
  Readln;
End;

Begin
  Exec;
End.
