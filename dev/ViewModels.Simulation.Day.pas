unit ViewModels.Simulation.Day;

interface

uses
  Models.MainModel,
  Models.Nullable,
  ZDbcIntfs;

type
  /// <summary>Array with dynamic memory allocation to hold values of type double.
  ///  Needed for System.Math.Mean and System.Math.StdDev.<summary>
  TDoublesArray = array of Double;
  /// <summary>Represents a record in the database table simulation_days.
  /// Contains methods to create, insert, update, read a record from the database
  /// and to calculate the values of such a record from the corresponding records
  /// in table simulation_run_days.<summary>
  TSimulationDay = class(TObject)
  private
    FSimulationDayID: String;
    FSimulationID: String;
    FDayNumber: Integer;
    FMeanSusceptible: TNullable<Double>;
    FDeviationSusceptible: TNullable<Double>;
    FDeltaSusceptible: TNullable<Double>;
    FMeanIncubated: TNullable<Double>;
    FDeviationIncubated: TNullable<Double>;
    FDeltaIncubated: TNullable<Double>;
    FMeanDiseased: TNullable<Double>;
    FDeviationDiseased: TNullable<Double>;
    FDeltaDiseased: TNullable<Double>;
    FMeanInfected: TNullable<Double>;
    FDeviationInfected: TNullable<Double>;
    FDeltaInfected: TNullable<Double>;
    FMeanImmune: TNullable<Double>;
    FDeviationImmune: TNullable<Double>;
    FDeltaImmune: TNullable<Double>;
    FMeanDeceased: TNullable<Double>;
    FDeviationDeceased: TNullable<Double>;
    FDeltaDeceased: TNullable<Double>;
    FMeanRemoved: TNullable<Double>;
    FDeviationRemoved: TNullable<Double>;
    FDeltaRemoved: TNullable<Double>;
    FMeanInfectious: TNullable<Double>;
    FDeviationInfectious: TNullable<Double>;
    FDeltaInfectious: TNullable<Double>;
    FMeanReproduction: TNullable<Double>;
    FDeviationReproduction: TNullable<Double>;
    FDeltaReproduction: TNullable<Double>;
    FMeanInfectionRisk: TNullable<Double>;
    FDeviationInfectionRisk: TNullable<Double>;
    FDeltaInfectionRisk: TNullable<Double>;
    FMeanInfectedLast7Days: TNullable<Double>;
    FDeviationInfectedLast7Days: TNullable<Double>;
    FDeltaInfectedLast7Days: TNullable<Double>;
    FConnection: IZConnection;
    FConnectionStr: string;
    FRunsCount: TNullable<Integer>;
    FPopulationNumber: TNullable<Integer>;
    FMeanNewInfected: TNullable<Double>;
    FDeviationNewInfected: TNullable<Double>;
    FDeltaNewInfected: TNullable<Double>;
    function IsSQLiteConnection: Boolean;
    function GetRunsCount: Integer;
    function GetPopulationNumber: Integer;
  public
    constructor Create(const AConnection: IZConnection); overload;
    constructor Create(const AConnection: IZConnection; const ASimulationID: String; const ADayNumber: Integer); overload;
    procedure LoadFromDataBase(const ASimulationDayID: String); overload;
    procedure LoadFromDataBase(const ASimulationID: String; const ADayNumber: Integer); overload;
    procedure InsertIntoDatabase;
    procedure UpdateToDatabase;
    /// <summary>Calculate the field values of the object using the according
    /// simulation_run_day records and the values of the previous day.<summary>
    procedure Evaluate(APreviousDay: TSimulationDay); overload;
    ///<summary>Calculate the field values for day zero of the simulation, using
    /// only the according simulation_run_day records.<summary>
    procedure Evaluate; overload;
    property RunsCount: Integer read GetRunsCount;
    property PopulationNumber: Integer read GetPopulationNumber;
    property SimulationDayID: String read FSimulationDayID write FSimulationDayID;
    property SimulationID: String read FSimulationID write FSimulationID;
    property DayNumber: Integer read FDayNumber write FDayNumber;
    property MeanSusceptible: TNullable<Double> read FMeanSusceptible write
        FMeanSusceptible;
    property DeviationSusceptible: TNullable<Double> read FDeviationSusceptible
        write FDeviationSusceptible;
    property DeltaSusceptible: TNullable<Double> read FDeltaSusceptible write
        FDeltaSusceptible;
    property MeanIncubated: TNullable<Double> read FMeanIncubated write
        FMeanIncubated;
    property DeviationIncubated: TNullable<Double> read FDeviationIncubated write
        FDeviationIncubated;
    property DeltaIncubated: TNullable<Double> read FDeltaIncubated write
        FDeltaIncubated;
    property MeanDiseased: TNullable<Double> read FMeanDiseased write FMeanDiseased;
    property DeviationDiseased: TNullable<Double> read FDeviationDiseased write
        FDeviationDiseased;
    property DeltaDiseased: TNullable<Double> read FDeltaDiseased write
        FDeltaDiseased;
    property MeanInfected: TNullable<Double> read FMeanInfected write FMeanInfected;
    property DeviationInfected: TNullable<Double> read FDeviationInfected write
        FDeviationInfected;
    property DeltaInfected: TNullable<Double> read FDeltaInfected write
        FDeltaInfected;
    property MeanImmune: TNullable<Double> read FMeanImmune write FMeanImmune;
    property DeviationImmune: TNullable<Double> read FDeviationImmune write
        FDeviationImmune;
    property DeltaImmune: TNullable<Double> read FDeltaImmune write FDeltaImmune;
    property MeanDeceased: TNullable<Double> read FMeanDeceased write FMeanDeceased;
    property DeviationDeceased: TNullable<Double> read FDeviationDeceased write
        FDeviationDeceased;
    property DeltaDeceased: TNullable<Double> read FDeltaDeceased write
        FDeltaDeceased;
    property MeanRemoved: TNullable<Double> read FMeanRemoved write FMeanRemoved;
    property DeviationRemoved: TNullable<Double> read FDeviationRemoved write
        FDeviationRemoved;
    property DeltaRemoved: TNullable<Double> read FDeltaRemoved write FDeltaRemoved;
    property MeanInfectious: TNullable<Double> read FMeanInfectious write
        FMeanInfectious;
    property DeviationInfectious: TNullable<Double> read FDeviationInfectious write
        FDeviationInfectious;
    property DeltaInfectious: TNullable<Double> read FDeltaInfectious write
        FDeltaInfectious;
    property MeanReproduction: TNullable<Double> read FMeanReproduction write
        FMeanReproduction;
    property DeviationReproduction: TNullable<Double> read FDeviationReproduction
        write FDeviationReproduction;
    property DeltaReproduction: TNullable<Double> read FDeltaReproduction write
        FDeltaReproduction;
    property MeanInfectionRisk: TNullable<Double> read FMeanInfectionRisk write
        FMeanInfectionRisk;
    property DeviationInfectionRisk: TNullable<Double> read FDeviationInfectionRisk
        write FDeviationInfectionRisk;
    property DeltaInfectionRisk: TNullable<Double> read FDeltaInfectionRisk write
        FDeltaInfectionRisk;
    property MeanInfectedLast7Days: TNullable<Double> read FMeanInfectedLast7Days
        write FMeanInfectedLast7Days;
    property DeviationInfectedLast7Days: TNullable<Double> read
        FDeviationInfectedLast7Days write FDeviationInfectedLast7Days;
    property DeltaInfectedLast7Days: TNullable<Double> read FDeltaInfectedLast7Days
        write FDeltaInfectedLast7Days;
    property MeanNewInfected: TNullable<Double> read FMeanNewInfected write FMeanNewInfected;
    property DeviationNewInfected: TNullable<Double> read FDeviationNewInfected write FDeviationNewInfected;
    property DeltaNewInfected: TNullable<Double> read FDeltaNewInfected write FDeltaNewInfected;
  end;



