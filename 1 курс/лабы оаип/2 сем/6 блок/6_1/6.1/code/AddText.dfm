object AddF: TAddF
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Add record'
  ClientHeight = 74
  ClientWidth = 179
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = AddMenu
  OldCreateOrder = False
  PopupMenu = MainForm.PopupMenu
  Position = poMainFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 47
    Height = 24
    Caption = 'Text:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Submit: TButton
    Left = 8
    Top = 38
    Width = 75
    Height = 25
    Caption = 'Add'
    ModalResult = 6
    PopupMenu = MainForm.PopupMenu
    TabOrder = 0
    OnClick = SubmitClick
  end
  object Cancel: TButton
    Left = 96
    Top = 38
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 6
    TabOrder = 1
    OnClick = CancelClick
  end
  object TextT: TEdit
    Left = 61
    Top = 11
    Width = 80
    Height = 21
    PopupMenu = MainForm.PopupMenu
    TabOrder = 2
    OnChange = PrChange
    OnKeyPress = TextTKeyPress
  end
  object AddMenu: TMainMenu
    Left = 152
    Top = 8
    object Help: TMenuItem
      Caption = 'Help'
      ShortCut = 16456
      OnClick = HelpClick
    end
  end
end
