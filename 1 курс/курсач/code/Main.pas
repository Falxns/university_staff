unit Main;

interface

uses
    System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
    FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Menus,
    FMX.Controls.Presentation, VCL.Dialogs, FMX.StdCtrls, FMX.Objects,
    System.ImageList, FMX.ImgList, FMX.Media;

type
    TMainF = class(TForm)
        BlankPop: TPopupMenu;
        btnExit: TSpeedButton;
        Imgs: TImageList;
        Style1: TStyleBook;
        btnStopMusic: TSpeedButton;
        btnPlay: TButton;
        btnScore: TButton;
        btnBackGr: TButton;
        btnSkins: TButton;
        Background: TImage;
        Music: TMediaPlayer;
        MusTimer: TTimer;
        procedure btnExitClick(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        procedure MusTimerTimer(Sender: TObject);
        procedure btnPlayClick(Sender: TObject);
        procedure btnStopMusicClick(Sender: TObject);
        procedure btnBackGrClick(Sender: TObject);
        procedure btnSkinsClick(Sender: TObject);
        procedure btnScoreClick(Sender: TObject);
        procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
        private
        { Private declarations }
        public
end;

var
  MainF: TMainF;

implementation

{$R *.fmx}

uses Game, Backgrounds, Skins, Shop;

procedure TMainF.btnBackGrClick(Sender: TObject);
begin
    BackgrF.Showmodal;
end;

procedure TMainF.btnExitClick(Sender: TObject);
begin
    Close;
end;

procedure TMainF.btnPlayClick(Sender: TObject);
begin
    Visible := false;
    with GameF  as TGameF do
    begin
        Showmodal;
    end;
end;

procedure TMainF.btnScoreClick(Sender: TObject);
begin
    ShopF.ShowModal;
end;

procedure TMainF.btnStopMusicClick(Sender: TObject);
begin
    if Music.CurrentTime > 0 then
    begin
        Music.Stop;
        Music.CurrentTime := 0;
    end
    else
    begin
        Music.Play;
    end;
end;

procedure TMainF.btnSkinsClick(Sender: TObject);
begin
    SkinsF.ShowModal;
end;

procedure TMainF.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
    btnSelected: Integer;
begin
    btnSelected := MessageDlg('Are you sure you want to exit?', mtConfirmation, [mbYes, mbNo], 0);
    if btnSelected <> mrYes then
        CanClose := false;
end;

procedure TMainF.FormCreate(Sender: TObject);
begin
    if not(FileExists('Materials\Music.wav'))
    or not(FileExists('Materials\Exit.png'))
    or not(FileExists('Materials\OffMusic.png'))
    or not(FileExists('Materials\MainMenu.jpg'))
    or not(FileExists('Materials\Background1.jpg'))
    or not(FileExists('Materials\Background2.jpg'))
    or not(FileExists('Materials\Background3.jpg'))
    or not(FileExists('Materials\Canon1.png'))
    or not(FileExists('Materials\Canon2.png'))
    or not(FileExists('Materials\Canon3.png'))
    or not(FileExists('Materials\Btn1.png'))
    or not(FileExists('Materials\Btn1.png')) then
        MessageDlg('Some of the game files were not found.' + #13#10 +
                   'Reinstall the game for correct work.', mtInformation,
                   [mbOk], 0);
    Music.FileName := 'Materials\Music.wav';
    Music.Volume := 0.6;
    Music.Play;
    Background.Bitmap.LoadFromFile('Materials\MainMenu.jpg');
    Imgs.Source[0].MultiResBitmap[0].Bitmap.LoadFromFile('Materials\Exit.png');
    Imgs.Source[0].MultiResBitmap[0].Scale := 1;
    Imgs.Source[1].MultiResBitmap[0].Bitmap.LoadFromFile('Materials\OffMusic.png');
    Imgs.Source[1].MultiResBitmap[0].Scale := 1;
    btnExit.ImageIndex := 0;
    btnStopMusic.ImageIndex := 1;
end;

procedure TMainF.MusTimerTimer(Sender: TObject);
begin
    if Music.CurrentTime >= Music.Duration then
    begin
        Music.CurrentTime := 1;
        Music.Play;
    end;
end;

end.