implementation

uses
  System.Math;

{ TSimulationDay }

constructor TSimulationDay.Create(const AConnection: IZConnection);
begin
  inherited Create;

  FConnection := AConnection;
  FConnectionStr := MainModel.ConnectionURL;

  FRunsCount.Clear;
  FPopulationNumber.Clear;
end;

// Constructor that also initializes key field values.
constructor TSimulationDay.Create(const AConnection: IZConnection;
  const ASimulationID: String; const ADayNumber: Integer);
begin
  inherited Create;

  FConnection := AConnection;
  FConnectionStr := MainModel.ConnectionURL;

  FRunsCount.Clear;
  FPopulationNumber.Clear;

  SimulationDayID := MainModel.GetPrimaryKeyValue;
  SimulationID := ASimulationID;
  DayNumber := ADayNumber;
end;

procedure TSimulationDay.Evaluate;
begin
  var Statement: IZPreparedStatement := FConnection.PrepareStatement(
    'SELECT * FROM simulation_run_days WHERE (simulation_day_id = ?) AND (run_number = 1);');
  Statement.SetString(1, SimulationDayID);
  var ResultSet: IZResultSet := Statement.ExecuteQueryPrepared;
  // select the first (and only) record into the ResultSet to avoid an exception
  if not(IsSQLiteConnection) then ResultSet.First;

  MeanSusceptible.Value := 100 * ResultSet.GetIntByName('count_susceptible') / PopulationNumber;
  DeviationSusceptible.Value := 0;
  DeltaSusceptible.Clear;

  MeanIncubated.Value := 100 * ResultSet.GetIntByName('count_incubated') / PopulationNumber;
  DeviationIncubated.Value := 0;
  DeltaIncubated.Clear;

  MeanDiseased.Value := 100 * ResultSet.GetIntByName('count_diseased') / PopulationNumber;
  DeviationDiseased.Value := 0;
  DeltaDiseased.Clear;

  MeanInfected.Value := 100 * ResultSet.GetIntByName('count_infected') / PopulationNumber;
  DeviationInfected.Value := 0;
  DeltaInfected.Clear;

  MeanImmune.Value := 100 * ResultSet.GetIntByName('count_immune') / PopulationNumber;
  DeviationImmune.Value := 0;
  DeltaImmune.Clear;

  MeanDeceased.Value := 100 * ResultSet.GetIntByName('count_deceased') / PopulationNumber;
  DeviationDeceased.Value := 0;
  DeltaDeceased.Clear;

  MeanRemoved.Value := 100 * ResultSet.GetIntByName('count_removed') / PopulationNumber;
  DeviationRemoved.Value := 0;
  DeltaRemoved.Clear;

  MeanInfectious.Value := 100 * ResultSet.GetIntByName('count_infectious') / PopulationNumber;
  DeviationInfectious.Value := 0;
  DeltaInfectious.Clear;

  MeanReproduction.Clear;
  DeviationReproduction.Clear;
  DeltaReproduction.Clear;

  MeanInfectionRisk.Clear;
  DeviationInfectionRisk.Clear;
  DeltaInfectionRisk.Clear;

  MeanInfectedLast7Days.Value := 100 * ResultSet.GetIntByName('sum_infected_7_days') / PopulationNumber;
  DeviationInfectedLast7Days.Value := 0;
  DeltaInfectedLast7Days.Clear;

  MeanNewInfected.Clear;
  DeviationNewInfected.Clear;
  DeltaNewInfected.Clear;
end;

