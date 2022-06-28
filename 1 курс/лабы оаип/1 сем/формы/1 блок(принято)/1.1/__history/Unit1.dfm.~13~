object Maksim: TMaksim
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Day of week'
  ClientHeight = 203
  ClientWidth = 221
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
  object Text: TLabel
    Left = 31
    Top = 16
    Width = 156
    Height = 24
    Caption = 'Enter number 1-7'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Result: TLabel
    Left = 48
    Top = 136
    Width = 4
    Height = 16
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Day: TEdit
    Left = 88
    Top = 54
    Width = 41
    Height = 21
    PopupMenu = PopupMenu
    TabOrder = 0
    OnChange = DayChange
    OnKeyPress = DayKeyPress
  end
  object Get: TButton
    Left = 72
    Top = 96
    Width = 75
    Height = 25
    Caption = 'Get'
    TabOrder = 1
    OnClick = GetClick
  end
  object Menu: TMainMenu
    Left = 160
    Top = 48
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
    Left = 32
    Top = 48
  end
  object Save: TSaveDialog
    Left = 32
    Top = 96
  end
  object PopupMenu: TPopupMenu
    Left = 160
    Top = 96
  end
end
