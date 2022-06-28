program BallBlast;



uses
  System.StartUpCopy,
  FMX.Forms,
  Main in 'Main.pas' {MainF},
  Game in 'Game.pas' {GameF},
  Backgrounds in 'Backgrounds.pas' {BackgrF},
  Skins in 'Skins.pas' {SkinsF},
  Shop in 'Shop.pas' {ShopF};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainF, MainF);
  Application.CreateForm(TGameF, GameF);
  Application.CreateForm(TBackgrF, BackgrF);
  Application.CreateForm(TSkinsF, SkinsF);
  Application.CreateForm(TShopF, ShopF);
  Application.Run;
end.
