object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'VK spamer'
  ClientHeight = 675
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 32
    Top = 72
    Width = 41
    Height = 13
    Caption = #1055#1072#1088#1086#1083#1100':'
  end
  object Label3: TLabel
    Left = 304
    Top = 74
    Width = 55
    Height = 13
    Caption = 'ID '#1075#1088#1091#1087#1087#1099':'
    Visible = False
  end
  object Label4: TLabel
    Left = 304
    Top = 101
    Width = 42
    Height = 13
    Caption = #1057#1089#1099#1083#1082#1080':'
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 16
    Width = 281
    Height = 169
    Caption = #1040#1074#1090#1086#1088#1080#1079#1072#1094#1080#1103
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 27
      Width = 34
      Height = 13
      Caption = #1051#1086#1075#1080#1085':'
    end
    object LoginEdit: TEdit
      Left = 80
      Top = 24
      Width = 177
      Height = 21
      TabOrder = 0
    end
    object PassEdit: TEdit
      Left = 80
      Top = 51
      Width = 177
      Height = 21
      PasswordChar = '*'
      TabOrder = 1
    end
    object Button1: TButton
      Left = 24
      Top = 88
      Width = 233
      Height = 25
      Caption = #1040#1074#1090#1086#1088#1080#1079#1072#1094#1080#1103
      TabOrder = 2
      OnClick = Button1Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 304
    Top = 145
    Width = 305
    Height = 121
    Caption = #1057#1086#1086#1073#1097#1077#1085#1080#1077
    TabOrder = 1
    object MessageMemo: TMemo
      Left = 11
      Top = 13
      Width = 281
      Height = 94
      TabOrder = 0
    end
  end
  object GroupEdit: TEdit
    Left = 376
    Top = 71
    Width = 217
    Height = 21
    TabOrder = 2
    Visible = False
  end
  object AttachEdit: TEdit
    Left = 376
    Top = 98
    Width = 217
    Height = 21
    TabOrder = 3
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 351
    Width = 617
    Height = 316
    Caption = #1051#1086#1075':'
    TabOrder = 4
    object LogMemo: TMemo
      Left = 16
      Top = 16
      Width = 585
      Height = 297
      TabOrder = 0
    end
  end
  object StartButton: TButton
    Left = 304
    Top = 280
    Width = 305
    Height = 33
    Caption = #1047#1072#1087#1091#1089#1082
    TabOrder = 5
    OnClick = StartButtonClick
  end
  object cmbGroups: TComboBox
    Left = 304
    Top = 32
    Width = 289
    Height = 21
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 6
    Text = #1057#1087#1080#1089#1086#1082' '#1074#1072#1096#1080#1093' '#1075#1088#1091#1087#1087
    OnClick = cmbGroupsClick
  end
  object lstStat: TListBox
    Left = 24
    Top = 200
    Width = 265
    Height = 145
    ItemHeight = 13
    TabOrder = 7
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = Timer1Timer
    Left = 24
    Top = 136
  end
  object IdHTTP1: TIdHTTP
    IOHandler = IdSSLIOHandlerSocketOpenSSL1
    AllowCookies = True
    HandleRedirects = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 56
    Top = 136
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 88
    Top = 136
  end
end
