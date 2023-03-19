inherited CustomDBMainDependentModuleView: TCustomDBMainDependentModuleView
  Caption = 'CustomDBMainDependentModuleView'
  ClientHeight = 516
  ClientWidth = 808
  ExplicitWidth = 824
  ExplicitHeight = 555
  PixelsPerInch = 96
  TextHeight = 17
  inherited MainPanel: TPanel
    Width = 808
    Height = 456
    ExplicitWidth = 808
    ExplicitHeight = 456
    inherited Splitter: TSplitter
      Height = 456
      ExplicitHeight = 462
    end
    inherited LeftPanel: TPanel
      Height = 456
      ExplicitHeight = 456
      inherited MainTableBgPanel: TPanel
        Height = 423
        ExplicitHeight = 423
        inherited MainGrid: TDBGrid
          Height = 419
          ReadOnly = True
        end
      end
    end
    inherited RightPanel: TPanel
      Width = 535
      Height = 456
      ExplicitWidth = 535
      ExplicitHeight = 456
      inherited PageControl: TPageControl
        Width = 531
        Height = 448
        ActivePage = DependentData1TabSheet
        ExplicitWidth = 531
        ExplicitHeight = 448
        inherited MainDetailsTabSheet: TTabSheet
          ExplicitWidth = 523
          ExplicitHeight = 416
          inherited MainDetailsTabSheetBgPanel: TPanel
            Width = 514
            Height = 408
            Margins.Right = 5
            ExplicitWidth = 514
            ExplicitHeight = 408
            inherited MainDetailsScrollBox: TScrollBox
              Width = 510
              Height = 404
              ExplicitWidth = 510
              ExplicitHeight = 404
            end
          end
        end
        object DependentData1TabSheet: TTabSheet
          Caption = 'Dependent Data 1'
          ImageIndex = 1
          object DependentData1Splitter: TSplitter
            Left = 189
            Top = 0
            Width = 8
            Height = 416
            Color = clBtnFace
            ParentColor = False
            ResizeStyle = rsUpdate
          end
          object DependentData1LeftBgPanel: TPanel
            AlignWithMargins = True
            Left = 4
            Top = 4
            Width = 185
            Height = 408
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 0
            Margins.Bottom = 4
            Align = alLeft
            BevelKind = bkFlat
            BevelOuter = bvNone
            ParentBackground = False
            TabOrder = 0
            object DependentData1Grid: TDBGrid
              Left = 0
              Top = 0
              Width = 181
              Height = 404
              Align = alClient
              BorderStyle = bsNone
              ReadOnly = True
              TabOrder = 0
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -13
              TitleFont.Name = 'Segoe UI'
              TitleFont.Style = []
            end
          end
          object DependentData1RightBgPanel: TPanel
            AlignWithMargins = True
            Left = 197
            Top = 4
            Width = 321
            Height = 408
            Margins.Left = 0
            Margins.Top = 4
            Margins.Right = 5
            Margins.Bottom = 4
            Align = alClient
            BevelKind = bkFlat
            BevelOuter = bvNone
            ParentBackground = False
            TabOrder = 1
            object DependentData1DetailsScrollBox: TScrollBox
              Left = 0
              Top = 0
              Width = 317
              Height = 404
              Align = alClient
              BevelInner = bvNone
              BevelOuter = bvNone
              BorderStyle = bsNone
              TabOrder = 0
            end
          end
        end
      end
    end
  end
  inherited ButtonsBgPanel: TPanel
    Top = 456
    Width = 808
    ExplicitTop = 456
    ExplicitWidth = 808
    DesignSize = (
      808
      60)
    inherited BtnBevel: TBevel
      Width = 808
      ExplicitWidth = 808
    end
  end
  inherited ButtonImageList: TImageList
    Left = 120
    Top = 400
  end
end
