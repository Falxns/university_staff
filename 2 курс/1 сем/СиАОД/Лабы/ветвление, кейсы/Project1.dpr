program Project2;

{$APPTYPE CONSOLE}

uses
  System.SysUtils;

var
    Choice: byte;
begin
    WriteLn('����� ���������� �� ���������� "������������ ��� ��������".' + #13#10 + '� ������ ������� �� �������� ��� ���� ������ ���������� �������������.' +#13#10+ '�������� �����: ����� � �������(1), ����� � �������(2), ����� � �������� ����(3)');
    ReadLn(Choice);
    case Choice of
        1:
        begin
            WriteLn('�� ������ �� ��� �� ������������ ������ �������. �� ����� �������� ������� ����. �������� ������: ��������� ������ "������� �������"(1), �����(2), ������ � ����(3)');
            ReadLn(Choice);
            case Choice of
                1:
                begin
                    WriteLn('�������� �����. ���� �� ��� � ���������, �������� �������� ��������.' + #13#10 + '���� �����: ���������� ����(1), ��������� �����(2), �������� � ��������(3)');
                    ReadLn(Choice);
                    case Choice of
                        1:
                        WriteLn('��������� �� ���������� ����, ����������� � �������� ���.');
                        2:
                        WriteLn('�� ������� ����� �� ������� ����� ���������. ������ �������, �� ����� ��������� �� ���������. �� ������');
                        3:
                        begin
                            WriteLn('�� �������� ��������� ���� � ������ ���������� �� ����, ������� ������ ������.' + #13#10 + '�� ��������� � ������� � ����� ��������: ������� ������(1), ������������ �����(2), ������� �����(3).');
                            ReadLn(Choice);
                            case Choice of
                                1:
                                WriteLn('� ������� ������ �� ��������� ���� ����� ������ ����� � �� ������ ��� ��������. �� ������');
                                2:
                                WriteLn('������ ������������ ����� ������� ��� �� �������� ����� ������');
                                3:
                                WriteLn('� ������� ����� �� ������� �� ��������� ����� ����������');
                            end;
                        end;
                    end;
                end;
                2:
                WriteLn('���� ������� � ������ � ��������� ������');
                3:
                WriteLn('� ��� ���������� �������� �������. ��� � �� ����� �������.');
            end;
        end;
        2:
        begin
            WriteLn('�� ���� �� �������� "������" �������, ��� �� ��� ����� ���������� ���� ��������.' +#13#10+ '����� ��� ��, ��� �� �����: ��������� "������� �������"(1), ���� ����-�����(2), ����������� � �������� ��� ������ �����(3)');
            ReadLn(Choice);
            case Choice of
                1:
                WriteLn('����� �������� ����� ��� ��� ������ �� ������� �� � ���� � ������. �� ������.');
                2:
                begin
                    WriteLn('�� ��� �����, �� ���� ������ ���� ����. ������� ���� �� ���, �� �� ��� ����� ����������.' +#13#10+ '��������, �� ��� ���������� ����: ��������(1), ����(2), �����(3)');
                    ReadLn(Choice);
                    case Choice of
                        1:
                        WriteLn('�� �������� ���� �������� ���������. �� ��������� ������������, �� ��� ������� �������� ��������');
                        2:
                        WriteLn('���� ����� ��������. ��� ������ ������� � �������, ����� �� ���. �� �������� ���� �� ������');
                        3:
                        WriteLn('��� ������ � 1966 ����, �� ������������ ��������� �� ������ ����� ��������');
                    end;
                end;
                3:
                begin
                    WriteLn('����� ������ � ��� ����������� ������. ���� ��������: ��������, ������ � �����(1), ������ �����(2), �������� �� �����(3)');
                    ReadLn(Choice);
                    case Choice of
                        1:
                        WriteLn('�� ������ �� ����. �� �������������� ����� ������������� ����� ���� ��������� � �����');
                        2:
                        begin
                            WriteLn('��� � ��������, ��� � ���������, ����� ������� �� ���� �����. ��� ��������: �����, ���� � �� ���������(1), ��������(2), ������ Pepsi(3)');
                            Readln(Choice);
                            case Choice of
                                1:
                                WriteLn('��� ��������� ����� ������ ��������������. �� ������.');
                                2:
                                WriteLn('�� �������� ���� ���� ������ ���������������������� �����������, ������ �� ���� ������������ � �������� � �������');
                                3:
                                WriteLn('Pepsi ������� ��� ���������� ���')
                            end;
                        end;
                        3:
                        WriteLn('�� ������� ������� ������. ��� ������ ������� � ���������� � ������');
                    end;
                end;
            end;
        end;
        3:
        begin
            WriteLn('� ������� ����� ����. � �� �������� ������� ����� ������ �� �����.' + #13#10 + '�� ������� ������ ����� - ��� ����� ����������: ���� ����� � �����������(1), ���� ����� � �����������(2), ���� ����� � �����������(3)');
            ReadLn(Choice);
            case Choice of
                1:
                WriteLn('�� ��� ������. �� ��� ������� �� ������');
                2:
                begin
                    WriteLn('�� ��������� ������. �������� ���� ����: �������(1), �����(2), ������(3)');
                    ReadLn(Choice);
                    case Choice of
                        1:
                        WriteLn('�� ����� �������, � ��� ����� ��� ��� ��������� ������. ������� ������� �� ��� ��������� �������. �� �������� ��������.');
                        2:
                        WriteLn('��� ���� ����� ��������� ������. ��� ������ �� ������� � ������������ � ����, ��� � ��������� ���������.');
                        3:
                        begin
                            WriteLn('������ �����, �� ����� ������ ����� � �������� ���� �����������. �������� ����: ���� 1(1), ���� 2(2), ���� 3(3)');
                            ReadLn(Choice);
                            case Choice of
                                1:
                                WriteLn('�� ������ ����� �� ������� �����, ������� ������� ��������� ��� �����.');
                                2:
                                WriteLn('������� �� ����������� ��������� �� �����������, ��� � ����� 2 ����');
                                3:
                                begin
                                    WriteLn('�� ������ ����� ��� ���� �������. �� ������ � ��� �� ���������. �� ������ ���� ���������, �� �� ��������, � �� ���������');
                                end;
                            end;
                        end;
                    end;
                end;
                3:
                WriteLn('�� �����, �����-�� �� �������. �� ��� �� ���������, ���������� �� ����� ����. �� ��������.');
            end;
        end;
    end;
    ReadLn;
end.
