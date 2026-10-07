object SelectBuild: TSelectBuild
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Build Me A Club - List of builds.'
  ClientHeight = 734
  ClientWidth = 430
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 21
  object pnlBorder: TPanel
    Left = 0
    Top = 0
    Width = 430
    Height = 734
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 3
    Color = clDarkgoldenrod
    ParentBackground = False
    TabOrder = 0
    StyleElements = []
    object pnlHeader: TPanel
      Left = 3
      Top = 3
      Width = 424
      Height = 41
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Select a build...'
      Color = clWindow
      ParentBackground = False
      TabOrder = 0
    end
    object pnlBody: TPanel
      Left = 3
      Top = 44
      Width = 424
      Height = 433
      Align = alClient
      BevelOuter = bvNone
      Color = clWindow
      ParentBackground = False
      TabOrder = 1
      object ListBox1: TListBox
        AlignWithMargins = True
        Left = 10
        Top = 10
        Width = 404
        Height = 413
        Margins.Left = 10
        Margins.Top = 10
        Margins.Right = 10
        Margins.Bottom = 10
        Style = lbOwnerDrawFixed
        AutoComplete = False
        Align = alClient
        BevelKind = bkFlat
        ExtendedSelect = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ItemHeight = 30
        Items.Strings = (
          '1.0.0.0'
          '1.0.0.2')
        ParentFont = False
        Sorted = True
        TabOrder = 0
        StyleElements = [seClient, seBorder]
        OnClick = ListBox1Click
        OnDblClick = ListBox1DblClick
        OnDrawItem = ListBox1DrawItem
      end
    end
    object pnlFooter: TPanel
      Left = 3
      Top = 665
      Width = 424
      Height = 66
      Align = alBottom
      BevelEdges = [beTop]
      BevelKind = bkFlat
      BevelOuter = bvNone
      Color = clWindow
      ParentBackground = False
      TabOrder = 2
      object btnCancel: TButton
        Left = 104
        Top = 15
        Width = 108
        Height = 35
        Caption = 'Cancel'
        ModalResult = 2
        TabOrder = 0
        OnClick = btnCancelClick
      end
      object btnOk: TButton
        Left = 218
        Top = 15
        Width = 108
        Height = 35
        Caption = 'Select'
        ModalResult = 1
        TabOrder = 1
        OnClick = btnOkClick
      end
    end
    object pnlNotes: TPanel
      Left = 3
      Top = 477
      Width = 424
      Height = 188
      Align = alBottom
      BevelOuter = bvNone
      Color = clWindow
      ParentBackground = False
      TabOrder = 3
      object lblNotes: TMemo
        AlignWithMargins = True
        Left = 12
        Top = 3
        Width = 400
        Height = 182
        Margins.Left = 12
        Margins.Right = 12
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Lines.Strings = (
          'Highlight a build to see notes displayed here.')
        ParentColor = True
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
  end
end
