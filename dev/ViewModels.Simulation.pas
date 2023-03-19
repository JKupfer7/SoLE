unit ViewModels.Simulation;

interface

uses
  System.SysUtils,
  System.Math,
  System.Generics.Collections,
  System.Generics.Defaults,
  Models.MainModel,
  ZDbcIntfs, // Contains used data access components.
  AMRandom;

type
  TSimulation = class(TObject)
  private
    type
      TPerson = class(TObject)
      private
        FInfectiousness: Double;
        FPersonID: String;
        FInfectiousPeriod: Integer;
        FIncubationPeriod: Integer;
        FPersonNumber: Integer;
        FInitialImmunity: Double;
        FDiseasePeriod: Integer;
        FInitialDayOfInfectious: Integer;
        FSusceptibility: Double;
        FMortality: Double;
        FHalvingImmunityPeriod: Integer;
        FImmunityPeriod: Integer;
        FStatusID: String;
        FRunDayID: String;
        FRunNumber: Integer;
        FDayNumber: Integer;
        FCurrentImmunity: Double;
        FDaysLeftDiseased: Integer;
        FDaysLeftIncubated: Integer;
        FInfectiousDelayPeriod: Integer;
        FDaysLeftImmune: Integer;
        FDaysLeftInfectiousDelay: Integer;
        FDaysLeftInfectious: Integer;
        FCountInfected: Integer;
        FDeceased: Boolean;
        FSumInfected: Integer;
        function GetDiseased: Boolean;
        function GetImmune: Boolean;
        function GetIncubated: Boolean;
        function GetInfected: Boolean;
        function GetInfectious: Boolean;
        function GetRemoved: Boolean;
        function GetSusceptible: Boolean;
      public
        class function GetSearchValue(APersonID: String): TSimulation.TPerson;
        procedure InitializeDayZero(const APersonID: String; const APersonNumber:
            Integer; const AStatusID, ARunDayID: String; const ARunNumber,
            AInitialDayOfInfectious: Integer; const ASusceptibility, AInfectiousness,
            AMortality, AInitialImmunity: Double; const AIncubationPeriod,
            ADiseasePeriod, AInfectiousDelayPeriod, AInfectiousPeriod,
            AHalvingImmunityPeriod, AImmunityPeriod: Integer);
        procedure InitializeNextDay;
        function DecideAboutContact(const AContactProbability: Double): Boolean;
        function DecideAboutInfection(const AnInfectiousness: Double): Boolean;
        function DecideAboutDecease: Boolean;
        function CalculateCurrentImmunity: Double;
        procedure SetAsInfected;
        procedure IncreaseCountInfected;
        property PersonID: String read FPersonID write FPersonID; // simulation_people.person_id
        property PersonNumber: Integer read FPersonNumber write FPersonNumber; // simulation_people.person_number
        property StatusID: String read FStatusID write FStatusID; // simulation_people_status.status_id
        property RunDayID: String read FRunDayID write FRunDayID; // simulation_people_status.run_day_id
        property DayNumber: Integer read FDayNumber write FDayNumber; // simulation_run_days.day_number
        property RunNumber: Integer read FRunNumber write FRunNumber; // simulation_run_days.run_number
        property InitialDayOfInfectious: Integer read FInitialDayOfInfectious write FInitialDayOfInfectious; // simulation_people.initial_day_of_infectious
        property Susceptibility: Double read FSusceptibility write FSusceptibility; // simulation_people.susceptibility
        property Infectiousness: Double read FInfectiousness write FInfectiousness; // simulation_people.infectiousness
        property Mortality: Double read FMortality write FMortality; // simulation_people.mortality
        property InitialImmunity: Double read FInitialImmunity write FInitialImmunity; // simulation_people.initial_immunity
        property IncubationPeriod: Integer read FIncubationPeriod write FIncubationPeriod; // simulation_people.incubation_period
        property DiseasePeriod: Integer read FDiseasePeriod write FDiseasePeriod; // simulation_people.disease_period
        property InfectiousDelayPeriod: Integer read FInfectiousDelayPeriod write FInfectiousDelayPeriod; // simulation_people.infectious_delay_period
        property InfectiousPeriod: Integer read FInfectiousPeriod write FInfectiousPeriod; // simulation_people.infectious_period
        property HalvingImmunityPeriod: Integer read FHalvingImmunityPeriod write FHalvingImmunityPeriod; // simulation_people.halving_immunity_period
        property ImmunityPeriod: Integer read FImmunityPeriod write FImmunityPeriod; // simulation_people.immunity_period
        property CurrentImmunity: Double read FCurrentImmunity write FCurrentImmunity; // simulation_people_status.current_immunity
        property DaysLeftIncubated: Integer read FDaysLeftIncubated write FDaysLeftIncubated; // simulation_people_status.days_left_incubated
        property DaysLeftDiseased: Integer read FDaysLeftDiseased write FDaysLeftDiseased; // simulation_people_status.days_left_diseased
        property DaysLeftInfectiousDelay: Integer read FDaysLeftInfectiousDelay write FDaysLeftInfectiousDelay; // simulation_people_status.days_left_infectious_delay
        property DaysLeftInfectious: Integer read FDaysLeftInfectious write FDaysLeftInfectious; // simulation_people_status.days_left_infectious
        property DaysLeftImmune: Integer read FDaysLeftImmune write FDaysLeftImmune; // simulation_people_status.days_left_immune
        property CountInfected: Integer read FCountInfected write FCountInfected; // simulation_people_status.count_infected
        property SumInfected: Integer read FSumInfected write FSumInfected; // simulation_people_status.sum_infected
        property Susceptible: Boolean read GetSusceptible; // simulation_people_status.susceptible (generated)
        property Incubated: Boolean read GetIncubated; // simulation_people_status.incubated (generated)
        property Diseased: Boolean read GetDiseased; // simulation_people_status.diseased (generated)
        property Infected: Boolean read GetInfected; // simulation_people_status.infected (generated)
        property Immune: Boolean read GetImmune; // simulation_people_status.immune (generated)
        property Deceased: Boolean read FDeceased write FDeceased; // simulation_people_status.deceased
        property Removed: Boolean read GetRemoved; // simulation_people_status.removed (generated)
        property Infectious: Boolean read GetInfectious; // simulation_people_status.infectious (generated)
      end;
    class function IsSQLiteConnection(const AConnectionStr: String): Boolean;
  public
    class function InitializeSimulation(const ASimulationID: String): Integer;
    class function InitializeDayZero(const ASimulationID: String): Integer;
    class function InitializeDayZeroRun(const ASimulationID: String; const
        ARunNumber: Integer): Boolean;
    class function ExecuteDay(const ASimulationID: String; const ADayNumber: Integer):
        Integer;
    class function ExecuteDayRun(const ASimulationID: String; const ADayNumber, ARunNumber:
        Integer): Boolean;
    class function EvaluateDay(const ASimulationID: String; const ADayNumber: Integer): Boolean;
  end;

implementation

uses
  Settings.Constants,
  ViewModels.Simulation.Day,
  ViewModels.Simulation.RunDay,
  ViewModels.Simulation.PersonState,
  ViewModels.Simulation.PersonStatesList,
  ViewModels.Simulation.Task,
  Dialogs.ErrorDialog;

{ TSimulation.TPerson }

