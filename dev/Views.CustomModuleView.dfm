inherited CustomModuleView: TCustomModuleView
  ClientHeight = 464
  ClientWidth = 617
  OnResize = FormResize
  ExplicitWidth = 633
  ExplicitHeight = 503
  PixelsPerInch = 96
  TextHeight = 17
  object MainPanel: TPanel [0]
    Left = 0
    Top = 0
    Width = 617
    Height = 410
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 888
    ExplicitHeight = 664
    object Splitter: TSplitter
      Left = 265
      Top = 0
      Width = 8
      Height = 410
      ResizeStyle = rsUpdate
      ExplicitLeft = 185
      ExplicitTop = 1
      ExplicitHeight = 311
    end
    object LeftPanel: TPanel
      Left = 0
      Top = 0
      Width = 265
      Height = 410
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitHeight = 664
    end
    object RightPanel: TPanel
      Left = 273
      Top = 0
      Width = 344
      Height = 410
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitWidth = 615
      ExplicitHeight = 664
    end
  end
  object ButtonsBgPanel: TPanel [1]
    Left = 0
    Top = 410
    Width = 617
    Height = 54
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 664
    ExplicitWidth = 888
    DesignSize = (
      617
      54)
    object BtnBevel: TBevel
      Left = 0
      Top = 0
      Width = 617
      Height = 8
      Align = alTop
      Shape = bsTopLine
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 886
    end
    object ButtonsPanel: TPanel
      Left = 212
      Top = -2
      Width = 289
      Height = 57
      Anchors = [akBottom]
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitLeft = 368
      object NewBtn: TBitBtn
        Left = 8
        Top = 8
        Width = 87
        Height = 41
        Caption = 'New'
        ImageIndex = 2
        Images = ButtonImageList
        TabOrder = 0
      end
      object EditBtn: TBitBtn
        Left = 101
        Top = 8
        Width = 87
        Height = 41
        Caption = 'Edit'
        ImageIndex = 3
        Images = ButtonImageList
        TabOrder = 1
      end
      object DeleteBtn: TBitBtn
        Left = 194
        Top = 8
        Width = 87
        Height = 41
        Caption = 'Delete'
        ImageIndex = 4
        Images = ButtonImageList
        TabOrder = 2
      end
    end
  end
end
