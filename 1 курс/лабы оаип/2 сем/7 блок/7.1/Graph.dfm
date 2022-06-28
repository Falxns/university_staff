object GraphF: TGraphF
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Gladkiy Maksim, gr. 851001'
  ClientHeight = 397
  ClientWidth = 376
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  PopupMenu = PopupMenu
  Position = poMainFormCenter
  OnPaint = FormPaint
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ResultLbl: TLabel
    Left = 80
    Top = 336
    Width = 6
    Height = 23
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    PopupMenu = PopupMenu
  end
  object NumEdit: TEdit
    Left = 104
    Top = 368
    Width = 25
    Height = 27
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    PopupMenu = PopupMenu
    TabOrder = 0
    OnChange = NumEditChange
    OnKeyPress = NumEditKeyPress
  end
  object FindBtn: TButton
    Left = 135
    Top = 364
    Width = 75
    Height = 31
    Caption = 'Go!'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    PopupMenu = PopupMenu
    TabOrder = 1
    OnClick = FindBtnClick
  end
  object PopupMenu: TPopupMenu
    Left = 8
  end
  object MainMenu: TMainMenu
    Left = 8
    Top = 48
    object FileMenu: TMenuItem
      Caption = 'File'
      object Save: TMenuItem
        Caption = 'Save..'
        OnClick = SaveClick
      end
    end
    object Inf: TMenuItem
      Caption = 'Info'
      OnClick = InfClick
    end
  end
  object SaveFile: TSaveDialog
    Filter = 'TextFile|*txt'
    Left = 8
    Top = 96
  end
end
