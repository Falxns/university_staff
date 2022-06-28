object Maksim: TMaksim
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Counting method'
  ClientHeight = 210
  ClientWidth = 321
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = Menu
  OldCreateOrder = False
  PopupMenu = PopupMenu
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object TextOne: TLabel
    Left = 8
    Top = 2
    Width = 169
    Height = 24
    Caption = 'Enter size of array:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 8
    Top = 124
    Width = 117
    Height = 24
    Caption = 'Sorted array:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Size: TEdit
    Left = 194
    Top = 8
    Width = 39
    Height = 21
    PopupMenu = PopupMenu
    TabOrder = 0
    OnChange = SizeChange
    OnKeyPress = SizeKeyPress
  end
  object Get: TButton
    Left = 102
    Top = 93
    Width = 75
    Height = 25
    Caption = 'Get'
    TabOrder = 1
    OnClick = GetClick
  end
  object Check: TButton
    Left = 239
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Check'
    TabOrder = 3
    OnClick = CheckClick
  end
  object SG: TStringGrid
    Left = 24
    Top = 39
    Width = 230
    Height = 48
    ColCount = 9
    DefaultColWidth = 24
    DefaultRowHeight = 20
    Enabled = False
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    PopupMenu = PopupMenu
    ScrollBars = ssNone
    TabOrder = 2
    OnKeyPress = SGKeyPress
    ColWidths = (
      24
      24
      24
      24
      24
      24
      24
      24
      24)
    RowHeights = (
      20
      20)
  end
  object SGR: TStringGrid
    Left = 24
    Top = 154
    Width = 230
    Height = 48
    ColCount = 9
    DefaultColWidth = 24
    DefaultRowHeight = 20
    Enabled = False
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    PopupMenu = PopupMenu
    ScrollBars = ssNone
    TabOrder = 4
    Visible = False
    OnKeyPress = SGKeyPress
    ColWidths = (
      24
      24
      24
      24
      24
      24
      24
      24
      24)
    RowHeights = (
      20
      20)
  end
  object Menu: TMainMenu
    Left = 264
    Top = 144
    object File1: TMenuItem
      Caption = 'File'
      object Openfile: TMenuItem
        Caption = 'Open file'
        ShortCut = 16463
        OnClick = OpenfileClick
      end
      object Savetofile: TMenuItem
        Caption = 'Save to file'
        ShortCut = 16467
        OnClick = SavetofileClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Exit: TMenuItem
        Caption = 'Exit'
        ShortCut = 16453
        OnClick = ExitClick
      end
    end
    object About: TMenuItem
      Caption = 'About'
      object Info: TMenuItem
        Caption = 'Info'
        ShortCut = 16457
        OnClick = InfoClick
      end
      object Developer: TMenuItem
        Caption = 'Developer'
        ShortCut = 16452
        OnClick = DeveloperClick
      end
    end
  end
  object Open: TOpenDialog
    Filter = 'TextFile|*.txt'
    Left = 264
    Top = 40
  end
  object Save: TSaveDialog
    Filter = 'FileName|*.txt'
    Left = 264
    Top = 88
  end
  object PopupMenu: TPopupMenu
    Left = 224
    Top = 96
  end
end