procedure TSimulationDay.Evaluate(APreviousDay: TSimulationDay);
begin
  var ValuesCountSusceptible: TDoublesArray;
  SetLength(ValuesCountSusceptible, RunsCount);
  var ValuesCountIncubated: TDoublesArray;
  SetLength(ValuesCountIncubated, RunsCount);
  var ValuesCountDiseased: TDoublesArray;
  SetLength(ValuesCountDiseased, RunsCount);
  var ValuesCountInfected: TDoublesArray;
  SetLength(ValuesCountInfected, RunsCount);
  var ValuesCountImmune: TDoublesArray;
  SetLength(ValuesCountImmune, RunsCount);
  var ValuesCountDeceased: TDoublesArray;
  SetLength(ValuesCountDeceased, RunsCount);
  var ValuesCountRemoved: TDoublesArray;
  SetLength(ValuesCountRemoved, RunsCount);
  var ValuesCountInfectious: TDoublesArray;
  SetLength(ValuesCountInfectious, RunsCount);

  var ValuesReproduction: TDoublesArray;
  SetLength(ValuesReproduction, 0);
  var ValuesInfectionRisk: TDoublesArray;
  SetLength(ValuesInfectionRisk, 0);
  var ValuesCountNewInfected: TDoublesArray;
  SetLength(ValuesCountNewInfected, RunsCount);
  var ValuesSumInfected7Days: TDoublesArray;
  SetLength(ValuesSumInfected7Days, RunsCount);

  var Statement: IZPreparedStatement := FConnection.PrepareStatement(
    'SELECT * FROM simulation_run_days WHERE (simulation_day_id = ?);');
  Statement.SetString(1, SimulationDayID);
  var ResultSet: IZResultSet := Statement.ExecuteQueryPrepared;
  // select the first (and only) record into the ResultSet to avoid an exception
  if not(IsSQLiteConnection) then ResultSet.First;

  for var I: Integer := 0 to RunsCount - 1 do
  begin
    ValuesCountSusceptible[I] := ResultSet.GetIntByName('count_susceptible');
    ValuesCountIncubated[I] := ResultSet.GetIntByName('count_incubated');
    ValuesCountDiseased[I] := ResultSet.GetIntByName('count_diseased');
    ValuesCountInfected[I] := ResultSet.GetIntByName('count_infected');
    ValuesCountImmune[I] := ResultSet.GetIntByName('count_immune');
    ValuesCountDeceased[I] := ResultSet.GetIntByName('count_deceased');
    ValuesCountRemoved[I] := ResultSet.GetIntByName('count_removed');
    ValuesCountInfectious[I] := ResultSet.GetIntByName('count_infectious');

    var CountInfectious: Double := ResultSet.GetIntByName('reproduction_count_infectious');
    // Reproduction can only be calculated if the CountInfectious is greater than 0
    if CountInfectious > 0 then
    begin
      var CountInfected: Double := ResultSet.GetIntByName('reproduction_count_infected');
      var Reproduction: Double := CountInfected / CountInfectious;
      // Increase lenght of array by 1
      SetLength(ValuesReproduction, Length(ValuesReproduction) + 1);
      // save calculated value at the end of the array
      ValuesReproduction[Length(ValuesReproduction) - 1] := Reproduction;
    end;

    var RiskyContacts: Double := ResultSet.GetIntByName('count_risky_contacts');
    // InfectionRisk can only be calculated if the value of RiskyContacts is greater than 0
    if RiskyContacts > 0 then
    begin
      var NewInfected: Double := ResultSet.GetIntByName('count_new_infected');
      var InfectionRisk: Double := NewInfected / RiskyContacts * 100;
      // Increase lenght of array by 1
      SetLength(ValuesInfectionRisk, Length(ValuesInfectionRisk) + 1);
      // save calculated value at the end of the array
      ValuesInfectionRisk[Length(ValuesInfectionRisk) - 1] := InfectionRisk;
    end;

    ValuesCountNewInfected[I] := ResultSet.GetIntByName('count_new_infected');
    ValuesSumInfected7Days[I] := ResultSet.GetIntByName('sum_infected_7_days');
    ResultSet.Next;
  end;

  MeanSusceptible.Value := 100 * Mean(ValuesCountSusceptible) / PopulationNumber;
  if Length(ValuesCountSusceptible) < 2 then
    DeviationSusceptible.Value := 0
  else
    DeviationSusceptible.Value := 100 * StdDev(ValuesCountSusceptible) / PopulationNumber;
  DeltaSusceptible.Value := Self.MeanSusceptible.Value - APreviousDay.MeanSusceptible.Value;

  MeanIncubated.Value := 100 * Mean(ValuesCountIncubated) / PopulationNumber;
  if Length(ValuesCountIncubated) < 2 then
    DeviationIncubated.Value := 0
  else
    DeviationIncubated.Value := 100 * StdDev(ValuesCountIncubated) / PopulationNumber;
  DeltaIncubated.Value := Self.MeanIncubated.Value - APreviousDay.MeanIncubated.Value;

  MeanDiseased.Value := 100 * Mean(ValuesCountDiseased) / PopulationNumber;
  if Length(ValuesCountDiseased) < 2 then
    DeviationDiseased.Value := 0
  else
    DeviationDiseased.Value := 100 * StdDev(ValuesCountDiseased) / PopulationNumber;
  DeltaDiseased.Value := Self.MeanDiseased.Value - APreviousDay.MeanDiseased.Value;

  MeanInfected.Value := 100 * Mean(ValuesCountInfected) / PopulationNumber;
  if Length(ValuesCountInfected) < 2 then
    DeviationInfected.Value := 0
  else
    DeviationInfected.Value := 100 * StdDev(ValuesCountInfected) / PopulationNumber;
  DeltaInfected.Value := Self.MeanInfected.Value - APreviousDay.MeanInfected.Value;

  MeanImmune.Value := 100 * Mean(ValuesCountImmune) / PopulationNumber;
  if Length(ValuesCountImmune) < 2 then
    DeviationImmune.Value := 0
  else
    DeviationImmune.Value := 100 * StdDev(ValuesCountImmune) / PopulationNumber;
  DeltaImmune.Value := Self.MeanImmune.Value - APreviousDay.MeanImmune.Value;

  MeanDeceased.Value := 100 * Mean(ValuesCountDeceased) / PopulationNumber;
  if Length(ValuesCountDeceased) < 2 then
    DeviationDeceased.Value := 0
  else
    DeviationDeceased.Value := 100 * StdDev(ValuesCountDeceased) / PopulationNumber;
  DeltaDeceased.Value := Self.MeanDeceased.Value - APreviousDay.MeanDeceased.Value;

  MeanRemoved.Value := 100 * Mean(ValuesCountRemoved) / PopulationNumber;
  if Length(ValuesCountRemoved) < 2 then
    DeviationRemoved.Value := 0
  else
    DeviationRemoved.Value := 100 * StdDev(ValuesCountRemoved) / PopulationNumber;
  DeltaRemoved.Value := Self.MeanRemoved.Value - APreviousDay.MeanRemoved.Value;

  MeanInfectious.Value := 100 * Mean(ValuesCountInfectious) / PopulationNumber;
  if Length(ValuesCountInfectious) < 2 then
    DeviationInfectious.Value := 0
  else
    DeviationInfectious.Value := 100 * StdDev(ValuesCountInfectious) / PopulationNumber;
  DeltaInfectious.Value := Self.MeanInfectious.Value - APreviousDay.MeanInfectious.Value;

  if Length(ValuesReproduction) > 0 then
  begin
    MeanReproduction.Value := Mean(ValuesReproduction);
    if Length(ValuesReproduction) < 2 then
      DeviationReproduction.Value := 0
    else
      DeviationReproduction.Value := StdDev(ValuesReproduction);
    if APreviousDay.MeanReproduction.HasValue then
      DeltaReproduction.Value := Self.MeanReproduction.Value - APreviousDay.MeanReproduction.Value
    else
      DeltaReproduction.Clear;
  end
  else
  begin
    MeanReproduction.Clear;
    DeviationReproduction.Clear;
    DeltaReproduction.Clear;
  end;

  if Length(ValuesInfectionRisk) > 0 then
  begin
    MeanInfectionRisk.Value := Mean(ValuesInfectionRisk);
    if Length(ValuesInfectionRisk) < 2 then
      DeviationInfectionRisk.Value := 0
    else
      DeviationInfectionRisk.Value := StdDev(ValuesInfectionRisk);
    if APreviousDay.MeanInfectionRisk.HasValue then
      DeltaInfectionRisk.Value := Self.MeanInfectionRisk.Value - APreviousDay.MeanInfectionRisk.Value
    else
      DeltaInfectionRisk.Clear;
  end
  else
  begin
    MeanInfectionRisk.Clear;
    DeviationInfectionRisk.Clear;
    DeltaInfectionRisk.Clear;
  end;

  MeanInfectedLast7Days.Value := 100 * Mean(ValuesSumInfected7Days) / PopulationNumber;
  if Length(ValuesSumInfected7Days) < 2 then
    DeviationInfectedLast7Days.Value := 0
  else
    DeviationInfectedLast7Days.Value := 100 * StdDev(ValuesSumInfected7Days) / PopulationNumber;
  if Self.MeanInfectedLast7Days.HasValue and APreviousDay.MeanInfectedLast7Days.HasValue then
    DeltaInfectedLast7Days.Value := Self.MeanInfectedLast7Days.Value - APreviousDay.MeanInfectedLast7Days.Value
  else
    DeltaInfectedLast7Days.Clear;

  MeanNewInfected.Value := 100 * Mean(ValuesCountNewInfected) / PopulationNumber;
  if Length(ValuesCountNewInfected) < 2 then
    DeviationNewInfected.Value := 0
  else
    DeviationNewInfected.Value := 100 * StdDev(ValuesCountNewInfected) / PopulationNumber;
  if Self.MeanNewInfected.HasValue and APreviousDay.MeanNewInfected.HasValue then
    DeltaNewInfected.Value := Self.MeanNewInfected.Value - APreviousDay.MeanNewInfected.Value
  else
    DeltaNewInfected.Clear;
