unit Main;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Vcl.ExtCtrls,
    Vcl.Imaging.jpeg, Vcl.Imaging.pngimage, Vcl.MPlayer;

type
    TMainF = class(TForm)
        BlankPop: TPopupMenu;
        btnPlay: TButton;
        btnExit: TButton;
        imMap: TImage;
        imBackground: TImage;
        Player: TImage;
        Door1: TImage;
        Door2: TImage;
        Door3: TImage;
        Door4: TImage;
        Music: TMediaPlayer;
        procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
        procedure btnExitClick(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        procedure btnPlayClick(Sender: TObject);
        procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MusicNotify(Sender: TObject);
    private
    { Private declarations }
    public
    { Public declarations }
    end;
TArr = array[1..8] of array[1..8] of Byte;

var
    MainF: TMainF;
    Map: TArr;
    Map1: TArr =
    ((0, 0, 0, 0, 0, 0, 0, 0),
    (0, 1, 0, 0, 0, 0, 0, 0),
    (0, 1, 0, 1, 0, 0, 0, 0),
    (0, 1, 0, 1, 1, 1, 0, 0),
    (0, 1, 0, 1, 0, 1, 2, 0),
    (0, 1, 0, 1, 0, 1, 0, 0),
    (0, 1, 1, 1, 0, 1, 0, 0),
    (0, 0, 0, 0, 0, 0, 0, 0));
    Map2: TArr =
    ((0, 0, 0, 0, 0, 0, 0, 0),
    (0, 0, 0, 1, 0, 0, 0, 0),
    (0, 1, 1, 1, 1, 1, 0, 0),
    (0, 1, 0, 0, 0, 1, 0, 0),
    (0, 1, 1, 0, 3, 1, 0, 0),
    (0, 1, 0, 0, 5, 0, 0, 0),
    (0, 1, 1, 4, 1, 1, 2, 0),
    (0, 0, 0, 0, 0, 0, 0, 0));
    Map3: TArr =
    ((0, 0, 0, 0, 0, 0, 0, 0),
    (0, 1, 1, 4, 1, 1, 1, 0),
    (0, 1, 0, 0, 1, 0, 5, 0),
    (0, 1, 0, 0, 3, 0, 2, 0),
    (0, 4, 0, 0, 0, 0, 1, 0),
    (0, 1, 0, 0, 0, 0, 4, 0),
    (0, 1, 1, 4, 1, 1, 1, 0),
    (0, 0, 0, 0, 0, 0, 0, 0));
    Pos: array[1..2] of Byte;
    Level, Door: Byte;
    PlKey: Boolean;

implementation

{$R *.dfm}

procedure TMainF.btnExitClick(Sender: TObject);
begin
    Close;
end;

procedure TMainF.MusicNotify(Sender: TObject);
begin
    with Music do
        if NotifyValue = nvSuccessful then
        begin
            Notify := true;
            Play;
        end;
end;

procedure TMainF.btnPlayClick(Sender: TObject);
begin
    MainF.ClientHeight := 540;
    MainF.ClientWidth := 540;
    MainF.Position := poDesktopCenter;
    btnPlay.Visible := false;
    btnExit.Visible := false;
    imBackground.Visible := false;
    imMap.Picture.LoadFromFile('Lvl1.png');
    Player.Top := 0;
    Player.Left := 0;
    Player.Picture.LoadFromFile('Player.png');
    imMap.Visible := true;
    Player.Visible := true;
    Map := Map1;
    Pos[1] := 2;
    Pos[2] := 2;
    Level := 1;
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
    MainF.ClientHeight := 200;
    MainF.ClientWidth := 200;
    MainF.Position := poDesktopCenter;
    imBackground.Picture.LoadFromFile('Background.png');
    Player.Picture.LoadFromFile('Player.png');
    Door1.Picture.LoadFromFile('Door.png');
    Door2.Picture.LoadFromFile('Door.png');
    Door3.Picture.LoadFromFile('Door.png');
    Door4.Picture.LoadFromFile('Door.png');
    Door1.Visible := false;
    Door2.Visible := false;
    Door3.Visible := false;
    Door4.Visible := false;
    imMap.Visible := false;
    Player.Visible := false;
    imBackground.Visible := true;
    Music.FileName := 'Music.wav';
    Music.Open;
    Music.Play;
end;

procedure TMainF.FormKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
var
    Buff: Byte;
begin
    case Key of
        VK_LEFT:
        begin
            Buff := Map[Pos[1], Pos[2] - 1];
            case Buff of
                0:;
                1:
                begin
                    Player.Left := Player.Left - 90;
                    dec(Pos[2]);
                end;
                2:
                begin
                    Player.Left := Player.Left - 90;
                    dec(Pos[2]);
                    case Level of
                        1:
                        begin
                            MessageDlg('You left first floor. It was easy :)', mtInformation, [mbOk], 0);
                            Map := Map2;
                            imMap.Picture.LoadFromFile('Lvl2.png');
                            Door1.Top := 450;
                            Door1.Left := 180;
                            Door1.Visible := true;
                            Pos[1] := 2;
                            Pos[2] := 4;
                            Player.Top := 0;
                            Player.Left := 180;
                            Door := 1;
                            PlKey := false;
                        end;
                        2:
                        begin
                            MessageDlg('Not so bad -_- You passed second floor.', mtInformation, [mbOk], 0);
                            Map := Map3;
                            imMap.Picture.LoadFromFile('Lvl3.png');
                            Player.Picture.LoadFromFile('Player.png');
                            Door1.Top := 0;
                            Door1.Left := 180;
                            Door1.Visible := true;
                            Door2.Visible := true;
                            Door3.Visible := true;
                            Door4.Visible := true;
                            Pos[1] := 2;
                            Pos[2] := 7;
                            Player.Top := 0;
                            Player.Left := 450;
                            Door := 1;
                            PlKey := false;
                        end;
                        3:
                        begin
                            MessageDlg('You are really nice one ^-^ You escaped from my prison. My congratulations!', mtInformation, [mbOk], 0);
                            MainF.ClientHeight := 200;
                            MainF.ClientWidth := 200;
                            Door1.Visible := false;
                            Door2.Visible := false;
                            Door3.Visible := false;
                            Door4.Visible := false;
                            imMap.Visible := false;
                            Player.Visible := false;
                            imBackground.Visible := true;
                            btnPlay.Visible := true;
                            btnExit.Visible := true;
                            MainF.Position := poDesktopCenter;
                        end;
                    end;
                    inc(Level);
                end;
                3:
                begin
                    Player.Left := Player.Left - 90;
                    dec(Pos[2]);
                    PlKey := true;
                    Player.Picture.LoadFromFile('PlayerKey.png');
                end;
                4:
                begin
                    if PlKey then
                    begin
                        Player.Left := Player.Left - 90;
                        dec(Pos[2]);
                        Player.Picture.LoadFromFile('Player.png');
                        case Door of
                            1: Door1.Visible := false;
                            2: Door2.Visible := false;
                            3: Door3.Visible := false;
                            4: Door4.Visible := false;
                        end;
                        inc(Door);
                        PlKey := false;
                        Map[Pos[1], Pos[2]] := 1;
                    end
                    else
                        MessageDlg('You don''t have a key.', mtInformation, [mbOk], 0);
                end;
                5:
                begin
                    Player.Left := Player.Left - 90;
                    dec(Pos[2]);
                    MessageDlg('OMG! You found a secret way O_o', mtInformation, [mbOk], 0);
                end;
            end;
        end;
        VK_RIGHT:
        begin
            Buff := Map[Pos[1], Pos[2] + 1];
            case Buff of
                0:;
                1:
                begin
                    Player.Left := Player.Left + 90;
                    inc(Pos[2]);
                end;
                2:
                begin
                    Player.Left := Player.Left + 90;
                    inc(Pos[2]);
                    case Level of
                        1:
                        begin
                            MessageDlg('You left first floor. It was easy :)', mtInformation, [mbOk], 0);
                            Map := Map2;
                            imMap.Picture.LoadFromFile('Lvl2.png');
                            Door1.Top := 450;
                            Door1.Left := 180;
                            Door1.Visible := true;
                            Pos[1] := 2;
                            Pos[2] := 4;
                            Player.Top := 0;
                            Player.Left := 180;
                            Door := 1;
                            PlKey := false;
                        end;
                        2:
                        begin
                            MessageDlg('Not so bad -_- You passed second floor.', mtInformation, [mbOk], 0);
                            Map := Map3;
                            imMap.Picture.LoadFromFile('Lvl3.png');
                            Player.Picture.LoadFromFile('Player.png');
                            Door1.Top := 0;
                            Door1.Left := 180;
                            Door1.Visible := true;
                            Door2.Visible := true;
                            Door3.Visible := true;
                            Door4.Visible := true;
                            Pos[1] := 2;
                            Pos[2] := 7;
                            Player.Top := 0;
                            Player.Left := 450;
                            Door := 1;
                            PlKey := false;
                        end;
                        3:
                        begin
                            MessageDlg('You are really nice one ^-^ You escaped from my prison. My congratulations!', mtInformation, [mbOk], 0);
                            MainF.ClientHeight := 200;
                            MainF.ClientWidth := 200;
                            Door1.Visible := false;
                            Door2.Visible := false;
                            Door3.Visible := false;
                            Door4.Visible := false;
                            imMap.Visible := false;
                            Player.Visible := false;
                            imBackground.Visible := true;
                            btnPlay.Visible := true;
                            btnExit.Visible := true;
                            MainF.Position := poDesktopCenter;
                        end;
                    end;
                    inc(Level);
                end;
                3:
                begin
                    Player.Left := Player.Left + 90;
                    inc(Pos[2]);
                    PlKey := true;
                    Player.Picture.LoadFromFile('PlayerKey.png');
                end;
                4:
                begin
                    if PlKey then
                    begin
                        Player.Left := Player.Left + 90;
                        inc(Pos[2]);
                        Player.Picture.LoadFromFile('Player.png');
                        case Door of
                            1: Door1.Visible := false;
                            2: Door2.Visible := false;
                            3: Door3.Visible := false;
                            4: Door4.Visible := false;
                        end;
                        inc(Door);
                        PlKey := false;
                        Map[Pos[1], Pos[2]] := 1;
                    end
                    else
                        MessageDlg('You don''t have a key.', mtInformation, [mbOk], 0);
                end;
                5:
                begin
                    Player.Left := Player.Left + 90;
                    inc(Pos[2]);
                    MessageDlg('OMG! You found a secret way O_o', mtInformation, [mbOk], 0);
                end;
            end;
        end;
        VK_UP:
        begin
            Buff := Map[Pos[1] - 1, Pos[2]];
            case Buff of
                0:;
                1:
                begin
                    Player.Top := Player.Top - 90;
                    dec(Pos[1]);
                end;
                2:
                begin
                    Player.Top := Player.Top - 90;
                    dec(Pos[1]);
                    case Level of
                        1:
                        begin
                            MessageDlg('You left first floor. It was easy :)', mtInformation, [mbOk], 0);
                            Map := Map2;
                            imMap.Picture.LoadFromFile('Lvl2.png');
                            Door1.Top := 450;
                            Door1.Left := 180;
                            Door1.Visible := true;
                            Pos[1] := 2;
                            Pos[2] := 4;
                            Player.Top := 0;
                            Player.Left := 180;
                            Door := 1;
                            PlKey := false;
                        end;
                        2:
                        begin
                            MessageDlg('Not so bad -_- You passed second floor.', mtInformation, [mbOk], 0);
                            Map := Map3;
                            imMap.Picture.LoadFromFile('Lvl3.png');
                            Player.Picture.LoadFromFile('Player.png');
                            Door1.Top := 0;
                            Door1.Left := 180;
                            Door1.Visible := true;
                            Door2.Visible := true;
                            Door3.Visible := true;
                            Door4.Visible := true;
                            Pos[1] := 2;
                            Pos[2] := 7;
                            Player.Top := 0;
                            Player.Left := 450;
                            Door := 1;
                            PlKey := false;
                        end;
                        3:
                        begin
                            MessageDlg('You are really nice one ^-^ You escaped from my prison. My congratulations!', mtInformation, [mbOk], 0);
                            MainF.ClientHeight := 200;
                            MainF.ClientWidth := 200;
                            Door1.Visible := false;
                            Door2.Visible := false;
                            Door3.Visible := false;
                            Door4.Visible := false;
                            imMap.Visible := false;
                            Player.Visible := false;
                            imBackground.Visible := true;
                            btnPlay.Visible := true;
                            btnExit.Visible := true;
                            MainF.Position := poDesktopCenter;
                        end;
                    end;
                    inc(Level);
                end;
                3:
                begin
                    Player.Top := Player.Top - 90;
                    dec(Pos[1]);
                    PlKey := true;
                    Player.Picture.LoadFromFile('PlayerKey.png');
                end;
                4:
                begin
                    if PlKey then
                    begin
                        Player.Top := Player.Top - 90;
                        dec(Pos[1]);
                        Player.Picture.LoadFromFile('Player.png');
                        case Door of
                            1: Door1.Visible := false;
                            2: Door2.Visible := false;
                            3: Door3.Visible := false;
                            4: Door4.Visible := false;
                        end;
                        inc(Door);
                        PlKey := false;
                        Map[Pos[1], Pos[2]] := 1;
                    end
                    else
                        MessageDlg('You don''t have a key.', mtInformation, [mbOk], 0);
                end;
                5:
                begin
                    Player.Top := Player.Top - 90;
                    dec(Pos[1]);
                    MessageDlg('OMG! You found a secret way O_o', mtInformation, [mbOk], 0);
                end;
            end;
        end;
        VK_DOWN:
        begin
            Buff := Map[Pos[1] + 1, Pos[2]];
            case Buff of
                0:;
                1:
                begin
                    Player.Top := Player.Top + 90;
                    inc(Pos[1]);
                end;
                2:
                begin
                    Player.Top := Player.Top + 90;
                    inc(Pos[1]);
                    case Level of
                        1:
                        begin
                            MessageDlg('You left first floor. It was easy :)', mtInformation, [mbOk], 0);
                            Map := Map2;
                            Door1.Top := 450;
                            Door1.Left := 180;
                            Door1.Visible := true;
                            Pos[1] := 2;
                            Pos[2] := 4;
                            Player.Top := 0;
                            Player.Left := 180;
                            Door := 1;
                            PlKey := false;
                        end;
                        2:
                        begin
                            MessageDlg('Not so bad -_- You passed second floor.', mtInformation, [mbOk], 0);
                            Map := Map3;
                            imMap.Picture.LoadFromFile('Lvl3.png');
                            Player.Picture.LoadFromFile('Player.png');
                            Door1.Top := 0;
                            Door1.Left := 180;
                            Door1.Visible := true;
                            Door2.Visible := true;
                            Door3.Visible := true;
                            Door4.Visible := true;
                            Pos[1] := 2;
                            Pos[2] := 7;
                            Player.Top := 0;
                            Player.Left := 450;
                            Door := 1;
                            PlKey := false;
                        end;
                        3:
                        begin
                            MessageDlg('You are really nice one ^-^ You escaped from my prison. My congratulations!', mtInformation, [mbOk], 0);
                            MainF.ClientHeight := 200;
                            MainF.ClientWidth := 200;
                            Door1.Visible := false;
                            Door2.Visible := false;
                            Door3.Visible := false;
                            Door4.Visible := false;
                            imMap.Visible := false;
                            Player.Visible := false;
                            imBackground.Visible := true;
                            btnPlay.Visible := true;
                            btnExit.Visible := true;
                            MainF.Position := poDesktopCenter;
                        end;
                    end;
                    inc(Level);
                end;
                3:
                begin
                    Player.Top := Player.Top + 90;
                    inc(Pos[1]);
                    PlKey := true;
                    Player.Picture.LoadFromFile('PlayerKey.png');
                end;
                4:
                begin
                    if PlKey then
                    begin
                        Player.Top := Player.Top + 90;
                        inc(Pos[1]);
                        Player.Picture.LoadFromFile('Player.png');
                        case Door of
                            1: Door1.Visible := false;
                            2: Door2.Visible := false;
                            3: Door3.Visible := false;
                            4: Door4.Visible := false;
                        end;
                        inc(Door);
                        PlKey := false;
                        Map[Pos[1], Pos[2]] := 1;
                    end
                    else
                        MessageDlg('You don''t have a key.', mtInformation, [mbOk], 0);
                end;
                5:
                begin
                    Player.Top := Player.Top + 90;
                    inc(Pos[1]);
                    MessageDlg('OMG! You found a secret way O_o', mtInformation, [mbOk], 0);
                end;
            end;
        end;
    end;
end;

end.
