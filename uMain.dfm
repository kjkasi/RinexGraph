object Form1: TForm1
  Left = 192
  Top = 124
  Width = 1305
  Height = 675
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblObserv: TLabel
    Left = 40
    Top = 16
    Width = 44
    Height = 13
    Caption = 'lblObserv'
  end
  object btnObserv: TButton
    Left = 112
    Top = 8
    Width = 75
    Height = 25
    Caption = 'btnObserv'
    TabOrder = 0
    OnClick = btnObservClick
  end
  object Memo1: TMemo
    Left = 8
    Top = 40
    Width = 1273
    Height = 585
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object OpenDialog: TOpenDialog
    FileName = 'C:\Users\AM\Desktop\!files\VSTU_2015_05_14_00.00.00.15O'
    Left = 8
    Top = 8
  end
end