function TSimulation.TPerson.CalculateCurrentImmunity: Double;
begin
  // No immunity acquired.
  if (InitialImmunity = 0) then
  begin
    Result := 0;
    Exit;
  end;

  // Acquired immunity does not decrease (SIR model).
  if (ImmunityPeriod = HalvingImmunityPeriod) then
  begin
    Result := InitialImmunity;
    Exit;
  end;

  // The acquired immunity has expired.
  if (DaysLeftImmune = 0) then
  begin
    Result := 0;
    Exit
  end;

  // The acquired immunity still exists.
  var Base: Double := Power(0.5, 1/(ImmunityPeriod - HalvingImmunityPeriod));
  Result := InitialImmunity / (1 - Power(Base, ImmunityPeriod)) * (1 - Power(Base, DaysLeftImmune));
end;

function TSimulation.TPerson.DecideAboutContact(
  const AContactProbability: Double): Boolean;
begin
  var Risk: Double := AContactProbability;
  var DecisionValue: Double := Random;
  Result := (Risk <= DecisionValue);
end;

function TSimulation.TPerson.DecideAboutDecease: Boolean;
begin
  var Risk: Double := Mortality;
  var DecisionValue: Double := Random;
  Result := (Risk <= DecisionValue);
end;

function TSimulation.TPerson.DecideAboutInfection(const AnInfectiousness: Double): Boolean;
begin
  var Risk: Double := Susceptibility * (1 - CurrentImmunity) * AnInfectiousness;
  var DecisionValue: Double := Random;
  Result := (Risk <= DecisionValue);
end;

function TSimulation.TPerson.GetDiseased: Boolean;
begin
  Result := (DaysLeftDiseased > 0);
end;

function TSimulation.TPerson.GetImmune: Boolean;
begin
  Result := (DaysLeftImmune > 0);
end;

function TSimulation.TPerson.GetIncubated: Boolean;
begin
  Result := (DaysLeftIncubated > 0);
end;

function TSimulation.TPerson.GetInfected: Boolean;
begin
  Result := (Incubated or Diseased);
end;

function TSimulation.TPerson.GetInfectious: Boolean;
begin
  Result := (DaysLeftInfectious > 0);
end;

function TSimulation.TPerson.GetRemoved: Boolean;
begin
  Result := (Immune or Deceased);
end;

class function TSimulation.TPerson.GetSearchValue(
  APersonID: String): TSimulation.TPerson;
begin
  var V: TSimulation.TPerson := TSimulation.TPerson.Create;
  V.PersonID := APersonID;
  Result := V;
end;

function TSimulation.TPerson.GetSusceptible: Boolean;
begin
  Result := not(Infected or Removed);
end;

procedure TSimulation.TPerson.IncreaseCountInfected;
begin
  CountInfected := CountInfected + 1;
end;

procedure TSimulation.TPerson.InitializeNextDay;
begin
  DayNumber := DayNumber + 1;

  if Susceptible then
  begin
    DaysLeftIncubated := 0;
    DaysLeftDiseased := 0;
    DaysLeftImmune := 0;
    CurrentImmunity := 0;
    Deceased := false;
  end
  else if (DaysLeftIncubated > 1) then
  begin
    // within the incubation phase:
    DaysLeftIncubated := DaysLeftIncubated - 1;
    DaysLeftDiseased := 0;
    DaysLeftImmune := 0;
    CurrentImmunity := 0;
    Deceased := false;
  end
  else if (DaysLeftIncubated = 1) then
  begin
    // incubation phase --> disease phase
    DaysLeftIncubated := 0;
    DaysLeftDiseased := DiseasePeriod;
    DaysLeftImmune := 0;
    CurrentImmunity := 0;
    Deceased := false;
  end
  else if (DaysLeftDiseased > 1) then
  begin
    // within disease phase:
    DaysLeftIncubated := 0;
    DaysLeftDiseased := DaysLeftDiseased - 1;
    DaysLeftImmune := 0;
    CurrentImmunity := 0;
    Deceased := false;
  end
  else if (DaysLeftDiseased = 1) then
  begin
    // diseased --> immune/deceased/susceptible
    Deceased := DecideAboutDecease;
    if Deceased then
    begin
      DaysLeftIncubated := 0;
      DaysLeftDiseased := 0;
      DaysLeftImmune := 0;
      CurrentImmunity := 0;
    end
    else
    begin
      DaysLeftIncubated := 0;
      DaysLeftDiseased := 0;
      DaysLeftImmune := ImmunityPeriod;
      CurrentImmunity := CalculateCurrentImmunity;
    end;
  end
  else if (DaysLeftImmune > 1) then
  begin
    // within immune phase
    DaysLeftIncubated := 0;
    DaysLeftDiseased := 0;
    DaysLeftImmune := DaysLeftImmune - 1;
    CurrentImmunity := CalculateCurrentImmunity;
    Deceased := false;
  end
  else if (DaysLeftImmune = 1) then
  begin
    // immune --> susceptible
    DaysLeftIncubated := 0;
    DaysLeftDiseased := 0;
    DaysLeftImmune := 0;
    CurrentImmunity := 0;
    Deceased := false;
  end
  else if Deceased then
  begin
    DaysLeftIncubated := 0;
    DaysLeftDiseased := 0;
    DaysLeftImmune := 0;
    CurrentImmunity := 0;
    Deceased := true;
  end;

  if (Deceased) then
  begin
    DaysLeftInfectiousDelay := 0;
    DaysLeftInfectious := 0;
  end
  else if (DaysLeftInfectiousDelay > 1) then
  begin
    DaysLeftInfectiousDelay := DaysLeftInfectiousDelay - 1;
    DaysLeftInfectious := 0;
  end
  else if (DaysLeftInfectiousDelay = 1) then
  begin
    DaysLeftInfectiousDelay := 0;
    DaysLeftInfectious := InfectiousPeriod;
  end
  else if (DaysLeftInfectious > 1) then
  begin
    DaysLeftInfectiousDelay := 0;
    DaysLeftInfectious := DaysLeftInfectious - 1;
  end
  else
  begin
    DaysLeftInfectiousDelay := 0;
    DaysLeftInfectious := 0;
  end;

  if (DaysLeftInfectious >= 1) then
    SumInfected := SumInfected + CountInfected
  else
    SumInfected := 0;
  CountInfected := 0;
end;

procedure TSimulation.TPerson.InitializeDayZero(const APersonID: String; const
    APersonNumber: Integer; const AStatusID, ARunDayID: String; const
    ARunNumber, AInitialDayOfInfectious: Integer; const ASusceptibility,
    AInfectiousness, AMortality, AInitialImmunity: Double; const
    AIncubationPeriod, ADiseasePeriod, AInfectiousDelayPeriod,
    AInfectiousPeriod, AHalvingImmunityPeriod, AImmunityPeriod: Integer);
