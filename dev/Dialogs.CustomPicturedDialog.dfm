inherited CustomPicturedDialog: TCustomPicturedDialog
  PixelsPerInch = 96
  TextHeight = 17
  inherited ButtonsBgPanel: TPanel
    inherited ButtonsPanel: TPanel
      ExplicitLeft = 7
    end
  end
  inherited InformationPanel: TPanel
    inherited MessageLabel: TLabel
      Left = 80
      Width = 313
      ExplicitLeft = 80
      ExplicitWidth = 313
      ExplicitHeight = 75
    end
    object Image: TImage
      Left = 16
      Top = 8
      Width = 50
      Height = 75
      Anchors = [akLeft, akTop, akBottom]
      Center = True
      Transparent = True
    end
  end
end
