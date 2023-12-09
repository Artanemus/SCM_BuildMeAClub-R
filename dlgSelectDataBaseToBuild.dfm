object SelectDataBaseToBuild: TSelectDataBaseToBuild
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'BMAC SwimClubMeet databases.'
  ClientHeight = 442
  ClientWidth = 298
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 21
  object Panel1: TPanel
    Left = 0
    Top = 41
    Width = 298
    Height = 335
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 624
    ExplicitHeight = 334
    object CheckListBox1: TCheckListBox
      AlignWithMargins = True
      Left = 10
      Top = 10
      Width = 278
      Height = 315
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alClient
      CheckBoxPadding = 5
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ItemHeight = 35
      Items.Strings = (
        'v1.0.0.0'
        'v1.1.5.0'
        'v1.1.5.1'
        'v1.1.5.2'
        'v1.1.5.3')
      ParentFont = False
      Sorted = True
      TabOrder = 0
      ExplicitWidth = 343
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 376
    Width = 298
    Height = 66
    Align = alBottom
    BevelEdges = [beTop]
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitWidth = 384
    object btnCancel: TButton
      Left = 38
      Top = 16
      Width = 108
      Height = 35
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 0
      OnClick = btnCancelClick
    end
    object btnOk: TButton
      Left = 152
      Top = 16
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
    Width = 298
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Select a version to build.'
    TabOrder = 2
    ExplicitWidth = 624
  end
end
