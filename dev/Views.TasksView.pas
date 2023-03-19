unit Views.TasksView;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.ImageList,
  Data.DB,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ImgList,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.WinXPanels,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  Views.CustomDBModuleView,
  Models.MainModel,
  ZAbstractRODataset,
  ZDataset, Vcl.DBCtrls;

type
  TTasksView = class(TCustomDBModuleView)
    TasksSource: TDataSource;
    TasksQuery: TZReadOnlyQuery;
    TasksQueryTaskID: TStringField;
    TasksQueryTaskType: TStringField;
    TasksQueryRecordID: TStringField;
    TasksQueryTaskStatus: TStringField;
    TasksQueryTaskOwner: TStringField;
    TasksQueryFirstStartOn: TDateTimeField;
    TasksQueryLastStartOn: TDateTimeField;
    TasksQueryCompletedOn: TDateTimeField;
    TasksQueryCalculationTime: TTimeField;
    TasksQueryProjectName: TStringField;
    TasksQueryTaskDescription: TStringField;
    TasksQueryTaskPriority: TIntegerField;
    TasksQueryDayNumber: TIntegerField;
    TasksQueryRunNumber: TIntegerField;
    TasksQueryCreatedOn: TDateField;
    TasksQueryOwnerCalculated: TStringField;
    TasksQueryDayNumberCalculated: TStringField;
    TasksQueryRunNumberCalculated: TStringField;
    TaskPropertiesBox: TGroupBox;
    TaskProcessingBox: TGroupBox;
    TasksTaskTypeText: TDBText;
    TasksTaskTypeLabel: TLabel;
    TasksProjectNameLabel: TLabel;
    TasksProjectNameText: TDBText;
    TasksTaskDescrptionLabel: TLabel;
    TasksTaskDescrptionText: TDBText;
    TasksDayNumberLabel: TLabel;
    TasksDayNumberText: TDBText;
    TasksRunNumberLabel: TLabel;
    TasksRunNumberText: TDBText;
    TasksCreatedOnLabel: TLabel;
    TasksCreatedOnText: TDBText;
    TasksTaskStatusLabel: TLabel;
    TasksTaskOwnerLabel: TLabel;
    TasksFirstStartOnLabel: TLabel;
    TasksLastStartOnLabel: TLabel;
    TasksCompletedOnLabel: TLabel;
    TasksCalculationTimeLabel: TLabel;
    TasksCalculationTimeText: TDBText;
    TasksCompletedOnText: TDBText;
    TasksLastStartOnText: TDBText;
    TasksFirstStartOnText: TDBText;
    TasksTaskOwnerText: TDBText;
    TasksTaskStatusText: TDBText;
    TasksQueryFirstStartCalculated: TStringField;
    TasksQueryLastStartCalculated: TStringField;
    TasksQueryCompletedCalculated: TStringField;
    TasksQueryCalculationTimeCalculated: TStringField;
    UnfinishedTasksQuery: TZReadOnlyQuery;
    UnfinishedTasksQuerySimulationID: TStringField;
    UnfinishedTasksQuerySimulationSetupID: TStringField;
    UnfinishedTasksQueryTaskID: TStringField;
    UnfinishedTasksQueryRecordID: TStringField;
    UnfinishedTasksQueryTaskType: TStringField;
    UnfinishedTasksQueryTaskPriority: TIntegerField;
    UnfinishedTasksQueryTaskStatus: TStringField;
    UnfinishedTasksQueryTaskOwner: TStringField;
    UnfinishedTasksQueryDayNumber: TIntegerField;
    UnfinishedTasksQueryRunNumber: TIntegerField;
    UnfinishedTasksQueryCreatedOn: TDateField;
    UnfinishedTasksQueryFirstStartOn: TDateTimeField;
    UnfinishedTasksQueryLastStartOn: TDateTimeField;
    UnfinishedTasksQueryCompletedOn: TDateTimeField;
    UnfinishedTasksQueryCalculationTime: TTimeField;
    UnfinishedTasksQueryProjectName: TStringField;
    UnfinishedTasksQueryTaskDescription: TStringField;
    procedure DeleteBtnClick(Sender: TObject);
    procedure EditBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure NewBtnClick(Sender: TObject);
    procedure RefreshBtnClick(Sender: TObject);
    procedure TasksQueryCalcFields(DataSet: TDataSet);
  private
    { Private-Deklarationen }
    function GetProjectsRecordCount: Integer;
    procedure ExecSetupInitTask(ARecordID: String);
    procedure ExecSimulationInitTask(ARecordID: String);
    procedure ExecDayZeoInitTask(ARecordID: String);
    procedure ExecDayRunTask(ARecordID: String; ADayNo: Integer);
    procedure ExecDayEvalTask(ARecordID: String; ADayNo: Integer);
  protected
    function DataSetEmpty: Boolean; override;
    function FormatModuleInfo: String; override;
    function ValidateData: Boolean; override;
    property TasksRecordCount: Integer read GetProjectsRecordCount;
  public
    { Public-Deklarationen }
  end;

