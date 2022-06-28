unit Game;

interface

uses
    System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
    FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, VCL.Dialogs, FMX.Objects,
    FMX.Ani, FMX.Controls.Presentation, FMX.StdCtrls;

type
    TGameF = class(TForm)
        Canon: TImage;
        Background: TImage;
        Bullet: TTimer;
        Ball: TTimer;
        Check: TTimer;
        ScoreLbl: TLabel;
        Points: TLabel;
        procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
            Shift: TShiftState);
        procedure Delete(Sender: Tobject);
        procedure Delt(Sender: TObject);
        procedure DeleteBall(Sender: TObject);
        procedure BulletTimer(Sender: TObject);
        procedure BallTimer(Sender: TObject);
        procedure FormClose(Sender: TObject; var Action: TCloseAction);
        procedure FormShow(Sender: TObject);
        procedure CheckTimer(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        private
            { Private declarations }
        public
            Koef, KoefDmg, RandFrom, RandTo: ShortInt;
        end;

var
    GameF: TGameF;
    Obj: TCircle;
    AnimX: TFloatAnimation;
    AnimY: TFloatAnimation;
    Bullets: array[1..1000] of TCircle;
    Balls: array[1..100] of TCircle;
    Counters: array[1..100] of SmallInt;
    Numbers: array[1..100] of TLabel;
    Score: Integer;
    i, j, ii, jj, k, l: Integer;

implementation

{$R *.fmx}

uses Main, Backgrounds, Shop;

procedure TGameF.FormShow(Sender: TObject);
begin
    for i := 1 to 100 do
    begin
        if Balls[i] <> nil then
        begin
            Balls[i].Destroy;
            Balls[i] := nil;
        end;
        Counters[i] := 0;
    end;
    for i := 1 to 1000 do
        if Bullets[i] <> nil then
        begin
            Bullets[i].Destroy;
            Bullets[i] := nil;
        end;
    i := 1;
    ii := 1;
    j := 0;
    jj := 0;
    Canon.Position.X := 108;
    Canon.Position.Y := 320;
    Score := 0;
    Points.Text := '0';
    Ball.Enabled := true;
    Bullet.Enabled := true;
end;

procedure TGameF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Check.Enabled := false;
    Ball.Enabled := false;
    Bullet.Enabled := false;
    ShopF.Coins.Text := IntToStr(StrToInt(ShopF.Coins.Text) + StrToInt(Points.Text));
    Close;
    MainF.Show;
end;

procedure TGameF.FormCreate(Sender: TObject);
begin
    Background.Bitmap.LoadFromFile('Materials\Background1.jpg');
    Canon.Bitmap.LoadFromFile('Materials\Canon1.png');
    Koef := 1;
    KoefDmg := 1;
    RandFrom := 2;
    RandTo := 5;
    Bullet.Interval := 600;
end;

procedure TGameF.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
    Shift: TShiftState);
begin
    case Key of
        37:
            if Canon.Position.X > -34 then
                Canon.Position.X := Canon.Position.X - 6;
        39:
            if Canon.Position.X < 250 then
                Canon.Position.X := Canon.Position.X + 6;
    end;
end;

procedure TGameF.BulletTimer(Sender: TObject);
begin
    // �������� ����
    Obj := TCircle.Create(Self);
    Obj.Parent := Self;
    Obj.Width := 10;
    Obj.Height := 10;
    Obj.Position.X := Canon.Position.X + 38;
    Obj.Position.Y := Canon.Position.Y;
    // ���������� ���� � ������
    inc(j);
    Bullets[j] := Obj;
    // ������� �������� �������� ����
    AnimY := TFloatAnimation.Create(Obj);
    AnimY.Parent := Obj;
    AnimY.StartValue := Obj.Position.Y;
    AnimY.PropertyName := 'Position.Y';
    AnimY.StopValue := 0;
    AnimY.Duration := 1;
    AnimY.Enabled := true;
    // �������� ���� ����� ��������� ��������
    AnimY.OnFinish := Delete;
end;

procedure TGameF.BallTimer(Sender: TObject);
var
    Num: TLabel;
    Rand: SmallInt;
