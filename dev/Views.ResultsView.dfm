inherited ResultsView: TResultsView
  ClientHeight = 475
  ClientWidth = 1052
  OnHide = FormHide
  OnShow = FormShow
  ExplicitWidth = 1068
  ExplicitHeight = 514
  PixelsPerInch = 96
  TextHeight = 17
  inherited MainPanel: TPanel
    Width = 1052
    Height = 415
    ExplicitWidth = 1052
    ExplicitHeight = 415
    inherited Splitter: TSplitter
      Left = 369
      Height = 415
      ExplicitLeft = 369
      ExplicitHeight = 415
    end
    inherited LeftPanel: TPanel
      Width = 369
      Height = 415
      ExplicitWidth = 369
      ExplicitHeight = 415
      inherited MainCaptionLabel: TLabel
        Width = 365
        Caption = 'Simulations'
        ExplicitWidth = 73
      end
      inherited MainTableBgPanel: TPanel
        Width = 365
        Height = 382
        ExplicitWidth = 365
        ExplicitHeight = 382
        inherited MainGrid: TDBGrid
          Width = 361
          Height = 378
          DataSource = SimulationsSource
          Columns = <
            item
              Expanded = False
              FieldName = 'Project'
              Width = 100
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Setup'
              Width = 100
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Simulation'
              Width = 130
              Visible = True
            end>
        end
      end
    end
    inherited RightPanel: TPanel
      Left = 377
      Width = 675
      Height = 415
      ExplicitLeft = 377
      ExplicitWidth = 675
      ExplicitHeight = 415
      inherited PageControl: TPageControl
        Width = 671
        Height = 407
        ActivePage = InfectiousTabSheet
        MultiLine = True
        ExplicitWidth = 671
        ExplicitHeight = 407
        inherited MainDetailsTabSheet: TTabSheet
          Caption = 'Susceptible - Infected - Removed (Proportions)'
          ExplicitTop = 72
          ExplicitWidth = 663
          ExplicitHeight = 331
          inherited MainDetailsTabSheetBgPanel: TPanel
            Width = 655
            Height = 323
            ExplicitWidth = 655
            ExplicitHeight = 323
            inherited MainDetailsScrollBox: TScrollBox
              Width = 651
              Height = 319
              ExplicitWidth = 651
              ExplicitHeight = 319
              object Splitter1: TSplitter
                Left = 313
                Top = 0
                Width = 8
                Height = 319
                ExplicitLeft = 209
                ExplicitHeight = 363
              end
              object Panel1: TPanel
                Left = 0
                Top = 0
                Width = 313
                Height = 319
                Align = alLeft
                BevelOuter = bvNone
                TabOrder = 0
                object Panel2: TPanel
                  AlignWithMargins = True
                  Left = 4
                  Top = 4
                  Width = 309
                  Height = 311
                  Margins.Left = 4
                  Margins.Top = 4
                  Margins.Right = 0
                  Margins.Bottom = 4
                  Align = alClient
                  BevelKind = bkFlat
                  BevelOuter = bvNone
                  TabOrder = 0
                  object DBGrid1: TDBGrid
                    Left = 0
                    Top = 0
                    Width = 305
                    Height = 307
                    Align = alClient
                    BorderStyle = bsNone
                    DataSource = SimulationDaysSource
                    TabOrder = 0
                    TitleFont.Charset = DEFAULT_CHARSET
                    TitleFont.Color = clWindowText
                    TitleFont.Height = -13
                    TitleFont.Name = 'Segoe UI'
                    TitleFont.Style = []
                    Columns = <
                      item
                        Expanded = False
                        FieldName = 'day_number'
                        Title.Caption = 'Day'
                        Width = 40
                        Visible = True
                      end
                      item
                        Expanded = False
                        FieldName = 'mean_susceptible'
                        Title.Caption = 'Susceptible'
                        Visible = True
                      end
                      item
                        Expanded = False
                        FieldName = 'mean_infected'
                        Title.Caption = 'Infected'
                        Visible = True
                      end
                      item
                        Expanded = False
                        FieldName = 'mean_removed'
                        Title.Caption = 'Removed'
                        Visible = True
                      end>
                  end
                end
              end
              object Panel3: TPanel
                Left = 321
                Top = 0
                Width = 330
                Height = 319
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 1
                object Panel4: TPanel
                  AlignWithMargins = True
                  Left = 0
                  Top = 4
                  Width = 326
                  Height = 311
                  Margins.Left = 0
                  Margins.Top = 4
                  Margins.Right = 4
                  Margins.Bottom = 4
                  Align = alClient
                  BevelKind = bkFlat
                  BevelOuter = bvNone
                  TabOrder = 0
                  object SIRProportionsChart: TDBChart
                    Left = 0
                    Top = 0
                    Width = 322
                    Height = 307
                    SubTitle.Font.Charset = ANSI_CHARSET
                    SubTitle.Font.Color = clBlack
                    SubTitle.Font.Height = -15
                    SubTitle.Font.Name = 'Segoe UI'
                    Title.Font.Charset = ANSI_CHARSET
                    Title.Font.Color = clBlack
                    Title.Font.Height = -19
                    Title.Font.Name = 'Segoe UI'
                    Title.Font.Style = [fsBold]
                    Title.Text.Strings = (
                      'Susceptible - Infected - Removed (Proportions)')
                    Title.Visible = False
                    BottomAxis.LabelsFormat.Font.Charset = ANSI_CHARSET
                    BottomAxis.LabelsFormat.Font.Height = -12
                    BottomAxis.LabelsFormat.Font.Name = 'Segoe UI'
                    BottomAxis.LabelsFormat.Font.Quality = fqClearType
                    BottomAxis.Title.Caption = 'Days'
                    BottomAxis.Title.Font.Charset = ANSI_CHARSET
                    BottomAxis.Title.Font.Height = -15
                    BottomAxis.Title.Font.Name = 'Segoe UI'
                    BottomAxis.Title.Font.Quality = fqClearType
                    LeftAxis.LabelsFormat.Font.Charset = ANSI_CHARSET
                    LeftAxis.LabelsFormat.Font.Height = -12
                    LeftAxis.LabelsFormat.Font.Name = 'Segoe UI'
                    LeftAxis.LabelsFormat.Font.Quality = fqClearType
                    LeftAxis.Title.Caption = 'Percentage'
                    LeftAxis.Title.Font.Charset = ANSI_CHARSET
                    LeftAxis.Title.Font.Height = -15
                    LeftAxis.Title.Font.Name = 'Segoe UI'
                    LeftAxis.Title.Font.Quality = fqClearType
                    Legend.Alignment = laBottom
                    Legend.Font.Height = -15
                    Legend.Font.Name = 'Segoe UI'
                    Legend.Font.Quality = fqClearType
                    Legend.Frame.Visible = False
                    Legend.Shadow.Visible = False
                    Legend.Symbol.Pen.Visible = False
                    Legend.Symbol.Shadow.Visible = False
                    Legend.Title.Font.Quality = fqClearType
                    Shadow.Visible = False
                    View3D = False
                    Zoom.Animated = True
                    Align = alClient
                    BevelOuter = bvNone
                    Color = clWhite
                    TabOrder = 0
                    DefaultCanvas = 'TGDIPlusCanvas'
                    PrintMargins = (
                      28
                      15
                      28
                      15)
                    ColorPaletteIndex = 11
                    object Series1: TLineSeries
                      Selected.Hover.Visible = False
                      DataSource = DaysQuery
                      Shadow.Visible = False
                      Title = 'Susceptible'
                      Brush.BackColor = clDefault
                      DrawStyle = dsCurve
                      LinePen.Width = 2
                      OutLine.Width = 7
                      Pointer.InflateMargins = True
                      Pointer.Style = psRectangle
                      XValues.Name = 'X'
                      XValues.Order = loAscending
                      XValues.ValueSource = 'day_number'
                      YValues.Name = 'Y'
                      YValues.Order = loNone
                      YValues.ValueSource = 'mean_susceptible'
                    end
                    object Series2: TLineSeries
                      DataSource = DaysQuery
                      Title = 'Infected'
                      Brush.BackColor = clDefault
                      DrawStyle = dsCurve
                      LinePen.Width = 2
                      Pointer.InflateMargins = True
                      Pointer.Style = psRectangle
                      XValues.Name = 'X'
                      XValues.Order = loAscending
                      XValues.ValueSource = 'day_number'
                      YValues.Name = 'Y'
                      YValues.Order = loNone
                      YValues.ValueSource = 'mean_infected'
                    end
                    object Series3: TLineSeries
                      DataSource = DaysQuery
                      Title = 'Removed'
                      Brush.BackColor = clDefault
                      DrawStyle = dsCurve
                      LinePen.Width = 2
                      Pointer.InflateMargins = True
                      Pointer.Style = psRectangle
                      XValues.Name = 'X'
                      XValues.Order = loAscending
                      XValues.ValueSource = 'day_number'
                      YValues.Name = 'Y'
                      YValues.Order = loNone
                      YValues.ValueSource = 'mean_removed'
                    end
                  end
                end
              end
            end
          end
        end
        object SIRDeltasTabSheet: TTabSheet
          Caption = 'Susceptible - Infected - Removed (Deltas)'
          ImageIndex = 1
          object Panel5: TPanel
            AlignWithMargins = True
            Left = 4
            Top = 4
            Width = 655
            Height = 323
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Align = alClient
            BevelKind = bkFlat
            BevelOuter = bvNone
            ParentBackground = False
            TabOrder = 0
            object ScrollBox1: TScrollBox
              Left = 0
              Top = 0
              Width = 651
              Height = 319
              Align = alClient
              BevelInner = bvNone
              BevelOuter = bvNone
              BorderStyle = bsNone
              TabOrder = 0
              object Splitter2: TSplitter
                Left = 313
                Top = 0
                Width = 8
                Height = 319
                ExplicitLeft = 209
                ExplicitHeight = 363
              end
              object Panel6: TPanel
                Left = 0
                Top = 0
                Width = 313
                Height = 319
                Align = alLeft
                BevelOuter = bvNone
                TabOrder = 0
                object Panel7: TPanel
                  AlignWithMargins = True
                  Left = 4
                  Top = 4
                  Width = 309
                  Height = 311
                  Margins.Left = 4
                  Margins.Top = 4
                  Margins.Right = 0
                  Margins.Bottom = 4
                  Align = alClient
                  BevelKind = bkFlat
                  BevelOuter = bvNone
                  TabOrder = 0
                  object DBGrid2: TDBGrid
                    Left = 0
                    Top = 0
                    Width = 305
                    Height = 307
                    Align = alClient
                    BorderStyle = bsNone
                    DataSource = SimulationDaysSource
                    TabOrder = 0
                    TitleFont.Charset = DEFAULT_CHARSET
                    TitleFont.Color = clWindowText
                    TitleFont.Height = -13
                    TitleFont.Name = 'Segoe UI'
                    TitleFont.Style = []
                    Columns = <
                      item
                        Expanded = False
                        FieldName = 'day_number'
                        Title.Caption = 'Day'
                        Width = 40
                        Visible = True
                      end
                      item
                        Expanded = False
                        FieldName = 'delta_susceptible'
                        Title.Caption = 'Susceptible'
                        Visible = True
                      end
                      item
                        Expanded = False
                        FieldName = 'delta_infected'
                        Title.Caption = 'Infected'
                        Visible = True
                      end
                      item
                        Expanded = False
                        FieldName = 'delta_removed'
                        Title.Caption = 'Removed'
                        Visible = True
                      end>
                  end
                end
              end
              object Panel8: TPanel
                Left = 321
                Top = 0
                Width = 330
                Height = 319
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 1
                object Panel9: TPanel
                  AlignWithMargins = True
                  Left = 0
                  Top = 4
                  Width = 326
                  Height = 311
                  Margins.Left = 0
                  Margins.Top = 4
                  Margins.Right = 4
                  Margins.Bottom = 4
                  Align = alClient
                  BevelKind = bkFlat
                  BevelOuter = bvNone
                  TabOrder = 0
                  object SIRDeltasChart: TDBChart
                    Left = 0
                    Top = 0
                    Width = 322
                    Height = 307
                    SubTitle.Font.Charset = ANSI_CHARSET
                    SubTitle.Font.Color = clBlack
                    SubTitle.Font.Height = -15
                    SubTitle.Font.Name = 'Segoe UI'
                    Title.Font.Charset = ANSI_CHARSET
                    Title.Font.Color = clBlack
                    Title.Font.Height = -19
                    Title.Font.Name = 'Segoe UI'
                    Title.Font.Style = [fsBold]
                    Title.Text.Strings = (
                      'Susceptible - Infected - Removed (Deltas)')
                    Title.Visible = False
                    BottomAxis.LabelsFormat.Font.Charset = ANSI_CHARSET
                    BottomAxis.LabelsFormat.Font.Height = -12
                    BottomAxis.LabelsFormat.Font.Name = 'Segoe UI'
                    BottomAxis.LabelsFormat.Font.Quality = fqClearType
                    BottomAxis.Title.Caption = 'Days'
                    BottomAxis.Title.Font.Height = -15
                    BottomAxis.Title.Font.Name = 'Segoe UI'
                    BottomAxis.Title.Font.Quality = fqClearType
                    LeftAxis.LabelsFormat.Font.Height = -12
                    LeftAxis.LabelsFormat.Font.Name = 'Segoe UI'
                    LeftAxis.LabelsFormat.Font.Quality = fqClearType
                    LeftAxis.Title.Caption = 'Percentage'
                    LeftAxis.Title.Font.Height = -15
                    LeftAxis.Title.Font.Name = 'Segoe UI'
                    LeftAxis.Title.Font.Quality = fqClearType
                    Legend.Alignment = laBottom
                    Legend.Font.Charset = ANSI_CHARSET
                    Legend.Font.Height = -15
                    Legend.Font.Name = 'Segoe UI'
                    Legend.Font.Quality = fqClearType
                    Legend.Frame.Visible = False
                    Legend.Shadow.Visible = False
                    Legend.Title.Font.Name = 'Segoe UI'
                    Legend.Title.Font.Quality = fqClearType
                    Legend.Title.Visible = False
                    Shadow.Visible = False
                    View3D = False
                    Zoom.Animated = True
                    Align = alClient
                    BevelOuter = bvNone
                    Color = clWhite
                    TabOrder = 0
                    DefaultCanvas = 'TGDIPlusCanvas'
                    ColorPaletteIndex = 11
                    object LineSeries1: TLineSeries
                      DataSource = DaysQuery
                      Title = 'Susceptible'
                      Brush.BackColor = clDefault
                      DrawStyle = dsCurve
                      LinePen.Width = 2
                      OutLine.Width = 7
                      Pointer.InflateMargins = True
                      Pointer.Style = psRectangle
                      XValues.Name = 'X'
                      XValues.Order = loAscending
                      XValues.ValueSource = 'day_number'
                      YValues.Name = 'Y'
                      YValues.Order = loNone
                      YValues.ValueSource = 'delta_susceptible'
                    end
                    object LineSeries2: TLineSeries
                      DataSource = DaysQuery
                      Title = 'Infected'
                      Brush.BackColor = clDefault
                      DrawStyle = dsCurve
                      LinePen.Width = 2
                      Pointer.InflateMargins = True
                      Pointer.Style = psRectangle
                      XValues.Name = 'X'
                      XValues.Order = loAscending
                      XValues.ValueSource = 'day_number'
                      YValues.Name = 'Y'
                      YValues.Order = loNone
                      YValues.ValueSource = 'delta_infected'
                    end
                    object LineSeries3: TLineSeries
                      DataSource = DaysQuery
                      Title = 'Removed'
                      Brush.BackColor = clDefault
                      DrawStyle = dsCurve
                      LinePen.Width = 2
                      Pointer.InflateMargins = True
                      Pointer.Style = psRectangle
                      XValues.Name = 'X'
                      XValues.Order = loAscending
                      XValues.ValueSource = 'day_number'
                      YValues.Name = 'Y'
                      YValues.Order = loNone
                      YValues.ValueSource = 'delta_removed'
                    end
                  end
                end
              end
            end
          end
        end
        object IncidenceTabSheet: TTabSheet
          Caption = '7-Days-Incidence and New Infected'
          ImageIndex = 2
          object Panel10: TPanel
            AlignWithMargins = True
            Left = 4
            Top = 4
            Width = 655
            Height = 323
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Align = alClient
            BevelKind = bkFlat
            BevelOuter = bvNone
            ParentBackground = False
            TabOrder = 0
            object ScrollBox2: TScrollBox
              Left = 0
              Top = 0
              Width = 651
              Height = 319
              Align = alClient
              BevelInner = bvNone
              BevelOuter = bvNone
              BorderStyle = bsNone
              TabOrder = 0
              object Splitter3: TSplitter
                Left = 265
                Top = 0
                Width = 8
                Height = 319
                ExplicitLeft = 209
                ExplicitHeight = 363
              end
              object Panel11: TPanel
                Left = 0
                Top = 0
                Width = 265
                Height = 319
                Align = alLeft
                BevelOuter = bvNone
                TabOrder = 0
                object Panel12: TPanel
                  AlignWithMargins = True
                  Left = 4
                  Top = 4
                  Width = 261
                  Height = 311
                  Margins.Left = 4
                  Margins.Top = 4
                  Margins.Right = 0
                  Margins.Bottom = 4
                  Align = alClient
                  BevelKind = bkFlat
                  BevelOuter = bvNone
                  TabOrder = 0
                  object DBGrid3: TDBGrid
                    Left = 0
                    Top = 0
                    Width = 257
                    Height = 307
                    Align = alClient
                    BorderStyle = bsNone
                    DataSource = SimulationDaysSource
                    TabOrder = 0
                    TitleFont.Charset = DEFAULT_CHARSET
                    TitleFont.Color = clWindowText
                    TitleFont.Height = -13
                    TitleFont.Name = 'Segoe UI'
                    TitleFont.Style = []
                    Columns = <
                      item
                        Expanded = False
                        FieldName = 'day_number'
                        Title.Caption = 'Day'
                        Width = 40
                        Visible = True
                      end
                      item
                        Expanded = False
                        FieldName = 'mean_infected_last_7_days'
                        Title.Caption = '7-Days-Incidence'
                        Visible = True
                      end
                      item
                        Expanded = False
                        FieldName = 'mean_new_infected'
                        Title.Caption = 'New Infected'
                        Visible = True
                      end>
                  end
                end
              end
              object Panel13: TPanel
                Left = 273
                Top = 0
                Width = 378
                Height = 319
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 1
                object Panel14: TPanel
                  AlignWithMargins = True
                  Left = 0
                  Top = 4
                  Width = 374
                  Height = 311
                  Margins.Left = 0
                  Margins.Top = 4
                  Margins.Right = 4
                  Margins.Bottom = 4
                  Align = alClient
                  BevelKind = bkFlat
                  BevelOuter = bvNone
                  TabOrder = 0
                  object IncidenceChart: TDBChart
                    Left = 0
                    Top = 0
                    Width = 370
                    Height = 307
                    SubTitle.Font.Charset = ANSI_CHARSET
                    SubTitle.Font.Color = clBlack
                    SubTitle.Font.Height = -15
                    SubTitle.Font.Name = 'Segoe UI'
                    Title.Font.Charset = ANSI_CHARSET
                    Title.Font.Color = clBlack
                    Title.Font.Height = -19
                    Title.Font.Name = 'Segoe UI'
                    Title.Font.Style = [fsBold]
                    Title.Font.Quality = fqClearType
                    Title.Text.Strings = (
                      '7-Days-Incidence and New Infected')
                    Title.Visible = False
                    BottomAxis.LabelsFormat.Font.Height = -12
                    BottomAxis.LabelsFormat.Font.Name = 'Segoe UI'
                    BottomAxis.LabelsFormat.Font.Quality = fqClearType
                    BottomAxis.Title.Caption = 'Days'
                    BottomAxis.Title.Font.Height = -15
                    BottomAxis.Title.Font.Name = 'Segoe UI'
                    BottomAxis.Title.Font.Quality = fqClearType
                    LeftAxis.LabelsFormat.Font.Height = -12
                    LeftAxis.LabelsFormat.Font.Name = 'Segoe UI'
                    LeftAxis.LabelsFormat.Font.Quality = fqClearType
                    LeftAxis.Title.Caption = 'Percentage'
                    LeftAxis.Title.Font.Height = -15
                    LeftAxis.Title.Font.Name = 'Segoe UI'
                    LeftAxis.Title.Font.Quality = fqClearType
                    Legend.Alignment = laBottom
                    Legend.Font.Height = -15
                    Legend.Font.Name = 'Segoe UI'
                    Legend.Font.Quality = fqClearType
                    Legend.Frame.Visible = False
                    Legend.Shadow.Visible = False
                    Legend.Title.Font.Quality = fqClearType
                    Shadow.Visible = False
                    View3D = False
                    Zoom.Animated = True
                    Align = alClient
                    BevelOuter = bvNone
                    Color = clWhite
                    TabOrder = 0
                    DefaultCanvas = 'TGDIPlusCanvas'
                    ColorPaletteIndex = 11
                    object LineSeries4: TLineSeries
                      DataSource = DaysQuery
                      Title = '7-Days-Incidence'
                      Brush.BackColor = clDefault
                      DrawStyle = dsCurve
                      LinePen.Width = 2
                      OutLine.Width = 7
                      Pointer.InflateMargins = True
                      Pointer.Style = psRectangle
                      XValues.Name = 'X'
                      XValues.Order = loAscending
                      XValues.ValueSource = 'day_number'
                      YValues.Name = 'Y'
                      YValues.Order = loNone
                      YValues.ValueSource = 'mean_infected_last_7_days'
                    end
                    object LineSeries5: TLineSeries
                      DataSource = DaysQuery
                      Title = 'New Infected'
                      Brush.BackColor = clDefault
                      DrawStyle = dsCurve
                      LinePen.Width = 2
                      Pointer.InflateMargins = True
                      Pointer.Style = psRectangle
                      XValues.Name = 'X'
                      XValues.Order = loAscending
                      XValues.ValueSource = 'day_number'
                      YValues.Name = 'Y'
                      YValues.Order = loNone
                      YValues.ValueSource = 'mean_new_infected'
                    end
                  end
                end
              end
            end
          end
        end
        object InfectionRiskTabSheet: TTabSheet
          Caption = 'Infection Risk on Contact'
          ImageIndex = 3
          object Panel15: TPanel
            AlignWithMargins = True
            Left = 4
            Top = 4
            Width = 655
            Height = 323
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Align = alClient
            BevelKind = bkFlat
            BevelOuter = bvNone
            ParentBackground = False
            TabOrder = 0
            object ScrollBox3: TScrollBox
              Left = 0
              Top = 0
              Width = 651
              Height = 319
              Align = alClient
              BevelInner = bvNone
              BevelOuter = bvNone
              BorderStyle = bsNone
              TabOrder = 0
              object Splitter4: TSplitter
                Left = 177
                Top = 0
                Width = 8
                Height = 319
                ExplicitLeft = 265
                ExplicitHeight = 363
              end
              object Panel16: TPanel
                Left = 0
                Top = 0
                Width = 177
                Height = 319
                Align = alLeft
                BevelOuter = bvNone
                TabOrder = 0
                object Panel17: TPanel
                  AlignWithMargins = True
                  Left = 4
                  Top = 4
                  Width = 173
                  Height = 311
                  Margins.Left = 4
                  Margins.Top = 4
                  Margins.Right = 0
                  Margins.Bottom = 4
                  Align = alClient
                  BevelKind = bkFlat
                  BevelOuter = bvNone
                  TabOrder = 0
                  object DBGrid4: TDBGrid
                    Left = 0
                    Top = 0
                    Width = 169
                    Height = 307
                    Align = alClient
                    BorderStyle = bsNone
                    DataSource = SimulationDaysSource
                    TabOrder = 0
                    TitleFont.Charset = DEFAULT_CHARSET
                    TitleFont.Color = clWindowText
                    TitleFont.Height = -13
                    TitleFont.Name = 'Segoe UI'
                    TitleFont.Style = []
                    Columns = <
                      item
                        Expanded = False
                        FieldName = 'day_number'
                        Title.Caption = 'Day'
                        Width = 40
                        Visible = True
                      end
                      item
                        Expanded = False
                        FieldName = 'mean_infection_risk'
                        Title.Caption = 'Infection Risk'
                        Width = 92
                        Visible = True
                      end>
                  end
                end
              end
              object Panel18: TPanel
                Left = 185
                Top = 0
                Width = 466
                Height = 319
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 1
                object Panel19: TPanel
                  AlignWithMargins = True
                  Left = 0
                  Top = 4
                  Width = 462
                  Height = 311
                  Margins.Left = 0
                  Margins.Top = 4
                  Margins.Right = 4
                  Margins.Bottom = 4
                  Align = alClient
                  BevelKind = bkFlat
                  BevelOuter = bvNone
                  TabOrder = 0
                  object InfectionRiskChart: TDBChart
                    Left = 0
                    Top = 0
                    Width = 458
                    Height = 307
                    SubTitle.Font.Charset = ANSI_CHARSET
                    SubTitle.Font.Color = clBlack
                    SubTitle.Font.Height = -15
                    SubTitle.Font.Name = 'Segoe UI'
                    Title.Font.Charset = ANSI_CHARSET
                    Title.Font.Color = clBlack
                    Title.Font.Height = -19
                    Title.Font.Name = 'Segoe UI'
                    Title.Font.Style = [fsBold]
                    Title.Font.Quality = fqClearType
                    Title.Text.Strings = (
                      'Infection Risk on Contact')
                    Title.Visible = False
                    BottomAxis.LabelsFormat.Font.Height = -12
                    BottomAxis.LabelsFormat.Font.Name = 'Segoe UI'
                    BottomAxis.LabelsFormat.Font.Quality = fqClearType
                    BottomAxis.Title.Caption = 'Days'
                    BottomAxis.Title.Font.Height = -15
                    BottomAxis.Title.Font.Name = 'Segoe UI'
                    BottomAxis.Title.Font.Quality = fqClearType
                    LeftAxis.LabelsFormat.Font.Height = -12
                    LeftAxis.LabelsFormat.Font.Name = 'Segoe UI'
                    LeftAxis.LabelsFormat.Font.Quality = fqClearType
                    LeftAxis.Title.Caption = 'Percentage'
                    LeftAxis.Title.Font.Height = -15
                    LeftAxis.Title.Font.Name = 'Segoe UI'
                    LeftAxis.Title.Font.Quality = fqClearType
                    Legend.Alignment = laBottom
                    Legend.Font.Height = -15
                    Legend.Font.Name = 'Segoe UI'
                    Legend.Font.Quality = fqClearType
                    Legend.Frame.Visible = False
                    Legend.LegendStyle = lsSeries
                    Legend.Shadow.Visible = False
                    Legend.Title.Font.Quality = fqClearType
                    Shadow.Visible = False
                    View3D = False
                    Zoom.Animated = True
                    Align = alClient
                    BevelOuter = bvNone
                    Color = clWhite
                    TabOrder = 0
                    DefaultCanvas = 'TGDIPlusCanvas'
                    ColorPaletteIndex = 11
                    object Series4: TLineSeries
                      Marks.Callout.Length = 20
                      DataSource = DaysQuery
                      Title = 'Infection Risk'
                      Brush.BackColor = clDefault
                      LinePen.Width = 2
                      Pointer.InflateMargins = True
                      Pointer.Style = psRectangle
                      XValues.Name = 'X'
                      XValues.Order = loAscending
                      XValues.ValueSource = 'day_number'
                      YValues.Name = 'Y'
                      YValues.Order = loNone
                      YValues.ValueSource = 'mean_infection_risk'
                    end
                  end
                end
              end
            end
          end
        end
        object ReproductionTabSheet: TTabSheet
          Caption = 'Reproduction Rate'
          ImageIndex = 4
          object Panel20: TPanel
            AlignWithMargins = True
            Left = 4
            Top = 4
            Width = 655
            Height = 323
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Align = alClient
            BevelKind = bkFlat
            BevelOuter = bvNone
            ParentBackground = False
            TabOrder = 0
            object ScrollBox4: TScrollBox
              Left = 0
              Top = 0
              Width = 651
              Height = 319
              Align = alClient
              BevelInner = bvNone
              BevelOuter = bvNone
              BorderStyle = bsNone
              TabOrder = 0
              object Splitter5: TSplitter
                Left = 193
                Top = 0
                Width = 8
                Height = 319
                ExplicitLeft = 265
                ExplicitHeight = 363
              end
              object Panel21: TPanel
                Left = 0
                Top = 0
                Width = 193
                Height = 319
                Align = alLeft
                BevelOuter = bvNone
                TabOrder = 0
                object Panel22: TPanel
                  AlignWithMargins = True
                  Left = 4
                  Top = 4
                  Width = 189
                  Height = 311
                  Margins.Left = 4
                  Margins.Top = 4
                  Margins.Right = 0
                  Margins.Bottom = 4
                  Align = alClient
                  BevelKind = bkFlat
                  BevelOuter = bvNone
                  TabOrder = 0
                  object DBGrid5: TDBGrid
                    Left = 0
                    Top = 0
                    Width = 185
                    Height = 307
                    Align = alClient
                    BorderStyle = bsNone
                    DataSource = SimulationDaysSource
                    TabOrder = 0
                    TitleFont.Charset = DEFAULT_CHARSET
                    TitleFont.Color = clWindowText
                    TitleFont.Height = -13
                    TitleFont.Name = 'Segoe UI'
                    TitleFont.Style = []
                    Columns = <
                      item
                        Expanded = False
                        FieldName = 'day_number'
                        Title.Caption = 'Day'
                        Width = 40
                        Visible = True
                      end
                      item
                        Expanded = False
                        FieldName = 'mean_reproduction'
                        Title.Caption = 'Reproduction Rate'
                        Visible = True
                      end>
                  end
                end
              end
              object Panel23: TPanel
                Left = 201
                Top = 0
                Width = 450
                Height = 319
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 1
                object Panel24: TPanel
                  AlignWithMargins = True
                  Left = 0
                  Top = 4
                  Width = 446
                  Height = 311
                  Margins.Left = 0
                  Margins.Top = 4
                  Margins.Right = 4
                  Margins.Bottom = 4
                  Align = alClient
                  BevelKind = bkFlat
                  BevelOuter = bvNone
                  TabOrder = 0
                  object ReproductionChart: TDBChart
                    Left = 0
                    Top = 0
                    Width = 442
                    Height = 307
                    SubTitle.Font.Charset = ANSI_CHARSET
                    SubTitle.Font.Color = clBlack
                    SubTitle.Font.Height = -15
                    SubTitle.Font.Name = 'Segoe UI'
                    Title.Font.Charset = ANSI_CHARSET
                    Title.Font.Color = clBlack
                    Title.Font.Height = -19
                    Title.Font.Name = 'Segoe UI'
                    Title.Font.Style = [fsBold]
                    Title.Font.Quality = fqClearType
                    Title.Text.Strings = (
                      'Reproduction Rate')
                    Title.Visible = False
                    BottomAxis.LabelsFormat.Font.Height = -12
                    BottomAxis.LabelsFormat.Font.Name = 'Segoe UI'
                    BottomAxis.LabelsFormat.Font.Quality = fqClearType
                    BottomAxis.Title.Caption = 'Days'
                    BottomAxis.Title.Font.Height = -15
                    BottomAxis.Title.Font.Name = 'Segoe UI'
                    BottomAxis.Title.Font.Quality = fqClearType
                    LeftAxis.LabelsFormat.Font.Height = -12
                    LeftAxis.LabelsFormat.Font.Name = 'Segoe UI'
                    LeftAxis.LabelsFormat.Font.Quality = fqClearType
                    LeftAxis.Title.Caption = 'Infections per Infectious'
                    LeftAxis.Title.Font.Height = -15
                    LeftAxis.Title.Font.Name = 'Segoe UI'
                    LeftAxis.Title.Font.Quality = fqClearType
                    Legend.Alignment = laBottom
                    Legend.Font.Height = -15
                    Legend.Font.Name = 'Segoe UI'
                    Legend.Font.Quality = fqClearType
                    Legend.Frame.Visible = False
                    Legend.LegendStyle = lsSeries
                    Legend.Shadow.Visible = False
                    Legend.Title.Font.Quality = fqClearType
                    Shadow.Visible = False
                    View3D = False
                    Zoom.Animated = True
                    Align = alClient
                    BevelOuter = bvNone
                    Color = clWhite
                    TabOrder = 0
                    DefaultCanvas = 'TGDIPlusCanvas'
                    ColorPaletteIndex = 11
                    object Series5: TBarSeries
                      Marks.Visible = False
                      DataSource = DaysQuery
                      Title = 'Reproduction Rate'
                      BarWidthPercent = 20
                      SideMargins = False
                      XValues.Name = 'X'
                      XValues.Order = loAscending
                      XValues.ValueSource = 'day_number'
                      YValues.Name = 'Bar'
                      YValues.Order = loNone
                      YValues.ValueSource = 'mean_reproduction'
                    end
                  end
                end
              end
            end
          end
        end
        object PopulationSharesTabSheet: TTabSheet
          Caption = 'Population Shares'
          ImageIndex = 5
          object Panel25: TPanel
            AlignWithMargins = True
            Left = 4
            Top = 4
            Width = 655
            Height = 323
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Align = alClient
            BevelKind = bkFlat
            BevelOuter = bvNone
            ParentBackground = False
            TabOrder = 0
            object ScrollBox5: TScrollBox
              Left = 0
              Top = 0
              Width = 651
              Height = 319
              Align = alClient
              BevelInner = bvNone
              BevelOuter = bvNone
              BorderStyle = bsNone
              TabOrder = 0
              object Splitter6: TSplitter
                Left = 457
                Top = 0
                Width = 8
                Height = 319
                ExplicitLeft = 209
                ExplicitHeight = 363
              end
              object Panel26: TPanel
                Left = 0
                Top = 0
                Width = 457
                Height = 319
                Align = alLeft
                BevelOuter = bvNone
                TabOrder = 0
                object Panel27: TPanel
                  AlignWithMargins = True
                  Left = 4
                  Top = 4
                  Width = 453
                  Height = 311
                  Margins.Left = 4
                  Margins.Top = 4
                  Margins.Right = 0
                  Margins.Bottom = 4
                  Align = alClient
                  BevelKind = bkFlat
                  BevelOuter = bvNone
                  TabOrder = 0
                  object DBGrid6: TDBGrid
                    Left = 0
                    Top = 0
                    Width = 449
                    Height = 307
                    Align = alClient
                    BorderStyle = bsNone
                    DataSource = SimulationDaysSource
                    TabOrder = 0
                    TitleFont.Charset = DEFAULT_CHARSET
                    TitleFont.Color = clWindowText
                    TitleFont.Height = -13
                    TitleFont.Name = 'Segoe UI'
                    TitleFont.Style = []
                    Columns = <
                      item
                        Expanded = False
                        FieldName = 'day_number'
                        Title.Caption = 'Day'
                        Width = 40
                        Visible = True
                      end
                      item
                        Expanded = False
                        FieldName = 'mean_susceptible'
                        Title.Caption = 'Susceptible'
                        Visible = True
                      end
                      item
                        Expanded = False
                        FieldName = 'mean_incubated'
                        Title.Caption = 'Incubated'
                        Visible = True
                      end
                      item
                        Expanded = False
                        FieldName = 'mean_diseased'
                        Title.Caption = 'Diseased'
                        Visible = True
                      end
                      item
                        Expanded = False
                        FieldName = 'mean_immune'
                        Title.Caption = 'Immune'
                        Visible = True
                      end
                      item
                        Expanded = False
                        FieldName = 'mean_deceased'
                        Title.Caption = 'Deceased'
                        Visible = True
                      end>
                  end
                end
              end
              object Panel28: TPanel
                Left = 465
                Top = 0
                Width = 186
                Height = 319
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 1
                object Panel29: TPanel
                  AlignWithMargins = True
                  Left = 0
                  Top = 4
                  Width = 182
                  Height = 311
                  Margins.Left = 0
                  Margins.Top = 4
                  Margins.Right = 4
                  Margins.Bottom = 4
                  Align = alClient
                  BevelKind = bkFlat
                  BevelOuter = bvNone
                  TabOrder = 0
                  object PopulationSharesChart: TDBChart
                    Left = 0
                    Top = 0
                    Width = 178
                    Height = 307
                    SubTitle.Font.Charset = ANSI_CHARSET
                    SubTitle.Font.Color = clBlack
                    SubTitle.Font.Height = -15
                    SubTitle.Font.Name = 'Segoe UI'
                    Title.Font.Charset = ANSI_CHARSET
                    Title.Font.Color = clBlack
                    Title.Font.Height = -19
                    Title.Font.Name = 'Segoe UI'
                    Title.Font.Style = [fsBold]
                    Title.Text.Strings = (
                      'Population Shares')
                    Title.Visible = False
                    BottomAxis.LabelsFormat.Font.Charset = ANSI_CHARSET
                    BottomAxis.LabelsFormat.Font.Height = -12
                    BottomAxis.LabelsFormat.Font.Name = 'Segoe UI'
                    BottomAxis.LabelsFormat.Font.Quality = fqClearType
                    BottomAxis.Title.Caption = 'Days'
                    BottomAxis.Title.Font.Charset = ANSI_CHARSET
                    BottomAxis.Title.Font.Height = -15
                    BottomAxis.Title.Font.Name = 'Segoe UI'
                    BottomAxis.Title.Font.Quality = fqClearType
                    LeftAxis.LabelsFormat.Font.Charset = ANSI_CHARSET
                    LeftAxis.LabelsFormat.Font.Height = -12
                    LeftAxis.LabelsFormat.Font.Name = 'Segoe UI'
                    LeftAxis.LabelsFormat.Font.Quality = fqClearType
                    LeftAxis.Title.Caption = 'Percentage'
                    LeftAxis.Title.Font.Charset = ANSI_CHARSET
                    LeftAxis.Title.Font.Height = -15
                    LeftAxis.Title.Font.Name = 'Segoe UI'
                    LeftAxis.Title.Font.Quality = fqClearType
                    Legend.Alignment = laBottom
                    Legend.Font.Height = -15
                    Legend.Font.Name = 'Segoe UI'
                    Legend.Font.Quality = fqClearType
                    Legend.Frame.Visible = False
                    Legend.LegendStyle = lsSeries
                    Legend.Shadow.Visible = False
                    Legend.Symbol.Pen.Visible = False
                    Legend.Symbol.Shadow.Visible = False
                    Legend.Title.Font.Quality = fqClearType
                    Shadow.Visible = False
                    View3D = False
                    Zoom.Animated = True
                    Align = alClient
                    BevelOuter = bvNone
                    Color = clWhite
                    TabOrder = 0
                    DefaultCanvas = 'TGDIPlusCanvas'
                    PrintMargins = (
                      28
                      15
                      28
                      15)
                    ColorPaletteIndex = 11
                    object Series6: TAreaSeries
                      DataSource = DaysQuery
                      Title = 'Susceptible'
                      AreaChartBrush.Color = clGray
                      AreaChartBrush.BackColor = clDefault
                      AreaLinesPen.Visible = False
                      Dark3D = False
                      DrawArea = True
                      LinePen.Visible = False
                      MultiArea = maStacked
                      Pointer.InflateMargins = True
                      Pointer.Style = psRectangle
                      Pointer.Visible = False
                      Transparency = 50
                      XValues.Name = 'X'
                      XValues.Order = loAscending
                      XValues.ValueSource = 'day_number'
                      YValues.Name = 'Y'
                      YValues.Order = loNone
                      YValues.ValueSource = 'mean_susceptible'
                    end
                    object Series7: TAreaSeries
                      DataSource = DaysQuery
                      Title = 'Incubated'
                      AreaChartBrush.Color = clGray
                      AreaChartBrush.BackColor = clDefault
                      AreaLinesPen.Visible = False
                      Dark3D = False
                      DrawArea = True
                      LinePen.Visible = False
                      MultiArea = maStacked
                      Pointer.InflateMargins = True
                      Pointer.Style = psRectangle
                      Pointer.Visible = False
                      Transparency = 50
                      XValues.Name = 'X'
                      XValues.Order = loAscending
                      XValues.ValueSource = 'day_number'
                      YValues.Name = 'Y'
                      YValues.Order = loNone
                      YValues.ValueSource = 'mean_incubated'
                    end
                    object Series8: TAreaSeries
                      Marks.Callout.Length = 20
                      DataSource = DaysQuery
                      Title = 'Diseased'
                      AreaChartBrush.Color = clGray
                      AreaChartBrush.BackColor = clDefault
                      AreaLinesPen.Visible = False
                      Dark3D = False
                      DrawArea = True
                      LinePen.Visible = False
                      MultiArea = maStacked
                      Pointer.InflateMargins = True
                      Pointer.Style = psRectangle
                      Pointer.Visible = False
                      Transparency = 50
                      XValues.Name = 'X'
                      XValues.Order = loAscending
                      XValues.ValueSource = 'day_number'
                      YValues.Name = 'Y'
                      YValues.Order = loNone
                      YValues.ValueSource = 'mean_diseased'
                    end
                    object Series9: TAreaSeries
                      Marks.Callout.Length = 20
                      DataSource = DaysQuery
                      Title = 'Immune'
                      AreaChartBrush.Color = clGray
                      AreaChartBrush.BackColor = clDefault
                      AreaLinesPen.Visible = False
                      Dark3D = False
                      DrawArea = True
                      LinePen.Visible = False
                      MultiArea = maStacked
                      Pointer.InflateMargins = True
                      Pointer.Style = psRectangle
                      Pointer.Visible = False
                      Transparency = 50
                      XValues.Name = 'X'
                      XValues.Order = loAscending
                      XValues.ValueSource = 'day_number'
                      YValues.Name = 'Y'
                      YValues.Order = loNone
                      YValues.ValueSource = 'mean_immune'
                    end
                    object Series10: TAreaSeries
                      DataSource = DaysQuery
                      Title = 'Deceased'
                      AreaChartBrush.Color = clGray
                      AreaChartBrush.BackColor = clDefault
                      AreaLinesPen.Visible = False
                      Dark3D = False
                      DrawArea = True
                      MultiArea = maStacked
                      Pointer.InflateMargins = True
                      Pointer.Style = psRectangle
                      Pointer.Visible = False
                      Transparency = 50
                      XValues.Name = 'X'
                      XValues.Order = loAscending
                      XValues.ValueSource = 'day_number'
                      YValues.Name = 'Y'
                      YValues.Order = loNone
                      YValues.ValueSource = 'mean_deceased'
                    end
                  end
                end
              end
            end
          end
        end
        object InfectiousTabSheet: TTabSheet
          Caption = 'Infectious'
          ImageIndex = 6
          object Panel30: TPanel
            AlignWithMargins = True
            Left = 4
            Top = 4
            Width = 655
            Height = 323
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Align = alClient
            BevelKind = bkFlat
            BevelOuter = bvNone
            ParentBackground = False
            TabOrder = 0
            object ScrollBox6: TScrollBox
              Left = 0
              Top = 0
              Width = 651
              Height = 319
              Align = alClient
              BevelInner = bvNone
              BevelOuter = bvNone
              BorderStyle = bsNone
              TabOrder = 0
              object Splitter7: TSplitter
                Left = 233
                Top = 0
                Width = 8
                Height = 319
                ExplicitLeft = 209
                ExplicitHeight = 363
              end
              object Panel31: TPanel
                Left = 0
                Top = 0
                Width = 233
                Height = 319
                Align = alLeft
                BevelOuter = bvNone
                TabOrder = 0
                object Panel32: TPanel
                  AlignWithMargins = True
                  Left = 4
                  Top = 4
                  Width = 229
                  Height = 311
                  Margins.Left = 4
                  Margins.Top = 4
                  Margins.Right = 0
                  Margins.Bottom = 4
                  Align = alClient
                  BevelKind = bkFlat
                  BevelOuter = bvNone
                  TabOrder = 0
                  object DBGrid7: TDBGrid
                    Left = 0
                    Top = 0
                    Width = 225
                    Height = 307
                    Align = alClient
                    BorderStyle = bsNone
                    DataSource = SimulationDaysSource
                    TabOrder = 0
                    TitleFont.Charset = DEFAULT_CHARSET
                    TitleFont.Color = clWindowText
                    TitleFont.Height = -13
                    TitleFont.Name = 'Segoe UI'
                    TitleFont.Style = []
                    Columns = <
                      item
                        Expanded = False
                        FieldName = 'day_number'
                        Title.Caption = 'Day'
                        Width = 40
                        Visible = True
                      end
                      item
                        Expanded = False
                        FieldName = 'mean_infectious'
                        Title.Caption = 'Mean'
                        Visible = True
                      end
                      item
                        Expanded = False
                        FieldName = 'deviation_infectious'
                        Title.Caption = 'Std. Dev.'
                        Visible = True
                      end>
                  end
                end
              end
              object Panel33: TPanel
                Left = 241
                Top = 0
                Width = 410
                Height = 319
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 1
                object Panel34: TPanel
                  AlignWithMargins = True
                  Left = 0
                  Top = 4
                  Width = 406
                  Height = 311
                  Margins.Left = 0
                  Margins.Top = 4
                  Margins.Right = 4
                  Margins.Bottom = 4
                  Align = alClient
                  BevelKind = bkFlat
                  BevelOuter = bvNone
                  TabOrder = 0
                  object InfectiousChart: TDBChart
                    Left = 0
                    Top = 0
                    Width = 402
                    Height = 307
                    SubTitle.Font.Charset = ANSI_CHARSET
                    SubTitle.Font.Color = clBlack
                    SubTitle.Font.Height = -15
                    SubTitle.Font.Name = 'Segoe UI'
                    Title.Font.Charset = ANSI_CHARSET
                    Title.Font.Color = clBlack
                    Title.Font.Height = -19
                    Title.Font.Name = 'Segoe UI'
                    Title.Font.Style = [fsBold]
                    Title.Font.Quality = fqClearType
                    Title.Text.Strings = (
                      'Infectious')
                    Title.Visible = False
                    BottomAxis.LabelsFormat.Font.Height = -12
                    BottomAxis.LabelsFormat.Font.Name = 'Segoe UI'
                    BottomAxis.LabelsFormat.Font.Quality = fqClearType
                    BottomAxis.Title.Caption = 'Days'
                    BottomAxis.Title.Font.Height = -15
                    BottomAxis.Title.Font.Name = 'Segoe UI'
                    BottomAxis.Title.Font.Quality = fqClearType
                    LeftAxis.LabelsFormat.Font.Height = -12
                    LeftAxis.LabelsFormat.Font.Name = 'Segoe UI'
                    LeftAxis.LabelsFormat.Font.Quality = fqClearType
                    LeftAxis.Title.Caption = 'Percentage'
                    LeftAxis.Title.Font.Height = -15
                    LeftAxis.Title.Font.Name = 'Segoe UI'
                    LeftAxis.Title.Font.Quality = fqClearType
                    Legend.Alignment = laBottom
                    Legend.Font.Height = -15
                    Legend.Font.Name = 'Segoe UI'
                    Legend.Font.Quality = fqClearType
                    Legend.Frame.Visible = False
                    Legend.LegendStyle = lsSeries
                    Legend.Shadow.Visible = False
                    Legend.Title.Font.Quality = fqClearType
                    Shadow.Visible = False
                    View3D = False
                    Zoom.Animated = True
                    Align = alClient
                    BevelOuter = bvNone
                    Color = clWhite
                    TabOrder = 0
                    ExplicitLeft = 4
                    DefaultCanvas = 'TGDIPlusCanvas'
                    ColorPaletteIndex = 11
                    object LineSeries6: TLineSeries
                      DataSource = DaysQuery
                      Title = 'Infectious'
                      Brush.BackColor = clDefault
                      DrawStyle = dsCurve
                      LinePen.Width = 2
                      OutLine.Width = 7
                      Pointer.InflateMargins = True
                      Pointer.Style = psRectangle
                      XValues.Name = 'X'
                      XValues.Order = loAscending
                      XValues.ValueSource = 'day_number'
                      YValues.Name = 'Y'
                      YValues.Order = loNone
                      YValues.ValueSource = 'mean_infectious'
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  inherited ButtonsBgPanel: TPanel
    Top = 415
    Width = 1052
    ExplicitTop = 415
    ExplicitWidth = 1052
    inherited BtnBevel: TBevel
      Width = 1052
      ExplicitWidth = 1052
    end
    inherited ButtonsCardPanel: TCardPanel
      Left = 56
      Width = 529
      ExplicitLeft = 56
      ExplicitWidth = 529
      inherited ViewModeCard: TCard
        Width = 529
        ExplicitWidth = 529
        inherited NewBtn: TBitBtn
          Width = 131
          Hint = '|Exports data as a CSV file.'
          Caption = 'Export Data'
          ImageIndex = 15
          OnClick = NewBtnClick
          ExplicitWidth = 131
        end
        inherited EditBtn: TBitBtn
          Left = 248
          Width = 131
          Hint = '|Exports the currently displayed chart as a bitmap file.'
          Caption = 'Export Chart'
          ImageIndex = 14
          OnClick = EditBtnClick
          ExplicitLeft = 248
          ExplicitWidth = 131
        end
        inherited DeleteBtn: TBitBtn
          Left = 385
          Width = 131
          Hint = '|Prints the currently displayed chart.'
          Caption = 'Print Chart'
          ImageIndex = 13
          OnClick = DeleteBtnClick
          ExplicitLeft = 385
          ExplicitWidth = 131
        end
        inherited RefreshBtn: TBitBtn
          Hint = '|Update the displayed data.'
          OnClick = RefreshBtnClick
        end
      end
      inherited EditModeCard: TCard
        Width = 529
        ExplicitWidth = 529
      end
    end
  end
  inherited ButtonImageList: TImageList
    Left = 64
    Top = 200
  end
  object SimulationsQuery: TZReadOnlyQuery
    Connection = MainModel.DBConnection
    SQL.Strings = (
      'SELECT'
      's.simulation_id,'
      'p.name AS Project,'
      'ss.name AS Setup,'
      's.name AS Simulation'
      'FROM simulations s'
      
        'JOIN simulation_setups ss ON (ss.simulation_setup_id = s.simulat' +
        'ion_setup_id)'
      'JOIN projects p ON (p.project_id = ss.project_id)'
      'ORDER BY p.name, ss.name, s.name;')
    Params = <>
    Left = 68
    Top = 85
    object SimulationsQuerysimulation_id: TStringField
      FieldName = 'simulation_id'
      ReadOnly = True
      Size = 36
    end
    object SimulationsQueryProject: TStringField
      FieldName = 'Project'
      ReadOnly = True
      Size = 100
    end
    object SimulationsQuerySetup: TStringField
      FieldName = 'Setup'
      ReadOnly = True
      Size = 100
    end
    object SimulationsQuerySimulation: TStringField
      FieldName = 'Simulation'
      ReadOnly = True
      Size = 100
    end
  end
  object SimulationsSource: TDataSource
    AutoEdit = False
    DataSet = SimulationsQuery
    OnDataChange = SimulationsSourceDataChange
    Left = 180
    Top = 85
  end
  object DaysQuery: TZReadOnlyQuery
    Connection = MainModel.DBConnection
    SQL.Strings = (
      'SELECT'
      '    sd.simulation_id,'
      '    sd.day_number,'
      '    sd.mean_susceptible,'
      '    sd.deviation_susceptible,'
      '    sd.delta_susceptible,'
      '    sd.mean_incubated,'
      '    sd.deviation_incubated,'
      '    sd.delta_incubated,'
      '    sd.mean_diseased,'
      '    sd.deviation_diseased,'
      '    sd.delta_diseased,'
      '    sd.mean_infected,'
      '    sd.deviation_infected,'
      '    sd.delta_infected,'
      '    sd.mean_immune,'
      '    sd.deviation_immune,'
      '    sd.delta_immune,'
      '    sd.mean_deceased,'
      '    sd.deviation_deceased,'
      '    sd.delta_deceased,'
      '    sd.mean_removed,'
      '    sd.deviation_removed,'
      '    sd.delta_removed,'
      '    sd.mean_infectious,'
      '    sd.deviation_infectious,'
      '    sd.delta_infectious,'
      '    sd.mean_reproduction,'
      '    sd.deviation_reproduction,'
      '    sd.delta_reproduction,'
      '    sd.mean_infection_risk,'
      '    sd.deviation_infection_risk,'
      '    sd.delta_infection_risk,'
      '    sd.mean_infected_last_7_days,'
      '    sd.deviation_infected_last_7_days,'
      '    sd.delta_infected_last_7_days,'
      '    sd.mean_new_infected,'
      '    sd.deviation_new_infected,'
      '    sd.delta_new_infected'
      'FROM simulation_days as sd'
      'ORDER BY sd.day_number;')
    Params = <>
    MasterFields = 'simulation_id'
    MasterSource = SimulationsSource
    LinkedFields = 'simulation_id'
    Left = 69
    Top = 134
    object DaysQuerySimulationID: TStringField
      FieldName = 'simulation_id'
      ReadOnly = True
      Size = 36
    end
    object DaysQueryDayNumber: TIntegerField
      FieldName = 'day_number'
      ReadOnly = True
    end
    object DaysQueryMeanSusceptible: TFloatField
      FieldName = 'mean_susceptible'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object DaysQueryDevSusceptible: TFloatField
      FieldName = 'deviation_susceptible'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object DaysQueryDeltaSusceptible: TFloatField
      FieldName = 'delta_susceptible'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object DaysQuerymean_incubated: TFloatField
      FieldName = 'mean_incubated'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object DaysQuerydeviation_incubated: TFloatField
      FieldName = 'deviation_incubated'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object DaysQuerydelta_incubated: TFloatField
      FieldName = 'delta_incubated'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object DaysQuerymean_diseased: TFloatField
      FieldName = 'mean_diseased'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object DaysQuerydeviation_diseased: TFloatField
      FieldName = 'deviation_diseased'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object DaysQuerydelta_diseased: TFloatField
      FieldName = 'delta_diseased'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object DaysQuerymean_infected: TFloatField
      FieldName = 'mean_infected'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object DaysQuerydeviation_infected: TFloatField
      FieldName = 'deviation_infected'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object DaysQuerydelta_infected: TFloatField
      FieldName = 'delta_infected'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object DaysQuerymean_immune: TFloatField
      FieldName = 'mean_immune'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object DaysQuerydeviation_immune: TFloatField
      FieldName = 'deviation_immune'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object DaysQuerydelta_immune: TFloatField
      FieldName = 'delta_immune'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object DaysQuerymean_deceased: TFloatField
      FieldName = 'mean_deceased'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object DaysQuerydeviation_deceased: TFloatField
      FieldName = 'deviation_deceased'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object DaysQuerydelta_deceased: TFloatField
      FieldName = 'delta_deceased'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object DaysQuerymean_removed: TFloatField
      FieldName = 'mean_removed'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object DaysQuerydeviation_removed: TFloatField
      FieldName = 'deviation_removed'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object DaysQuerydelta_removed: TFloatField
      FieldName = 'delta_removed'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object DaysQuerymean_infectious: TFloatField
      FieldName = 'mean_infectious'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object DaysQuerydeviation_infectious: TFloatField
      FieldName = 'deviation_infectious'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object DaysQuerydelta_infectious: TFloatField
      FieldName = 'delta_infectious'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object DaysQuerymean_reproduction: TFloatField
      FieldName = 'mean_reproduction'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object DaysQuerydeviation_reproduction: TFloatField
      FieldName = 'deviation_reproduction'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object DaysQuerydelta_reproduction: TFloatField
      FieldName = 'delta_reproduction'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object DaysQuerymean_infection_risk: TFloatField
      FieldName = 'mean_infection_risk'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object DaysQuerydeviation_infection_risk: TFloatField
      FieldName = 'deviation_infection_risk'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object DaysQuerydelta_infection_risk: TFloatField
      FieldName = 'delta_infection_risk'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object DaysQuerymean_infected_last_7_days: TFloatField
      FieldName = 'mean_infected_last_7_days'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object DaysQuerydeviation_infected_last_7_days: TFloatField
      FieldName = 'deviation_infected_last_7_days'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object DaysQuerydelta_infected_last_7_days: TFloatField
      FieldName = 'delta_infected_last_7_days'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object DaysQuerymean_new_infected: TFloatField
      FieldName = 'mean_new_infected'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object DaysQuerydeviation_new_infected: TFloatField
      FieldName = 'deviation_new_infected'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object DaysQuerydelta_new_infected: TFloatField
      FieldName = 'delta_new_infected'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
  end
  object SimulationDaysSource: TDataSource
    DataSet = DaysQuery
    Left = 181
    Top = 134
  end
  object ChartSaveDialog: TFileSaveDialog
    DefaultExtension = 'bmp'
    FavoriteLinks = <>
    FileNameLabel = 'File Name'
    FileTypes = <
      item
        DisplayName = 'Bitmaps'
        FileMask = '*.bmp'
      end
      item
        DisplayName = 'All Files'
        FileMask = '*.*'
      end>
    FileTypeIndex = 0
    OkButtonLabel = 'Save'
    Options = [fdoOverWritePrompt]
    Title = 'Save as Bitmap'
    Left = 157
    Top = 204
  end
  object DataSaveDialog: TFileSaveDialog
    DefaultExtension = 'csv'
    FavoriteLinks = <>
    FileNameLabel = 'File Name'
    FileTypes = <
      item
        DisplayName = 'Comma Separated Values'
        FileMask = '*.csv'
      end
      item
        DisplayName = 'All Files'
        FileMask = '*.*'
      end>
    OkButtonLabel = 'Save'
    Options = [fdoOverWritePrompt]
    Title = 'Save as CSV file'
    Left = 236
    Top = 205
  end
end