begin
  PersonID := APersonID;
  PersonNumber := APersonNumber;
  StatusID := AStatusID;
  RunDayID := ARunDayID;
  DayNumber := 0;
  RunNumber := ARunNumber;
  InitialDayOfInfectious := AInitialDayOfInfectious;
  Susceptibility := ASusceptibility;
  Infectiousness := AInfectiousness;
  Mortality := AMortality;
  InitialImmunity := AInitialImmunity;
  IncubationPeriod := AIncubationPeriod;
  DiseasePeriod := ADiseasePeriod;
  InfectiousDelayPeriod := AInfectiousDelayPeriod;
  InfectiousPeriod := AInfectiousPeriod;
  HalvingImmunityPeriod := AHalvingImmunityPeriod;
  ImmunityPeriod := AImmunityPeriod;

  CurrentImmunity := 0;
  DaysLeftImmune := 0;
  CountInfected := 0;
  SumInfected := 0;
  Deceased := false;

  // infected on day zero
  if (InitialDayOfInfectious > 0) then
  begin
    // Person already infectious.
    DaysLeftInfectiousDelay := 0;

    // Example: Person has an infectious period of 15 days.
    //          They are on day 10 of this period.
    //          They still have 6 days left, including current day.
    // Therefore: InfectiousPeriod - InitialDayOfInfectious + 1
    DaysLeftInfectious := InfectiousPeriod - InitialDayOfInfectious + 1;

    //
    DaysLeftIncubated := IfThen(IncubationPeriod - (InfectiousDelayPeriod + InitialDayOfInfectious) + 1 < 0, 0, IncubationPeriod - (InfectiousDelayPeriod + InitialDayOfInfectious) + 1);

    //
    DaysLeftDiseased := IfThen((IncubationPeriod + DiseasePeriod - InfectiousDelayPeriod - InitialDayOfInfectious + 1 > DiseasePeriod) or (IncubationPeriod + DiseasePeriod - InfectiousDelayPeriod - InitialDayOfInfectious + 1 < 0), 0, IncubationPeriod + DiseasePeriod - InfectiousDelayPeriod - InitialDayOfInfectious + 1);

    //
    DaysLeftImmune := IfThen(InfectiousDelayPeriod + InitialDayOfInfectious - IncubationPeriod - DiseasePeriod < 0, 0, ImmunityPeriod - InfectiousDelayPeriod - InitialDayOfInfectious + IncubationPeriod + DiseasePeriod +1);
    CalculateCurrentImmunity;
  end
  // susceptible on day zero
  else
  begin
    DaysLeftInfectiousDelay := 0;
    DaysLeftInfectious := 0;
    DaysLeftIncubated := 0;
    DaysLeftDiseased := 0;
  end;
end;

procedure TSimulation.TPerson.SetAsInfected;
begin
  if (IncubationPeriod > 0) then
  begin
    DaysLeftIncubated := IncubationPeriod;
    DaysLeftDiseased := 0;
  end
  else
  begin
    DaysLeftIncubated := 0;
    DaysLeftDiseased := DiseasePeriod;
  end;
  if (InfectiousDelayPeriod > 0) then
  begin
    DaysLeftInfectiousDelay := InfectiousDelayPeriod;
    DaysLeftInfectious := 0;
  end
  else
  begin
    DaysLeftInfectiousDelay := 0;
    DaysLeftInfectious := InfectiousPeriod;
  end;
end;

class function TSimulation.ExecuteDayRun(const ASimulationID: String; const ADayNumber,
    ARunNumber: Integer): Boolean;
begin
  // Initialize functions result.
  Result := false;

  // Establishing Connection.
  var ConnectionStr: String := MainModel.ConnectionURL;
  var Connection: IZConnection := DriverManager.GetConnection(ConnectionStr);

  var Task: TSimulationTask := TSimulationTask.Create(Connection);
  Task.LoadFromDataBase(ASimulationID, TaskTypeRunExecution, ADayNumber, ARunNumber);
  try
    if (Task.IsAvailable and Task.ConditionsMet) then
    begin
      Task.Grab;
      var StatesList: TSimulationPersonStatesList := TSimulationPersonStatesList.Create(Connection, ASimulationID, ADayNumber, ARunNumber);
      try
        StatesList.InitializePersonStates;
        StatesList.InsertIntoDatabase;
        StatesList.SimulateContacts;
        if not(MainModel.Settings.TasksKeepPeopleStates) then
          StatesList.DeletePreviousPersonStatesFromDatabase;
        Task.Release;
        Result := true;
      finally
        StatesList.Free;
      end;
    end;
  finally
    Task.Free;
    Connection.Close;
  end;
end;

class function TSimulation.InitializeDayZeroRun(const ASimulationID: String;
    const ARunNumber: Integer): Boolean;
