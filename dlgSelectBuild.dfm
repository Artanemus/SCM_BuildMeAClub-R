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
  object Panel1: TPanel
    Left = 0
    Top = 41
    Width = 430
    Height = 543
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object ListBox1: TListBox
      AlignWithMargins = True
      Left = 10
      Top = 10
      Width = 410
      Height = 523
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 10
      AutoComplete = False
      Align = alClient
      BevelKind = bkFlat
      ExtendedSelect = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ItemHeight = 25
      Items.Strings = (
        '1.0.0.0'
        '1.0.0.2')
      ParentFont = False
      Sorted = True
      TabOrder = 0
      StyleElements = [seClient, seBorder]
      OnClick = ListBox1Click
      OnDblClick = ListBox1DblClick
      ExplicitWidth = 406
      ExplicitHeight = 522
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 668
    Width = 430
    Height = 66
    Align = alBottom
    BevelEdges = [beTop]
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 667
    ExplicitWidth = 426
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
      Caption = 'Ok'
      ModalResult = 1
      TabOrder = 1
      OnClick = btnOkClick
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 430
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Select a build...'
    TabOrder = 2
    ExplicitWidth = 426
  end
  object pnlNotes: TPanel
    Left = 0
    Top = 584
    Width = 430
    Height = 84
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    ExplicitTop = 583
    ExplicitWidth = 426
    object lblNotes: TLabel
      AlignWithMargins = True
      Left = 12
      Top = 3
      Width = 406
      Height = 78
      Margins.Left = 12
      Margins.Right = 12
      Align = alClient
      Alignment = taCenter
      Caption = 'lblNotes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      WordWrap = True
      ExplicitLeft = 10
      ExplicitTop = 0
      ExplicitWidth = 420
      ExplicitHeight = 84
    end
  end
end
