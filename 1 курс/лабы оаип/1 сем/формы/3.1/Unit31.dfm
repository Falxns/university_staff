object TMaxim: TTMaxim
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Strings'
  ClientHeight = 132
  ClientWidth = 441
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 73
    Height = 24
    Caption = 'Enter N:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 38
    Width = 155
    Height = 24
    Caption = 'Enter your string:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Result: TLabel
    Left = 8
    Top = 109
    Width = 5
    Height = 19
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object N: TEdit
    Left = 87
    Top = 8
    Width = 41
    Height = 21
    PopupMenu = PopupMenu1
    TabOrder = 0
    OnChange = NChange
    OnKeyPress = NKeyPress
  end
  object Strng: TEdit
    Left = 166
    Top = 38
    Width = 272
    Height = 21
    PopupMenu = PopupMenu1
    TabOrder = 1
    OnChange = StrngChange
    OnKeyPress = StrngKeyPress
  end
  object Change: TButton
    Left = 47
    Top = 68
    Width = 81
    Height = 35
    Caption = 'Change'
    TabOrder = 2
    OnClick = ChangeClick
  end
  object MainMenu1: TMainMenu
    Left = 176
    Top = 65528
    object File1: TMenuItem
      Caption = 'File'
      object Openfile1: TMenuItem
        Caption = 'Open file'
        ShortCut = 16463
        OnClick = Openfile1Click
      end
      object Savetofile: TMenuItem
        Caption = 'Save to  file'
        ShortCut = 16467
        OnClick = SavetofileClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = 'Exit'
        ShortCut = 16453
        OnClick = Exit1Click
      end
    end
    object About1: TMenuItem
      Caption = 'About'
      object Info: TMenuItem
        Caption = 'Info'
        ShortCut = 16457
        OnClick = InfoClick
      end
      object Developer1: TMenuItem
        Caption = 'Developer'
        ShortCut = 16452
        OnClick = Developer1Click
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 232
    Top = 65528
  end
  object Save: TSaveDialog
    Left = 288
    Top = 65528
  end
  object Open: TOpenDialog
    Left = 336
    Top = 65528
  end
end
