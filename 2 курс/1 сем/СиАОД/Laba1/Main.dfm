object MainF: TMainF
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Game'
  ClientHeight = 540
  ClientWidth = 540
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object imMap: TImage
    Left = 0
    Top = 0
    Width = 540
    Height = 540
    PopupMenu = BlankPop
  end
  object imBackground: TImage
    Left = 0
    Top = 0
    Width = 200
    Height = 200
  end
  object Player: TImage
    Left = 0
    Top = 0
    Width = 90
    Height = 90
    PopupMenu = BlankPop
  end
  object Door1: TImage
    Left = 180
    Top = 450
    Width = 90
    Height = 90
    PopupMenu = BlankPop
  end
  object Door2: TImage
    Left = 0
    Top = 270
    Width = 90
    Height = 90
    PopupMenu = BlankPop
  end
  object Door3: TImage
    Left = 180
    Top = 450
    Width = 90
    Height = 90
    PopupMenu = BlankPop
  end
  object Door4: TImage
    Left = 450
    Top = 360
    Width = 90
    Height = 90
    PopupMenu = BlankPop
  end
  object btnPlay: TButton
    Left = 50
    Top = 60
    Width = 100
    Height = 30
    Caption = 'Play'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    PopupMenu = BlankPop
    TabOrder = 0
    OnClick = btnPlayClick
  end
  object btnExit: TButton
    Left = 50
    Top = 110
    Width = 100
    Height = 30
    Caption = 'Exit'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ModalResult = 8
    ParentFont = False
    PopupMenu = BlankPop
    TabOrder = 1
    OnClick = btnExitClick
  end
  object Music: TMediaPlayer
    Left = 0
    Top = 540
    Width = 253
    Height = 30
    DoubleBuffered = True
    Visible = False
    ParentDoubleBuffered = False
    PopupMenu = BlankPop
    TabOrder = 2
    OnNotify = MusicNotify
  end
  object BlankPop: TPopupMenu
    Left = 8
  end
end
