object Main: TMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Hladki Maksim 851001'
  ClientHeight = 345
  ClientWidth = 334
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PopupMenu = Popup
  PixelsPerInch = 96
  TextHeight = 13
  object Text1: TLabel
    Left = 8
    Top = 8
    Width = 38
    Height = 19
    Caption = 'Rows'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    PopupMenu = Popup
  end
  object Text2: TLabel
    Left = 8
    Top = 33
    Width = 62
    Height = 19
    Caption = 'Columns'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    PopupMenu = Popup
  end
  object SG: TStringGrid
    Left = 8
    Top = 64
    Width = 320
    Height = 120
    Enabled = False
    FixedCols = 0
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    PopupMenu = Popup
    ScrollBars = ssNone
    TabOrder = 0
    OnKeyPress = SGKeyPress
  end
  object SGR: TStringGrid
    Left = 8
    Top = 190
    Width = 320
    Height = 120
    Enabled = False
    FixedCols = 0
    FixedRows = 0
    PopupMenu = Popup
    ScrollBars = ssNone
    TabOrder = 1
    Visible = False
  end
  object SortBtn: TButton
    Left = 122
    Top = 33
    Width = 75
    Height = 25
    Caption = 'Sort'
    Enabled = False
    PopupMenu = Popup
    TabOrder = 2
    OnClick = SortBtnClick
  end
  object RowsAm: TEdit
    Left = 76
    Top = 10
    Width = 37
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    PopupMenu = Popup
    TabOrder = 3
    OnKeyPress = RowsAmKeyPress
  end
  object ColumnsAm: TEdit
    Left = 76
    Top = 37
    Width = 37
    Height = 21
    PopupMenu = Popup
    TabOrder = 4
    OnKeyPress = RowsAmKeyPress
  end
  object CheckBtn: TButton
    Left = 122
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Check'
    Enabled = False
    PopupMenu = Popup
    TabOrder = 5
    OnClick = CheckBtnClick
  end
  object Popup: TPopupMenu
    Left = 16
    Top = 312
  end
end