var
  TasksView: TTasksView;

implementation

uses
  System.Math,
  System.StrUtils,
  Dialogs.WaitingDialog,
  Dialogs.InformationDialog,
  ViewModels.SimulationSetup,
  ViewModels.Simulation,
  Settings.Constants;

{$R *.dfm}

function TTasksView.DataSetEmpty: Boolean;
begin
  Result := (TasksRecordCount = 0)
end;

procedure TTasksView.DeleteBtnClick(Sender: TObject);
begin
  inherited;

  UnfinishedTasksQuery.Open;
  UnfinishedTasksQuery.ParamByName('PROJECT_NAME').AsString := TasksQueryProjectName.AsString;
  UnfinishedTasksQuery.Refresh;

  if (UnfinishedTasksQuery.RecordCount = 0) then
  begin
    TInformationDialog.ShowDlg('There is no task to execute.');
    Exit;
  end;

  UnfinishedTasksQuery.First;
  var TaskType: String := UnfinishedTasksQueryTaskType.AsString;

  if TaskType = TaskTypeSetupInitialization then
  begin
    var WaitingDlg := TWaitingDialog.ShowDlg(
          Format('The setup %s of the project %s is initialized. Please wait...',
            [UnfinishedTasksQueryTaskDescription.AsString,
            UnfinishedTasksQueryProjectName.AsString]));
    try
      ExecSetupInitTask(UnfinishedTasksQueryRecordID.AsString);
    finally
      WaitingDlg.HideDlg;
    end;
  end
  else if TaskType = TaskTypeSimulationInitialization then
  begin
    var WaitingDlg := TWaitingDialog.ShowDlg(
          Format('The simulation %s of the project %s is initialized. Please wait...',
            [UnfinishedTasksQueryTaskDescription.AsString,
            UnfinishedTasksQueryProjectName.AsString]));
    try
      ExecSimulationInitTask(UnfinishedTasksQueryRecordID.AsString);
    finally
      WaitingDlg.HideDlg;
    end;
  end
  else if TaskType = TaskTypeRunInitialization then
  begin
    var WaitingDlg := TWaitingDialog.ShowDlg(
        Format('The day %d of the project "%s", simulation "%s" will be executed and evaluated. Please wait...',
          [UnfinishedTasksQueryDayNumber.AsInteger,
          UnfinishedTasksQueryProjectName.AsString,
          UnfinishedTasksQueryTaskDescription.AsString]));
    try
      ExecDayZeoInitTask(UnfinishedTasksQueryRecordID.AsString);
    finally
      WaitingDlg.HideDlg;
    end;
  end
  else if TaskType = TaskTypeRunExecution then
  begin
    var WaitingDlg := TWaitingDialog.ShowDlg(
        Format('The day %d of the project "%s", simulation "%s" will be executed and evaluated. Please wait...',
          [UnfinishedTasksQueryDayNumber.AsInteger,
          UnfinishedTasksQueryProjectName.AsString,
          UnfinishedTasksQueryTaskDescription.AsString]));
    try
      ExecDayRunTask(UnfinishedTasksQueryRecordID.AsString, UnfinishedTasksQueryDayNumber.AsInteger);
    finally
      WaitingDlg.HideDlg;
    end;
  end
  else if TaskType = TaskTypeDayEvaluation then
  begin
    var WaitingDlg := TWaitingDialog.ShowDlg(
        Format('The day %d of the project "%s", simulation "%s" will be evaluated. Please wait...',
          [UnfinishedTasksQueryDayNumber.AsInteger,
          UnfinishedTasksQueryProjectName.AsString,
          UnfinishedTasksQueryTaskDescription.AsString]));
    try
      ExecDayEvalTask(UnfinishedTasksQueryRecordID.AsString, UnfinishedTasksQueryDayNumber.AsInteger);
    finally
      WaitingDlg.HideDlg;
    end;
  end;

  UnfinishedTasksQuery.Close;
  TasksQuery.Refresh;
