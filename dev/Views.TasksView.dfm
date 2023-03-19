inherited TasksView: TTasksView
  ClientHeight = 527
  OnCreate = FormCreate
  OnHide = FormHide
  OnShow = FormShow
  ExplicitHeight = 566
  PixelsPerInch = 96
  TextHeight = 17
  inherited MainPanel: TPanel
    Height = 467
    ExplicitHeight = 467
    inherited Splitter: TSplitter
      Left = 617
      Height = 467
      ExplicitLeft = 617
      ExplicitHeight = 701
    end
    inherited LeftPanel: TPanel
      Width = 617
      Height = 467
      ExplicitWidth = 617
      ExplicitHeight = 467
      inherited MainCaptionLabel: TLabel
        Width = 613
        Caption = 'Tasks'
        ExplicitWidth = 33
      end
      inherited MainTableBgPanel: TPanel
        Width = 613
        Height = 434
        ExplicitWidth = 613
        ExplicitHeight = 434
        inherited MainGrid: TDBGrid
          Width = 609
          Height = 430
          DataSource = TasksSource
          ReadOnly = True
          Columns = <
            item
              Expanded = False
              FieldName = 'project_name'
              Width = 120
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'task_description'
              Width = 145
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'task_type'
              Width = 110
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'DayNumberCalculated'
              Title.Alignment = taCenter
              Title.Caption = 'DayNo'
              Width = 50
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'RunNumberCalculated'
              Title.Alignment = taCenter
              Title.Caption = 'RunNo'
              Width = 50
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'task_status'
              Width = 95
              Visible = True
            end>
        end
      end
    end
    inherited RightPanel: TPanel
      Left = 625
      Width = 333
      Height = 467
      ExplicitLeft = 625
      ExplicitWidth = 333
      ExplicitHeight = 467
      inherited PageControl: TPageControl
        Width = 329
        Height = 459
        ExplicitWidth = 329
        ExplicitHeight = 459
        inherited MainDetailsTabSheet: TTabSheet
          Caption = 'Details of selected Task'
          ExplicitWidth = 321
          ExplicitHeight = 427
          inherited MainDetailsTabSheetBgPanel: TPanel
            Width = 313
            Height = 419
            ExplicitWidth = 313
            ExplicitHeight = 419
            inherited MainDetailsScrollBox: TScrollBox
              Width = 309
              Height = 415
              ExplicitWidth = 309
              ExplicitHeight = 415
              object TaskPropertiesBox: TGroupBox
                AlignWithMargins = True
                Left = 8
                Top = 8
                Width = 293
                Height = 177
                Margins.Left = 8
                Margins.Top = 8
                Margins.Right = 8
                Margins.Bottom = 8
                Align = alTop
                Caption = 'Task Properties'
                TabOrder = 0
                DesignSize = (
                  293
                  177)
                object TasksTaskTypeText: TDBText
                  Left = 123
                  Top = 47
                  Width = 106
                  Height = 17
                  Anchors = [akLeft, akTop, akRight]
                  AutoSize = True
                  DataField = 'task_type'
                  DataSource = TasksSource
                end
                object TasksTaskTypeLabel: TLabel
                  Left = 19
                  Top = 47
                  Width = 27
                  Height = 17
                  Caption = 'Type'
                end
                object TasksProjectNameLabel: TLabel
                  Left = 19
                  Top = 24
                  Width = 40
                  Height = 17
                  Caption = 'Project'
                end
                object TasksProjectNameText: TDBText
                  Left = 123
                  Top = 24
                  Width = 129
                  Height = 17
                  Anchors = [akLeft, akTop, akRight]
                  AutoSize = True
                  DataField = 'project_name'
                  DataSource = TasksSource
                end
                object TasksTaskDescrptionLabel: TLabel
                  Left = 19
                  Top = 70
                  Width = 66
                  Height = 17
                  Caption = 'Description'
                end
                object TasksTaskDescrptionText: TDBText
                  Left = 123
                  Top = 70
                  Width = 142
                  Height = 17
                  Anchors = [akLeft, akTop, akRight]
                  AutoSize = True
                  DataField = 'task_description'
                  DataSource = TasksSource
                end
                object TasksDayNumberLabel: TLabel
                  Left = 19
                  Top = 93
                  Width = 74
                  Height = 17
                  Caption = 'Day Number'
                end
                object TasksDayNumberText: TDBText
                  Left = 123
                  Top = 93
                  Width = 124
                  Height = 17
                  Anchors = [akLeft, akTop, akRight]
                  AutoSize = True
                  DataField = 'DayNumberCalculated'
                  DataSource = TasksSource
                end
                object TasksRunNumberLabel: TLabel
                  Left = 19
                  Top = 116
                  Width = 74
                  Height = 17
                  Caption = 'Run Number'
                end
                object TasksRunNumberText: TDBText
                  Left = 123
                  Top = 116
                  Width = 124
                  Height = 17
                  Anchors = [akLeft, akTop, akRight]
                  AutoSize = True
                  DataField = 'RunNumberCalculated'
                  DataSource = TasksSource
                end
                object TasksCreatedOnLabel: TLabel
                  Left = 19
                  Top = 139
                  Width = 65
                  Height = 17
                  Caption = 'Created on'
                end
                object TasksCreatedOnText: TDBText
                  Left = 123
                  Top = 139
                  Width = 117
                  Height = 17
                  Anchors = [akLeft, akTop, akRight]
                  AutoSize = True
                  DataField = 'created_on'
                  DataSource = TasksSource
                end
              end
              object TaskProcessingBox: TGroupBox
                AlignWithMargins = True
                Left = 8
                Top = 201
                Width = 293
                Height = 176
                Margins.Left = 8
                Margins.Top = 8
                Margins.Right = 8
                Margins.Bottom = 8
                Align = alTop
                Caption = 'Processing Status'
                TabOrder = 1
                DesignSize = (
                  293
                  176)
                object TasksTaskStatusLabel: TLabel
                  Left = 19
                  Top = 24
                  Width = 35
                  Height = 17
                  Caption = 'Status'
                end
                object TasksTaskOwnerLabel: TLabel
                  Left = 19
                  Top = 47
                  Width = 38
                  Height = 17
                  Caption = 'Owner'
                end
                object TasksFirstStartOnLabel: TLabel
                  Left = 19
                  Top = 70
                  Width = 76
                  Height = 17
                  Caption = 'First Start On'
                end
                object TasksLastStartOnLabel: TLabel
                  Left = 19
                  Top = 93
                  Width = 75
                  Height = 17
                  Caption = 'Last Start On'
                end
                object TasksCompletedOnLabel: TLabel
                  Left = 19
                  Top = 116
                  Width = 85
                  Height = 17
                  Caption = 'Completed On'
                end
                object TasksCalculationTimeLabel: TLabel
                  Left = 19
                  Top = 139
                  Width = 95
                  Height = 17
                  Caption = 'Calculation Time'
                end
                object TasksCalculationTimeText: TDBText
                  Left = 123
                  Top = 139
                  Width = 145
                  Height = 17
                  Anchors = [akLeft, akTop, akRight]
                  AutoSize = True
                  DataField = 'CalculationTimeCalculated'
                  DataSource = TasksSource
                end
                object TasksCompletedOnText: TDBText
                  Left = 123
                  Top = 116
                  Width = 135
                  Height = 17
                  Anchors = [akLeft, akTop, akRight]
                  AutoSize = True
                  DataField = 'CompletedCalculated'
                  DataSource = TasksSource
                end
                object TasksLastStartOnText: TDBText
                  Left = 123
                  Top = 93
                  Width = 121
                  Height = 17
                  Anchors = [akLeft, akTop, akRight]
                  AutoSize = True
                  DataField = 'LastStartCalculated'
                  DataSource = TasksSource
                end
                object TasksFirstStartOnText: TDBText
                  Left = 123
                  Top = 70
                  Width = 122
                  Height = 17
                  Anchors = [akLeft, akTop, akRight]
                  AutoSize = True
                  DataField = 'FirstStartCalculated'
                  DataSource = TasksSource
                end
                object TasksTaskOwnerText: TDBText
                  Left = 123
                  Top = 47
                  Width = 117
                  Height = 17
                  Anchors = [akLeft, akTop, akRight]
                  AutoSize = True
                  DataField = 'OwnerCalculated'
                  DataSource = TasksSource
                end
                object TasksTaskStatusText: TDBText
                  Left = 123
                  Top = 24
                  Width = 114
                  Height = 17
                  Anchors = [akLeft, akTop, akRight]
                  AutoSize = True
                  DataField = 'task_status'
                  DataSource = TasksSource
                end
              end
            end
          end
        end
      end
    end
  end
  inherited ButtonsBgPanel: TPanel
    Top = 467
    ExplicitTop = 467
    inherited ButtonsCardPanel: TCardPanel
      Width = 617
      Caption = '^'
      ExplicitWidth = 617
      inherited ViewModeCard: TCard
        Width = 617
        ExplicitWidth = 617
        inherited NewBtn: TBitBtn
          Width = 162
          Hint = '|Executes all pending steps of the selected project.'
          Caption = 'Execute all Steps'
          ImageIndex = 17
          ImageName = ''
          OnClick = NewBtnClick
          ExplicitWidth = 162
        end
        inherited EditBtn: TBitBtn
          Left = 279
          Width = 162
          Hint = '|Executes the next 10 steps of the selected project.'
          Caption = 'Next 10 Steps'
          ImageIndex = 16
          OnClick = EditBtnClick
          ExplicitLeft = 279
          ExplicitWidth = 162
        end
        inherited DeleteBtn: TBitBtn
          Left = 447
          Width = 162
          Hint = '|Executes the next step of the selected project.'
          Caption = 'Execute next Step'
          ImageIndex = 10
          OnClick = DeleteBtnClick
          ExplicitLeft = 447
          ExplicitWidth = 162
        end
        inherited RefreshBtn: TBitBtn
          OnClick = RefreshBtnClick
        end
      end
      inherited EditModeCard: TCard
        Width = 617
        ExplicitWidth = 617
      end
    end
  end
  inherited ButtonImageList: TImageList
    Left = 216
    Top = 104
  end
  object TasksSource: TDataSource
    AutoEdit = False
    DataSet = TasksQuery
    Left = 52
    Top = 101
  end
  object TasksQuery: TZReadOnlyQuery
    Connection = MainModel.DBConnection
    OnCalcFields = TasksQueryCalcFields
    Filter = 'task_status <> '#39'finished'#39
    SQL.Strings = (
      'SELECT *'
      'FROM view_tasks'
      
        'ORDER BY project_name, task_description, task_priority DESC, day' +
        '_number, run_number;')
    Params = <>
    Left = 140
    Top = 101
    object TasksQueryTaskID: TStringField
      DisplayLabel = 'Task ID'
      FieldName = 'task_id'
      ReadOnly = True
      Size = 36
    end
    object TasksQueryRecordID: TStringField
      DisplayLabel = 'Record ID'
      FieldName = 'record_id'
      ReadOnly = True
      Size = 36
    end
    object TasksQueryTaskType: TStringField
      DisplayLabel = 'Type'
      FieldName = 'task_type'
      ReadOnly = True
      Size = 100
    end
    object TasksQueryTaskPriority: TIntegerField
      DisplayLabel = 'Priority'
      FieldName = 'task_priority'
      ReadOnly = True
    end
    object TasksQueryTaskOwner: TStringField
      DisplayLabel = 'Owner'
      FieldName = 'task_owner'
      ReadOnly = True
      Size = 100
    end
    object TasksQueryTaskStatus: TStringField
      DisplayLabel = 'Status'
      FieldName = 'task_status'
      ReadOnly = True
      Size = 100
    end
    object TasksQueryProjectName: TStringField
      DisplayLabel = 'Project'
      FieldName = 'project_name'
      ReadOnly = True
      Size = 100
    end
    object TasksQueryTaskDescription: TStringField
      DisplayLabel = 'Description'
      FieldName = 'task_description'
      ReadOnly = True
      Size = 100
    end
    object TasksQueryDayNumber: TIntegerField
      DisplayLabel = 'Day Number'
      FieldName = 'day_number'
      ReadOnly = True
    end
    object TasksQueryRunNumber: TIntegerField
      DisplayLabel = 'Run Number'
      FieldName = 'run_number'
      ReadOnly = True
    end
    object TasksQueryCreatedOn: TDateField
      FieldName = 'created_on'
      ReadOnly = True
    end
    object TasksQueryFirstStartOn: TDateTimeField
      DisplayLabel = 'First Start'
      FieldName = 'first_start_on'
      ReadOnly = True
      DisplayFormat = 'ddddd tt'
    end
    object TasksQueryLastStartOn: TDateTimeField
      DisplayLabel = 'Last Start'
      FieldName = 'last_start_on'
      ReadOnly = True
      DisplayFormat = 'ddddd tt'
    end
    object TasksQueryCompletedOn: TDateTimeField
      DisplayLabel = 'Completed'
      FieldName = 'completed_on'
      ReadOnly = True
      DisplayFormat = 'ddddd tt'
    end
    object TasksQueryCalculationTime: TTimeField
      DisplayLabel = 'Calculation Time'
      FieldName = 'calculation_time'
      ReadOnly = True
    end
    object TasksQueryOwnerCalculated: TStringField
      FieldKind = fkCalculated
      FieldName = 'OwnerCalculated'
      Calculated = True
    end
    object TasksQueryDayNumberCalculated: TStringField
      FieldKind = fkCalculated
      FieldName = 'DayNumberCalculated'
      Calculated = True
    end
    object TasksQueryRunNumberCalculated: TStringField
      FieldKind = fkCalculated
      FieldName = 'RunNumberCalculated'
      Calculated = True
    end
    object TasksQueryFirstStartCalculated: TStringField
      FieldKind = fkCalculated
      FieldName = 'FirstStartCalculated'
      Calculated = True
    end
    object TasksQueryLastStartCalculated: TStringField
      FieldKind = fkCalculated
      FieldName = 'LastStartCalculated'
      Calculated = True
    end
    object TasksQueryCompletedCalculated: TStringField
      FieldKind = fkCalculated
      FieldName = 'CompletedCalculated'
      Calculated = True
    end
    object TasksQueryCalculationTimeCalculated: TStringField
      FieldKind = fkCalculated
      FieldName = 'CalculationTimeCalculated'
      Calculated = True
    end
  end
  object UnfinishedTasksQuery: TZReadOnlyQuery
    Connection = MainModel.DBConnection
    SQL.Strings = (
      'SELECT'
      's.simulation_id,'
      's.simulation_setup_id,'
      'vt.*'
      'FROM view_tasks vt'
      
        'LEFT OUTER JOIN simulations s ON (vt.record_id = s.simulation_id' +
        ')'
      'WHERE'
      '(vt.project_name = :PROJECT_NAME) AND'
      '(vt.task_status in ('#39'not started'#39', '#39'queued'#39'))'
      
        'ORDER BY vt.project_name, vt.task_description, vt.task_priority ' +
        'DESC, vt.day_number, vt.run_number;')
    Params = <
      item
        DataType = ftString
        Name = 'PROJECT_NAME'
        ParamType = ptInputOutput
      end>
    Left = 164
    Top = 253
    ParamData = <
      item
        DataType = ftString
        Name = 'PROJECT_NAME'
        ParamType = ptInputOutput
      end>
    object UnfinishedTasksQuerySimulationID: TStringField
      FieldName = 'simulation_id'
      ReadOnly = True
      Size = 36
    end
    object UnfinishedTasksQuerySimulationSetupID: TStringField
      FieldName = 'simulation_setup_id'
      ReadOnly = True
      Size = 36
    end
    object UnfinishedTasksQueryTaskID: TStringField
      FieldName = 'task_id'
      ReadOnly = True
      Size = 36
    end
    object UnfinishedTasksQueryRecordID: TStringField
      FieldName = 'record_id'
      ReadOnly = True
      Size = 36
    end
    object UnfinishedTasksQueryTaskType: TStringField
      FieldName = 'task_type'
      ReadOnly = True
      Size = 100
    end
    object UnfinishedTasksQueryTaskPriority: TIntegerField
      FieldName = 'task_priority'
      ReadOnly = True
    end
    object UnfinishedTasksQueryTaskStatus: TStringField
      FieldName = 'task_status'
      ReadOnly = True
      Size = 100
    end
    object UnfinishedTasksQueryTaskOwner: TStringField
      FieldName = 'task_owner'
      ReadOnly = True
      Size = 100
    end
    object UnfinishedTasksQueryDayNumber: TIntegerField
      FieldName = 'day_number'
      ReadOnly = True
    end
    object UnfinishedTasksQueryRunNumber: TIntegerField
      FieldName = 'run_number'
      ReadOnly = True
    end
    object UnfinishedTasksQueryCreatedOn: TDateField
      FieldName = 'created_on'
      ReadOnly = True
    end
    object UnfinishedTasksQueryFirstStartOn: TDateTimeField
      FieldName = 'first_start_on'
      ReadOnly = True
    end
    object UnfinishedTasksQueryLastStartOn: TDateTimeField
      FieldName = 'last_start_on'
      ReadOnly = True
    end
    object UnfinishedTasksQueryCompletedOn: TDateTimeField
      FieldName = 'completed_on'
      ReadOnly = True
    end
    object UnfinishedTasksQueryCalculationTime: TTimeField
      FieldName = 'calculation_time'
      ReadOnly = True
    end
    object UnfinishedTasksQueryProjectName: TStringField
      FieldName = 'project_name'
      ReadOnly = True
      Size = 100
    end
    object UnfinishedTasksQueryTaskDescription: TStringField
      FieldName = 'task_description'
      ReadOnly = True
      Size = 100
    end
  end
end
