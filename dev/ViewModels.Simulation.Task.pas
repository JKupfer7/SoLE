unit ViewModels.Simulation.Task;

interface

uses
  Models.MainModel,
  ZDbcIntfs;

type
  TSimulationTask = class(TObject)
  private
    FConnection: IZConnection;
    FConnectionStr: String;
    FRecordID: String;
    FCalculationTime: TTime;
    FTaskOwner: String;
    FRunNumber: Integer;
    FTaskID: String;
    FFirstStartOn: TDateTime;
    FTaskType: String;
    FCreatedOn: TDate;
    FDayNumber: Integer;
    FCompletedOn: TDateTime;
    FTaskPriority: Integer;
    FLastStartOn: TDateTime;
    FTaskStatus: String;
    FCurrentCalculationTime: TTime;
    class function IsSQLiteConnection(const AConnectionStr: String): Boolean;
  public
    constructor Create(const AConnection: IZConnection);
    function IsAvailable: Boolean;
    function ConditionsMet: Boolean;
    procedure LoadFromDataBase(const ASimulationID, ATaskType: String;
    const ADayNumber, ARunNumber: Integer); overload;
    procedure LoadFromDataBase(const ASimulationID, ATaskType: String;
    const ADayNumber: Integer); overload;
    procedure Grab;
    procedure Release;
  end;

implementation

uses
  System.SysUtils,
  System.Math,
  Settings.Constants;

{ TSimulationTask }


function TSimulationTask.IsAvailable: Boolean;
begin
  Result := ((FTaskStatus = TaskStatusNotStarted) or (FTaskStatus = TaskStatusQueued));
end;

class function TSimulationTask.IsSQLiteConnection(const AConnectionStr: String)
    : Boolean;
begin
  Result := (Copy(AConnectionStr, 6, 6) = 'sqlite');
end;

procedure TSimulationTask.LoadFromDataBase(const ASimulationID,
  ATaskType: String; const ADayNumber: Integer);
begin
  // Read the values of the associated task.
  var Statement: IZPreparedStatement := FConnection.PrepareStatement(
    'SELECT * FROM tasks WHERE (record_id=?) AND (task_type=?) AND (day_number=?);');
  // Field record_id in table tasks holds the simulation_id.
  Statement.SetString(1, ASimulationID);
  Statement.SetString(2, ATaskType);
  Statement.SetInt(3, ADayNumber);

  var ResultSet: IZResultSet := Statement.ExecuteQueryPrepared;
  if not(IsSQLiteConnection(FConnectionStr)) then ResultSet.First; // select the first (and only) record into the ResultSet to avoid an exception

  FTaskID := ResultSet.GetStringByName('task_id');
  FRecordID := ResultSet.GetStringByName('record_id');
  FTaskType := ResultSet.GetStringByName('task_type');
  FTaskPriority := ResultSet.GetIntByName('task_priority');
  FTaskStatus := ResultSet.GetStringByName('task_status');
  FDayNumber := ResultSet.GetIntByName('day_number');
  FCreatedOn := ResultSet.GetDateByName('created_on');
  if ResultSet.IsNull(10) then
    FFirstStartOn := Now
  else
    FFirstStartOn := ResultSet.GetDateByName('first_start_on');
  FCompletedOn := ResultSet.GetDateByName('completed_on');
  FCalculationTime := ResultSet.GetTimeByName('calculation_time');

end;

procedure TSimulationTask.LoadFromDataBase(const ASimulationID,
  ATaskType: String; const ADayNumber, ARunNumber: Integer);
begin
  // Read the values of the associated task.
  var Statement: IZPreparedStatement := FConnection.PrepareStatement(
    'SELECT * FROM tasks WHERE (record_id=?) AND (task_type=?) AND (run_number=?) AND (day_number=?);');
  // Field record_id in table tasks holds the simulation_id.
  Statement.SetString(1, ASimulationID);
  Statement.SetString(2, ATaskType);
  Statement.SetInt(3, ARunNumber);
  Statement.SetInt(4, ADayNumber);

  var ResultSet: IZResultSet := Statement.ExecuteQueryPrepared;
  if not(IsSQLiteConnection(FConnectionStr)) then ResultSet.First; // select the first (and only) record into the ResultSet to avoid an exception

  FTaskID := ResultSet.GetStringByName('task_id');
  FRecordID := ResultSet.GetStringByName('record_id');
  FTaskType := ResultSet.GetStringByName('task_type');
  FTaskPriority := ResultSet.GetIntByName('task_priority');
  FTaskStatus := ResultSet.GetStringByName('task_status');
  FDayNumber := ResultSet.GetIntByName('day_number');
  FRunNumber := ResultSet.GetIntByName('run_number');
  FCreatedOn := ResultSet.GetDateByName('created_on');
  if ResultSet.IsNull(10) then
    FFirstStartOn := Now
  else
    FFirstStartOn := ResultSet.GetDateByName('first_start_on');
  FCompletedOn := ResultSet.GetDateByName('completed_on');
  FCalculationTime := ResultSet.GetTimeByName('calculation_time');
end;

procedure TSimulationTask.Release;
begin
  // Update the associated task.
  var Statement: IZPreparedStatement := FConnection.PrepareStatement(
    'UPDATE tasks SET task_status = ?, task_owner = ?, completed_on = ?, calculation_time = ? WHERE task_id = ?;');
  Statement.SetString(1, TaskStatusFinished);
  Statement.SetNull(2, stString); // SetNull requires type of variable to be set to null.
  var TaskCompletedOn: TDateTime := Now;
  var TaskNewCalculationTime: TTime := TaskCompletedOn - FLastStartOn;
  Statement.SetTimestamp(3, TaskCompletedOn);
  Statement.SetTime(4, TaskNewCalculationTime + FCalculationTime);
  Statement.SetString(5, FTaskID);
  Statement.ExecutePrepared;