end;

function TSimulationDay.GetPopulationNumber: Integer;
begin
  // On first call, get number of people in the population from database.
  if FPopulationNumber.IsNull then
  begin
    var Statement: IZPreparedStatement := FConnection.PrepareStatement(
      'SELECT p.population_number AS value ' +
      'FROM simulation_days sd ' +
      'JOIN simulations s ON (sd.simulation_id = s.simulation_id) ' +
      'JOIN simulation_setups ss ON (s.simulation_setup_id = ss.simulation_setup_id) ' +
      'JOIN projects p ON (ss.project_id = p.project_id) ' +
      'WHERE (sd.simulation_day_id = ?);');
    Statement.SetString(1, SimulationDayID);
    var ResultSet: IZResultSet := Statement.ExecuteQueryPrepared;
    // select the first (and only) record into the ResultSet to avoid an exception
    if not(IsSQLiteConnection) then ResultSet.First;
    FPopulationNumber.Value := ResultSet.GetIntByName('value');
  end;
  Result := FPopulationNumber.Value;
end;

function TSimulationDay.GetRunsCount: Integer;
begin
  // On first call, get number of total runs from database.
  if FRunsCount.IsNull then
  begin
    var Statement: IZPreparedStatement := FConnection.PrepareStatement(
      'SELECT count(simulation_run_day_id) AS value FROM simulation_run_days WHERE (simulation_day_id = ?);');
    Statement.SetString(1, SimulationDayID);
    var ResultSet: IZResultSet := Statement.ExecuteQueryPrepared;
    // select the first (and only) record into the ResultSet to avoid an exception
    if not(IsSQLiteConnection) then ResultSet.First;
    FRunsCount.Value := ResultSet.GetIntByName('value');
  end;
  Result := FRunsCount.Value;
