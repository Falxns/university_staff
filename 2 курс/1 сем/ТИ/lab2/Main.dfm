object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Lab2'
  ClientHeight = 419
  ClientWidth = 847
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 8
    Width = 46
    Height = 21
    Caption = 'LFSR1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 0
    Top = 116
    Width = 24
    Height = 19
    Caption = 'File'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 178
    Top = 116
    Width = 39
    Height = 19
    Caption = 'Key 1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 682
    Top = 116
    Width = 80
    Height = 19
    Caption = 'Encrupt file'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 0
    Top = 35
    Width = 46
    Height = 21
    Caption = 'LFSR2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 0
    Top = 62
    Width = 46
    Height = 21
    Caption = 'LFSR3'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel
    Left = 346
    Top = 116
    Width = 39
    Height = 19
    Caption = 'Key 2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label8: TLabel
    Left = 514
    Top = 116
    Width = 39
    Height = 19
    Caption = 'Key 3'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object TC1: TMemo
    Left = 0
    Top = 141
    Width = 162
    Height = 276
    TabOrder = 0
  end
  object TC2: TMemo
    Left = 682
    Top = 141
    Width = 162
    Height = 276
    TabOrder = 1
  end
  object TempKey1: TMemo
    Left = 178
    Top = 141
    Width = 162
    Height = 276
    TabOrder = 2
  end
  object StartBtn: TButton
    Left = 118
    Top = 89
    Width = 99
    Height = 25
    Caption = 'Generate'
    TabOrder = 3
    OnClick = StartBtnClick
  end
  object LFSR1: TEdit
    Left = 52
    Top = 8
    Width = 165
    Height = 21
    TabOrder = 4
  end
  object Geffe: TButton
    Left = 0
    Top = 89
    Width = 99
    Height = 25
    Caption = 'Geffe'
    TabOrder = 5
    OnClick = GeffeClick
  end
  object LFSR2: TEdit
    Left = 52
    Top = 35
    Width = 165
    Height = 21
    Enabled = False
    TabOrder = 6
  end
  object LFSR3: TEdit
    Left = 52
    Top = 62
    Width = 165
    Height = 21
    Enabled = False
    TabOrder = 7
  end
  object TempKey2: TMemo
    Left = 346
    Top = 141
    Width = 162
    Height = 276
    TabOrder = 8
  end
  object TempKey3: TMemo
    Left = 514
    Top = 141
    Width = 162
    Height = 276
    TabOrder = 9
  end
  object SaveFile: TSaveDialog
    Left = 296
  end
  object OpenInputFile: TOpenDialog
    Left = 240
  end
end
