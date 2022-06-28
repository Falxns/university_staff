unit Skins;

interface

uses
    System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
    FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
    FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects;

type
    TSkinsF = class(TForm)
        FirstChoice: TButton;
        SecChoice: TButton;
        ThirdChoice: TButton;
        Canon1: TImage;
        Canon2: TImage;
        Canon3: TImage;
        procedure FormCreate(Sender: TObject);
        procedure FirstChoiceClick(Sender: TObject);
        procedure SecChoiceClick(Sender: TObject);
        procedure ThirdChoiceClick(Sender: TObject);
        private
        { Private declarations }
        public
        { Public declarations }
end;

var
  SkinsF: TSkinsF;

implementation

{$R *.fmx}

uses Game, Main;

procedure TSkinsF.FormCreate(Sender: TObject);
begin
    Canon1.Bitmap.LoadFromFile('Materials\Canon1.png');
    Canon2.Bitmap.LoadFromFile('Materials\Canon2.png');
    Canon3.Bitmap.LoadFromFile('Materials\Canon3.png');
    FirstChoice.Enabled := false;
    SecChoice.Enabled := true;
    ThirdChoice.Enabled := true;
end;

procedure TSkinsF.FirstChoiceClick(Sender: TObject);
begin
    FirstChoice.Enabled := false;
    SecChoice.Enabled := true;
    ThirdChoice.Enabled := true;
    GameF.Canon.Bitmap.LoadFromFile('Materials\Canon1.png');
end;

procedure TSkinsF.SecChoiceClick(Sender: TObject);
begin
    SecChoice.Enabled := false;
    FirstChoice.Enabled := true;
    ThirdChoice.Enabled := true;
    GameF.Canon.Bitmap.LoadFromFile('Materials\Canon2.png');
end;

procedure TSkinsF.ThirdChoiceClick(Sender: TObject);
begin
    ThirdChoice.Enabled := false;
    FirstChoice.Enabled := true;
    SecChoice.Enabled := true;
    GameF.Canon.Bitmap.LoadFromFile('Materials\Canon3.png');
end;

end.
