object Maksim: TMaksim
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Sum of elements'
  ClientHeight = 181
  ClientWidth = 331
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
    Top = 16
    Width = 87
    Height = 24
    Caption = 'Enter size'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Result: TLabel
    Left = 8
    Top = 83
    Width = 4
    Height = 16
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Size: TEdit
    Left = 101
    Top = 22
    Width = 39
    Height = 21
    PopupMenu = PopupMenu
    TabOrder = 0
    OnChange = SizeChange
    OnKeyPress = SizeKeyPress
  end
  object Get: TButton
    Left = 8
    Top = 46
    Width = 75
    Height = 25
    Caption = 'Get'
    TabOrder = 1
    OnClick = GetClick
  end
  object Check: TButton
    Left = 146
    Top = 20
    Width = 75
    Height = 25
    Caption = 'Check'
    TabOrder = 3
    OnClick = CheckClick
  end
  object SG: TStringGrid
    Left = 8
    Top = 105
    Width = 314
    Height = 53
    ColCount = 10
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
  end
  object Menu: TMainMenu
    Left = 200
    Top = 56
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
    Left = 232
    Top = 8
  end
  object Save: TSaveDialog
    Left = 232
    Top = 56
  end
  object PopupMenu: TPopupMenu
    Left = 152
    Top = 56
  end
end
