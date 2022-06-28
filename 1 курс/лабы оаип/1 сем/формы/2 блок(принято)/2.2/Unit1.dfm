object Maksim: TMaksim
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Smallest number'
  ClientHeight = 96
  ClientWidth = 190
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = Menu
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Text: TLabel
    Left = 8
    Top = 8
    Width = 174
    Height = 24
    Caption = 'Click to get number'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Result: TLabel
    Left = 8
    Top = 69
    Width = 57
    Height = 16
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Get: TButton
    Left = 56
    Top = 38
    Width = 75
    Height = 25
    Caption = 'Get'
    TabOrder = 0
    OnClick = GetClick
  end
  object Save: TSaveDialog
    Left = 8
    Top = 32
  end
  object Menu: TMainMenu
    Left = 144
    Top = 32
    object File1: TMenuItem
      Caption = 'File'
      object SavetoFile: TMenuItem
        Caption = 'Save to file'
        ShortCut = 16467
        OnClick = SavetoFileClick
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
    object About1: TMenuItem
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
end
