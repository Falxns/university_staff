object EDS: TEDS
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'EDS'
  ClientHeight = 399
  ClientWidth = 284
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
    Left = 26
    Top = 8
    Width = 54
    Height = 13
    Caption = #1042#1074#1077#1076#1080#1090#1077' Q'
  end
  object Label2: TLabel
    Left = 26
    Top = 58
    Width = 52
    Height = 13
    Caption = #1042#1074#1077#1076#1080#1090#1077' P'
  end
  object Label3: TLabel
    Left = 26
    Top = 106
    Width = 52
    Height = 13
    Caption = #1042#1074#1077#1076#1080#1090#1077' h'
  end
  object Label4: TLabel
    Left = 26
    Top = 155
    Width = 52
    Height = 13
    Caption = #1042#1074#1077#1076#1080#1090#1077' X'
  end
  object Label5: TLabel
    Left = 45
    Top = 338
    Width = 6
    Height = 13
    Caption = 'Y'
  end
  object Label6: TLabel
    Left = 45
    Top = 294
    Width = 7
    Height = 13
    Caption = 'G'
  end
  object Label7: TLabel
    Left = 26
    Top = 202
    Width = 51
    Height = 13
    Caption = #1042#1074#1077#1076#1080#1090#1077' k'
  end
  object Label8: TLabel
    Left = 147
    Top = 93
    Width = 79
    Height = 13
    Caption = #1061#1077#1096' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
  end
  object Label9: TLabel
    Left = 164
    Top = 143
    Width = 43
    Height = 13
    Caption = #1055#1086#1076#1087#1080#1089#1100
  end
  object Label10: TLabel
    Left = 147
    Top = 294
    Width = 8
    Height = 13
    Caption = 'w'
  end
  object Label11: TLabel
    Left = 214
    Top = 294
    Width = 12
    Height = 13
    Caption = 'u1'
  end
  object Label12: TLabel
    Left = 143
    Top = 340
    Width = 12
    Height = 13
    Caption = 'u2'
  end
  object Label13: TLabel
    Left = 214
    Top = 338
    Width = 6
    Height = 13
    Caption = 'v'
  end
  object QNumber: TEdit
    Left = 2
    Top = 31
    Width = 97
    Height = 21
    TabOrder = 0
    OnChange = QNumberChange
  end
  object PNumber: TEdit
    Left = 2
    Top = 79
    Width = 97
    Height = 21
    TabOrder = 1
    OnChange = QNumberChange
  end
  object HNumber: TEdit
    Left = 2
    Top = 128
    Width = 97
    Height = 21
    TabOrder = 2
    OnChange = QNumberChange
  end
  object XNumber: TEdit
    Left = 2
    Top = 175
    Width = 97
    Height = 21
    TabOrder = 3
    OnChange = QNumberChange
  end
  object YNumber: TEdit
    Left = 2
    Top = 357
    Width = 97
    Height = 21
    TabOrder = 5
    OnChange = gChange
  end
  object Calculate: TButton
    Left = 2
    Top = 258
    Width = 97
    Height = 25
    Caption = #1042#1099#1095#1080#1089#1083#1080#1090#1100' '#1082#1083#1102#1095
    Enabled = False
    TabOrder = 6
    OnClick = CalculateClick
  end
  object GNumber: TEdit
    Left = 2
    Top = 313
    Width = 97
    Height = 21
    TabOrder = 7
    OnChange = gChange
  end
  object FileText: TMemo
    Left = 438
    Top = 265
    Width = 97
    Height = 65
    TabOrder = 8
  end
  object Open: TButton
    Left = 120
    Top = 8
    Width = 137
    Height = 33
    Caption = #1054#1090#1082#1088#1099#1090#1100' '#1092#1072#1081#1083
    Enabled = False
    TabOrder = 9
    OnClick = OpenClick
  end
  object generate: TButton
    Left = 120
    Top = 47
    Width = 137
    Height = 34
    Caption = #1057#1092#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100' '#1087#1086#1076#1087#1080#1089#1100
    Enabled = False
    TabOrder = 10
    OnClick = generateClick
  end
  object KNumber: TEdit
    Left = 2
    Top = 221
    Width = 97
    Height = 21
    TabOrder = 4
    OnChange = QNumberChange
  end
  object hashtext: TEdit
    Left = 120
    Top = 120
    Width = 59
    Height = 21
    TabOrder = 11
  end
  object Save: TButton
    Left = 120
    Top = 194
    Width = 137
    Height = 30
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '
    TabOrder = 12
    OnClick = SaveClick
  end
  object sign: TEdit
    Left = 122
    Top = 167
    Width = 57
    Height = 21
    TabOrder = 13
  end
  object OpenCipher: TButton
    Left = 120
    Top = 230
    Width = 137
    Height = 27
    Caption = #1055#1086#1076#1087#1080#1089#1072#1085#1085#1099#1081' '#1092#1072#1081#1083' '
    TabOrder = 14
    OnClick = OpenCipherClick
  end
  object Check: TButton
    Left = 120
    Top = 263
    Width = 137
    Height = 26
    Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100' '#1087#1086#1076#1087#1080#1089#1100
    TabOrder = 15
    OnClick = CheckClick
  end
  object sign1: TEdit
    Left = 194
    Top = 167
    Width = 63
    Height = 21
    TabOrder = 16
  end
  object U1Number: TEdit
    Left = 194
    Top = 313
    Width = 63
    Height = 21
    TabOrder = 17
  end
  object WNumber: TEdit
    Left = 120
    Top = 313
    Width = 59
    Height = 21
    TabOrder = 18
  end
  object U2Number: TEdit
    Left = 120
    Top = 357
    Width = 59
    Height = 21
    TabOrder = 19
  end
  object VNumber: TEdit
    Left = 194
    Top = 357
    Width = 63
    Height = 21
    TabOrder = 20
  end
  object NewHash: TEdit
    Left = 194
    Top = 120
    Width = 63
    Height = 21
    TabOrder = 21
  end
  object OpenF: TOpenDialog
    Left = 446
    Top = 272
  end
  object SaveF: TSaveDialog
    Left = 486
    Top = 272
  end
end
