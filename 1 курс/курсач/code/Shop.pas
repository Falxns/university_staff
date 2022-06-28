unit Shop;

interface

uses
    System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
    FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
    FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects;

type
    TShopF = class(TForm)
        CoinsLbl: TLabel;
        Coins: TLabel;
        BullRate: TLabel;
        BulletUpgr: TButton;
        Bull1: TImage;
        Bull2: TImage;
        Bull3: TImage;
        Bull4: TImage;
        Bull5: TImage;
        CoinsKoef: TLabel;
        CoinsUpgr: TButton;
        Coins1: TImage;
        Coins2: TImage;
        Coins3: TImage;
        BullDmg: TLabel;
        DmgUpgr: TButton;
        Dmg1: TImage;
        Dmg2: TImage;
        Dmg3: TImage;
        Dmg4: TImage;
        Dmg5: TImage;
        procedure FormCreate(Sender: TObject);
        procedure FormShow(Sender: TObject);
        procedure BulletUpgrClick(Sender: TObject);
        procedure CoinsUpgrClick(Sender: TObject);
        procedure DmgUpgrClick(Sender: TObject);
        private
        { Private declarations }
        public
        { Public declarations }
end;

var
    ShopF: TShopF;
    Bul, Coin, Dmg: ShortInt;

implementation

{$R *.fmx}

uses Game, Main;

procedure TShopF.BulletUpgrClick(Sender: TObject);
begin
    inc(Bul);
    case Bul of
        2:
        begin
            GameF.Bullet.Interval := 550;
            inc(GameF.RandFrom, 1);
            inc(GameF.RandTo, 1);
            Bull2.Bitmap.LoadFromFile('Materials\Btn2.png');
            Coins.Text := IntToStr(StrToInt(Coins.Text) - StrToInt(BulletUpgr.Text));
            BulletUpgr.Text := '15';
            if StrToInt(Coins.Text) < StrToInt(BulletUpgr.Text) then
                BulletUpgr.Enabled := false;
            if CoinsUpgr.Text <> 'Full' then
                if StrToInt(Coins.Text) < StrToInt(CoinsUpgr.Text) then
                    CoinsUpgr.Enabled := false;
            if DmgUpgr.Text <> 'Full' then
                if StrToInt(Coins.Text) < StrToInt(DmgUpgr.Text) then
                    DmgUpgr.Enabled := false;
        end;
        3:
        begin
            GameF.Bullet.Interval := 500;
            inc(GameF.RandFrom, 1);
            inc(GameF.RandTo, 1);
            Bull3.Bitmap.LoadFromFile('Materials\Btn2.png');
            Coins.Text := IntToStr(StrToInt(Coins.Text) - StrToInt(BulletUpgr.Text));
            BulletUpgr.Text := '20';
            if StrToInt(Coins.Text) < StrToInt(BulletUpgr.Text) then
                BulletUpgr.Enabled := false;
            if CoinsUpgr.Text <> 'Full' then
                if StrToInt(Coins.Text) < StrToInt(CoinsUpgr.Text) then
                    CoinsUpgr.Enabled := false;
            if DmgUpgr.Text <> 'Full' then
                if StrToInt(Coins.Text) < StrToInt(DmgUpgr.Text) then
                    DmgUpgr.Enabled := false;
        end;
        4:
        begin
            GameF.Bullet.Interval := 450;
            inc(GameF.RandFrom, 1);
            inc(GameF.RandTo, 2);
            Bull4.Bitmap.LoadFromFile('Materials\Btn2.png');
            Coins.Text := IntToStr(StrToInt(Coins.Text) - StrToInt(BulletUpgr.Text));
            BulletUpgr.Text := '25';
            if StrToInt(Coins.Text) < StrToInt(BulletUpgr.Text) then
                BulletUpgr.Enabled := false;
            if CoinsUpgr.Text <> 'Full' then
                if StrToInt(Coins.Text) < StrToInt(CoinsUpgr.Text) then
                    CoinsUpgr.Enabled := false;
            if DmgUpgr.Text <> 'Full' then
                if StrToInt(Coins.Text) < StrToInt(DmgUpgr.Text) then
                    DmgUpgr.Enabled := false;
        end;
        5:
        begin
            GameF.Bullet.Interval := 400;
            inc(GameF.RandFrom, 2);
            inc(GameF.RandTo, 2);
            Bull5.Bitmap.LoadFromFile('Materials\Btn2.png');
            Coins.Text := IntToStr(StrToInt(Coins.Text) - StrToInt(BulletUpgr.Text));
            BulletUpgr.Text := 'Full';
            BulletUpgr.Enabled := false;
            if CoinsUpgr.Text <> 'Full' then
                if StrToInt(Coins.Text) < StrToInt(CoinsUpgr.Text) then
                    CoinsUpgr.Enabled := false;
            if DmgUpgr.Text <> 'Full' then
                if StrToInt(Coins.Text) < StrToInt(DmgUpgr.Text) then
                    DmgUpgr.Enabled := false;
        end;
    end;