end;

procedure TSimulationDay.InsertIntoDatabase;
begin
  var Statement: IZPreparedStatement := FConnection.PrepareStatement(
    'INSERT INTO simulation_days (simulation_day_id, simulation_id, day_number) VALUES (?, ?, ?);');
  Statement.SetString(1, SimulationDayID);
  Statement.SetString(2, SimulationID);
  Statement.SetInt(3, DayNumber);
  Statement.ExecutePrepared;
end;

function TSimulationDay.IsSQLiteConnection: Boolean;
begin
  Result := (Copy(FConnectionStr, 6, 6) = 'sqlite');
end;

procedure TSimulationDay.LoadFromDataBase(const ASimulationID: String;
  const ADayNumber: Integer);
begin
  var Statement: IZPreparedStatement := FConnection.PrepareStatement(
    'SELECT * FROM simulation_days WHERE (simulation_id = ?) AND (day_number = ?);');
  Statement.SetString(1, ASimulationID);
  Statement.SetInt(2, ADayNumber);
  var ResultSet: IZResultSet := Statement.ExecuteQueryPrepared;
  // select the first (and only) record into the ResultSet to avoid an exception
  if not(IsSQLiteConnection) then ResultSet.First;

  SimulationDayID := ResultSet.GetStringByName('simulation_day_id');
  SimulationID := ASimulationID;
  DayNumber := ADayNumber;

  if ResultSet.IsNullByName('mean_susceptible') then MeanSusceptible.Clear
  else MeanSusceptible.Value := ResultSet.GetDoubleByName('mean_susceptible');
  if ResultSet.IsNullByName('deviation_susceptible') then DeviationSusceptible.Clear
  else DeviationSusceptible.Value := ResultSet.GetDoubleByName('deviation_susceptible');
  if ResultSet.IsNullByName('delta_susceptible') then DeltaSusceptible.Clear
  else DeltaSusceptible.Value := ResultSet.GetDoubleByName('delta_susceptible');

  if ResultSet.IsNullByName('mean_incubated') then MeanIncubated.Clear
  else MeanIncubated.Value := ResultSet.GetDoubleByName('mean_incubated');
  if ResultSet.IsNullByName('deviation_incubated') then DeviationIncubated.Clear
  else DeviationIncubated.Value := ResultSet.GetDoubleByName('deviation_incubated');
  if ResultSet.IsNullByName('delta_incubated') then DeltaIncubated.Clear
  else DeltaIncubated.Value := ResultSet.GetDoubleByName('delta_incubated');

  if ResultSet.IsNullByName('mean_diseased') then MeanDiseased.Clear
  else MeanDiseased.Value := ResultSet.GetDoubleByName('mean_diseased');
  if ResultSet.IsNullByName('deviation_diseased') then DeviationDiseased.Clear
  else DeviationDiseased.Value := ResultSet.GetDoubleByName('deviation_diseased');
  if ResultSet.IsNullByName('delta_diseased') then DeltaDiseased.Clear
  else DeltaDiseased.Value := ResultSet.GetDoubleByName('delta_diseased');

  if ResultSet.IsNullByName('mean_infected') then MeanInfected.Clear
  else MeanInfected.Value := ResultSet.GetDoubleByName('mean_infected');
  if ResultSet.IsNullByName('deviation_infected') then DeviationInfected.Clear
  else DeviationInfected.Value := ResultSet.GetDoubleByName('deviation_infected');
  if ResultSet.IsNullByName('delta_infected') then DeltaInfected.Clear
  else DeltaInfected.Value := ResultSet.GetDoubleByName('delta_infected');

  if ResultSet.IsNullByName('mean_immune') then MeanImmune.Clear
  else MeanImmune.Value := ResultSet.GetDoubleByName('mean_immune');
  if ResultSet.IsNullByName('deviation_immune') then DeviationImmune.Clear
  else DeviationImmune.Value := ResultSet.GetDoubleByName('deviation_immune');
  if ResultSet.IsNullByName('delta_immune') then DeltaImmune.Clear
  else DeltaImmune.Value := ResultSet.GetDoubleByName('delta_immune');

  if ResultSet.IsNullByName('mean_deceased') then MeanDiseased.Clear
  else MeanDeceased.Value := ResultSet.GetDoubleByName('mean_deceased');
  if ResultSet.IsNullByName('deviation_deceased') then DeviationDeceased.Clear
  else DeviationDeceased.Value := ResultSet.GetDoubleByName('deviation_deceased');
  if ResultSet.IsNullByName('delta_deceased') then DeltaDeceased.Clear
  else DeltaDeceased.Value := ResultSet.GetDoubleByName('delta_deceased');

  if ResultSet.IsNullByName('mean_removed') then MeanRemoved.Clear
  else MeanRemoved.Value := ResultSet.GetDoubleByName('mean_removed');
  if ResultSet.IsNullByName('deviation_removed') then DeviationRemoved.Clear
  else DeviationRemoved.Value := ResultSet.GetDoubleByName('deviation_removed');
  if ResultSet.IsNullByName('delta_removed') then DeltaRemoved.Clear
  else DeltaRemoved.Value := ResultSet.GetDoubleByName('delta_removed');

  if ResultSet.IsNullByName('mean_infectious') then MeanInfectious.Clear
  else MeanInfectious.Value := ResultSet.GetDoubleByName('mean_infectious');
  if ResultSet.IsNullByName('deviation_infectious') then DeviationInfectious.Clear
  else DeviationInfectious.Value := ResultSet.GetDoubleByName('deviation_infectious');
  if ResultSet.IsNullByName('delta_infectious') then DeltaInfectious.Clear
  else DeltaInfectious.Value := ResultSet.GetDoubleByName('delta_infectious');

  if ResultSet.IsNullByName('mean_reproduction') then MeanReproduction.Clear
  else MeanReproduction.Value := ResultSet.GetDoubleByName('mean_reproduction');
  if ResultSet.IsNullByName('deviation_reproduction') then DeviationReproduction.Clear
  else DeviationReproduction.Value := ResultSet.GetDoubleByName('deviation_reproduction');
  if ResultSet.IsNullByName('delta_reproduction') then DeltaReproduction.Clear
  else DeltaReproduction.Value := ResultSet.GetDoubleByName('delta_reproduction');

  if ResultSet.IsNullByName('mean_infection_risk') then MeanInfectionRisk.Clear
  else MeanInfectionRisk.Value := ResultSet.GetDoubleByName('mean_infection_risk');
  if ResultSet.IsNullByName('deviation_infection_risk') then DeviationInfectionRisk.Clear
  else DeviationInfectionRisk.Value := ResultSet.GetDoubleByName('deviation_infection_risk');
  if ResultSet.IsNullByName('delta_infection_risk') then DeltaInfectionRisk.Clear
  else DeltaInfectionRisk.Value := ResultSet.GetDoubleByName('delta_infection_risk');

  if ResultSet.IsNullByName('mean_infected_last_7_days') then MeanInfectedLast7Days.Clear
  else MeanInfectedLast7Days.Value := ResultSet.GetDoubleByName('mean_infected_last_7_days');
  if ResultSet.IsNullByName('deviation_infected_last_7_days') then DeviationInfectedLast7Days.Clear
  else DeviationInfectedLast7Days.Value := ResultSet.GetDoubleByName('deviation_infected_last_7_days');
  if ResultSet.IsNullByName('delta_infected_last_7_days') then DeltaInfectedLast7Days.Clear
  else DeltaInfectedLast7Days.Value := ResultSet.GetDoubleByName('delta_infected_last_7_days');

  if ResultSet.IsNullByName('mean_new_infected') then MeanNewInfected.Clear
  else MeanNewInfected.Value := ResultSet.GetDoubleByName('mean_new_infected');
  if ResultSet.IsNullByName('deviation_new_infected') then DeviationNewInfected.Clear
  else DeviationNewInfected.Value := ResultSet.GetDoubleByName('deviation_new_infected');
  if ResultSet.IsNullByName('delta_new_infected') then DeltaNewInfected.Clear
  else DeltaNewInfected.Value := ResultSet.GetDoubleByName('delta_new_infected');