begin
  // Initialize functions result.
  Result := false;

  // Save attributes of people.
  var People: TObjectList<TPerson> := TObjectList<TPerson>.Create(
    // Creates comparer to use the method IndexOf.
    TComparer<TPerson>.Construct(
      function(const Left, Right: TPerson): Integer
      begin
        if (Left.PersonID < Right.PersonID) then
          Result := -1
        else if (Left.PersonID > Right.PersonID) then
          Result := 1
        else
          Result := 0;
      end),
    true);

  // Establishing Connection.
  var ConnectionStr: String := MainModel.ConnectionURL;
  var IsSQLite: Boolean := (Copy(ConnectionStr, 6, 6) = 'sqlite');
  var Connection: IZConnection := DriverManager.GetConnection(ConnectionStr);

  try
    // Read the values of the associated task.
    var ReadTaskStatement: IZPreparedStatement := Connection.PrepareStatement(
      'SELECT * FROM tasks WHERE (record_id=?) and (task_type=?) and (run_number=?);');
    // Field record_id in table tasks holds the simulation_id.
    ReadTaskStatement.SetString(1, ASimulationID);
    ReadTaskStatement.SetString(2, TaskTypeRunInitialization);
    ReadTaskStatement.SetInt(3, ARunNumber);
    var ReadTaskResultSet: IZResultSet := ReadTaskStatement.ExecuteQueryPrepared;

    if not(IsSQLite) then ReadTaskResultSet.First; // select the first (and only) record into the ResultSet to avoid an exception
    var TaskStatus: String := ReadTaskResultSet.GetStringByName('task_status');
    // Cancel initialization if task is already in work or completed.
    if not((TaskStatus = TaskStatusNotStarted) or (TaskStatus = TaskStatusQueued)) then Exit;

    // Check if according simulation initialization is finished.
    var CheckSimulationInitializationStatement: IZPreparedStatement := Connection.PrepareStatement(
      'SELECT task_status FROM tasks WHERE (record_id=?) and (task_type=?);');
    CheckSimulationInitializationStatement.SetString(1, ASimulationID);
    CheckSimulationInitializationStatement.SetString(2, TaskTypeSimulationInitialization);
    var CheckSimulationInitializationResultSet: IZResultSet := CheckSimulationInitializationStatement.ExecuteQueryPrepared;

    if not(IsSQLite) then CheckSimulationInitializationResultSet.First; // select the first (and only) record into the ResultSet to avoid an exception
    var SimulationInitializationFinished: Boolean := (CheckSimulationInitializationResultSet.GetStringByName('task_status') = TaskStatusFinished);
    // Cancel run initialization if the according simulation initialization is not finished.
    if not(SimulationInitializationFinished) then Exit;

    // Check if according simulation setup is finished.
    var CheckSimulationSetupStatement: IZPreparedStatement := Connection.PrepareStatement(
      'SELECT t.task_status FROM tasks t ' +
      'JOIN simulation_setups ss ON (ss.simulation_setup_id = t.record_id) ' +
      'JOIN simulations s ON (s.simulation_setup_id = ss.simulation_setup_id) ' +
      'WHERE (s.simulation_id=?) AND (t.task_type=?);');
    CheckSimulationSetupStatement.SetString(1, ASimulationID);
    CheckSimulationSetupStatement.SetString(2, TaskTypeSetupInitialization);
    var CheckSimulationSetupResultSet: IZResultSet := CheckSimulationSetupStatement.ExecuteQueryPrepared;

    if not(IsSQLite) then CheckSimulationSetupResultSet.First; // select the first (and only) record into the ResultSet to avoid an exception
    var SimulationSetupFinished: Boolean := (CheckSimulationSetupResultSet.GetStringByName('task_status') = TaskStatusFinished);
    // Cancel run initialization if the according simulation setup is not finished.
    if not(SimulationSetupFinished) then Exit;

    // Calculate values for task.
    var TaskID: String := ReadTaskResultSet.GetStringByName('task_id');
    var TaskOwner: String := MainModel.Settings.OwnComputerName;
    var TaskFirstStartOn: TDateTime;
    if ReadTaskResultSet.IsNull(10) then
      TaskFirstStartOn := Now
    else
      TaskFirstStartOn := ReadTaskResultSet.GetDateByName('first_start_on');
    var TaskLastStartOn: TDateTime := Now;
    var TaskLastCalculationTime: TDateTime := 0;
    if not(ReadTaskResultSet.IsNull(13)) then
      TaskLastCalculationTime := ReadTaskResultSet.GetTimeByName('calculation_time');

    // Grab the associated task.
    var GrabTaskStatement: IZPreparedStatement := Connection.PrepareStatement(
      'UPDATE tasks SET task_status = ?, task_owner = ?, first_start_on = ?, last_start_on = ? WHERE task_id = ?;');
    GrabTaskStatement.SetString(1, TaskStatusRunning);
    GrabTaskStatement.SetString(2, TaskOwner);
    GrabTaskStatement.SetTimestamp(3, TaskFirstStartOn);
    GrabTaskStatement.SetTimestamp(4, TaskLastStartOn);
    GrabTaskStatement.SetString(5, TaskID);
    GrabTaskStatement.ExecutePrepared;

    // Calculate values to be used in simulation_run_days.
    var SimulationRunDayID := MainModel.GetPrimaryKeyValue;
    var GetSimulationDayIDStatement: IZPreparedStatement := Connection.PrepareStatement(
      'SELECT simulation_day_id FROM simulation_days WHERE (day_number=0) AND (simulation_id=?);');
    GetSimulationDayIDStatement.SetString(1, ASimulationID);
    var GetSimulationDayIDResultSet: IZResultSet := GetSimulationDayIDStatement.ExecuteQueryPrepared;
    if not(IsSQLite) then GetSimulationDayIDResultSet.First; // select the first (and only) record into the ResultSet to avoid an exception
    var SimulationDayID: String := GetSimulationDayIDResultSet.GetStringByName('simulation_day_id');

    // Create a record in simulation_run_days.
    var InsertSimulationRunDaysStatement: IZPreparedStatement := Connection.PrepareStatement(
      'INSERT INTO simulation_run_days (simulation_run_day_id, simulation_day_id, day_number, run_number) VALUES (?, ?, ?, ?);');
    InsertSimulationRunDaysStatement.SetString(1, SimulationRunDayID);
    InsertSimulationRunDaysStatement.SetString(2, SimulationDayID);
    InsertSimulationRunDaysStatement.SetInt(3, 0);
    InsertSimulationRunDaysStatement.SetInt(4, ARunNumber);
    InsertSimulationRunDaysStatement.ExecutePrepared;

    // Initialize values in run_days.
    var CountSusceptible: Integer := 0;
    var CountIncubated: Integer := 0;
    var CountDiseased: Integer := 0;
    var CountImmune: Integer := 0;
    var CountDeceased: Integer := 0;
    var CountInfectious: Integer := 0;
    var DeltaSusceptible: Integer := 0;
    var DeltaIncubated: Integer := 0;
    var DeltaDiseased: Integer := 0;
    var DeltaInfected: Integer := 0;
    var DeltaImmune: Integer := 0;
    var DeltaDeceased: Integer := 0;
    var DeltaInfectious: Integer := 0;
    var ReproductionCountInfected: Integer := 0;
    var ReproductionCountInfectious: Integer := 0;
    var InfectedHistory1: Integer := 0;
    var InfectedHistory2: Integer := 0;
    var InfectedHistory3: Integer := 0;
    var InfectedHistory4: Integer := 0;
    var InfectedHistory5: Integer := 0;
    var InfectedHistory6: Integer := 0;
    var InfectedHistory7: Integer := 0;

    var GetSimulationPeopleStatusStatement: IZPreparedStatement := Connection.PrepareStatement(
    'SELECT * FROM view_day_zero_run_people WHERE (simulation_id=?);');
    GetSimulationPeopleStatusStatement.SetString(1, ASimulationID);
    var GetSimulationPeopleStatusResultSet: IZResultSet := GetSimulationPeopleStatusStatement.ExecuteQueryPrepared;
    if not(IsSQLite) then GetSimulationPeopleStatusResultSet.First; // select the first (and only) record into the ResultSet to avoid an exception

    if IsSQLite then GetSimulationPeopleStatusResultSet.Next; // SQLite will otherwise store the first record twice.
    repeat
      var Person: TSimulation.TPerson := TSimulation.TPerson.Create();
      Person.InitializeDayZero(
        GetSimulationPeopleStatusResultSet.GetStringByName('person_id'),
        GetSimulationPeopleStatusResultSet.GetIntByName('person_number'),
        MainModel.GetPrimaryKeyValue,
        SimulationRunDayID,
        ARunNumber,
        GetSimulationPeopleStatusResultSet.GetIntByName('initial_day_of_infectious'),
        GetSimulationPeopleStatusResultSet.GetDoubleByName('susceptibility'),
        GetSimulationPeopleStatusResultSet.GetDoubleByName('infectiousness'),
        GetSimulationPeopleStatusResultSet.GetDoubleByName('mortality'),
        GetSimulationPeopleStatusResultSet.GetDoubleByName('initial_immunity'),
        GetSimulationPeopleStatusResultSet.GetIntByName('incubation_period'),
        GetSimulationPeopleStatusResultSet.GetIntByName('disease_period'),
        GetSimulationPeopleStatusResultSet.GetIntByName('infectious_delay_period'),
        GetSimulationPeopleStatusResultSet.GetIntByName('infectious_period'),
        GetSimulationPeopleStatusResultSet.GetIntByName('halving_immunity_period'),
        GetSimulationPeopleStatusResultSet.GetIntByName('immunity_period'));
      People.Add(Person);

      if (Person.Susceptible) then Inc(CountSusceptible);
      if (Person.Incubated) then Inc(CountIncubated);
      if (Person.Diseased) then Inc(CountDiseased);
      if (Person.Immune) then Inc(CountImmune);
      if (Person.Deceased) then Inc(CountDeceased);
      if (Person.Infectious) then Inc(CountInfectious);
      if (Person.DaysLeftInfectious = 1) then Inc(ReproductionCountInfectious);
      if (Person.InitialDayOfInfectious > 0) then
      begin
        var DaysAfterInfection: Integer := Person.InfectiousDelayPeriod + Person.InitialDayOfInfectious;
        case DaysAfterInfection of
          1: Inc(InfectedHistory1);
          2: Inc(InfectedHistory2);
          3: Inc(InfectedHistory3);
          4: Inc(InfectedHistory4);
          5: Inc(InfectedHistory5);
          6: Inc(InfectedHistory6);
          7: Inc(InfectedHistory7);
        end;
      end;
    until not(GetSimulationPeopleStatusResultSet.Next);

    var InsertSimulationPeopleStatusStatement: IZPreparedStatement := Connection.PrepareStatement(
      'INSERT INTO simulation_people_status ' +
      '(status_id, run_day_id, person_id, current_immunity, days_left_incubated, ' +
      'days_left_diseased, days_left_infectious_delay, ' +
      'days_left_infectious, days_left_immune, count_infected, sum_infected, deceased) ' +
      'VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);');
    for var P: TSimulation.TPerson in People do
    begin
      InsertSimulationPeopleStatusStatement.SetString(1, P.StatusID);
      InsertSimulationPeopleStatusStatement.SetString(2, SimulationRunDayID);
      InsertSimulationPeopleStatusStatement.SetString(3, P.PersonID);
      InsertSimulationPeopleStatusStatement.SetDouble(4, P.CurrentImmunity);
      InsertSimulationPeopleStatusStatement.SetInt(5, P.DaysLeftIncubated);
      InsertSimulationPeopleStatusStatement.SetInt(6, P.DaysLeftDiseased);
      InsertSimulationPeopleStatusStatement.SetInt(7, P.DaysLeftInfectiousDelay);
      InsertSimulationPeopleStatusStatement.SetInt(8, P.DaysLeftInfectious);
      InsertSimulationPeopleStatusStatement.SetInt(9, P.DaysLeftImmune);
      InsertSimulationPeopleStatusStatement.SetInt(10, P.CountInfected);
      InsertSimulationPeopleStatusStatement.SetInt(11, P.SumInfected);
      InsertSimulationPeopleStatusStatement.SetInt(12, IfThen(P.Deceased, 1, 0));
      InsertSimulationPeopleStatusStatement.ExecutePrepared;
    end;

    var UpdateSimulationRunDaysStatement: IZPreparedStatement := Connection.PrepareStatement(
      'UPDATE simulation_run_days SET count_susceptible = ?, count_incubated = ?, count_diseased = ?, ' +
      'count_immune = ?, count_deceased = ?, count_infectious = ?, delta_susceptible = ?, ' +
      'delta_incubated = ?, delta_diseased = ?, delta_immune = ?, delta_deceased = ?, ' +
      'delta_infectious = ?, reproduction_count_infected = ?, reproduction_count_infectious = ?, ' +
      'infected_history_1 = ?, infected_history_2 = ?, infected_history_3 = ?, infected_history_4 = ?, ' +
      'infected_history_5 = ?, infected_history_6 = ?, infected_history_7 = ? WHERE simulation_run_day_id = ?;');
    UpdateSimulationRunDaysStatement.SetInt(1, CountSusceptible);
    UpdateSimulationRunDaysStatement.SetInt(2, CountIncubated);
    UpdateSimulationRunDaysStatement.SetInt(3, CountDiseased);
    UpdateSimulationRunDaysStatement.SetInt(4, CountImmune);
    UpdateSimulationRunDaysStatement.SetInt(5, CountDeceased);
    UpdateSimulationRunDaysStatement.SetInt(6, CountInfectious);
    UpdateSimulationRunDaysStatement.SetInt(7, DeltaSusceptible);
    UpdateSimulationRunDaysStatement.SetInt(8, DeltaIncubated);
    UpdateSimulationRunDaysStatement.SetInt(9, DeltaDiseased);
    UpdateSimulationRunDaysStatement.SetInt(10, DeltaImmune);
    UpdateSimulationRunDaysStatement.SetInt(11, DeltaDeceased);
    UpdateSimulationRunDaysStatement.SetInt(12, DeltaInfectious);
    UpdateSimulationRunDaysStatement.SetInt(13, ReproductionCountInfected);
    UpdateSimulationRunDaysStatement.SetInt(14, ReproductionCountInfectious);
    UpdateSimulationRunDaysStatement.SetInt(15, InfectedHistory1);
    UpdateSimulationRunDaysStatement.SetInt(16, InfectedHistory2);
    UpdateSimulationRunDaysStatement.SetInt(17, InfectedHistory3);
    UpdateSimulationRunDaysStatement.SetInt(18, InfectedHistory4);
    UpdateSimulationRunDaysStatement.SetInt(19, InfectedHistory5);
    UpdateSimulationRunDaysStatement.SetInt(20, InfectedHistory6);
    UpdateSimulationRunDaysStatement.SetInt(21, InfectedHistory7);
    UpdateSimulationRunDaysStatement.SetString(22, SimulationRunDayID);
    UpdateSimulationRunDaysStatement.ExecutePrepared;

    // Update the associated task.
    var UpdateTaskStatement: IZPreparedStatement := Connection.PrepareStatement(
      'UPDATE tasks SET task_status = ?, task_owner = ?, completed_on = ?, calculation_time = ? WHERE task_id = ?;');
    UpdateTaskStatement.SetString(1, TaskStatusFinished);
    UpdateTaskStatement.SetNull(2, stString); // SetNull requires type of variable to be set to null.
    var TaskCompletedOn: TDateTime := Now;
    var TaskNewCalculationTime: TDateTime := TaskCompletedOn - TaskLastStartOn;
    UpdateTaskStatement.SetTimestamp(3, TaskCompletedOn);
    UpdateTaskStatement.SetTime(4, TaskNewCalculationTime + TaskLastCalculationTime);
    UpdateTaskStatement.SetString(5, TaskID);
    UpdateTaskStatement.ExecutePrepared;

    Result := true;
  finally
    People.Free;
    Connection.Close;
  end;
