object Main: TMain
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Build Me A Club'
  ClientHeight = 436
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    628
    436)
  PixelsPerInch = 96
  TextHeight = 17
  object Label1: TLabel
    Left = 43
    Top = 15
    Width = 37
    Height = 17
    Alignment = taRightJustify
    Caption = 'Server'
  end
  object Label2: TLabel
    Left = 14
    Top = 46
    Width = 66
    Height = 17
    Alignment = taRightJustify
    Caption = 'User Name'
  end
  object Label3: TLabel
    Left = 24
    Top = 77
    Width = 56
    Height = 17
    Alignment = taRightJustify
    Caption = 'Password'
  end
  object prefServer: TEdit
    Left = 86
    Top = 12
    Width = 534
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    Text = 'localhost\SQLEXPRESS'
  end
  object prefUser: TEdit
    Left = 86
    Top = 43
    Width = 403
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
  end
  object prefPassword: TEdit
    Left = 86
    Top = 74
    Width = 299
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
  end
  object prefUseOSAuthentication: TCheckBox
    Left = 86
    Top = 106
    Width = 163
    Height = 17
    Caption = 'Use OS Authentication'
    Checked = True
    State = cbChecked
    TabOrder = 3
  end
  object Panel1: TPanel
    Left = 0
    Top = 395
    Width = 628
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    object btnCancel: TButton
      Left = 236
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 0
      OnClick = btnCancelClick
    end
    object btnOk: TButton
      Left = 317
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Ok'
      TabOrder = 1
      OnClick = btnOkClick
    end
  end
  object Memo1: TMemo
    Left = 8
    Top = 152
    Width = 612
    Height = 237
    Lines.Strings = (
      'Artanemus'
      'Build Me A Club'
      'Version: 1.0'
      ''
      'Author Ben Ambrose'
      'Copyright 2020-2021')
    ScrollBars = ssVertical
    TabOrder = 5
  end
  object ProgressBar1: TProgressBar
    Left = 8
    Top = 129
    Width = 612
    Height = 17
    TabOrder = 6
  end
  object FDConnection1: TFDConnection
    Left = 496
    Top = 40
  end
  object FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink
    Left = 568
    Top = 40
  end
end
