object Rabina: TRabina
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Rabina'
  ClientHeight = 349
  ClientWidth = 514
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
  object TLabel
    Left = 35
    Top = 77
    Width = 3
    Height = 13
  end
  object Label2: TLabel
    Left = 8
    Top = 33
    Width = 8
    Height = 13
    Alignment = taCenter
    Caption = 'Q'
  end
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 6
    Height = 13
    Alignment = taCenter
    Caption = 'P'
  end
  object N: TLabel
    Left = 8
    Top = 58
    Width = 12
    Height = 13
    Caption = 'N'
  end
  object B: TLabel
    Left = 8
    Top = 83
    Width = 6
    Height = 13
    Caption = 'B'
  end
  object Label3: TLabel
    Left = 336
    Top = 336
    Width = 53
    Height = 13
    Caption = 'Third value'
  end
  object Label4: TLabel
    Left = 436
    Top = 336
    Width = 55
    Height = 13
    Caption = 'Forth value'
  end
  object Label5: TLabel
    Left = 232
    Top = 336
    Width = 64
    Height = 13
    Caption = 'Second value'
  end
  object Label6: TLabel
    Left = 150
    Top = 336
    Width = 34
    Height = 13
    Caption = 'Output'
  end
  object Label7: TLabel
    Left = 44
    Top = 336
    Width = 33
    Height = 13
    Caption = 'Source'
  end
  object Pnumber: TEdit
    Left = 20
    Top = 5
    Width = 121
    Height = 20
    TabOrder = 0
    OnChange = PnumberChange
  end
  object Qnumber: TEdit
    Left = 20
    Top = 30
    Width = 121
    Height = 20
    TabOrder = 1
    OnChange = PnumberChange
  end
  object calculateN: TButton
    Left = 150
    Top = 5
    Width = 119
    Height = 20
    Caption = 'Accept'
    Enabled = False
    TabOrder = 2
    OnClick = calculateNClick
  end
  object Nnumber: TEdit
    Left = 20
    Top = 55
    Width = 121
    Height = 20
    Enabled = False
    TabOrder = 3
    OnChange = PnumberChange
  end
  object Bnumber: TEdit
    Left = 20
    Top = 80
    Width = 121
    Height = 20
    TabOrder = 4
    OnChange = PnumberChange
  end
  object cipher: TButton
    Left = 150
    Top = 30
    Width = 119
    Height = 20
    Caption = 'Encrypt'
    Enabled = False
    TabOrder = 5
    OnClick = cipherClick
  end
  object FileText: TMemo
    Left = 20
    Top = 110
    Width = 90
    Height = 220
    TabOrder = 6
  end
  object Open: TButton
    Left = 277
    Top = 5
    Width = 120
    Height = 20
    Caption = 'Open file'
    TabOrder = 7
    OnClick = OpenClick
  end
  object CipherText: TMemo
    Left = 120
    Top = 110
    Width = 90
    Height = 220
    TabOrder = 8
  end
  object SaveCipher: TButton
    Left = 277
    Top = 30
    Width = 120
    Height = 20
    Caption = 'Save encrypted'
    TabOrder = 9
    OnClick = SaveCipherClick
  end
  object OpenCipher: TButton
    Left = 277
    Top = 55
    Width = 120
    Height = 20
    Caption = 'Open encrypted'
    TabOrder = 10
    OnClick = OpenCipherClick
  end
  object saveFile: TButton
    Left = 277
    Top = 80
    Width = 120
    Height = 20
    Caption = 'Save file'
    TabOrder = 11
    OnClick = saveFileClick
  end
  object Decipher: TButton
    Left = 150
    Top = 55
    Width = 119
    Height = 20
    Caption = 'Decrypt'
    Enabled = False
    TabOrder = 12
    OnClick = DecipherClick
  end
  object SecByte: TMemo
    Left = 220
    Top = 110
    Width = 90
    Height = 220
    TabOrder = 13
  end
  object ThByte: TMemo
    Left = 320
    Top = 110
    Width = 90
    Height = 220
    TabOrder = 14
  end
  object FrByte: TMemo
    Left = 420
    Top = 110
    Width = 90
    Height = 220
    TabOrder = 15
  end
  object OpenF: TOpenDialog
    Left = 448
  end
  object SaveF: TSaveDialog
    Left = 408
  end
end