end;

class function TSimulation.InitializeDayZero(const ASimulationID: String): Integer;
begin
  // Initialize functions result.
  Result := 0;

  var People: TObjectList<TPerson> := TObjectList<TPerson>.Create(
    TComparer<TPerson>.Construct(
      function(const Left, Right: TPerson): Integer
      begin
        if (Left.PersonID < Right.PersonID) then
          Result := -1
        else if (Left.PersonID > Right.PersonID) then
          Result := 1
        else
          Result := 0;
      end),
    true);

  // Establishing Connection.
  var ConnectionStr: String := MainModel.ConnectionURL;
  var IsSQLite: Boolean := (Copy(ConnectionStr, 6, 6) = 'sqlite');
  var Connection: IZConnection := DriverManager.GetConnection(ConnectionStr);

  try
    // Check if according simulation initialization is finished.
    var CheckSimulationInitializationStatement: IZPreparedStatement := Connection.PrepareStatement(
      'SELECT task_status FROM tasks WHERE (record_id=?) and (task_type=?);');
    CheckSimulationInitializationStatement.SetString(1, ASimulationID);
    CheckSimulationInitializationStatement.SetString(2, TaskTypeSimulationInitialization);
    var CheckSimulationInitializationResultSet: IZResultSet := CheckSimulationInitializationStatement.ExecuteQueryPrepared;

    if not(IsSQLite) then CheckSimulationInitializationResultSet.First; // select the first (and only) record into the ResultSet to avoid an exception
    var SimulationInitializationFinished: Boolean := (CheckSimulationInitializationResultSet.GetStringByName('task_status') = TaskStatusFinished);
    // Cancel run initialization if the according simulation initialization is not finished.
    if not(SimulationInitializationFinished) then Exit;

    // Check if according simulation setup is finished.
    var CheckSimulationSetupStatement: IZPreparedStatement := Connection.PrepareStatement(
      'SELECT t.task_status FROM tasks t ' +
      'JOIN simulation_setups ss ON (ss.simulation_setup_id = t.record_id) ' +
      'JOIN simulations s ON (s.simulation_setup_id = ss.simulation_setup_id) ' +
      'WHERE (s.simulation_id=?) AND (t.task_type=?);');
    CheckSimulationSetupStatement.SetString(1, ASimulationID);
    CheckSimulationSetupStatement.SetString(2, TaskTypeSetupInitialization);
    var CheckSimulationSetupResultSet: IZResultSet := CheckSimulationSetupStatement.ExecuteQueryPrepared;

    if not(IsSQLite) then CheckSimulationSetupResultSet.First; // select the first (and only) record into the ResultSet to avoid an exception
    var SimulationSetupFinished: Boolean := (CheckSimulationSetupResultSet.GetStringByName('task_status') = TaskStatusFinished);
    // Cancel run initialization if the according simulation setup is not finished.
    if not(SimulationSetupFinished) then Exit;

    // Read the number of runs of this simulation.
    var ReadRunNumberStatement: IZPreparedStatement := Connection.PrepareStatement(
      'SELECT number_of_runs FROM simulations WHERE (simulation_id = ?);');
    // Field record_id in table tasks holds the simulation_id.
    ReadRunNumberStatement.SetString(1, ASimulationID);
    var ReadRunNumberResultSet: IZResultSet := ReadRunNumberStatement.ExecuteQueryPrepared;

    if not(IsSQLite) then ReadRunNumberResultSet.First; // select the first (and only) record into the ResultSet to avoid an exception
    var NumberOfRuns: Integer := ReadRunNumberResultSet.GetIntByName('number_of_runs');

    for var CurrentRun: Integer := 1 to NumberOfRuns do
    begin
      // Read the values of the associated task.
      var ReadTaskStatement: IZPreparedStatement := Connection.PrepareStatement(
        'SELECT * FROM tasks WHERE (record_id=?) and (task_type=?) and (run_number=?);');
      // Field record_id in table tasks holds the simulation_id.
      ReadTaskStatement.SetString(1, ASimulationID);
      ReadTaskStatement.SetString(2, TaskTypeRunInitialization);
      ReadTaskStatement.SetInt(3, CurrentRun);
      var ReadTaskResultSet: IZResultSet := ReadTaskStatement.ExecuteQueryPrepared;

      if not(IsSQLite) then ReadTaskResultSet.First; // select the first (and only) record into the ResultSet to avoid an exception
      var TaskStatus: String := ReadTaskResultSet.GetStringByName('task_status');

      // Execute only if the status of the task is 'not started' or 'queued'.
      if (TaskStatus = TaskStatusNotStarted) or (TaskStatus = TaskStatusQueued) then
      begin
        // Calculate values for task.
        var TaskID: String := ReadTaskResultSet.GetStringByName('task_id');
        var TaskOwner: String := MainModel.Settings.OwnComputerName;
        var TaskFirstStartOn: TDateTime;
        if ReadTaskResultSet.IsNull(10) then
          TaskFirstStartOn := Now
        else
          TaskFirstStartOn := ReadTaskResultSet.GetDateByName('first_start_on');
        var TaskLastStartOn: TDateTime := Now;
        var TaskLastCalculationTime: TDateTime := 0;
        if not(ReadTaskResultSet.IsNull(13)) then
          TaskLastCalculationTime := ReadTaskResultSet.GetTimeByName('calculation_time');

        // Grab the associated task.
        var GrabTaskStatement: IZPreparedStatement := Connection.PrepareStatement(
          'UPDATE tasks SET task_status = ?, task_owner = ?, first_start_on = ?, last_start_on = ? WHERE task_id = ?;');
        GrabTaskStatement.SetString(1, TaskStatusRunning);
        GrabTaskStatement.SetString(2, TaskOwner);
        GrabTaskStatement.SetTimestamp(3, TaskFirstStartOn);
        GrabTaskStatement.SetTimestamp(4, TaskLastStartOn);
        GrabTaskStatement.SetString(5, TaskID);
        GrabTaskStatement.ExecutePrepared;

        // Calculate values to be used in simulation_run_days.
        var SimulationRunDayID := MainModel.GetPrimaryKeyValue;
        var GetSimulationDayIDStatement: IZPreparedStatement := Connection.PrepareStatement(
          'SELECT simulation_day_id FROM simulation_days WHERE (day_number=0) AND (simulation_id=?);');
        GetSimulationDayIDStatement.SetString(1, ASimulationID);
        var GetSimulationDayIDResultSet: IZResultSet := GetSimulationDayIDStatement.ExecuteQueryPrepared;
        if not(IsSQLite) then GetSimulationDayIDResultSet.First; // select the first (and only) record into the ResultSet to avoid an exception
        var SimulationDayID: String := GetSimulationDayIDResultSet.GetStringByName('simulation_day_id');

        // Create a record in simulation_run_days.
        var InsertSimulationRunDaysStatement: IZPreparedStatement := Connection.PrepareStatement(
          'INSERT INTO simulation_run_days (simulation_run_day_id, simulation_day_id, day_number, run_number) VALUES (?, ?, ?, ?);');
        InsertSimulationRunDaysStatement.SetString(1, SimulationRunDayID);
        InsertSimulationRunDaysStatement.SetString(2, SimulationDayID);
        InsertSimulationRunDaysStatement.SetInt(3, 0);
        InsertSimulationRunDaysStatement.SetInt(4, CurrentRun);
        InsertSimulationRunDaysStatement.ExecutePrepared;

        // Initialize values in run_days.
        var CountSusceptible: Integer := 0;
        var CountIncubated: Integer := 0;
        var CountDiseased: Integer := 0;
        var CountImmune: Integer := 0;
        var CountDeceased: Integer := 0;
        var CountInfectious: Integer := 0;
        var DeltaSusceptible: Integer := 0;
        var DeltaIncubated: Integer := 0;
        var DeltaDiseased: Integer := 0;
        var DeltaInfected: Integer := 0;
        var DeltaImmune: Integer := 0;
        var DeltaDeceased: Integer := 0;
        var DeltaInfectious: Integer := 0;
        var ReproductionCountInfected: Integer := 0;
        var ReproductionCountInfectious: Integer := 0;
        var InfectedHistory1: Integer := 0;
        var InfectedHistory2: Integer := 0;
        var InfectedHistory3: Integer := 0;
        var InfectedHistory4: Integer := 0;
        var InfectedHistory5: Integer := 0;
        var InfectedHistory6: Integer := 0;
        var InfectedHistory7: Integer := 0;

        var GetSimulationPeopleStatusStatement: IZPreparedStatement := Connection.PrepareStatement(
        'SELECT * FROM view_day_zero_run_people WHERE (simulation_id=?);');
        GetSimulationPeopleStatusStatement.SetString(1, ASimulationID);
        var GetSimulationPeopleStatusResultSet: IZResultSet := GetSimulationPeopleStatusStatement.ExecuteQueryPrepared;
        if not(IsSQLite) then GetSimulationPeopleStatusResultSet.First; // select the first (and only) record into the ResultSet to avoid an exception

        People.Clear;
        if IsSQLite then GetSimulationPeopleStatusResultSet.Next; // SQLite will otherwise store the first record twice.
        repeat
          var Person: TSimulation.TPerson := TSimulation.TPerson.Create();
          Person.InitializeDayZero(
            GetSimulationPeopleStatusResultSet.GetStringByName('person_id'),
            GetSimulationPeopleStatusResultSet.GetIntByName('person_number'),
            MainModel.GetPrimaryKeyValue,
            SimulationRunDayID,
            CurrentRun,
            GetSimulationPeopleStatusResultSet.GetIntByName('initial_day_of_infectious'),
            GetSimulationPeopleStatusResultSet.GetDoubleByName('susceptibility'),
            GetSimulationPeopleStatusResultSet.GetDoubleByName('infectiousness'),
            GetSimulationPeopleStatusResultSet.GetDoubleByName('mortality'),
            GetSimulationPeopleStatusResultSet.GetDoubleByName('initial_immunity'),
            GetSimulationPeopleStatusResultSet.GetIntByName('incubation_period'),
            GetSimulationPeopleStatusResultSet.GetIntByName('disease_period'),
            GetSimulationPeopleStatusResultSet.GetIntByName('infectious_delay_period'),
            GetSimulationPeopleStatusResultSet.GetIntByName('infectious_period'),
            GetSimulationPeopleStatusResultSet.GetIntByName('halving_immunity_period'),
            GetSimulationPeopleStatusResultSet.GetIntByName('immunity_period'));
          People.Add(Person);

          if (Person.Susceptible) then Inc(CountSusceptible);
          if (Person.Incubated) then Inc(CountIncubated);
          if (Person.Diseased) then Inc(CountDiseased);
          if (Person.Immune) then Inc(CountImmune);
          if (Person.Deceased) then Inc(CountDeceased);
          if (Person.Infectious) then Inc(CountInfectious);
          if (Person.Infectious) then Inc(ReproductionCountInfectious);
          if (Person.InitialDayOfInfectious > 0) then
          begin
            var DaysAfterInfection: Integer := Person.InfectiousDelayPeriod + Person.InitialDayOfInfectious;
            case DaysAfterInfection of
              1: Inc(InfectedHistory1);
              2: Inc(InfectedHistory2);
              3: Inc(InfectedHistory3);
              4: Inc(InfectedHistory4);
              5: Inc(InfectedHistory5);
              6: Inc(InfectedHistory6);
              7: Inc(InfectedHistory7);
            end;
          end;
        until not(GetSimulationPeopleStatusResultSet.Next);

        var InsertSimulationPeopleStatusStatement: IZPreparedStatement := Connection.PrepareStatement(
          'INSERT INTO simulation_people_status ' +
          '(status_id, run_day_id, person_id, current_immunity, days_left_incubated, ' +
          'days_left_diseased, days_left_infectious_delay, ' +
          'days_left_infectious, days_left_immune, count_infected, sum_infected, deceased) ' +
          'VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);');
        for var P: TSimulation.TPerson in People do
        begin
          InsertSimulationPeopleStatusStatement.SetString(1, P.StatusID);
          InsertSimulationPeopleStatusStatement.SetString(2, SimulationRunDayID);
          InsertSimulationPeopleStatusStatement.SetString(3, P.PersonID);
          InsertSimulationPeopleStatusStatement.SetDouble(4, P.CurrentImmunity);
          InsertSimulationPeopleStatusStatement.SetInt(5, P.DaysLeftIncubated);
          InsertSimulationPeopleStatusStatement.SetInt(6, P.DaysLeftDiseased);
          InsertSimulationPeopleStatusStatement.SetInt(7, P.DaysLeftInfectiousDelay);
          InsertSimulationPeopleStatusStatement.SetInt(8, P.DaysLeftInfectious);
          InsertSimulationPeopleStatusStatement.SetInt(9, P.DaysLeftImmune);
          InsertSimulationPeopleStatusStatement.SetInt(10, P.CountInfected);
          InsertSimulationPeopleStatusStatement.SetInt(11, P.SumInfected);
          InsertSimulationPeopleStatusStatement.SetInt(12, IfThen(P.Deceased, 1, 0));
          InsertSimulationPeopleStatusStatement.ExecutePrepared;
        end;

        var UpdateSimulationRunDaysStatement: IZPreparedStatement := Connection.PrepareStatement(
          'UPDATE simulation_run_days SET count_susceptible = ?, count_incubated = ?, count_diseased = ?, ' +
          'count_immune = ?, count_deceased = ?, count_infectious = ?, delta_susceptible = ?, ' +
          'delta_incubated = ?, delta_diseased = ?, delta_immune = ?, delta_deceased = ?, ' +
          'delta_infectious = ?, reproduction_count_infected = ?, reproduction_count_infectious = ?, ' +
          'infected_history_1 = ?, infected_history_2 = ?, infected_history_3 = ?, infected_history_4 = ?, ' +
          'infected_history_5 = ?, infected_history_6 = ?, infected_history_7 = ? WHERE simulation_run_day_id = ?;');
        UpdateSimulationRunDaysStatement.SetInt(1, CountSusceptible);
        UpdateSimulationRunDaysStatement.SetInt(2, CountIncubated);
        UpdateSimulationRunDaysStatement.SetInt(3, CountDiseased);
        UpdateSimulationRunDaysStatement.SetInt(4, CountImmune);
        UpdateSimulationRunDaysStatement.SetInt(5, CountDeceased);
        UpdateSimulationRunDaysStatement.SetInt(6, CountInfectious);
        UpdateSimulationRunDaysStatement.SetInt(7, DeltaSusceptible);
        UpdateSimulationRunDaysStatement.SetInt(8, DeltaIncubated);
        UpdateSimulationRunDaysStatement.SetInt(9, DeltaDiseased);
        UpdateSimulationRunDaysStatement.SetInt(10, DeltaImmune);
        UpdateSimulationRunDaysStatement.SetInt(11, DeltaDeceased);
        UpdateSimulationRunDaysStatement.SetInt(12, DeltaInfectious);
        UpdateSimulationRunDaysStatement.SetInt(13, ReproductionCountInfected);
        UpdateSimulationRunDaysStatement.SetInt(14, ReproductionCountInfectious);
        UpdateSimulationRunDaysStatement.SetInt(15, InfectedHistory1);
        UpdateSimulationRunDaysStatement.SetInt(16, InfectedHistory2);
        UpdateSimulationRunDaysStatement.SetInt(17, InfectedHistory3);
        UpdateSimulationRunDaysStatement.SetInt(18, InfectedHistory4);
        UpdateSimulationRunDaysStatement.SetInt(19, InfectedHistory5);
        UpdateSimulationRunDaysStatement.SetInt(20, InfectedHistory6);
        UpdateSimulationRunDaysStatement.SetInt(21, InfectedHistory7);
        UpdateSimulationRunDaysStatement.SetString(22, SimulationRunDayID);
        UpdateSimulationRunDaysStatement.ExecutePrepared;

        // Update the associated task.
        var UpdateTaskStatement: IZPreparedStatement := Connection.PrepareStatement(
          'UPDATE tasks SET task_status = ?, task_owner = ?, completed_on = ?, calculation_time = ? WHERE task_id = ?;');
        UpdateTaskStatement.SetString(1, TaskStatusFinished);
        UpdateTaskStatement.SetNull(2, stString); // SetNull requires type of variable to be set to null.
        var TaskCompletedOn: TDateTime := Now;
        var TaskNewCalculationTime: TDateTime := TaskCompletedOn - TaskLastStartOn;
        UpdateTaskStatement.SetTimestamp(3, TaskCompletedOn);
        UpdateTaskStatement.SetTime(4, TaskNewCalculationTime + TaskLastCalculationTime);
        UpdateTaskStatement.SetString(5, TaskID);
        UpdateTaskStatement.ExecutePrepared;

        Result := Result + 1;
      end;
    end;
  finally
    People.Free;
    Connection.Close;
  end;
