object SortF: TSortF
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Sorted products'
  ClientHeight = 294
  ClientWidth = 486
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = SortMenu
  OldCreateOrder = False
  PopupMenu = MainForm.PopupMenu
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object SGR: TStringGrid
    Left = 0
    Top = 32
    Width = 485
    Height = 260
    ColCount = 4
    DefaultColWidth = 120
    DefaultRowHeight = 25
    FixedCols = 0
    RowCount = 10
    FixedRows = 0
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Close: TButton
    Left = 0
    Top = 1
    Width = 75
    Height = 25
    Caption = 'Close'
    ModalResult = 6
    PopupMenu = MainForm.PopupMenu
    TabOrder = 1
    OnClick = CloseClick
  end
  object SortMenu: TMainMenu
    Left = 440
    object Help: TMenuItem
      Caption = 'Help'
      OnClick = HelpClick
    end
    object SavetoFileS: TMenuItem
      Caption = 'Save'
      OnClick = SavetoFileSClick
    end
  end
  object Save: TSaveDialog
    DefaultExt = '*.txt'
    Filter = 'DataBase|*.db'
    Left = 80
  end
end