end;

procedure TTasksView.EditBtnClick(Sender: TObject);
begin
  inherited;

  UnfinishedTasksQuery.Open;
  UnfinishedTasksQuery.ParamByName('PROJECT_NAME').AsString := TasksQueryProjectName.AsString;
  UnfinishedTasksQuery.Refresh;

  if (UnfinishedTasksQuery.RecordCount = 0) then
  begin
    TInformationDialog.ShowDlg('There is no task to execute.');
    Exit;
  end;

  var WaitingDlg := TWaitingDialog.ShowDlg(
        Format('Executing the next ten Steps of the project %s. Please wait...',
          [UnfinishedTasksQueryProjectName.AsString]));
  try
    var StepNo: Integer := 1;
    var TasksAvailable: Boolean;
    var TaskType: String;

    repeat
      UnfinishedTasksQuery.Refresh;
      TasksAvailable := (UnfinishedTasksQuery.RecordCount > 0);

      if TasksAvailable then
      begin
        UnfinishedTasksQuery.First;
        TaskType := UnfinishedTasksQueryTaskType.AsString;

        if TaskType = TaskTypeSetupInitialization then
        begin
          WaitingDlg.UpdateMsg(Format('The setup %s of the project %s is initialized. Please wait...',
                  [UnfinishedTasksQueryTaskDescription.AsString,
                  UnfinishedTasksQueryProjectName.AsString]));
          ExecSetupInitTask(UnfinishedTasksQueryRecordID.AsString);
        end
        else if TaskType = TaskTypeSimulationInitialization then
        begin
          WaitingDlg.UpdateMsg(Format('The simulation %s of the project %s is initialized. Please wait...',
                  [UnfinishedTasksQueryTaskDescription.AsString,
                  UnfinishedTasksQueryProjectName.AsString]));
          ExecSimulationInitTask(UnfinishedTasksQueryRecordID.AsString);
        end
        else if TaskType = TaskTypeRunInitialization then
        begin
          WaitingDlg.UpdateMsg(Format('The day %d of the project "%s", simulation "%s" will be executed and evaluated. Please wait...',
                [UnfinishedTasksQueryDayNumber.AsInteger,
                UnfinishedTasksQueryProjectName.AsString,
                UnfinishedTasksQueryTaskDescription.AsString]));
          ExecDayZeoInitTask(UnfinishedTasksQueryRecordID.AsString);
        end
        else if TaskType = TaskTypeRunExecution then
        begin
          WaitingDlg.UpdateMsg(Format('The day %d of the project "%s", simulation "%s" will be executed and evaluated. Please wait...',
                [UnfinishedTasksQueryDayNumber.AsInteger,
                UnfinishedTasksQueryProjectName.AsString,
                UnfinishedTasksQueryTaskDescription.AsString]));
          ExecDayRunTask(UnfinishedTasksQueryRecordID.AsString, UnfinishedTasksQueryDayNumber.AsInteger);
        end
        else if TaskType = TaskTypeDayEvaluation then
        begin
          WaitingDlg.UpdateMsg(Format('The day %d of the project "%s", simulation "%s" will be evaluated. Please wait...',
                [UnfinishedTasksQueryDayNumber.AsInteger,
                UnfinishedTasksQueryProjectName.AsString,
                UnfinishedTasksQueryTaskDescription.AsString]));
          ExecDayEvalTask(UnfinishedTasksQueryRecordID.AsString, UnfinishedTasksQueryDayNumber.AsInteger);
        end;
        TasksQuery.Refresh;
      end;

      StepNo := StepNo + 1;
    until ((StepNo > 10) or not(TasksAvailable));
  finally
    WaitingDlg.HideDlg;
  end;

  UnfinishedTasksQuery.Close;
