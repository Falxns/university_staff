object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Maksim Gladkiy. Group: 851001'
  ClientHeight = 270
  ClientWidth = 240
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  PopupMenu = PopupMenu
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 2
    Width = 48
    Height = 24
    Caption = 'Menu'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object SG: TStringGrid
    Left = 106
    Top = 2
    Width = 127
    Height = 260
    ColCount = 1
    DefaultColWidth = 420
    DefaultRowHeight = 25
    FixedCols = 0
    RowCount = 10
    PopupMenu = PopupMenu
    ScrollBars = ssVertical
    TabOrder = 0
    ColWidths = (
      420)
    RowHeights = (
      25
      25
      25
      25
      25
      25
      25
      25
      25
      25)
  end
  object Add: TButton
    Left = 0
    Top = 25
    Width = 100
    Height = 25
    Caption = 'Add..'
    TabOrder = 1
    OnClick = AddClick
  end
  object Delete: TButton
    Left = 0
    Top = 48
    Width = 100
    Height = 25
    Caption = 'Delete..'
    TabOrder = 2
    OnClick = DeleteClick
  end
  object Show: TButton
    Left = 0
    Top = 71
    Width = 100
    Height = 25
    Caption = 'Show..'
    TabOrder = 3
    OnClick = ShowClick
  end
  object MainMenu: TMainMenu
    Left = 8
    Top = 224
    object About: TMenuItem
      Caption = 'About'
      object Developer: TMenuItem
        Caption = 'Developer'
        ShortCut = 16452
        OnClick = DeveloperClick
      end
      object Info: TMenuItem
        Caption = 'Info'
        ShortCut = 16457
        OnClick = InfoClick
      end
    end
  end
  object PopupMenu: TPopupMenu
    Left = 64
    Top = 224
  end
end