end;

procedure TShopF.CoinsUpgrClick(Sender: TObject);
begin
    inc(Coin);
    case Coin of
        2:
        begin
            GameF.Koef := 2;
            inc(GameF.RandFrom, 2);
            inc(GameF.RandTo, 3);
            Coins2.Bitmap.LoadFromFile('Materials\Btn2.png');
            Coins.Text := IntToStr(StrToInt(Coins.Text) - StrToInt(CoinsUpgr.Text));
            CoinsUpgr.Text := '40';
            if StrToInt(Coins.Text) < StrToInt(CoinsUpgr.Text) then
                CoinsUpgr.Enabled := false;
            if BulletUpgr.Text <> 'Full' then
                if StrToInt(Coins.Text) < StrToInt(BulletUpgr.Text) then
                    BulletUpgr.Enabled := false;
            if DmgUpgr.Text <> 'Full' then
                if StrToInt(Coins.Text) < StrToInt(DmgUpgr.Text) then
                    DmgUpgr.Enabled := false;
        end;
        3:
        begin
            GameF.Koef := 3;
            inc(GameF.RandFrom, 2);
            inc(GameF.RandTo, 4);
            Coins3.Bitmap.LoadFromFile('Materials\Btn2.png');
            Coins.Text := IntToStr(StrToInt(Coins.Text) - StrToInt(CoinsUpgr.Text));
            CoinsUpgr.Text := 'Full';
            CoinsUpgr.Enabled := false;
            if BulletUpgr.Text <> 'Full' then
                if StrToInt(Coins.Text) < StrToInt(BulletUpgr.Text) then
                    BulletUpgr.Enabled := false;
            if DmgUpgr.Text <> 'Full' then
                if StrToInt(Coins.Text) < StrToInt(DmgUpgr.Text) then
                    DmgUpgr.Enabled := false;
        end;
    end;
end;