end;

procedure TTasksView.ExecSetupInitTask(ARecordID: String);
begin
  TSimulationSetup.Initialize(ARecordID);
end;

procedure TTasksView.ExecSimulationInitTask(ARecordID: String);
begin
  TSimulation.InitializeSimulation(ARecordID);
  TSimulation.InitializeDayZero(ARecordID);
  TSimulation.EvaluateDay(ARecordID, 0);
end;

procedure TTasksView.ExecDayEvalTask(ARecordID: String; ADayNo: Integer);
begin
  TSimulation.EvaluateDay(ARecordID, ADayNo);
end;

procedure TTasksView.ExecDayRunTask(ARecordID: String; ADayNo: Integer);
begin
  TSimulation.ExecuteDay(ARecordID, ADayNo);
  TSimulation.EvaluateDay(ARecordID, ADayNo);
end;

procedure TTasksView.ExecDayZeoInitTask(ARecordID: String);
begin
  TSimulation.InitializeDayZero(ARecordID);
  TSimulation.EvaluateDay(ARecordID, 0);
end;

function TTasksView.FormatModuleInfo: String;
begin
  Result := Format('Count of Tasks: %d', [TasksRecordCount]);
end;

procedure TTasksView.FormCreate(Sender: TObject);
begin
  inherited;

  MessagesEnabled := false;
end;

procedure TTasksView.FormHide(Sender: TObject);
begin
  inherited;
  MessagesEnabled := false;

  // Closing the data sources.
  TasksQuery.Close;
end;

procedure TTasksView.FormShow(Sender: TObject);
begin
  inherited;

  TasksQuery.Filtered := MainModel.Settings.TasksHideFinished;

  // Opening the data sources.
  TasksQuery.Open;

  // Send view info to main view.
  SendModuleInfoChanged(FormatModuleInfo);
end;

function TTasksView.GetProjectsRecordCount: Integer;
begin
  Result := IfThen(TasksQuery.Active, TasksQuery.RecordCount, 0);
end;

procedure TTasksView.NewBtnClick(Sender: TObject);
begin
  inherited;
  UnfinishedTasksQuery.Open;
  UnfinishedTasksQuery.ParamByName('PROJECT_NAME').AsString := TasksQueryProjectName.AsString;
  UnfinishedTasksQuery.Refresh;

  if (UnfinishedTasksQuery.RecordCount = 0) then
  begin
    TInformationDialog.ShowDlg('There is no task to execute.');
    Exit;
  end;

  var WaitingDlg := TWaitingDialog.ShowDlg(
        Format('Executing the next ten Steps of the project %s. Please wait...',
          [UnfinishedTasksQueryProjectName.AsString]));
  try
    var TasksAvailable: Boolean;
    var TaskType: String;

    repeat
      UnfinishedTasksQuery.Refresh;
      TasksAvailable := (UnfinishedTasksQuery.RecordCount > 0);

      if TasksAvailable then
      begin
        UnfinishedTasksQuery.First;
        TaskType := UnfinishedTasksQueryTaskType.AsString;

        if TaskType = TaskTypeSetupInitialization then
        begin
          WaitingDlg.UpdateMsg(Format('The setup %s of the project %s is initialized. Please wait...',
                  [UnfinishedTasksQueryTaskDescription.AsString,
                  UnfinishedTasksQueryProjectName.AsString]));
          ExecSetupInitTask(UnfinishedTasksQueryRecordID.AsString);
        end
        else if TaskType = TaskTypeSimulationInitialization then
        begin
          WaitingDlg.UpdateMsg(Format('The simulation %s of the project %s is initialized. Please wait...',
                  [UnfinishedTasksQueryTaskDescription.AsString,
                  UnfinishedTasksQueryProjectName.AsString]));
          ExecSimulationInitTask(UnfinishedTasksQueryRecordID.AsString);
        end
        else if TaskType = TaskTypeRunInitialization then
        begin
          WaitingDlg.UpdateMsg(Format('The day %d of the project "%s", simulation "%s" will be executed and evaluated. Please wait...',
                [UnfinishedTasksQueryDayNumber.AsInteger,
                UnfinishedTasksQueryProjectName.AsString,
                UnfinishedTasksQueryTaskDescription.AsString]));
          ExecDayZeoInitTask(UnfinishedTasksQueryRecordID.AsString);
        end
        else if TaskType = TaskTypeRunExecution then
        begin
          WaitingDlg.UpdateMsg(Format('The day %d of the project "%s", simulation "%s" will be executed and evaluated. Please wait...',
                [UnfinishedTasksQueryDayNumber.AsInteger,
                UnfinishedTasksQueryProjectName.AsString,
                UnfinishedTasksQueryTaskDescription.AsString]));
          ExecDayRunTask(UnfinishedTasksQueryRecordID.AsString, UnfinishedTasksQueryDayNumber.AsInteger);
        end
        else if TaskType = TaskTypeDayEvaluation then
        begin
          WaitingDlg.UpdateMsg(Format('The day %d of the project "%s", simulation "%s" will be evaluated. Please wait...',
                [UnfinishedTasksQueryDayNumber.AsInteger,
                UnfinishedTasksQueryProjectName.AsString,
                UnfinishedTasksQueryTaskDescription.AsString]));
          ExecDayEvalTask(UnfinishedTasksQueryRecordID.AsString, UnfinishedTasksQueryDayNumber.AsInteger);
        end;
        TasksQuery.Refresh;
      end;
    until not(TasksAvailable);
  finally
    WaitingDlg.HideDlg;
  end;

  UnfinishedTasksQuery.Close;
