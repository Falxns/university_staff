unit Backgrounds;

interface

uses
    System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
    FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
    FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects;

type
    TBackgrF = class(TForm)
        FirstChoice: TButton;
        SecChoice: TButton;
        ThirdChoice: TButton;
        BackGr1: TImage;
        BackGr2: TImage;
        BackGr3: TImage;
        procedure FirstChoiceClick(Sender: TObject);
        procedure SecChoiceClick(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        procedure ThirdChoiceClick(Sender: TObject);
        private
        { Private declarations }
        public
        { Public declarations }
end;

var
    BackgrF: TBackgrF;

implementation

{$R *.fmx}

uses Game, Main;

procedure TBackgrF.FormCreate(Sender: TObject);
begin
    BackGr1.Bitmap.LoadFromFile('Materials\Background1.jpg');
    BackGr2.Bitmap.LoadFromFile('Materials\Background2.jpg');
    BackGr3.Bitmap.LoadFromFile('Materials\Background3.jpg');
    FirstChoice.Enabled := false;
    SecChoice.Enabled := true;
    ThirdChoice.Enabled := true;
end;

procedure TBackgrF.FirstChoiceClick(Sender: TObject);
begin
    FirstChoice.Enabled := false;
    SecChoice.Enabled := true;
    ThirdChoice.Enabled := true;
    GameF.Background.Bitmap.LoadFromFile('Materials\Background1.jpg');
end;

procedure TBackgrF.SecChoiceClick(Sender: TObject);
begin
    SecChoice.Enabled := false;
    FirstChoice.Enabled := true;
    ThirdChoice.Enabled := true;
    GameF.Background.Bitmap.LoadFromFile('Materials\Background2.jpg');
end;

procedure TBackgrF.ThirdChoiceClick(Sender: TObject);
begin
    ThirdChoice.Enabled := false;
    FirstChoice.Enabled := true;
    SecChoice.Enabled := true;
    GameF.Background.Bitmap.LoadFromFile('Materials\Background3.jpg');
end;

end.