end;

class function TSimulation.InitializeSimulation(
  const ASimulationID: String): Integer;
begin
  // Initialize functions result.
  Result := 0;

  // Establishing Connection.
  var ConnectionStr: String := MainModel.ConnectionURL;
  var IsSQLite: Boolean := (Copy(ConnectionStr, 6, 6) = 'sqlite');
  var Connection: IZConnection := DriverManager.GetConnection(ConnectionStr);

  try
    // Read the values of the associated task.
    var ReadTaskStatement: IZPreparedStatement := Connection.PrepareStatement(
      'SELECT * FROM tasks WHERE (record_id=?) and (task_type=?);');
    // Field record_id in table tasks holds the simulation_id.
    ReadTaskStatement.SetString(1, ASimulationID);
    ReadTaskStatement.SetString(2, TaskTypeSimulationInitialization);
    var ReadTaskResultSet: IZResultSet := ReadTaskStatement.ExecuteQueryPrepared;

    if not(IsSQLite) then ReadTaskResultSet.First; // select the first (and only) record into the ResultSet to avoid an exception
    var TaskStatus: String := ReadTaskResultSet.GetStringByName('task_status');
    // Cancel initialization if task is already in work or completed.
    if not((TaskStatus = TaskStatusNotStarted) or (TaskStatus = TaskStatusQueued)) then Exit;

    var TaskID: String := ReadTaskResultSet.GetStringByName('task_id');
    var TaskOwner: String := MainModel.Settings.OwnComputerName;
    var TaskFirstStartOn: TDateTime;
    if ReadTaskResultSet.IsNull(10) then
      TaskFirstStartOn := Now
    else
      TaskFirstStartOn := ReadTaskResultSet.GetDateByName('first_start_on');
    var TaskLastStartOn: TDateTime := Now;
    var TaskLastCalculationTime: TDateTime := 0;
    if not(ReadTaskResultSet.IsNull(13)) then
      TaskLastCalculationTime := ReadTaskResultSet.GetTimeByName('calculation_time');

    // Grab the associated task.
    var GrabTaskStatement: IZPreparedStatement := Connection.PrepareStatement(
      'UPDATE tasks SET task_status = ?, task_owner = ?, first_start_on = ?, last_start_on = ? WHERE task_id = ?;');
    GrabTaskStatement.SetString(1, TaskStatusRunning);
    GrabTaskStatement.SetString(2, TaskOwner);
    GrabTaskStatement.SetTimestamp(3, TaskFirstStartOn);
    GrabTaskStatement.SetTimestamp(4, TaskLastStartOn);
    GrabTaskStatement.SetString(5, TaskID);
    GrabTaskStatement.ExecutePrepared;

    var ReadDayCountStatement: IZPreparedStatement := Connection.PrepareStatement(
      'SELECT simulation_duration FROM simulations WHERE (simulation_id = ?);');
    // Field record_id in table tasks holds the simulation_id.
    ReadDayCountStatement.SetString(1, ASimulationID);
    var ReadDayCountResultSet: IZResultSet := ReadDayCountStatement.ExecuteQueryPrepared;
    if not(IsSQLite) then ReadDayCountResultSet.First; // select the first (and only) record into the ResultSet to avoid an exception
    var DayCount: Integer := ReadDayCountResultSet.GetIntByName('simulation_duration');

    for var DayNo := 0 to DayCount do
    begin
      // Check if the record already exists.
      var CheckExistsStatement: IZPreparedStatement := Connection.PrepareStatement(
        'SELECT count(simulation_day_id) as day_count FROM simulation_days WHERE ((simulation_id = ?) and (day_number = ?));');
      CheckExistsStatement.SetString(1, ASimulationID);
      CheckExistsStatement.SetInt(2, DayNo);
      var CheckExistsResultSet: IZResultSet := CheckExistsStatement.ExecuteQueryPrepared;

      if not(IsSQLite) then CheckExistsResultSet.First; // select the first (and only) record into the ResultSet to avoid an exception
      var DayNotExists: Boolean := (CheckExistsResultSet.GetIntByName('day_count') = 0);

      if DayNotExists then
      begin
        // Create the corresponding record in simulation_days.
        var InsertRecordStatement: IZPreparedStatement := Connection.PrepareStatement(
          'INSERT INTO simulation_days (simulation_day_id, simulation_id, day_number) VALUES (?, ?, ?);');
        var SimulationDayID: String := MainModel.GetPrimaryKeyValue;
        InsertRecordStatement.SetString(1, SimulationDayID);
        InsertRecordStatement.SetString(2, ASimulationID);
        InsertRecordStatement.SetInt(3, DayNo);
        InsertRecordStatement.ExecutePrepared;

        Result := Result + 1;
      end;
    end;

    // Update the associated task.
    var UpdateTaskStatement: IZPreparedStatement := Connection.PrepareStatement(
      'UPDATE tasks SET task_status = ?, task_owner = ?, completed_on = ?, calculation_time = ? WHERE task_id = ?;');
    UpdateTaskStatement.SetString(1, TaskStatusFinished);
    UpdateTaskStatement.SetNull(2, stString); // SetNull requires type of variable to be set to null.
    var TaskCompletedOn: TDateTime := Now;
    var TaskNewCalculationTime: TDateTime := TaskCompletedOn - TaskLastStartOn;
    UpdateTaskStatement.SetTimestamp(3, TaskCompletedOn);
    UpdateTaskStatement.SetTime(4, TaskNewCalculationTime + TaskLastCalculationTime);
    UpdateTaskStatement.SetString(5, TaskID);
    UpdateTaskStatement.ExecutePrepared;
  finally
    Connection.Close;
  end;