end;

procedure TSimulationDay.LoadFromDataBase(const ASimulationDayID: String);
begin
  var Statement: IZPreparedStatement := FConnection.PrepareStatement(
    'SELECT * FROM simulation_days WHERE (simulation_day_id = ?);');
  Statement.SetString(1, ASimulationDayID);
  var ResultSet: IZResultSet := Statement.ExecuteQueryPrepared;
  // select the first (and only) record into the ResultSet to avoid an exception
  if not(IsSQLiteConnection) then ResultSet.First;

  SimulationDayID := ASimulationDayID;
  SimulationID := ResultSet.GetStringByName('simulation_id');
  DayNumber := ResultSet.GetIntByName('day_number');

  if ResultSet.IsNullByName('mean_susceptible') then MeanSusceptible.Clear
  else MeanSusceptible.Value := ResultSet.GetDoubleByName('mean_susceptible');
  if ResultSet.IsNullByName('deviation_susceptible') then DeviationSusceptible.Clear
  else DeviationSusceptible.Value := ResultSet.GetDoubleByName('deviation_susceptible');
  if ResultSet.IsNullByName('delta_susceptible') then DeltaSusceptible.Clear
  else DeltaSusceptible.Value := ResultSet.GetDoubleByName('delta_susceptible');

  if ResultSet.IsNullByName('mean_incubated') then MeanIncubated.Clear
  else MeanIncubated.Value := ResultSet.GetDoubleByName('mean_incubated');
  if ResultSet.IsNullByName('deviation_incubated') then DeviationIncubated.Clear
  else DeviationIncubated.Value := ResultSet.GetDoubleByName('deviation_incubated');
  if ResultSet.IsNullByName('delta_incubated') then DeltaIncubated.Clear
  else DeltaIncubated.Value := ResultSet.GetDoubleByName('delta_incubated');

  if ResultSet.IsNullByName('mean_diseased') then MeanDiseased.Clear
  else MeanDiseased.Value := ResultSet.GetDoubleByName('mean_diseased');
  if ResultSet.IsNullByName('deviation_diseased') then DeviationDiseased.Clear
  else DeviationDiseased.Value := ResultSet.GetDoubleByName('deviation_diseased');
  if ResultSet.IsNullByName('delta_diseased') then DeltaDiseased.Clear
  else DeltaDiseased.Value := ResultSet.GetDoubleByName('delta_diseased');

  if ResultSet.IsNullByName('mean_infected') then MeanInfected.Clear
  else MeanInfected.Value := ResultSet.GetDoubleByName('mean_infected');
  if ResultSet.IsNullByName('deviation_infected') then DeviationInfected.Clear
  else DeviationInfected.Value := ResultSet.GetDoubleByName('deviation_infected');
  if ResultSet.IsNullByName('delta_infected') then DeltaInfected.Clear
  else DeltaInfected.Value := ResultSet.GetDoubleByName('delta_infected');

  if ResultSet.IsNullByName('mean_immune') then MeanImmune.Clear
  else MeanImmune.Value := ResultSet.GetDoubleByName('mean_immune');
  if ResultSet.IsNullByName('deviation_immune') then DeviationImmune.Clear
  else DeviationImmune.Value := ResultSet.GetDoubleByName('deviation_immune');
  if ResultSet.IsNullByName('delta_immune') then DeltaImmune.Clear
  else DeltaImmune.Value := ResultSet.GetDoubleByName('delta_immune');

  if ResultSet.IsNullByName('mean_deceased') then MeanDiseased.Clear
  else MeanDeceased.Value := ResultSet.GetDoubleByName('mean_deceased');
  if ResultSet.IsNullByName('deviation_deceased') then DeviationDeceased.Clear
  else DeviationDeceased.Value := ResultSet.GetDoubleByName('deviation_deceased');
  if ResultSet.IsNullByName('delta_deceased') then DeltaDeceased.Clear
  else DeltaDeceased.Value := ResultSet.GetDoubleByName('delta_deceased');

  if ResultSet.IsNullByName('mean_removed') then MeanRemoved.Clear
  else MeanRemoved.Value := ResultSet.GetDoubleByName('mean_removed');
  if ResultSet.IsNullByName('deviation_removed') then DeviationRemoved.Clear
  else DeviationRemoved.Value := ResultSet.GetDoubleByName('deviation_removed');
  if ResultSet.IsNullByName('delta_removed') then DeltaRemoved.Clear
  else DeltaRemoved.Value := ResultSet.GetDoubleByName('delta_removed');

  if ResultSet.IsNullByName('mean_infectious') then MeanInfectious.Clear
  else MeanInfectious.Value := ResultSet.GetDoubleByName('mean_infectious');
  if ResultSet.IsNullByName('deviation_infectious') then DeviationInfectious.Clear
  else DeviationInfectious.Value := ResultSet.GetDoubleByName('deviation_infectious');
  if ResultSet.IsNullByName('delta_infectious') then DeltaInfectious.Clear
  else DeltaInfectious.Value := ResultSet.GetDoubleByName('delta_infectious');

  if ResultSet.IsNullByName('mean_reproduction') then MeanReproduction.Clear
  else MeanReproduction.Value := ResultSet.GetDoubleByName('mean_reproduction');
  if ResultSet.IsNullByName('deviation_reproduction') then DeviationReproduction.Clear
  else DeviationReproduction.Value := ResultSet.GetDoubleByName('deviation_reproduction');
  if ResultSet.IsNullByName('delta_reproduction') then DeltaReproduction.Clear
  else DeltaReproduction.Value := ResultSet.GetDoubleByName('delta_reproduction');

  if ResultSet.IsNullByName('mean_infection_risk') then MeanInfectionRisk.Clear
  else MeanInfectionRisk.Value := ResultSet.GetDoubleByName('mean_infection_risk');
  if ResultSet.IsNullByName('deviation_infection_risk') then DeviationInfectionRisk.Clear
  else DeviationInfectionRisk.Value := ResultSet.GetDoubleByName('deviation_infection_risk');
  if ResultSet.IsNullByName('delta_infection_risk') then DeltaInfectionRisk.Clear
  else DeltaInfectionRisk.Value := ResultSet.GetDoubleByName('delta_infection_risk');

  if ResultSet.IsNullByName('mean_infected_last_7_days') then MeanInfectedLast7Days.Clear
  else MeanInfectedLast7Days.Value := ResultSet.GetDoubleByName('mean_infected_last_7_days');
  if ResultSet.IsNullByName('deviation_infected_last_7_days') then DeviationInfectedLast7Days.Clear
  else DeviationInfectedLast7Days.Value := ResultSet.GetDoubleByName('deviation_infected_last_7_days');
  if ResultSet.IsNullByName('delta_infected_last_7_days') then DeltaInfectedLast7Days.Clear
  else DeltaInfectedLast7Days.Value := ResultSet.GetDoubleByName('delta_infected_last_7_days');

  if ResultSet.IsNullByName('mean_new_infected') then MeanNewInfected.Clear
  else MeanNewInfected.Value := ResultSet.GetDoubleByName('mean_new_infected');
  if ResultSet.IsNullByName('deviation_new_infected') then DeviationNewInfected.Clear
  else DeviationNewInfected.Value := ResultSet.GetDoubleByName('deviation_new_infected');
  if ResultSet.IsNullByName('delta_new_infected') then DeltaNewInfected.Clear
  else DeltaNewInfected.Value := ResultSet.GetDoubleByName('delta_new_infected');
