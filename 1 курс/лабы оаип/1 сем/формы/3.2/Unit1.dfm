object Maksim: TMaksim
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Set in sets'
  ClientHeight = 289
  ClientWidth = 377
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
    Width = 193
    Height = 24
    Caption = 'Enter number of sets:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Result: TLabel
    Left = 8
    Top = 237
    Width = 55
    Height = 24
    Caption = 'Result'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Size: TEdit
    Left = 207
    Top = 8
    Width = 39
    Height = 21
    PopupMenu = PopupMenu
    TabOrder = 0
    OnChange = SizeChange
    OnKeyPress = SizeKeyPress
  end
  object Get: TButton
    Left = 293
    Top = 100
    Width = 75
    Height = 25
    Caption = 'Get'
    TabOrder = 1
    OnClick = GetClick
  end
  object Check: TButton
    Left = 258
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Check'
    TabOrder = 3
    OnClick = CheckClick
  end
  object SG: TStringGrid
    Left = 56
    Top = 39
    Width = 231
    Height = 192
    ColCount = 1
    DefaultColWidth = 230
    DefaultRowHeight = 20
    Enabled = False
    FixedCols = 0
    RowCount = 9
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    PopupMenu = PopupMenu
    ScrollBars = ssNone
    TabOrder = 2
    OnKeyPress = SGKeyPress
    RowHeights = (
      20
      20
      20
      20
      20
      20
      20
      20
      20)
  end
  object SGC: TStringGrid
    Left = 25
    Top = 39
    Width = 25
    Height = 192
    ColCount = 1
    DefaultColWidth = 24
    DefaultRowHeight = 20
    Enabled = False
    FixedCols = 0
    RowCount = 9
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    PopupMenu = PopupMenu
    ScrollBars = ssNone
    TabOrder = 4
    OnKeyPress = SGKeyPress
    RowHeights = (
      20
      20
      20
      20
      20
      20
      20
      20
      20)
  end
  object Menu: TMainMenu
    Left = 304
    Top = 184
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
    Left = 296
    Top = 40
  end
  object Save: TSaveDialog
    Filter = 'FileName|*.txt'
    Left = 336
    Top = 40
  end
  object PopupMenu: TPopupMenu
    Left = 304
    Top = 136
  end
end