end;

class function TSimulation.IsSQLiteConnection(
  const AConnectionStr: String): Boolean;
begin
  Result := (Copy(AConnectionStr, 6, 6) = 'sqlite');
end;

class function TSimulation.EvaluateDay(const ASimulationID: String;
  const ADayNumber: Integer): Boolean;
begin
  // Initialize functions result.
  Result := false;

  // Establishing Connection.
  var ConnectionStr: String := MainModel.ConnectionURL;
  var Connection: IZConnection := DriverManager.GetConnection(ConnectionStr);

  var Task: TSimulationTask := TSimulationTask.Create(Connection);
  Task.LoadFromDataBase(ASimulationID, TaskTypeDayEvaluation, ADayNumber);
  try
    if (Task.IsAvailable and Task.ConditionsMet) then
    begin
      Task.Grab;
      var CurrentDay: TSimulationDay := TSimulationDay.Create(Connection, ASimulationID, ADayNumber);
      try
        if (ADayNumber > 0) then
        // If the day_number is greater than zero, evaluate simulation day using previous one.
        begin
          var PreviousDay: TSimulationDay := TSimulationDay.Create(Connection, ASimulationID, ADayNumber - 1);
          try
            PreviousDay.LoadFromDataBase(ASimulationID, ADayNumber - 1);
            CurrentDay.LoadFromDataBase(ASimulationID, ADayNumber);
            CurrentDay.Evaluate(PreviousDay);
            CurrentDay.UpdateToDatabase;
          finally
            PreviousDay.Free;
          end;
        end
        else
        // If day_number is zero, evaluate simulation day without previous one.
        begin
          CurrentDay.LoadFromDataBase(ASimulationID, ADayNumber);
          CurrentDay.Evaluate;
          CurrentDay.UpdateToDatabase;
        end;
        Result := true;
        Task.Release;
      finally
        CurrentDay.Free;
      end;
    end;
  finally
    Task.Free;
    Connection.Close;
  end;
end;

class function TSimulation.ExecuteDay(const ASimulationID: String; const ADayNumber:
    Integer): Integer;
begin
  // Initialize functions result.
  Result := 0;

  // Get number of runs.
  var NumberOfRuns: Integer;
  var ConnectionStr: String := MainModel.ConnectionURL;
  var Connection: IZConnection := DriverManager.GetConnection(ConnectionStr);
  try
    var Statement: IZPreparedStatement := Connection.PrepareStatement(
      'SELECT number_of_runs FROM simulations WHERE simulation_id = ?;');
    Statement.SetString(1, ASimulationID);
    var ResultSet: IZResultSet := Statement.ExecuteQueryPrepared;
    if not(IsSQLiteConnection(ConnectionStr)) then ResultSet.First; // select the first (and only) record into the ResultSet to avoid an exception
    NumberOfRuns := ResultSet.GetIntByName('number_of_runs');
  finally
    Connection.Close;
  end;

  // Execute all runs of the day.
  for var I: Integer := 1 to NumberOfRuns do
  begin
    if ExecuteDayRun(ASimulationID, ADayNumber, I) then
      Result := Result + 1;
  end;
end;


end.