begin
    Rand := Random(2);
    // �������� ����
    Obj := TCircle.Create(Self);
    Obj.Parent := Self;
    Obj.Width := Random(30) + 51;
    Obj.Height := Obj.Width;
    case Rand of
        0:
            Obj.Position.X := 0;
        1:
            Obj.Position.X := 300 - Obj.Width;
    end;
    Obj.Position.X := 0;
    Obj.Position.Y := Random(100);
    // ����� ����� ����
    case Random(5) of
        0: Obj.Fill.Color := TAlphaColors.Cyan;
        1: Obj.Fill.Color := TAlphaColors.White;
        2: Obj.Fill.Color := TAlphaColors.Green;
        3: Obj.Fill.Color := TAlphaColors.Gold;
        4: Obj.Fill.Color := TAlphaColors.Pink;
    end;
    // ���������� ����� � ���
    Num := TLabel.Create(Self);
    Num.Parent := Obj;
    Num.Position.X := Trunc(Obj.Width) div 2 - 5;
    Num.Position.Y := Trunc(Obj.Height) div 2 - 10;
    Num.TextSettings.Font.Size := 20;
    Num.TextSettings.FontColor := TAlphaColors.Black;
    if TStyledSetting.Size in Num.StyledSettings then
        Num.StyledSettings := Num.StyledSettings - [TStyledSetting.Size] - [TStyledSetting.FontColor]
    else
        Num.StyledSettings := Num.StyledSettings + [TStyledSetting.Size] + [TStyledSetting.FontColor];
    Num.Text := IntToStr(Random(RandTo) + RandFrom);
    // ��������� ������ � �������
    inc(jj);
    Balls[jj] := Obj;
    Counters[jj] := StrToInt(Num.Text);
    Numbers[jj] := Num;
    // �������� �������� �� �����������
    AnimX := TFloatAnimation.Create(Obj);
    AnimX.Parent := Obj;
    AnimX.PropertyName := 'Position.X';
    case Rand of
        0:
        begin
            AnimX.StartValue := Obj.Position.X;
            AnimX.StopValue := 300 - Obj.Width;
        end;
        1:
        begin
            AnimX.StartValue := 300 - Obj.Width;
            AnimX.StopValue := Obj.Position.X;
        end;
    end;
    AnimX.Duration := 4;
    AnimX.Loop := true;
    AnimX.AutoReverse := true;
    AnimX.Enabled := true;
    // �������� �������� �� ���������
    AnimY := TFloatAnimation.Create(Obj);
    AnimY.Parent := Obj;
    AnimY.StartValue := Obj.Position.Y;
    AnimY.PropertyName := 'Position.Y';
    AnimY.StopValue := 400 - Obj.Height;
    AnimY.Duration := 2;
    AnimY.Interpolation := TInterpolationType.Quadratic;
    AnimY.Loop := true;
    AnimY.AutoReverse := true;
    AnimY.Enabled := true;
    // ������ ��������� �������
    Check.Enabled := true;
end;

procedure TGameF.CheckTimer(Sender: TObject);
var
    m: Integer;
begin
    // �������� �� ��������
    for m := ii to jj do
        if (Balls[m] <> nil)and(Balls[m].Position.X + Balls[m].Width > Canon.Position.X + 20)and(Balls[m].Position.X < Canon.Position.X + Canon.Width - 20) then
            if (Balls[m].Position.Y + Balls[m].Height > Canon.Position.Y + 15) then
            begin
                // ���������� �������� � ��������� �������
                Ball.Enabled := false;
                Bullet.Enabled := false;
                Check.Enabled := false;
                // ������� �������� ���� �� �����
                for l := 1 to 100 do
                    if Balls[l] <> nil then
                    begin
                        Balls[l].Destroy;
                        Balls[l] := nil;
                    end;
                // ��������� � ���������
                MessageDlg('You lose! Try again!', mtInformation, [mbOk], 0);
                Close;
                MainF.Show;
            end;
    // �������� �� ��������� �� ����
    for k := i to j do
        for l := ii to jj do
            if (Bullets[k] <> nil)and(Balls[l] <> nil) then
                if (Bullets[k].Position.X + 5 > Balls[l].Position.X)and(Bullets[k].Position.X + 5 < Balls[l].Position.X + Balls[l].Width) then
                    if (Bullets[k].Position.Y + 5 > Balls[l].Position.Y)and(Bullets[k].Position.Y + 5 < Balls[l].Position.Y + Balls[l].Height)  then
                    begin
                        // �������� ���� � ������
                        Delt(Sender);
                        DeleteBall(Sender);
                    end;
end;

procedure TGameF.DeleteBall(Sender: TObject);
begin
    // �������� �� ����������� ����������� ����
    if Counters[l] <= KoefDmg then
    begin
        // ����������� ������
        Balls[l].Destroy;
        Balls[l] := nil;
        // ���������� ���������� �����
        inc(Score, Koef * Counters[l]);
        Points.Text := IntToStr(Score);
    end
    else
    begin
        // ���������� ����� ������ ����
        dec(Counters[l], KoefDmg);
        Numbers[l].Text := IntToStr(Counters[l]);
        // ���������� ���������� �����
        inc(Score, Koef * KoefDmg);
        Points.Text := IntToStr(Score);
    end;
end;

procedure TGameF.Delete(Sender: TObject);
begin
    if Bullets[i] <> nil then
    begin
        Bullets[i].Destroy;
        Bullets[i] := nil;
    end
    else
        if Bullets[i - 1] <> nil then
        begin
            Bullets[i - 1].Destroy;
            Bullets[i - 1] := nil;
        end;
    inc(i);
end;

procedure TGameF.Delt(Sender: TObject);
begin
    // �������� ����
    Bullets[k].Destroy;
    Bullets[k] := nil;
    inc(i);
end;

end.
