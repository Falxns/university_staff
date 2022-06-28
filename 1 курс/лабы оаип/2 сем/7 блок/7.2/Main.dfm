object MainF: TMainF
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Gladkiy Maksim, gr. 851001'
  ClientHeight = 439
  ClientWidth = 402
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  PopupMenu = PopupMenu
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object VerticesLbl: TLabel
    Left = 0
    Top = 7
    Width = 240
    Height = 25
    Caption = 'Enter number of vertices:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object EdgesLbl: TLabel
    Left = 16
    Top = 44
    Width = 224
    Height = 25
    Caption = 'Enter number of edges:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object SG: TStringGrid
    Left = 0
    Top = 80
    Width = 313
    Height = 313
    ColCount = 10
    DefaultColWidth = 30
    DefaultRowHeight = 30
    Enabled = False
    FixedColor = clBackground
    FixedCols = 0
    RowCount = 10
    FixedRows = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    GradientEndColor = clGray
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    ParentFont = False
    TabOrder = 0
    OnKeyPress = SGKeyPress
    ColWidths = (
      30
      30
      30
      30
      30
      30
      30
      30
      30
      30)
  end
  object TransformBtn: TButton
    Left = 94
    Top = 399
    Width = 121
    Height = 35
    Caption = 'Go!'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = TransformBtnClick
  end
  object SetSizeBtn: TButton
    Left = 277
    Top = 24
    Width = 121
    Height = 35
    Caption = 'Set'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = SetSizeBtnClick
  end
  object VertEdit: TEdit
    Left = 246
    Top = 6
    Width = 25
    Height = 31
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnChange = VertEditChange
    OnKeyPress = VertEditKeyPress
  end
  object EdgeEdit: TEdit
    Left = 246
    Top = 43
    Width = 25
    Height = 31
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnChange = EdgeEditChange
    OnKeyPress = EdgeEditKeyPress
  end
  object MainMenu: TMainMenu
    Left = 344
    Top = 124
    object FileMenu: TMenuItem
      Caption = 'File'
      object Open: TMenuItem
        Caption = 'Open...'
        OnClick = OpenClick
      end
    end
    object Help: TMenuItem
      Caption = 'Help'
      object Info: TMenuItem
        Caption = 'Info'
        OnClick = InfoClick
      end
      object Developer: TMenuItem
        Caption = 'Developer'
        OnClick = DeveloperClick
      end
    end
  end
  object OpenFile: TOpenDialog
    Filter = 'TextFile|*txt'
    Left = 344
    Top = 76
  end
  object PopupMenu: TPopupMenu
    Left = 344
    Top = 172
  end
end
