object Main: TMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Knight chess bypass'
  ClientHeight = 457
  ClientWidth = 427
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = Menu
  OldCreateOrder = False
  PopupMenu = BlankPopUp
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object SG: TStringGrid
    Left = 8
    Top = 8
    Width = 412
    Height = 412
    ColCount = 8
    DefaultColWidth = 50
    DefaultRowHeight = 50
    FixedCols = 0
    RowCount = 8
    FixedRows = 0
    PopupMenu = BlankPopUp
    ScrollBars = ssNone
    TabOrder = 0
    OnDrawCell = SGDrawCell
    OnSelectCell = SGSelectCell
  end
  object btnPush: TButton
    Left = 8
    Top = 426
    Width = 75
    Height = 25
    Caption = 'Push'
    PopupMenu = BlankPopUp
    TabOrder = 1
    OnClick = btnPushClick
  end
  object btnRetry: TButton
    Left = 177
    Top = 426
    Width = 75
    Height = 25
    Caption = 'Retry'
    PopupMenu = BlankPopUp
    TabOrder = 2
    OnClick = btnRetryClick
  end
  object btnAuto: TButton
    Left = 345
    Top = 426
    Width = 75
    Height = 25
    Caption = 'Auto'
    PopupMenu = BlankPopUp
    TabOrder = 3
    OnClick = btnAutoClick
  end
  object Menu: TMainMenu
    Left = 88
    Top = 424
    object Info: TMenuItem
      Caption = 'Info'
      OnClick = InfoClick
    end
    object Developer: TMenuItem
      Caption = 'Developer'
      OnClick = DeveloperClick
    end
    object Exit: TMenuItem
      Caption = 'Exit'
      OnClick = ExitClick
    end
  end
  object BlankPopUp: TPopupMenu
    Left = 136
    Top = 424
  end
  object Tick: TTimer
    Enabled = False
    OnTimer = TickTimer
    Left = 288
    Top = 424
  end
end