end;

procedure TTasksView.RefreshBtnClick(Sender: TObject);
begin
  inherited;
  TasksQuery.Refresh;
end;

procedure TTasksView.TasksQueryCalcFields(DataSet: TDataSet);
begin
  inherited;
  TasksQueryOwnerCalculated.AsString := IfThen(TasksQueryTaskOwner.IsNull, 'n/a', TasksQueryTaskOwner.AsString);
  TasksQueryDayNumberCalculated.AsString := IfThen(TasksQueryDayNumber.IsNull, 'n/a', IntToStr(TasksQueryDayNumber.AsInteger));
  TasksQueryRunNumberCalculated.AsString := IfThen(TasksQueryRunNumber.IsNull, 'n/a', IntToStr(TasksQueryRunNumber.AsInteger));
  var DateTimeStr: String;
  if TasksQueryFirstStartOn.IsNull then
    TasksQueryFirstStartCalculated.AsString := 'never started'
  else
  begin
    DateTimeToString(DateTimeStr, TasksQueryFirstStartOn.DisplayFormat, TasksQueryFirstStartOn.AsDateTime);
    TasksQueryFirstStartCalculated.AsString := DateTimeStr;
  end;
  if TasksQueryLastStartOn.IsNull then
    TasksQueryLastStartCalculated.AsString := 'never started'
  else
  begin
    DateTimeToString(DateTimeStr, TasksQueryLastStartOn.DisplayFormat, TasksQueryLastStartOn.AsDateTime);
    TasksQueryLastStartCalculated.AsString := DateTimeStr;
  end;
  if TasksQueryCompletedOn.IsNull then
    TasksQueryCompletedCalculated.AsString := 'not yet completed'
  else
  begin
    DateTimeToString(DateTimeStr, TasksQueryCompletedOn.DisplayFormat, TasksQueryCompletedOn.AsDateTime);
    TasksQueryCompletedCalculated.AsString := DateTimeStr;
  end;
  if TasksQueryCalculationTime.IsNull then
    TasksQueryCalculationTimeCalculated.AsString := 'never started'
  else
    TasksQueryCalculationTimeCalculated.AsString := FormatDateTime('hh:nn:ss.zzz', TasksQueryCalculationTime.AsDateTime);
end;

function TTasksView.ValidateData: Boolean;
begin
  // No validation needed.
  Result := true;
end;

end.