end;

{ TSimulationTask }

function TSimulationTask.ConditionsMet: Boolean;
begin
  Result := false;

  if (FTaskType =TaskTypeSetupInitialization) then
  begin
    Result := true;
  end
  else if (FTaskType = TaskTypeSimulationInitialization) then
  begin
    // Check if Setup is initialized.
    var Statement: IZPreparedStatement := FConnection.PrepareStatement(
      'SELECT ot.task_status FROM tasks ot WHERE ot.record_id IN ( '+
      'SELECT s.simulation_setup_id FROM tasks t '+
      'JOIN simulations s ON (t.record_id = s.simulation_id) '+
      'WHERE (t.task_id = ?));');
    Statement.SetString(1, FTaskID);
    var ResultSet: IZResultSet := Statement.ExecuteQueryPrepared;
    if not(ISSQLiteConnection(FConnectionStr)) then ResultSet.First; // select the first (and only) record into the ResultSet to avoid an exception
    Result := (ResultSet.GetStringByName('task_status') = TaskStatusFinished);
  end
  else if (FTaskType = TaskTypeRunInitialization) then
  begin
    // Check if Simulation is initialized.
    var Statement: IZPreparedStatement := FConnection.PrepareStatement(
      'SELECT task_status FROM tasks WHERE (task_type = ?) AND (record_id = ?);');
    Statement.SetString(1, 'Simulation Initialization');
    Statement.SetString(2, FRecordID);
    var ResultSet: IZResultSet := Statement.ExecuteQueryPrepared;
    if not(ISSQLiteConnection(FConnectionStr)) then ResultSet.First; // select the first (and only) record into the ResultSet to avoid an exception
    Result := (ResultSet.GetStringByName('task_status') = TaskStatusFinished);
  end
  else if (FTaskType = TaskTypeRunExecution) then
  begin
    // Check if the previous task (RunExecution or RunInitialization) is finished.
    var Statement: IZPreparedStatement := FConnection.PrepareStatement(
      'SELECT task_status FROM tasks WHERE (record_id = ?) AND (run_number = ?) AND (day_number = ?);');
    Statement.SetString(1, FRecordID);
    Statement.SetInt(2, FRunNumber);
    Statement.SetInt(3, (FDayNumber-1));
    var ResultSet: IZResultSet := Statement.ExecuteQueryPrepared;
    if not(ISSQLiteConnection(FConnectionStr)) then ResultSet.First; // select the first (and only) record into the ResultSet to avoid an exception
    Result := (ResultSet.GetStringByName('task_status') = TaskStatusFinished);
  end
  else if (FTaskType = TaskTypeDayEvaluation) then
  begin
    // Check if previous day is evaluated.
    var PreviousDayEvaluated: Boolean := false;
    if FDayNumber = 0 then
      PreviousDayEvaluated := true
    else
    begin
      var EvaluationStatement: IZPreparedStatement := FConnection.PrepareStatement(
        'SELECT task_status FROM tasks WHERE (task_type = ?) AND (day_number = ?) ' +
        'AND (record_id = ?);');
      EvaluationStatement.SetString(1, TaskTypeDayEvaluation);
      EvaluationStatement.SetInt(2, FDayNumber-1);
      EvaluationStatement.SetString(3, FRecordID);
      var EvaluationResultSet: IZResultSet := EvaluationStatement.ExecuteQueryPrepared;
      if not(ISSQLiteConnection(FConnectionStr)) then EvaluationResultSet.First; // select the first (and only) record into the ResultSet to avoid an exception
        PreviousDayEvaluated := (EvaluationResultSet.GetStringByName('task_status') = TaskStatusFinished);
    end;
    // Check if according days have been executed.
    var Statement: IZPreparedStatement := FConnection.PrepareStatement(
      'SELECT count(task_id) as count_unfinished FROM tasks ' +
      'WHERE (day_number = ?) AND (task_type != ?) AND ' +
      '(task_status != ?) AND (record_id = ?);');
    Statement.SetInt(1, FDayNumber);
    Statement.SetString(2, TaskTypeDayEvaluation);
    Statement.SetString(3, TaskStatusFinished);
    Statement.SetString(4, FRecordID);
    var ResultSet: IZResultSet := Statement.ExecuteQueryPrepared;
    if not(ISSQLiteConnection(FConnectionStr)) then ResultSet.First; // select the first (and only) record into the ResultSet to avoid an exception
    var AccordingRunsExecuted := (ResultSet.GetIntByName('count_unfinished') = 0);

    Result := (PreviousDayEvaluated and AccordingRunsExecuted);
  end;
end;

constructor TSimulationTask.Create(const AConnection: IZConnection);
begin
  inherited Create;

  FConnection := AConnection;
  FConnectionStr := MainModel.ConnectionURL;
end;

procedure TSimulationTask.Grab;
begin
  // Calculate values for task.
  FTaskOwner := MainModel.Settings.OwnComputerName;
  FLastStartOn := Now;
  FCurrentCalculationTime := 0;

  // Grab the associated task.
  var Statement: IZPreparedStatement := FConnection.PrepareStatement(
    'UPDATE tasks SET task_status = ?, task_owner = ?, first_start_on = ?, last_start_on = ? WHERE task_id = ?;');
  Statement.SetString(1, TaskStatusRunning);
  Statement.SetString(2, FTaskOwner);
  Statement.SetTimestamp(3, FFirstStartOn);
  Statement.SetTimestamp(4, FLastStartOn);
  Statement.SetString(5, FTaskID);
  Statement.ExecutePrepared;
end;

end.