procedure TShopF.DmgUpgrClick(Sender: TObject);
begin
    inc(Dmg);
    case Dmg of
        2:
        begin
            GameF.KoefDmg := 2;
            inc(GameF.RandFrom, 2);
            inc(GameF.RandTo, 3);
            Dmg2.Bitmap.LoadFromFile('Materials\Btn2.png');
            Coins.Text := IntToStr(StrToInt(Coins.Text) - StrToInt(DmgUpgr.Text));
            DmgUpgr.Text := '40';
            if StrToInt(Coins.Text) < StrToInt(DmgUpgr.Text) then
                DmgUpgr.Enabled := false;
            if BulletUpgr.Text <> 'Full' then
                if StrToInt(Coins.Text) < StrToInt(BulletUpgr.Text) then
                    BulletUpgr.Enabled := false;
            if CoinsUpgr.Text <> 'Full' then
                if StrToInt(Coins.Text) < StrToInt(CoinsUpgr.Text) then
                    CoinsUpgr.Enabled := false;
        end;
        3:
        begin
            GameF.KoefDmg := 3;
            inc(GameF.RandFrom, 2);
            inc(GameF.RandTo, 4);
            Dmg3.Bitmap.LoadFromFile('Materials\Btn2.png');
            Coins.Text := IntToStr(StrToInt(Coins.Text) - StrToInt(DmgUpgr.Text));
            DmgUpgr.Text := '50';
            if StrToInt(Coins.Text) < StrToInt(DmgUpgr.Text) then
                DmgUpgr.Enabled := false;
            if BulletUpgr.Text <> 'Full' then
                if StrToInt(Coins.Text) < StrToInt(BulletUpgr.Text) then
                    BulletUpgr.Enabled := false;
            if CoinsUpgr.Text <> 'Full' then
                if StrToInt(Coins.Text) < StrToInt(CoinsUpgr.Text) then
                    CoinsUpgr.Enabled := false;
        end;
        4:
        begin
            GameF.KoefDmg := 4;
            inc(GameF.RandFrom, 3);
            inc(GameF.RandTo, 5);
            Dmg4.Bitmap.LoadFromFile('Materials\Btn2.png');
            Coins.Text := IntToStr(StrToInt(Coins.Text) - StrToInt(DmgUpgr.Text));
            DmgUpgr.Text := '60';
            if StrToInt(Coins.Text) < StrToInt(DmgUpgr.Text) then
                DmgUpgr.Enabled := false;
            if BulletUpgr.Text <> 'Full' then
                if StrToInt(Coins.Text) < StrToInt(BulletUpgr.Text) then
                    BulletUpgr.Enabled := false;
            if CoinsUpgr.Text <> 'Full' then
                if StrToInt(Coins.Text) < StrToInt(CoinsUpgr.Text) then
                    CoinsUpgr.Enabled := false;
        end;
        5:
        begin
            GameF.KoefDmg := 5;
            inc(GameF.RandFrom, 4);
            inc(GameF.RandTo, 7);
            Dmg5.Bitmap.LoadFromFile('Materials\Btn2.png');
            Coins.Text := IntToStr(StrToInt(Coins.Text) - StrToInt(DmgUpgr.Text));
            DmgUpgr.Text := 'Full';
            DmgUpgr.Enabled := false;
            if BulletUpgr.Text <> 'Full' then
                if StrToInt(Coins.Text) < StrToInt(BulletUpgr.Text) then
                    BulletUpgr.Enabled := false;
            if CoinsUpgr.Text <> 'Full' then
                if StrToInt(Coins.Text) < StrToInt(CoinsUpgr.Text) then
                    CoinsUpgr.Enabled := false;
        end;
    end;
end;

procedure TShopF.FormCreate(Sender: TObject);
begin
    Bul := 1;
    Coin := 1;
    Dmg := 1;
    BulletUpgr.Text := '10';
    CoinsUpgr.Text := '30';
    DmgUpgr.Text := '30';
    Bull1.Bitmap.LoadFromFile('Materials\Btn2.png');
    Bull2.Bitmap.LoadFromFile('Materials\Btn1.png');
    Bull3.Bitmap.LoadFromFile('Materials\Btn1.png');
    Bull4.Bitmap.LoadFromFile('Materials\Btn1.png');
    Bull5.Bitmap.LoadFromFile('Materials\Btn1.png');
    Coins1.Bitmap.LoadFromFile('Materials\Btn2.png');
    Coins2.Bitmap.LoadFromFile('Materials\Btn1.png');
    Coins3.Bitmap.LoadFromFile('Materials\Btn1.png');
    Dmg1.Bitmap.LoadFromFile('Materials\Btn2.png');
    Dmg2.Bitmap.LoadFromFile('Materials\Btn1.png');
    Dmg3.Bitmap.LoadFromFile('Materials\Btn1.png');
    Dmg4.Bitmap.LoadFromFile('Materials\Btn1.png');
    Dmg5.Bitmap.LoadFromFile('Materials\Btn1.png');
end;

procedure TShopF.FormShow(Sender: TObject);
begin
    if BulletUpgr.Text <> 'Full' then
        if StrToInt(Coins.Text) <= StrToInt(BulletUpgr.Text) then
            BulletUpgr.Enabled := false
        else
            BulletUpgr.Enabled := true;
    if CoinsUpgr.Text <> 'Full' then
        if (StrToInt(Coins.Text) <= StrToInt(CoinsUpgr.Text)) then
            CoinsUpgr.Enabled := false
        else
            CoinsUpgr.Enabled := true;
    if DmgUpgr.Text <> 'Full' then
        if (StrToInt(Coins.Text) <= StrToInt(DmgUpgr.Text)) then
            DmgUpgr.Enabled := false
        else
            DmgUpgr.Enabled := true;
end;

end.
