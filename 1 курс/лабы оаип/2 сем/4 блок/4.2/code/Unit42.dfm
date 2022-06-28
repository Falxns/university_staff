object Lab_4_2: TLab_4_2
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = ' Akkerman'#39's Function'
  ClientHeight = 148
  ClientWidth = 295
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
    Width = 167
    Height = 24
    Caption = 'Enter arguments:  '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 169
    Top = 8
    Width = 20
    Height = 24
    Caption = 'A('
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 281
    Top = 8
    Width = 8
    Height = 24
    Caption = ')'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 232
    Top = 8
    Width = 6
    Height = 24
    Caption = ','
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Result: TLabel
    Left = 8
    Top = 77
    Width = 77
    Height = 24
    Caption = 'Value is:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object M: TEdit
    Left = 195
    Top = 8
    Width = 31
    Height = 29
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    PopupMenu = PopupMenu1
    TabOrder = 0
    OnChange = MChange
    OnKeyPress = MKeyPress
  end
  object N: TEdit
    Left = 244
    Top = 8
    Width = 31
    Height = 29
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    PopupMenu = PopupMenu1
    TabOrder = 1
    OnChange = NChange
    OnKeyPress = NKeyPress
  end
  object Calculate: TButton
    Left = 8
    Top = 38
    Width = 80
    Height = 33
    Caption = 'Calculate'
    Enabled = False
    TabOrder = 2
    OnClick = CalculateClick
  end
  object Retry: TButton
    Left = 8
    Top = 107
    Width = 80
    Height = 33
    Caption = 'Retry'
    TabOrder = 3
    Visible = False
    OnClick = RetryClick
  end
  object Answer: TEdit
    Left = 94
    Top = 72
    Width = 47
    Height = 29
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    PopupMenu = PopupMenu1
    ReadOnly = True
    TabOrder = 4
    Visible = False
  end
  object MainMenu1: TMainMenu
    Left = 208
    Top = 104
    object File1: TMenuItem
      Caption = 'File'
      object Open: TMenuItem
        Caption = 'Open file'
        ShortCut = 16463
        OnClick = OpenClick
      end
      object Save: TMenuItem
        Caption = 'Save to file'
        Enabled = False
        ShortCut = 16467
        OnClick = SaveClick
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
    object Help: TMenuItem
      Caption = 'Help'
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
  object PopupMenu1: TPopupMenu
    Left = 256
    Top = 104
  end
  object SaveFile: TSaveDialog
    Left = 256
    Top = 64
  end
  object OpenFile: TOpenDialog
    Left = 208
    Top = 64
  end
end
