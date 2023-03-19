object WaitingDialog: TWaitingDialog
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Please wait'
  ClientHeight = 82
  ClientWidth = 402
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 17
  object InformationPanel: TPanel
    Left = 0
    Top = 0
    Width = 402
    Height = 82
    Align = alClient
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      402
      82)
    object MessageLabel: TLabel
      AlignWithMargins = True
      Left = 16
      Top = 16
      Width = 369
      Height = 48
      Alignment = taCenter
      Anchors = [akLeft, akTop, akRight, akBottom]
      AutoSize = False
      Caption = 'Message'
      Layout = tlCenter
      WordWrap = True
    end
  end
end
