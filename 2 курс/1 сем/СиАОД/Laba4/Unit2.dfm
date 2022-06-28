object Add: TAdd
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1044#1086#1073#1072#1074#1080#1090#1100
  ClientHeight = 293
  ClientWidth = 273
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 180
    Width = 143
    Height = 16
    Caption = #1058#1077#1088#1084#1080#1085' '#1076#1083#1103' '#1076#1086#1073#1072#1074#1083#1077#1085#1080#1103
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 0
    Top = 0
    Width = 103
    Height = 16
    Caption = #1054#1089#1085#1086#1074#1085#1086#1081' '#1090#1077#1088#1084#1080#1085
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 0
    Top = 45
    Width = 64
    Height = 16
    Caption = #1055#1086#1076#1090#1077#1088#1084#1080#1085
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 0
    Top = 229
    Width = 146
    Height = 16
    Caption = #1045#1089#1083#1080' '#1083#1080#1085#1080#1103' '#1073#1091#1076#1077#1090' '#1087#1091#1089#1090#1072#1103
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 0
    Top = 245
    Width = 269
    Height = 16
    Caption = #1090#1077#1088#1084#1080#1085' '#1073#1091#1076#1077#1090' '#1076#1086#1073#1072#1074#1083#1077#1085' '#1074' '#1073#1083#1080#1078#1072#1081#1096#1077#1077' '#1076#1077#1088#1077#1074#1086
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 0
    Top = 89
    Width = 203
    Height = 16
    Caption = #1058#1077#1088#1084#1080#1085' '#1076#1083#1103' '#1076#1086#1073#1072#1074#1083#1077#1085#1080#1103' '#1089#1090#1088#1072#1085#1080#1094#1099
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label7: TLabel
    Left = 0
    Top = 138
    Width = 111
    Height = 16
    Caption = #1055#1088#1086#1096#1083#1072#1103' '#1089#1090#1088#1072#1085#1080#1094#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object NewTerm: TEdit
    Left = 0
    Top = 202
    Width = 121
    Height = 21
    TabOrder = 0
    OnChange = NewTermChange
  end
  object Father: TEdit
    Left = 0
    Top = 67
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 1
    OnKeyPress = FatherKeyPress
  end
  object GrandFather: TEdit
    Left = 0
    Top = 20
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 2
    OnKeyPress = GrandFatherKeyPress
  end
  object Action: TButton
    Left = 0
    Top = 267
    Width = 121
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = ActionClick
  end
  object Son: TEdit
    Left = 0
    Top = 111
    Width = 121
    Height = 21
    TabOrder = 4
    Visible = False
    OnChange = SonChange
  end
  object OldPage: TEdit
    Left = 0
    Top = 153
    Width = 121
    Height = 21
    TabOrder = 5
  end
end
