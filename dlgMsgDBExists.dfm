object MsgDBExists: TMsgDBExists
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'BMAC message ...'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poMainFormCenter
  OnKeyDown = FormKeyDown
  TextHeight = 21
  object MsgDBExists: TPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitLeft = 240
    ExplicitTop = 128
    ExplicitWidth = 185
    object lblHeader: TLabel
      Left = 165
      Top = 10
      Width = 303
      Height = 21
      Caption = 'The SwimClubMeet dataBase already exists!'
    end
  end
  object pnlFooter: TPanel
    Left = 0
    Top = 384
    Width = 624
    Height = 57
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btnOk: TButton
      Left = 274
      Top = 12
      Width = 75
      Height = 33
      Caption = 'OK'
      TabOrder = 0
      OnClick = btnOkClick
    end
  end
  object pnlBody: TPanel
    Left = 0
    Top = 41
    Width = 624
    Height = 343
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitLeft = 360
    ExplicitTop = 160
    ExplicitWidth = 185
    ExplicitHeight = 41
    object memoBody: TMemo
      AlignWithMargins = True
      Left = 10
      Top = 10
      Width = 604
      Height = 323
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alClient
      Lines.Strings = (
        'Unable to '#39'Build Me A Club'#39'.'
        ''
        
          'This application will not be able to complete it'#39's task because ' +
          'a database named '
        
          'SwimClubMeet already exists on the Microsoft SQL Server Express ' +
          'instance.'
        ''
        
          'To protect your existing data, this application will not overwri' +
          'te or delete an existing '
        'database.'
        ''
        
          'If you wish to create a new database, you can use Microsoft SQL ' +
          'Server Management '
        
          'Studio (SSMS) to remove the existing SwimClubMeet database, then' +
          ' run the BMAC '
        'application again.'
        ''
        
          'Please ensure you have backed up any important data before remov' +
          'ing the existing '
        'database.')
      TabOrder = 0
      ExplicitLeft = 104
      ExplicitTop = 56
      ExplicitWidth = 409
      ExplicitHeight = 225
    end
  end
end
