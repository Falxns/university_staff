object Form1: TForm1
  Left = 204
  Top = 124
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Graphs'
  ClientHeight = 682
  ClientWidth = 976
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbCountElem: TLabel
    Left = 719
    Top = 8
    Width = 50
    Height = 20
    Caption = 'Vertex:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lbFinishPoint: TLabel
    Left = 871
    Top = 8
    Width = 51
    Height = 20
    Caption = 'End to:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lbStartPoint: TLabel
    Left = 788
    Top = 8
    Width = 81
    Height = 20
    Caption = 'Begin from:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lbTextMaxWay: TLabel
    Left = 719
    Top = 246
    Width = 75
    Height = 16
    Caption = 'Longest way'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lbTextMinWay: TLabel
    Left = 719
    Top = 268
    Width = 76
    Height = 16
    Caption = 'Shortest way'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lbTextCenterGraph: TLabel
    Left = 719
    Top = 290
    Width = 77
    Height = 16
    Caption = 'Graph center'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lbMaxWay: TLabel
    Left = 801
    Top = 246
    Width = 6
    Height = 20
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbMinWay: TLabel
    Left = 801
    Top = 264
    Width = 6
    Height = 20
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbCenterGraph: TLabel
    Left = 802
    Top = 287
    Width = 6
    Height = 20
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbAllWay: TLabel
    Left = 719
    Top = 312
    Width = 49
    Height = 16
    Caption = 'All ways'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object gbGraphView: TGroupBox
    Left = 8
    Top = -8
    Width = 703
    Height = 689
    TabOrder = 0
    object imgGraphView: TImage
      Left = 2
      Top = 15
      Width = 699
      Height = 672
      Align = alClient
      ExplicitLeft = 1
      ExplicitTop = 3
    end
  end
  object strgrAdjTab: TStringGrid
    Left = 717
    Top = 59
    Width = 252
    Height = 134
    ColCount = 6
    FixedColor = clWhite
    FixedCols = 0
    RowCount = 6
    FixedRows = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goAlwaysShowEditor]
    ParentFont = False
    TabOrder = 1
    OnKeyDown = strgrAdjTabKeyDown
  end
  object seCountElem: TSpinEdit
    Left = 717
    Top = 31
    Width = 65
    Height = 22
    MaxValue = 10
    MinValue = 1
    TabOrder = 2
    Value = 6
    OnChange = seCountElemChange
  end
  object btnGraphPaint: TButton
    Left = 717
    Top = 199
    Width = 124
    Height = 41
    Caption = 'Build graph'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = btnGraphPaintClick
  end
  object seFinishPoint: TSpinEdit
    Left = 871
    Top = 31
    Width = 65
    Height = 22
    MaxValue = 10
    MinValue = 0
    TabOrder = 4
    Value = 5
  end
  object seStartPoint: TSpinEdit
    Left = 788
    Top = 31
    Width = 65
    Height = 22
    MaxValue = 10
    MinValue = 0
    TabOrder = 5
    Value = 0
  end
  object btnDoCalculation: TButton
    Left = 847
    Top = 199
    Width = 122
    Height = 41
    Caption = 'Find ways'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnClick = btnDoCalculationClick
  end
  object mmAllWay: TMemo
    Left = 719
    Top = 334
    Width = 250
    Height = 208
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
end
