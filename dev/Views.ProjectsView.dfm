inherited ProjectsView: TProjectsView
  Caption = ''
  ClientHeight = 605
  ClientWidth = 1016
  OnCreate = FormCreate
  OnHide = FormHide
  OnShow = FormShow
  ExplicitWidth = 1032
  ExplicitHeight = 644
  PixelsPerInch = 96
  TextHeight = 17
  inherited MainPanel: TPanel
    Width = 1016
    Height = 545
    ExplicitWidth = 1016
    ExplicitHeight = 545
    inherited Splitter: TSplitter
      Left = 234
      Height = 545
      ExplicitLeft = 234
      ExplicitHeight = 728
    end
    inherited LeftPanel: TPanel
      Width = 234
      Height = 545
      ExplicitWidth = 234
      ExplicitHeight = 545
      inherited MainCaptionLabel: TLabel
        Width = 230
        Caption = 'Projects'
        ExplicitWidth = 49
      end
      inherited MainTableBgPanel: TPanel
        Width = 230
        Height = 512
        ExplicitWidth = 230
        ExplicitHeight = 512
        inherited MainGrid: TDBGrid
          Width = 226
          Height = 508
          DataSource = ProjectsSource
          Columns = <
            item
              Expanded = False
              FieldName = 'name'
              Width = 200
              Visible = True
            end>
        end
      end
    end
    inherited RightPanel: TPanel
      Left = 242
      Width = 774
      Height = 545
      ExplicitLeft = 242
      ExplicitWidth = 774
      ExplicitHeight = 545
      inherited PageControl: TPageControl
        Width = 770
        Height = 537
        ActivePage = DependentData2TabSheet
        ExplicitWidth = 770
        ExplicitHeight = 537
        inherited MainDetailsTabSheet: TTabSheet
          Caption = 'Details of selected Project'
          ExplicitWidth = 762
          ExplicitHeight = 505
          inherited MainDetailsTabSheetBgPanel: TPanel
            Width = 753
            Height = 497
            ExplicitWidth = 753
            ExplicitHeight = 497
            inherited MainDetailsScrollBox: TScrollBox
              Width = 749
              Height = 493
              HorzScrollBar.Smooth = True
              VertScrollBar.Smooth = True
              ExplicitWidth = 749
              ExplicitHeight = 493
              object ProjectPopulationBox: TGroupBox
                AlignWithMargins = True
                Left = 8
                Top = 154
                Width = 733
                Height = 129
                Margins.Left = 8
                Margins.Top = 8
                Margins.Right = 8
                Margins.Bottom = 8
                Align = alBottom
                Caption = 'Population'
                Constraints.MinHeight = 129
                Constraints.MinWidth = 733
                TabOrder = 1
                object ProjectPopulationSizeLabel: TLabel
                  Left = 19
                  Top = 27
                  Width = 89
                  Height = 17
                  Caption = 'Population Size'
                end
                object ProjectContactsMeanLabel: TLabel
                  Left = 421
                  Top = 27
                  Width = 64
                  Height = 17
                  Alignment = taCenter
                  AutoSize = False
                  Caption = 'Mean'
                end
                object ProjectContactsCountLabel: TLabel
                  Left = 297
                  Top = 58
                  Width = 118
                  Height = 17
                  Caption = 'Contacts per Person'
                end
                object ProjectContactsDeviationLabel: TLabel
                  Left = 491
                  Top = 27
                  Width = 64
                  Height = 17
                  Hint = 'Standard Deviation'
                  Alignment = taCenter
                  AutoSize = False
                  Caption = 'Std. Dev.'
                end
                object ProjectContactProbabilityLabel: TLabel
                  Left = 297
                  Top = 89
                  Width = 110
                  Height = 17
                  Caption = 'Contact Probability'
                end
                object ProjectContactsLabel: TLabel
                  Left = 297
                  Top = 27
                  Width = 50
                  Height = 17
                  Caption = 'Contacts'
                end
                object ProjectInfectiousOnStartLabel: TLabel
                  Left = 19
                  Top = 58
                  Width = 158
                  Height = 17
                  Caption = 'Infectious on Start (Default)'
                end
                object ProjectCountSimulationDaysLabel: TLabel
                  Left = 19
                  Top = 89
                  Width = 145
                  Height = 17
                  Caption = 'Simulation Days (Default)'
                end
                object ProjectPopulationSizeEdit: TDBEdit
                  Left = 183
                  Top = 24
                  Width = 98
                  Height = 25
                  DataField = 'population_number'
                  DataSource = ProjectsSource
                  TabOrder = 0
                end
                object ProjectContactsMeanEdit: TDBEdit
                  Left = 421
                  Top = 55
                  Width = 64
                  Height = 25
                  DataField = 'mean_contacts'
                  DataSource = ProjectsSource
                  TabOrder = 3
                end
                object ProjectContactsDeviationEdit: TDBEdit
                  Left = 491
                  Top = 55
                  Width = 64
                  Height = 25
                  DataField = 'deviation_contacts'
                  DataSource = ProjectsSource
                  TabOrder = 4
                end
                object ProjectContactProbabilityMeanEdit: TDBEdit
                  Left = 421
                  Top = 86
                  Width = 64
                  Height = 25
                  DataField = 'mean_contact_probability'
                  DataSource = ProjectsSource
                  TabOrder = 5
                end
                object ProjectContactProbabilityDeviationEdit: TDBEdit
                  Left = 491
                  Top = 86
                  Width = 64
                  Height = 25
                  DataField = 'deviation_contact_probability'
                  DataSource = ProjectsSource
                  TabOrder = 6
                end
                object ProjectInfectiousOnStartEdit: TDBEdit
                  Left = 183
                  Top = 55
                  Width = 98
                  Height = 25
                  DataField = 'default_infectious_on_start'
                  DataSource = ProjectsSource
                  TabOrder = 1
                end
                object ProjectCountSimulationDaysEdit: TDBEdit
                  Left = 183
                  Top = 86
                  Width = 98
                  Height = 25
                  DataField = 'default_simulation_duration'
                  DataSource = ProjectsSource
                  TabOrder = 2
                end
              end
              object ProjectNameBox: TGroupBox
                AlignWithMargins = True
                Left = 8
                Top = 8
                Width = 733
                Height = 130
                Margins.Left = 8
                Margins.Top = 8
                Margins.Right = 8
                Margins.Bottom = 8
                Align = alClient
                Caption = 'Name and Description'
                Constraints.MinHeight = 130
                Constraints.MinWidth = 733
                TabOrder = 0
                DesignSize = (
                  733
                  130)
                object ProjectNameLabel: TLabel
                  Left = 19
                  Top = 27
                  Width = 35
                  Height = 17
                  Caption = 'Name'
                end
                object ProjectsDescriptionLabel: TLabel
                  Left = 19
                  Top = 58
                  Width = 66
                  Height = 17
                  Caption = 'Description'
                end
                object ProjectNameEdit: TDBEdit
                  Left = 91
                  Top = 24
                  Width = 626
                  Height = 25
                  Hint = '|The name of the project.'
                  Anchors = [akLeft, akTop, akRight]
                  DataField = 'name'
                  DataSource = ProjectsSource
                  TabOrder = 0
                end
                object ProjectDescriptionEdit: TDBMemo
                  Left = 91
                  Top = 55
                  Width = 626
                  Height = 58
                  Anchors = [akLeft, akTop, akRight, akBottom]
                  DataField = 'description'
                  DataSource = ProjectsSource
                  TabOrder = 1
                end
              end
              object ProjectDiseaseBox: TGroupBox
                AlignWithMargins = True
                Left = 8
                Top = 299
                Width = 733
                Height = 186
                Margins.Left = 8
                Margins.Top = 8
                Margins.Right = 8
                Margins.Bottom = 8
                Align = alBottom
                Caption = 'Disease'
                Constraints.MinHeight = 186
                Constraints.MinWidth = 733
                TabOrder = 2
                object ProjectDiseasePeriodsLabel: TLabel
                  Left = 19
                  Top = 27
                  Width = 44
                  Height = 17
                  Caption = 'Periods'
                end
                object ProjectIncubationPeriodLabel: TLabel
                  Left = 19
                  Top = 58
                  Width = 60
                  Height = 17
                  Caption = 'Incubation'
                end
                object ProjectInfectiousPeriodLabel: TLabel
                  Left = 19
                  Top = 151
                  Width = 55
                  Height = 17
                  Caption = 'Infectious'
                end
                object ProjectDiseasePeriodLabel: TLabel
                  Left = 19
                  Top = 89
                  Width = 45
                  Height = 17
                  Caption = 'Disease'
                end
                object ProjectsDiseasePeriodsMeanLabel: TLabel
                  Left = 116
                  Top = 27
                  Width = 64
                  Height = 17
                  Alignment = taCenter
                  AutoSize = False
                  Caption = 'Mean'
                end
                object ProjectsDiseasePeriodsDeviationLabel: TLabel
                  Left = 186
                  Top = 27
                  Width = 64
                  Height = 17
                  Hint = 'Standard Deviation'
                  Alignment = taCenter
                  AutoSize = False
                  Caption = 'Std. Dev.'
                end
                object ProjectsDiseaseProbabilitiesLabel: TLabel
                  Left = 272
                  Top = 27
                  Width = 72
                  Height = 17
                  Caption = 'Probabilities'
                end
                object ProjectsDiseaseProbabilitiesMeanLabel: TLabel
                  Left = 359
                  Top = 27
                  Width = 64
                  Height = 17
                  Alignment = taCenter
                  AutoSize = False
                  Caption = 'Mean'
                end
                object ProjectsDiseaseProbabilitiesDeviationLabel: TLabel
                  Left = 429
                  Top = 27
                  Width = 64
                  Height = 17
                  Hint = 'Standard Deviation'
                  Alignment = taCenter
                  AutoSize = False
                  Caption = 'Std. Dev.'
                end
                object ProjectSusceptibilityProbabilityLabel: TLabel
                  Left = 272
                  Top = 58
                  Width = 75
                  Height = 17
                  Caption = 'Susceptibility'
                end
                object ProjectSusceptibilityInfectiousnessLabel: TLabel
                  Left = 272
                  Top = 89
                  Width = 81
                  Height = 17
                  Caption = 'Infectiousness'
                end
                object ProjectSusceptibilityMortalityLabel: TLabel
                  Left = 272
                  Top = 120
                  Width = 52
                  Height = 17
                  Caption = 'Mortality'
                end
                object ProjectInfectiousDelayLabel: TLabel
                  Left = 19
                  Top = 120
                  Width = 91
                  Height = 17
                  Caption = 'Infectious Delay'
                end
                object ProjectsDiseaseImmunityLabel: TLabel
                  Left = 512
                  Top = 27
                  Width = 52
                  Height = 17
                  Hint = 'Immunity after Disease'
                  Caption = 'Immunity'
                end
                object ProjectMeanInitialImmunityPeriod: TLabel
                  Left = 512
                  Top = 58
                  Width = 65
                  Height = 17
                  Caption = 'Initial Value'
                end
                object ProjectImmunityPeriodEdit: TLabel
                  Left = 512
                  Top = 120
                  Width = 76
                  Height = 17
                  Hint = 'Detectable Period'
                  Caption = 'Detectable P.'
                end
                object ProjectHalvingImmunityPeriodLabel: TLabel
                  Left = 512
                  Top = 89
                  Width = 85
                  Height = 17
                  Caption = 'Halving Period'
                end
                object ProjectsDiseaseImmunityMeanLabel: TLabel
                  Left = 607
                  Top = 27
                  Width = 64
                  Height = 17
                  Alignment = taCenter
                  AutoSize = False
                  Caption = 'Mean'
                end
                object ProjectsDiseaseImmunityDeviationLabel: TLabel
                  Left = 677
                  Top = 27
                  Width = 64
                  Height = 17
                  Hint = 'Standard Deviation'
                  Alignment = taCenter
                  AutoSize = False
                  Caption = 'Std. Dev.'
                end
                object ProjectMeanIncubationPeriodEdit: TDBEdit
                  Left = 116
                  Top = 55
                  Width = 64
                  Height = 25
                  DataField = 'mean_incubation_period'
                  DataSource = ProjectsSource
                  TabOrder = 0
                end
                object ProjectDeviationIncubationPeriodEdit: TDBEdit
                  Left = 186
                  Top = 55
                  Width = 64
                  Height = 25
                  DataField = 'deviation_incubation_period'
                  DataSource = ProjectsSource
                  TabOrder = 1
                end
                object ProjectMeanInfectiousPeriodEdit: TDBEdit
                  Left = 116
                  Top = 148
                  Width = 64
                  Height = 25
                  DataField = 'mean_infectious_period'
                  DataSource = ProjectsSource
                  TabOrder = 6
                end
                object ProjectDeviationInfectiousPeriodEdit: TDBEdit
                  Left = 186
                  Top = 148
                  Width = 64
                  Height = 25
                  DataField = 'deviation_infectious_period'
                  DataSource = ProjectsSource
                  TabOrder = 7
                end
                object ProjectMeanDiseasePeriodEdit: TDBEdit
                  Left = 116
                  Top = 86
                  Width = 64
                  Height = 25
                  DataField = 'mean_disease_period'
                  DataSource = ProjectsSource
                  TabOrder = 2
                end
                object ProjectDeviationDiseasePeriodEdit: TDBEdit
                  Left = 186
                  Top = 86
                  Width = 64
                  Height = 25
                  DataField = 'deviation_disease_period'
                  DataSource = ProjectsSource
                  TabOrder = 3
                end
                object ProjectMeanInfectiousDelayPeriodEdit: TDBEdit
                  Left = 116
                  Top = 117
                  Width = 64
                  Height = 25
                  DataField = 'mean_infectious_delay_period'
                  DataSource = ProjectsSource
                  TabOrder = 4
                end
                object ProjectMeanSusceptibilityProbabilityEdit: TDBEdit
                  Left = 359
                  Top = 55
                  Width = 64
                  Height = 25
                  DataField = 'mean_susceptibility'
                  DataSource = ProjectsSource
                  TabOrder = 8
                end
                object ProjectDeviationSusceptibilityProbabilityEdit: TDBEdit
                  Left = 429
                  Top = 55
                  Width = 64
                  Height = 25
                  DataField = 'deviation_susceptibility'
                  DataSource = ProjectsSource
                  TabOrder = 9
                end
                object ProjectMeanInfectiousnessProbabilityEdit: TDBEdit
                  Left = 359
                  Top = 86
                  Width = 64
                  Height = 25
                  DataField = 'mean_infectiousness'
                  DataSource = ProjectsSource
                  TabOrder = 10
                end
                object ProjectDeviationInfectiousnessProbabilityEdit: TDBEdit
                  Left = 429
                  Top = 86
                  Width = 64
                  Height = 25
                  DataField = 'deviation_infectiousness'
                  DataSource = ProjectsSource
                  TabOrder = 11
                end
                object ProjectMeanInitialImmunityEdit: TDBEdit
                  Left = 607
                  Top = 53
                  Width = 64
                  Height = 25
                  DataField = 'mean_initial_immunity'
                  DataSource = ProjectsSource
                  TabOrder = 14
                end
                object ProjectDeviationInitialImmunityEdit: TDBEdit
                  Left = 677
                  Top = 53
                  Width = 64
                  Height = 25
                  DataField = 'deviation_initial_immunity'
                  DataSource = ProjectsSource
                  TabOrder = 15
                end
                object ProjectMeanMortalityProbabilityEdit: TDBEdit
                  Left = 359
                  Top = 117
                  Width = 64
                  Height = 25
                  DataField = 'mean_mortality'
                  DataSource = ProjectsSource
                  TabOrder = 12
                end
                object ProjectDeviationMortalityProbabilityEdit: TDBEdit
                  Left = 429
                  Top = 117
                  Width = 64
                  Height = 25
                  DataField = 'deviation_mortality'
                  DataSource = ProjectsSource
                  TabOrder = 13
                end
                object ProjectMeanHalvingImmunityPeriodEdit: TDBEdit
                  Left = 607
                  Top = 84
                  Width = 64
                  Height = 25
                  DataField = 'mean_halving_immunity_period'
                  DataSource = ProjectsSource
                  TabOrder = 16
                end
                object ProjectDeviationInfectiousDelayPeriod: TDBEdit
                  Left = 186
                  Top = 117
                  Width = 64
                  Height = 25
                  DataField = 'deviation_infectious_delay_period'
                  DataSource = ProjectsSource
                  TabOrder = 5
                end
                object ProjectDeviationHalvingImmunityPeriodEdit: TDBEdit
                  Left = 677
                  Top = 84
                  Width = 64
                  Height = 25
                  DataField = 'deviation_halving_immunity_period'
                  DataSource = ProjectsSource
                  TabOrder = 17
                end
                object ProjectMeanImmunityPeriodEdit: TDBEdit
                  Left = 607
                  Top = 117
                  Width = 64
                  Height = 25
                  DataField = 'mean_immunity_period'
                  DataSource = ProjectsSource
                  TabOrder = 18
                end
                object ProjectDeviationImmunityPeriodEdit: TDBEdit
                  Left = 677
                  Top = 117
                  Width = 64
                  Height = 25
                  DataField = 'deviation_immunity_period'
                  DataSource = ProjectsSource
                  TabOrder = 19
                end
              end
            end
          end
        end
        inherited DependentData1TabSheet: TTabSheet
          Caption = 'Simulation Setups'
          ExplicitWidth = 762
          ExplicitHeight = 505
          inherited DependentData1Splitter: TSplitter
            Height = 505
            Color = clWindow
            ExplicitHeight = 688
          end
          inherited DependentData1LeftBgPanel: TPanel
            Height = 497
            ExplicitHeight = 497
            inherited DependentData1Grid: TDBGrid
              Height = 493
              DataSource = SimulationSetupsSource
              Columns = <
                item
                  Expanded = False
                  FieldName = 'name'
                  Width = 150
                  Visible = True
                end>
            end
          end
          inherited DependentData1RightBgPanel: TPanel
            Width = 560
            Height = 497
            ExplicitWidth = 560
            ExplicitHeight = 497
            inherited DependentData1DetailsScrollBox: TScrollBox
              Width = 556
              Height = 493
              ExplicitWidth = 556
              ExplicitHeight = 493
              object SetupSetupBox: TGroupBox
                AlignWithMargins = True
                Left = 8
                Top = 8
                Width = 540
                Height = 97
                Margins.Left = 8
                Margins.Top = 8
                Margins.Right = 8
                Margins.Bottom = 8
                Align = alTop
                Caption = 'Setup'
                TabOrder = 0
                DesignSize = (
                  540
                  97)
                object SetupNameLabel: TLabel
                  Left = 19
                  Top = 27
                  Width = 35
                  Height = 17
                  Caption = 'Name'
                end
                object SimulationCountSimulationDaysLabel: TLabel
                  Left = 19
                  Top = 58
                  Width = 145
                  Height = 17
                  Caption = 'Simulation Days (Default)'
                end
                object SetupInfectiousOnStartLabel: TLabel
                  Left = 263
                  Top = 58
                  Width = 105
                  Height = 17
                  Caption = 'Infectious on Start'
                end
                object SetupNameEdit: TDBEdit
                  Left = 60
                  Top = 24
                  Width = 461
                  Height = 25
                  Hint = 
                    'A setup descripes a spezific community according to the settings' +
                    ' in the project.#13#10The properties and the contacts are set ra' +
                    'ndomly. For that reason a setup descripes a unique community dif' +
                    'ferent to each other.'
                  Anchors = [akLeft, akTop, akRight]
                  DataField = 'name'
                  DataSource = SimulationSetupsSource
                  TabOrder = 0
                end
                object SetupCountSimulationDaysEdit: TDBEdit
                  Left = 170
                  Top = 55
                  Width = 76
                  Height = 25
                  DataField = 'default_simulation_duration'
                  DataSource = SimulationSetupsSource
                  TabOrder = 1
                end
                object SetupInfectiousOnStartEdit: TDBEdit
                  Left = 374
                  Top = 55
                  Width = 84
                  Height = 25
                  DataField = 'infectious_on_start'
                  DataSource = SimulationSetupsSource
                  TabOrder = 2
                end
              end
              object SetupPeopleBox: TGroupBox
                AlignWithMargins = True
                Left = 8
                Top = 121
                Width = 540
                Height = 364
                Margins.Left = 8
                Margins.Top = 8
                Margins.Right = 8
                Margins.Bottom = 8
                Align = alClient
                Caption = 'People'
                TabOrder = 1
                DesignSize = (
                  540
                  364)
                object SetupPeoplePeriodsDoyOfInfectiousnessLabel: TLabel
                  Left = 256
                  Top = 147
                  Width = 123
                  Height = 17
                  Hint = 'Initial Day of Infectiousness'
                  Caption = 'Day of Infectiousness'
                end
                object SetupPeopleProbabilitiesSusceptibilityLabel: TLabel
                  Left = 384
                  Top = 55
                  Width = 75
                  Height = 17
                  Caption = 'Susceptibility'
                end
                object SetupPeopleInfectiousnessLabel: TLabel
                  Left = 384
                  Top = 78
                  Width = 81
                  Height = 17
                  Caption = 'Infectiousness'
                end
                object SetupPeoplePeriodsIncubationLabel: TLabel
                  Left = 256
                  Top = 55
                  Width = 60
                  Height = 17
                  Caption = 'Incubation'
                end
                object SetupPeoplePeriodsDiseaseLabel: TLabel
                  Left = 256
                  Top = 78
                  Width = 45
                  Height = 17
                  Caption = 'Disease'
                end
                object SetupPeopleProbabilitiesImmunityLabel: TLabel
                  Left = 384
                  Top = 124
                  Width = 76
                  Height = 17
                  Hint = 'Initial Immunity'
                  Caption = 'Init. Immunity'
                end
                object SetupPeopleProbabilitiesMortalityLabel: TLabel
                  Left = 384
                  Top = 101
                  Width = 52
                  Height = 17
                  Caption = 'Mortality'
                end
                object SetupPeoplePeriodsInfectiousText: TDBText
                  Left = 332
                  Top = 124
                  Width = 29
                  Height = 17
                  Alignment = taRightJustify
                  DataField = 'infectious_period'
                  DataSource = SimulationPeopleSource
                end
                object SetupPeoplePeriodsDoyOfInfectiousnessText: TDBText
                  Left = 384
                  Top = 147
                  Width = 29
                  Height = 17
                  Alignment = taRightJustify
                  DataField = 'initial_day_of_infectious'
                  DataSource = SimulationPeopleSource
                end
                object SetupPeopleProbabilitiesSusceptibilityText: TDBText
                  Left = 471
                  Top = 55
                  Width = 50
                  Height = 17
                  Alignment = taRightJustify
                  DataField = 'susceptibility'
                  DataSource = SimulationPeopleSource
                end
                object SetupPeoplePeriodsIncubationText: TDBText
                  Left = 332
                  Top = 55
                  Width = 29
                  Height = 17
                  Alignment = taRightJustify
                  DataField = 'incubation_period'
                  DataSource = SimulationPeopleSource
                end
                object SetupPeoplePeriodsInfectiousDelayText: TDBText
                  Left = 332
                  Top = 101
                  Width = 29
                  Height = 17
                  Alignment = taRightJustify
                  DataField = 'infectious_delay_period'
                  DataSource = SimulationPeopleSource
                end
                object SetupPeopleInfectiousnessText: TDBText
                  Left = 471
                  Top = 78
                  Width = 50
                  Height = 17
                  Alignment = taRightJustify
                  DataField = 'infectiousness'
                  DataSource = SimulationPeopleSource
                end
                object SetupPeopleProbabilitiesMortalityText: TDBText
                  Left = 471
                  Top = 101
                  Width = 50
                  Height = 17
                  Alignment = taRightJustify
                  DataField = 'mortality'
                  DataSource = SimulationPeopleSource
                end
                object SetupPeoplePeriodsInfectiousLabel: TLabel
                  Left = 256
                  Top = 124
                  Width = 55
                  Height = 17
                  Caption = 'Infectious'
                end
                object SetupPeoplePeriodsDiseaseText: TDBText
                  Left = 332
                  Top = 78
                  Width = 29
                  Height = 17
                  Alignment = taRightJustify
                  DataField = 'disease_period'
                  DataSource = SimulationPeopleSource
                end
                object SetupPeoplePeriodsLabel: TLabel
                  Left = 256
                  Top = 32
                  Width = 44
                  Height = 17
                  Caption = 'Periods'
                end
                object SetupPeoplePeriodsInfectiousDelayLabel: TLabel
                  Left = 256
                  Top = 101
                  Width = 53
                  Height = 17
                  Hint = 'Infectious Delay'
                  Caption = 'Inf. Delay'
                end
                object SetupPeopleProbabilitiesLabel: TLabel
                  Left = 384
                  Top = 32
                  Width = 72
                  Height = 17
                  Caption = 'Probabilities'
                end
                object SetupPeopleProbabilitiesImmunityText: TDBText
                  Left = 471
                  Top = 124
                  Width = 50
                  Height = 17
                  Alignment = taRightJustify
                  DataField = 'initial_immunity'
                  DataSource = SimulationPeopleSource
                end
                object SetupPeoplePeriodsImmunityDetectableLabel: TLabel
                  Left = 256
                  Top = 170
                  Width = 117
                  Height = 17
                  Caption = 'Immunity detectable'
                end
                object SetupPeoplePeriodsImmunityHalvingLabel: TLabel
                  Left = 256
                  Top = 193
                  Width = 99
                  Height = 17
                  Hint = 'Immunity Halving'
                  Caption = 'Immunity Halving'
                end
                object SetupPeoplePeriodsImmunityDetectableText: TDBText
                  Left = 384
                  Top = 170
                  Width = 29
                  Height = 17
                  Alignment = taRightJustify
                  DataField = 'immunity_period'
                  DataSource = SimulationPeopleSource
                end
                object SetupPeoplePeriodsImmunityHalvingText: TDBText
                  Left = 384
                  Top = 193
                  Width = 29
                  Height = 17
                  Alignment = taRightJustify
                  DataField = 'halving_immunity_period'
                  DataSource = SimulationPeopleSource
                end
                object SimulationPeopleGrid: TDBGrid
                  Left = 16
                  Top = 29
                  Width = 225
                  Height = 318
                  Anchors = [akLeft, akTop, akBottom]
                  DataSource = SimulationPeopleSource
                  ReadOnly = True
                  TabOrder = 0
                  TitleFont.Charset = DEFAULT_CHARSET
                  TitleFont.Color = clWindowText
                  TitleFont.Height = -13
                  TitleFont.Name = 'Segoe UI'
                  TitleFont.Style = []
                  Columns = <
                    item
                      Expanded = False
                      FieldName = 'person_number'
                      Width = 68
                      Visible = True
                    end
                    item
                      Expanded = False
                      FieldName = 'contacts'
                      Width = 55
                      Visible = True
                    end
                    item
                      Alignment = taCenter
                      Expanded = False
                      FieldName = 'infectious'
                      Visible = True
                    end>
                end
                object DBGrid1: TDBGrid
                  Left = 256
                  Top = 216
                  Width = 270
                  Height = 131
                  Anchors = [akLeft, akTop, akRight, akBottom]
                  DataSource = PersonKnowsPersonSource
                  ReadOnly = True
                  TabOrder = 1
                  TitleFont.Charset = DEFAULT_CHARSET
                  TitleFont.Color = clWindowText
                  TitleFont.Height = -13
                  TitleFont.Name = 'Segoe UI'
                  TitleFont.Style = []
                  Columns = <
                    item
                      Expanded = False
                      FieldName = 'contact_number'
                      Width = 70
                      Visible = True
                    end
                    item
                      Expanded = False
                      FieldName = 'contact_probability'
                      Width = 85
                      Visible = True
                    end
                    item
                      Expanded = False
                      FieldName = 'contact_contacts'
                      Width = 55
                      Visible = True
                    end
                    item
                      Alignment = taCenter
                      Expanded = False
                      FieldName = 'infectious'
                      Visible = True
                    end>
                end
              end
            end
          end
        end
        object DependentData2TabSheet: TTabSheet
          Caption = 'Simulations'
          ImageIndex = 2
          object DependentData2Splitter: TSplitter
            Left = 189
            Top = 0
            Width = 8
            Height = 505
            Color = clBtnFace
            ParentColor = False
            ResizeStyle = rsUpdate
            ExplicitLeft = 197
            ExplicitHeight = 556
          end
          object DependentData2LeftBgPanel: TPanel
            AlignWithMargins = True
            Left = 4
            Top = 4
            Width = 185
            Height = 497
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 0
            Margins.Bottom = 4
            Align = alLeft
            BevelKind = bkFlat
            BevelOuter = bvNone
            ParentBackground = False
            TabOrder = 0
            object DependentData2Grid: TDBGrid
              Left = 0
              Top = 0
              Width = 181
              Height = 493
              Align = alClient
              BorderStyle = bsNone
              DataSource = SimulationsSource
              ReadOnly = True
              TabOrder = 0
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -13
              TitleFont.Name = 'Segoe UI'
              TitleFont.Style = []
              Columns = <
                item
                  Expanded = False
                  FieldName = 'name'
                  Width = 150
                  Visible = True
                end>
            end
          end
          object DependentData2RightBgPanel: TPanel
            AlignWithMargins = True
            Left = 197
            Top = 4
            Width = 560
            Height = 497
            Margins.Left = 0
            Margins.Top = 4
            Margins.Right = 5
            Margins.Bottom = 4
            Align = alClient
            BevelKind = bkFlat
            BevelOuter = bvNone
            ParentBackground = False
            TabOrder = 1
            object DependentData2DetailsScrollBox: TScrollBox
              Left = 0
              Top = 0
              Width = 556
              Height = 493
              Align = alClient
              BevelInner = bvNone
              BevelOuter = bvNone
              BorderStyle = bsNone
              TabOrder = 0
              DesignSize = (
                556
                493)
              object SimulationBox: TGroupBox
                AlignWithMargins = True
                Left = 8
                Top = 8
                Width = 540
                Height = 225
                Margins.Left = 8
                Margins.Top = 8
                Margins.Right = 8
                Margins.Bottom = 8
                Align = alTop
                Caption = 'Simulation'
                TabOrder = 0
                DesignSize = (
                  540
                  225)
                object SimulationUsedSetupLabel: TLabel
                  Left = 19
                  Top = 27
                  Width = 67
                  Height = 17
                  Caption = 'Used Setup'
                end
                object SimulationNumberOfRunsLabel: TLabel
                  Left = 175
                  Top = 184
                  Width = 96
                  Height = 17
                  Anchors = [akLeft, akBottom]
                  Caption = 'Number of Runs'
                end
                object SimulationDurationLabel: TLabel
                  Left = 19
                  Top = 184
                  Width = 50
                  Height = 17
                  Anchors = [akLeft, akBottom]
                  Caption = 'Duration'
                end
                object SimulationDescriptionLabel: TLabel
                  Left = 19
                  Top = 89
                  Width = 66
                  Height = 17
                  Caption = 'Description'
                end
                object SimulationNameLabel: TLabel
                  Left = 19
                  Top = 58
                  Width = 35
                  Height = 17
                  Caption = 'Name'
                end
                object SimulationNameEdit: TDBEdit
                  Left = 91
                  Top = 55
                  Width = 435
                  Height = 25
                  Anchors = [akLeft, akTop, akRight]
                  DataField = 'name'
                  DataSource = SimulationsSource
                  TabOrder = 0
                end
                object SimulationNumberOfRunsEdit: TDBEdit
                  Left = 277
                  Top = 181
                  Width = 84
                  Height = 25
                  Anchors = [akLeft, akBottom]
                  DataField = 'number_of_runs'
                  DataSource = SimulationsSource
                  TabOrder = 4
                end
                object SimulationDurationEdit: TDBEdit
                  Left = 91
                  Top = 181
                  Width = 62
                  Height = 25
                  Anchors = [akLeft, akBottom]
                  DataField = 'simulation_duration'
                  DataSource = SimulationsSource
                  TabOrder = 3
                end
                object SimulationDescriptionEdit: TDBMemo
                  Left = 91
                  Top = 86
                  Width = 435
                  Height = 89
                  Anchors = [akLeft, akTop, akRight, akBottom]
                  DataField = 'description'
                  DataSource = SimulationsSource
                  TabOrder = 2
                end
                object SimulationUsedSetupEdit: TDBLookupComboBox
                  Left = 91
                  Top = 24
                  Width = 435
                  Height = 25
                  Anchors = [akLeft, akTop, akRight]
                  DataField = 'simulation_setup_id'
                  DataSource = SimulationsSource
                  KeyField = 'simulation_setup_id'
                  ListField = 'name'
                  ListSource = LookupSimulationSetupSource
                  TabOrder = 1
                end
              end
              object TenMoreDaysBtn: TButton
                Left = 422
                Top = 244
                Width = 130
                Height = 25
                Anchors = [akTop, akRight]
                Caption = 'Add 10 more days'
                TabOrder = 1
                Visible = False
                OnClick = TenMoreDaysBtnClick
              end
            end
          end
        end
      end
    end
  end
  inherited ButtonsBgPanel: TPanel
    Top = 545
    Width = 1016
    ExplicitTop = 545
    ExplicitWidth = 1016
    inherited BtnBevel: TBevel
      Width = 1016
      ExplicitWidth = 1046
    end
    inherited ButtonsCardPanel: TCardPanel
      Left = 95
      OnCardChange = ButtonsCardPanelCardChange
      ExplicitLeft = 95
      inherited ViewModeCard: TCard
        inherited NewBtn: TBitBtn
          Hint = '| Starts the insert mode to create a new record.'
          OnClick = NewBtnClick
        end
        inherited EditBtn: TBitBtn
          Hint = '| Starts the edit mode to edit the selected record.'
          OnClick = EditBtnClick
        end
        inherited DeleteBtn: TBitBtn
          Hint = 
            '| Deletes the selected record. The deleted data cannot be restor' +
            'ed.'
          OnClick = DeleteBtnClick
        end
        inherited RefreshBtn: TBitBtn
          Hint = '| Reloads the data to show changes.'
          OnClick = RefreshBtnClick
        end
      end
      inherited EditModeCard: TCard
        inherited PostBtn: TBitBtn
          Hint = '| Saves the new or changed data and switches back to view mode.'
          OnClick = PostBtnClick
        end
        inherited CancelBtn: TBitBtn
          Hint = '| Discards the new or changed data and returns to view mode.'
          OnClick = CancelBtnClick
        end
      end
    end
  end
  inherited ButtonImageList: TImageList
    Left = 24
    Top = 648
  end
  object ProjectsTable: TZTable
    Connection = MainModel.DBConnection
    SortedFields = 'name'
    TableName = 'projects'
    IndexFieldNames = 'name Asc'
    Left = 168
    Top = 72
    object ProjectsTableProjectID: TStringField
      DisplayLabel = 'Project-ID'
      FieldName = 'project_id'
      Required = True
      Size = 36
    end
    object ProjectsTableName: TStringField
      DisplayLabel = 'Name'
      FieldName = 'name'
      Required = True
      Size = 100
    end
    object ProjectsTableDescription: TMemoField
      DisplayLabel = 'Description'
      FieldName = 'description'
      BlobType = ftMemo
    end
    object ProjectsTablePopulationNumber: TIntegerField
      DisplayLabel = 'Population Number'
      FieldName = 'population_number'
      Required = True
    end
    object ProjectsTableDefaultInfectiousOnStart: TIntegerField
      DisplayLabel = 'Count Infectious on Start (Default)'
      FieldName = 'default_infectious_on_start'
      Required = True
    end
    object ProjectsTableDefaultSimulationDuration: TIntegerField
      DisplayLabel = 'Count Simulation Days (Default)'
      FieldName = 'default_simulation_duration'
      Required = True
    end
    object ProjectsTableMeanContacts: TFloatField
      DisplayLabel = 'Mean Contacts'
      FieldName = 'mean_contacts'
      Required = True
    end
    object ProjectsTableDeviationContacts: TFloatField
      DisplayLabel = 'Std. Deviation Contacts'
      FieldName = 'deviation_contacts'
      Required = True
    end
    object ProjectsTableMeanContactProbability: TFloatField
      DisplayLabel = 'Mean Contact Probability'
      FieldName = 'mean_contact_probability'
      Required = True
    end
    object ProjectsTableDeviationContactProbability: TFloatField
      DisplayLabel = 'Std. Deviation Contact Probability'
      FieldName = 'deviation_contact_probability'
      Required = True
    end
    object ProjectsTableMeanSusceptibility: TFloatField
      DisplayLabel = 'Mean Susceptibility'
      FieldName = 'mean_susceptibility'
      Required = True
    end
    object ProjectsTableDeviationSusceptibility: TFloatField
      DisplayLabel = 'Std. Deviation Susceptibility'
      FieldName = 'deviation_susceptibility'
      Required = True
    end
    object ProjectsTableMeanInfectiousness: TFloatField
      DisplayLabel = 'Mean Infectiousness'
      FieldName = 'mean_infectiousness'
      Required = True
    end
    object ProjectsTableDeviationInfectiousness: TFloatField
      DisplayLabel = 'Std. Deviation Infectiousness'
      FieldName = 'deviation_infectiousness'
      Required = True
    end
    object ProjectsTableMeanInitialImmunity: TFloatField
      DisplayLabel = 'Mean Initial Immunity'
      FieldName = 'mean_initial_immunity'
      Required = True
    end
    object ProjectsTableDeviationInitialImmunity: TFloatField
      DisplayLabel = 'Std. Deviation Initial Immunity'
      FieldName = 'deviation_initial_immunity'
      Required = True
    end
    object ProjectsTableMeanMortality: TFloatField
      DisplayLabel = 'Mean Mortality'
      FieldName = 'mean_mortality'
      Required = True
    end
    object ProjectsTableDeviationMortality: TFloatField
      DisplayLabel = 'Std. Deviation Mortality'
      FieldName = 'deviation_mortality'
      Required = True
    end
    object ProjectsTableMeanInfectiousDelayPeriod: TFloatField
      DisplayLabel = 'Mean Infectious Delay Period'
      FieldName = 'mean_infectious_delay_period'
      Required = True
    end
    object ProjectsTableDeviationInfectiousDelayPeriod: TFloatField
      DisplayLabel = 'Std. Deviation Infectious Delay Period'
      FieldName = 'deviation_infectious_delay_period'
      Required = True
    end
    object ProjectsTableMeanInfectiousPeriod: TFloatField
      DisplayLabel = 'Mean Infectious Period'
      FieldName = 'mean_infectious_period'
      Required = True
    end
    object ProjectsTableDeviationInfectiousPeriod: TFloatField
      DisplayLabel = 'Std. Deviation Infectious Period'
      FieldName = 'deviation_infectious_period'
      Required = True
    end
    object ProjectsTableMeanIncubationPeriod: TFloatField
      DisplayLabel = 'Mean Incubation Period'
      FieldName = 'mean_incubation_period'
      Required = True
    end
    object ProjectsTableDeviationIncubationPeriod: TFloatField
      DisplayLabel = 'Std. Deviation Incubation Period'
      FieldName = 'deviation_incubation_period'
      Required = True
    end
    object ProjectsTableMeanDiseasePeriod: TFloatField
      DisplayLabel = 'Mean Disease Period'
      FieldName = 'mean_disease_period'
      Required = True
    end
    object ProjectsTableDeviationDiseasePeriod: TFloatField
      DisplayLabel = 'Std. Deviation Disease Period'
      FieldName = 'deviation_disease_period'
      Required = True
    end
    object ProjectsTableMeanHalvingImmunityPeriod: TFloatField
      DisplayLabel = 'Mean Halving Immunity Period'
      FieldName = 'mean_halving_immunity_period'
      Required = True
    end
    object ProjectsTableDeviationHalvingImmunityPeriod: TFloatField
      DisplayLabel = 'Std. Deviation Halving Immunity Period'
      FieldName = 'deviation_halving_immunity_period'
      Required = True
    end
    object ProjectsTableMeanImmunityPeriod: TFloatField
      DisplayLabel = 'Mean Immunity Period'
      FieldName = 'mean_immunity_period'
      Required = True
    end
    object ProjectsTableDeviationImmunityPeriod: TFloatField
      DisplayLabel = 'Std. Deviation Immunity Period'
      FieldName = 'deviation_immunity_period'
      Required = True
    end
  end
  object ProjectsSource: TDataSource
    AutoEdit = False
    DataSet = ProjectsTable
    OnDataChange = ProjectsSourceDataChange
    Left = 48
    Top = 72
  end
  object SimulationSetupsTable: TZTable
    Connection = MainModel.DBConnection
    SortedFields = 'name'
    TableName = 'simulation_setups'
    MasterFields = 'project_id'
    MasterSource = ProjectsSource
    LinkedFields = 'project_id'
    IndexFieldNames = 'name Asc'
    Left = 168
    Top = 128
    object SimulationSetupsTableSimulationSetupID: TStringField
      DisplayLabel = 'Simulation Setup ID'
      FieldName = 'simulation_setup_id'
      Required = True
      Size = 36
    end
    object SimulationSetupsTableProjectID: TStringField
      DisplayLabel = 'Project ID'
      FieldName = 'project_id'
      Required = True
      Size = 36
    end
    object SimulationSetupsTableName: TStringField
      DisplayLabel = 'Name'
      FieldName = 'name'
      Required = True
      Size = 100
    end
    object SimulationSetupsTableDefaultSimulationDuration: TIntegerField
      DisplayLabel = 'Count Simulation Days (Default)'
      FieldName = 'default_simulation_duration'
      Required = True
    end
    object SimulationSetupsTableInfectiousOnStart: TIntegerField
      DisplayLabel = 'Infectious on Start'
      FieldName = 'infectious_on_start'
      Required = True
    end
    object SimulationSetupsTableSetupState: TStringField
      DisplayLabel = 'Setup State'
      FieldName = 'setup_state'
      Required = True
      Size = 100
    end
  end
  object SimulationsQuery: TZQuery
    Connection = MainModel.DBConnection
    SortedFields = 'name'
    UpdateObject = SimulationsUpdateSQL
    SQL.Strings = (
      'SELECT'
      '  ss.project_id,'
      '  ss.name as setup_name,'
      '  s.simulation_id,'
      '  s.simulation_setup_id,'
      '  s.name,'
      '  s.description,'
      '  s.simulation_duration,'
      '  s.number_of_runs'
      'FROM simulations s'
      
        'JOIN simulation_setups ss on (ss.simulation_setup_id = s.simulat' +
        'ion_setup_id);')
    Params = <>
    MasterFields = 'project_id'
    MasterSource = ProjectsSource
    LinkedFields = 'project_id'
    IndexFieldNames = 'name Asc'
    Left = 168
    Top = 184
    object SimulationsQueryProjectID: TStringField
      DisplayLabel = 'Project ID'
      FieldName = 'project_id'
      Required = True
      Size = 36
    end
    object SimulationsQuerySetupName: TStringField
      DisplayLabel = 'Setup Name'
      FieldName = 'setup_name'
      Required = True
      Size = 100
    end
    object SimulationsQuerySimulationID: TStringField
      DisplayLabel = 'Simulation ID'
      FieldName = 'simulation_id'
      Required = True
      Size = 36
    end
    object SimulationsQuerySimulationSetupID: TStringField
      DisplayLabel = 'Setup ID'
      FieldName = 'simulation_setup_id'
      Required = True
      OnChange = SimulationsQuerySimulationSetupIDChange
      Size = 36
    end
    object SimulationsQueryName: TStringField
      DisplayLabel = 'Name'
      FieldName = 'name'
      Required = True
      Size = 100
    end
    object SimulationsQueryDescription: TMemoField
      DisplayLabel = 'Description'
      FieldName = 'description'
      BlobType = ftMemo
    end
    object SimulationsQuerySimulationDuration: TIntegerField
      DisplayLabel = 'Simulation Duration'
      FieldName = 'simulation_duration'
      Required = True
    end
    object SimulationsQueryNumberOfRuns: TIntegerField
      DisplayLabel = 'Number of Runs'
      FieldName = 'number_of_runs'
      Required = True
    end
  end
  object SimulationsUpdateSQL: TZUpdateSQL
    DeleteSQL.Strings = (
      'DELETE FROM simulations'
      'WHERE'
      '  simulations.simulation_id = :OLD_simulation_id')
    InsertSQL.Strings = (
      'INSERT INTO simulations'
      
        '  (simulation_id, simulation_setup_id, name, description, simula' +
        'tion_duration, '
      '   number_of_runs)'
      'VALUES'
      
        '  (:simulation_id, :simulation_setup_id, :name, :description, :s' +
        'imulation_duration, '
      '   :number_of_runs)')
    ModifySQL.Strings = (
      'UPDATE simulations SET'
      '  simulation_id = :simulation_id,'
      '  simulation_setup_id = :simulation_setup_id,'
      '  name = :name,'
      '  description = :description,'
      '  simulation_duration = :simulation_duration,'
      '  number_of_runs = :number_of_runs'
      'WHERE'
      '  simulations.simulation_id = :OLD_simulation_id')
    UseSequenceFieldForRefreshSQL = False
    Left = 298
    Top = 184
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'simulation_id'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'simulation_setup_id'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'name'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'description'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'simulation_duration'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'number_of_runs'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'OLD_simulation_id'
        ParamType = ptUnknown
      end>
  end
  object SimulationSetupsSource: TDataSource
    AutoEdit = False
    DataSet = SimulationSetupsTable
    Left = 48
    Top = 128
  end
  object SimulationsSource: TDataSource
    AutoEdit = False
    DataSet = SimulationsQuery
    Left = 48
    Top = 184
  end
  object SimulationPeopleTable: TZTable
    Connection = MainModel.DBConnection
    SortedFields = 'person_number'
    OnCalcFields = SimulationPeopleTableCalcFields
    TableName = 'simulation_people'
    MasterFields = 'simulation_setup_id'
    MasterSource = SimulationSetupsSource
    LinkedFields = 'simulation_setup_id'
    IndexFieldNames = 'person_number Asc'
    Left = 168
    Top = 244
    object SimulationPeopleTablePersonID: TStringField
      DisplayLabel = 'Person ID'
      FieldName = 'person_id'
      Required = True
      Size = 36
    end
    object SimulationPeopleTableSimulationSetupID: TStringField
      DisplayLabel = 'Simulation Setup ID'
      FieldName = 'simulation_setup_id'
      Required = True
      Size = 36
    end
    object SimulationPeopleTablePersonNumber: TIntegerField
      DisplayLabel = 'Person No'
      FieldName = 'person_number'
      Required = True
    end
    object SimulationPeopleTableContacts: TIntegerField
      DisplayLabel = 'Contacts'
      FieldName = 'contacts'
      Required = True
    end
    object SimulationPeopleTableInitialDayOfInfectiousness: TIntegerField
      DisplayLabel = 'Initial Day of Infectiousness'
      FieldName = 'initial_day_of_infectious'
      Required = True
    end
    object SimulationPeopleTableSusceptibility: TFloatField
      DisplayLabel = 'Susceptibility'
      FieldName = 'susceptibility'
      Required = True
      DisplayFormat = '0.0000'
    end
    object SimulationPeopleTableInfectiousness: TFloatField
      DisplayLabel = 'Infectiousness'
      FieldName = 'infectiousness'
      Required = True
      DisplayFormat = '0.0000'
    end
    object SimulationPeopleTableInfectiousDelayPeriod: TIntegerField
      DisplayLabel = 'Infectious Delay Period'
      FieldName = 'infectious_delay_period'
      Required = True
    end
    object SimulationPeopleTableInfectiousPeriod: TIntegerField
      DisplayLabel = 'Infectious Period'
      FieldName = 'infectious_period'
      Required = True
    end
    object SimulationPeopleTableIncubationPeriod: TIntegerField
      DisplayLabel = 'Incubation Period'
      FieldName = 'incubation_period'
      Required = True
    end
    object SimulationPeopleTableDiseasePeriod: TIntegerField
      DisplayLabel = 'Disease Period'
      FieldName = 'disease_period'
      Required = True
    end
    object SimulationPeopleTableHalvingImmunityPeriod: TIntegerField
      DisplayLabel = 'Halving Immunity Period'
      FieldName = 'halving_immunity_period'
      Required = True
    end
    object SimulationPeopleTableImmunityPeriod: TIntegerField
      DisplayLabel = 'Immunity Period'
      FieldName = 'immunity_period'
      Required = True
    end
    object SimulationPeopleTableInitialImmunity: TFloatField
      DisplayLabel = 'Initial Immunity'
      FieldName = 'initial_immunity'
      Required = True
      DisplayFormat = '0.0000'
    end
    object SimulationPeopleTableMortality: TFloatField
      DisplayLabel = 'Mortality'
      FieldName = 'mortality'
      Required = True
      DisplayFormat = '0.0000'
    end
    object SimulationPeopleTableInfectious: TBooleanField
      DisplayLabel = 'Infectious'
      FieldKind = fkCalculated
      FieldName = 'infectious'
      DisplayValues = 'Y;N'
      Calculated = True
    end
  end
  object SimulationPeopleSource: TDataSource
    AutoEdit = False
    DataSet = SimulationPeopleTable
    OnDataChange = SimulationPeopleSourceDataChange
    Left = 48
    Top = 244
  end
  object PersonKnowsPersonSource: TDataSource
    AutoEdit = False
    DataSet = PersonKnowsPersonQuery
    Left = 48
    Top = 300
  end
  object PersonKnowsPersonQuery: TZQuery
    Connection = MainModel.DBConnection
    SortedFields = 'contact_number'
    OnCalcFields = PersonKnowsPersonQueryCalcFields
    SQL.Strings = (
      'SELECT '
      'pkp.person_knows_person_id,'
      'pkp.person1_id as master_id,'
      'pkp.person2_id as contact_id,'
      'pkp.contact_probability,'
      'sp.person_number as contact_number,'
      'sp.contacts as contact_contacts,'
      'sp.initial_day_of_infectious as contact_day_of_infectious'
      'FROM person_knows_person pkp'
      'JOIN simulation_people sp ON (sp.person_id = pkp.person2_id)'
      'WHERE (pkp.person1_id = :person_id)'
      'UNION'
      'SELECT '
      'pkp.person_knows_person_id,'
      'pkp.person2_id as master_id,'
      'pkp.person1_id as contact_id,'
      'pkp.contact_probability,'
      'sp.person_number as contact_number,'
      'sp.contacts as contact_contacts,'
      'sp.initial_day_of_infectious as contact_day_of_infectious'
      'FROM person_knows_person pkp'
      'JOIN simulation_people sp ON (sp.person_id = pkp.person1_id)'
      'WHERE (pkp.person2_id = :person_id);')
    Params = <
      item
        DataType = ftString
        Name = 'person_id'
        ParamType = ptInput
      end>
    IndexFieldNames = 'contact_number Asc'
    Left = 168
    Top = 301
    ParamData = <
      item
        DataType = ftString
        Name = 'person_id'
        ParamType = ptInput
      end>
    object PersonKnowsPersonQueryInfectious: TBooleanField
      DisplayLabel = 'Infect.'
      FieldKind = fkCalculated
      FieldName = 'infectious'
      DisplayValues = 'Y;N'
      Calculated = True
    end
    object PersonKnowsPersonQueryperson_knows_person_id: TStringField
      DisplayLabel = 'Person knows Person ID'
      FieldName = 'person_knows_person_id'
      ReadOnly = True
      Size = 36
    end
    object PersonKnowsPersonQuerymaster_id: TStringField
      DisplayLabel = 'Master ID'
      FieldName = 'master_id'
      ReadOnly = True
      Size = 36
    end
    object PersonKnowsPersonQuerycontact_id: TStringField
      DisplayLabel = 'Contact ID'
      FieldName = 'contact_id'
      ReadOnly = True
      Size = 36
    end
    object PersonKnowsPersonQueryContactProbability: TFloatField
      DisplayLabel = 'Cont. Prob.'
      FieldName = 'contact_probability'
      ReadOnly = True
      DisplayFormat = '0.0000'
    end
    object PersonKnowsPersonQueryContactNumber: TIntegerField
      DisplayLabel = 'Contact No'
      FieldName = 'contact_number'
      ReadOnly = True
    end
    object PersonKnowsPersonQueryContactContacts: TIntegerField
      DisplayLabel = 'Contacts'
      FieldName = 'contact_contacts'
      ReadOnly = True
    end
    object PersonKnowsPersonQueryContactDayOfInfectiousness: TIntegerField
      DisplayLabel = 'Day of Ifnectiousness'
      FieldName = 'contact_day_of_infectious'
      ReadOnly = True
    end
  end
  object ProposeSetupNumberQuery: TZReadOnlyQuery
    Connection = MainModel.DBConnection
    SQL.Strings = (
      'select count(simulation_setup_id) + 1 as setup_no'
      'from simulation_setups'
      'where (project_id = :PROJECTID);')
    Params = <
      item
        DataType = ftString
        Name = 'PROJECTID'
        ParamType = ptInput
      end>
    Left = 42
    Top = 472
    ParamData = <
      item
        DataType = ftString
        Name = 'PROJECTID'
        ParamType = ptInput
      end>
    object ProposeSetupNumberQuerySetupNumber: TLargeintField
      DisplayLabel = 'Proposed Setup Number'
      FieldName = 'setup_no'
      ReadOnly = True
    end
  end
  object ProposeSimulationNumberQuery: TZReadOnlyQuery
    Connection = MainModel.DBConnection
    SQL.Strings = (
      'SELECT count(s.simulation_id) + 1 as simulation_no'
      'FROM simulations s'
      
        'JOIN simulation_setups ss on (ss.simulation_setup_id = s.simulat' +
        'ion_setup_id)'
      'WHERE (ss.project_id = :PROJECTID);')
    Params = <
      item
        DataType = ftString
        Name = 'PROJECTID'
        ParamType = ptInput
      end>
    Left = 42
    Top = 524
    ParamData = <
      item
        DataType = ftString
        Name = 'PROJECTID'
        ParamType = ptInput
      end>
    object ProposeSimulationNumberQuerySimulationNumber: TLargeintField
      DisplayLabel = 'Proposed Simulation Number'
      FieldName = 'simulation_no'
      ReadOnly = True
    end
  end
  object LookupSimulationSetupQuery: TZReadOnlyQuery
    Connection = MainModel.DBConnection
    SQL.Strings = (
      'SELECT'
      'simulation_setup_id,'
      'project_id,'
      'name,'
      'default_simulation_duration'
      'FROM simulation_setups'
      'ORDER BY name;')
    Params = <>
    MasterFields = 'project_id'
    MasterSource = ProjectsSource
    LinkedFields = 'project_id'
    Left = 168
    Top = 413
    object LookupSimulationSetupQuerysimulationSetupID: TStringField
      DisplayLabel = 'Simulation Setup ID'
      FieldName = 'simulation_setup_id'
      ReadOnly = True
      Size = 36
    end
    object LookupSimulationSetupQueryProjectID: TStringField
      DisplayLabel = 'Project ID'
      FieldName = 'project_id'
      ReadOnly = True
      Size = 36
    end
    object LookupSimulationSetupQueryName: TStringField
      DisplayLabel = 'Name'
      FieldName = 'name'
      ReadOnly = True
      Size = 100
    end
    object LookupSimulationSetupQueryDefaultSimulationDuration: TIntegerField
      DisplayLabel = 'Default Simulation Duration'
      FieldName = 'default_simulation_duration'
      ReadOnly = True
    end
  end
  object LookupSimulationSetupSource: TDataSource
    DataSet = LookupSimulationSetupQuery
    Left = 44
    Top = 413
  end
  object TasksTable: TZTable
    Connection = MainModel.DBConnection
    TableName = 'tasks'
    Left = 168
    Top = 357
    object TasksTableTaskID: TStringField
      FieldName = 'task_id'
      Required = True
      Size = 36
    end
    object TasksTableRecordID: TStringField
      FieldName = 'record_id'
      Required = True
      Size = 36
    end
    object TasksTableTaskType: TStringField
      FieldName = 'task_type'
      Required = True
      Size = 100
    end
    object TasksTableTaskPriority: TIntegerField
      FieldName = 'task_priority'
      Required = True
    end
    object TasksTableTaskStatus: TStringField
      FieldName = 'task_status'
      Required = True
      Size = 100
    end
    object TasksTableTaskOwner: TStringField
      FieldName = 'task_owner'
      Size = 100
    end
    object TasksTableDayNumber: TIntegerField
      FieldName = 'day_number'
    end
    object TasksTableRunNumber: TIntegerField
      FieldName = 'run_number'
    end
    object TasksTableCreatedOn: TDateField
      FieldName = 'created_on'
    end
    object TasksTableFirstStartOn: TDateTimeField
      FieldName = 'first_start_on'
    end
    object TasksTableLastStartOn: TDateTimeField
      FieldName = 'last_start_on'
    end
    object TasksTableCompletedOn: TDateTimeField
      FieldName = 'completed_on'
    end
    object TasksTableCalculationTime: TTimeField
      FieldName = 'calculation_time'
    end
  end
  object ProjectStartedTasksQuery: TZReadOnlyQuery
    Connection = MainModel.DBConnection
    SQL.Strings = (
      'SELECT count(task_id) as count_started_tasks FROM tasks'
      'WHERE'
      '((record_id in (SELECT simulation_setup_id'
      'FROM simulation_setups'
      'WHERE (project_id = :PROJECT_ID)))'
      'OR'
      '(record_id in (SELECT simulation_id'
      'FROM simulations s'
      
        'JOIN simulation_setups ss ON (s.simulation_setup_id = ss.simulat' +
        'ion_setup_id)'
      'WHERE (ss.project_id = :PROJECT_ID))))'
      'AND (task_status <> '#39'not started'#39'); ')
    Params = <
      item
        DataType = ftString
        Name = 'PROJECT_ID'
        ParamType = ptInput
      end>
    Left = 298
    Top = 252
    ParamData = <
      item
        DataType = ftString
        Name = 'PROJECT_ID'
        ParamType = ptInput
      end>
    object ProjectStartedTasksQueryCount: TLargeintField
      FieldName = 'count_started_tasks'
      ReadOnly = True
    end
  end
  object SetupStartedTasksQuery: TZReadOnlyQuery
    Connection = MainModel.DBConnection
    SQL.Strings = (
      'SELECT COUNT(task_id) AS count_started_tasks FROM tasks'
      'WHERE'
      '((record_id = :SETUP_ID) OR'
      
        '(record_id in (SELECT simulation_id FROM simulations WHERE (simu' +
        'lation_setup_id = :SETUP_ID))))'
      'AND (task_status <> '#39'not started'#39'); ')
    Params = <
      item
        DataType = ftString
        Name = 'SETUP_ID'
        ParamType = ptInput
      end>
    Left = 298
    Top = 308
    ParamData = <
      item
        DataType = ftString
        Name = 'SETUP_ID'
        ParamType = ptInput
      end>
    object SetupStartedTasksQueryCount: TLargeintField
      FieldName = 'count_started_tasks'
      ReadOnly = True
    end
  end
end