end;

procedure TSimulationDay.UpdateToDatabase;
begin
  var Statement: IZPreparedStatement := FConnection.PrepareStatement(
    'UPDATE simulation_days SET ' +
    'mean_susceptible = ?, deviation_susceptible = ?, delta_susceptible = ?, ' +
    'mean_incubated = ?, deviation_incubated = ?, delta_incubated = ?, ' +
    'mean_diseased = ?, deviation_diseased = ?, delta_diseased = ?, ' +
    'mean_infected = ?, deviation_infected = ?, delta_infected = ?, ' +
    'mean_immune =?, deviation_immune = ?, delta_immune = ?, ' +
    'mean_deceased = ?, deviation_deceased = ?, delta_deceased = ?, ' +
    'mean_removed = ?, deviation_removed = ?, delta_removed = ?, ' +
    'mean_infectious = ?, deviation_infectious = ?, delta_infectious = ?, ' +
    'mean_reproduction = ?, deviation_reproduction = ?, delta_reproduction = ?, ' +
    'mean_infection_risk = ?, deviation_infection_risk = ?, delta_infection_risk = ?, ' +
    'mean_infected_last_7_days = ?, deviation_infected_last_7_days = ?, delta_infected_last_7_days = ?, ' +
    'mean_new_infected = ?, deviation_new_infected = ?, delta_new_infected = ? ' +
    'WHERE simulation_day_id = ?;');

  if MeanSusceptible.IsNull then Statement.SetNull(1, stDouble)
  else Statement.SetDouble(1, MeanSusceptible.Value);
  if DeviationSusceptible.IsNull then Statement.SetNull(2, stDouble)
  else Statement.SetDouble(2, DeviationSusceptible.Value);
  if DeltaSusceptible.IsNull then Statement.SetNull(3, stDouble)
  else Statement.SetDouble(3, DeltaSusceptible.Value);

  if MeanIncubated.IsNull then Statement.SetNull(4, stDouble)
  else Statement.SetDouble(4, MeanIncubated.Value);
  if DeviationIncubated.IsNull then Statement.SetNull(5, stDouble)
  else Statement.SetDouble(5, DeviationIncubated.Value);
  if DeltaIncubated.IsNull then Statement.SetNull(6, stDouble)
  else Statement.SetDouble(6, DeltaIncubated.Value);

  if MeanDiseased.IsNull then Statement.SetNull(7, stDouble)
  else Statement.SetDouble(7, MeanDiseased.Value);
  if DeviationDiseased.IsNull then Statement.SetNull(8, stDouble)
  else Statement.SetDouble(8, DeviationDiseased.Value);
  if DeltaDiseased.IsNull then Statement.SetNull(9, stDouble)
  else Statement.SetDouble(9, DeltaDiseased.Value);

  if MeanInfected.IsNull then Statement.SetNull(10, stDouble)
  else Statement.SetDouble(10, MeanInfected.Value);
  if DeviationInfected.IsNull then Statement.SetNull(11, stDouble)
  else Statement.SetDouble(11, DeviationInfected.Value);
  if DeltaInfected.IsNull then Statement.SetNull(12, stDouble)
  else Statement.SetDouble(12, DeltaInfected.Value);

  if MeanImmune.IsNull then Statement.SetNull(13, stDouble)
  else Statement.SetDouble(13, MeanImmune.Value);
  if DeviationImmune.IsNull then Statement.SetNull(14, stDouble)
  else Statement.SetDouble(14, DeviationImmune.Value);
  if DeltaImmune.IsNull then Statement.SetNull(15, stDouble)
  else Statement.SetDouble(15, DeltaImmune.Value);

  if MeanDeceased.IsNull then Statement.SetNull(16, stDouble)
  else Statement.SetDouble(16, MeanDeceased.Value);
  if DeviationDeceased.IsNull then Statement.SetNull(17, stDouble)
  else Statement.SetDouble(17, DeviationDeceased.Value);
  if DeltaDeceased.IsNull then Statement.SetNull(18, stDouble)
  else Statement.SetDouble(18, DeltaDeceased.Value);

  if MeanRemoved.IsNull then Statement.SetNull(19, stDouble)
  else Statement.SetDouble(19, MeanRemoved.Value);
  if DeviationRemoved.IsNull then Statement.SetNull(20, stDouble)
  else Statement.SetDouble(20, DeviationRemoved.Value);
  if DeltaRemoved.IsNull then Statement.SetNull(21, stDouble)
  else Statement.SetDouble(21, DeltaRemoved.Value);

  if MeanInfectious.IsNull then Statement.SetNull(22, stDouble)
  else Statement.SetDouble(22, MeanInfectious.Value);
  if DeviationInfectious.IsNull then Statement.SetNull(23, stDouble)
  else Statement.SetDouble(23, DeviationInfectious.Value);
  if DeltaInfectious.IsNull then Statement.SetNull(24, stDouble)
  else Statement.SetDouble(24, DeltaInfectious.Value);

  if MeanReproduction.IsNull then Statement.SetNull(25, stDouble)
  else Statement.SetDouble(25, MeanReproduction.Value);
  if DeviationReproduction.IsNull then Statement.SetNull(26, stDouble)
  else Statement.SetDouble(26, DeviationReproduction.Value);
  if DeltaReproduction.IsNull then Statement.SetNull(27, stDouble)
  else Statement.SetDouble(27, DeltaReproduction.Value);

  if MeanInfectionRisk.IsNull then Statement.SetNull(28, stDouble)
  else Statement.SetDouble(28, MeanInfectionRisk.Value);
  if DeviationInfectionRisk.IsNull then Statement.SetNull(29, stDouble)
  else Statement.SetDouble(29, DeviationInfectionRisk.Value);
  if DeltaInfectionRisk.IsNull then Statement.SetNull(30, stDouble)
  else Statement.SetDouble(30, DeltaInfectionRisk.Value);

  if MeanInfectedLast7Days.IsNull then Statement.SetNull(31, stDouble)
  else Statement.SetDouble(31, MeanInfectedLast7Days.Value);
  if DeviationInfectedLast7Days.IsNull then Statement.SetNull(32, stDouble)
  else Statement.SetDouble(32, DeviationInfectedLast7Days.Value);
  if DeltaInfectedLast7Days.IsNull then Statement.SetNull(33, stDouble)
  else Statement.SetDouble(33, DeltaInfectedLast7Days.Value);

  if MeanNewInfected.IsNull then Statement.SetNull(34, stDouble)
  else Statement.SetDouble(34, MeanNewInfected.Value);
  if DeviationNewInfected.IsNull then Statement.SetNull(35, stDouble)
  else Statement.SetDouble(35, DeviationNewInfected.Value);
  if DeltaNewInfected.IsNull then Statement.SetNull(36, stDouble)
  else Statement.SetDouble(36, DeltaNewInfected.Value);

  Statement.SetString(37, SimulationDayID);

  Statement.ExecutePrepared;
end;

end.
