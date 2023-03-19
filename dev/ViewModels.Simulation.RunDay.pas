unit ViewModels.Simulation.RunDay;

interface

uses
  Models.MainModel,
  ZDbcIntfs;

type
  TSimulationRunDay = class(TObject)
  private
    FConnection: IZConnection;
    FConnectionStr: String;
    FSimulationRunDayID: String;
    FSimulationDayID: String;
    FSimulationID: String;
    FDayNumber: Integer;
    FRunNumber: Integer;
    FCountIncubated: Integer;
    FCountDiseased: Integer;
    FCountSusceptible: Integer;
    FCountImmune: Integer;
    FCountDeceased: Integer;
    FCountInfectious: Integer;
    FDeltaSusceptible: Integer;
    FDeltaIncubated: Integer;
    FDeltaDiseased: Integer;
    FDeltaImmune: Integer;
    FDeltaDeceased: Integer;
    FDeltaRemoved: Integer;
    FDeltaInfectious: Integer;
    FReproductionCountInfected: Integer;
    FReproductionCountInfectious: Integer;
    FInfectedHistory1: Integer;
    FInfectedHistory2: Integer;
    FInfectedHistory3: Integer;
    FInfectedHistory4: Integer;
    FInfectedHistory5: Integer;
    FInfectedHistory6: Integer;
    FInfectedHistory7: Integer;
    FCountNewInfected: Integer;
    FCountRiskyContacts: Integer;
    function GetCountInfected: Integer;
    function GetCountRemoved: Integer;
    function GetDeltaInfected: Integer;
    function GetDeltaRemoved: Integer;
    function GetSumInfected7Days: Integer;
    function IsSQLiteConnection: Boolean;
    function ReadDayIDFromDatabase: String; overload;
    function ReadDayIDFromDatabase(const SimulationID: String; const DayNumber: Integer): String; overload;
  protected
  public
    constructor CreateFromDatabase(const AConnection: IZConnection; const ASimulationID: String; const
        ADayNumber, ARunNumber: Integer);
    constructor CreateNextRunDay(APreviousRunDay: TSimulationRunDay);
    procedure InsertIntoDatabase;
    procedure UpdateToDataBase;
    procedure DeletePersonStatesFromDatabase;
    procedure SetDeltas(APreviousRunDay: TSimulationRunDay);
    procedure CalculateCurrentValues(APreviousRunDay: TSimulationRunDay);
    property ConnectionStr: String read FConnectionStr;
    property Connection: IZConnection read FConnection;
    property SimulationRunDayID: String read FSimulationRunDayID write FSimulationRunDayID;
    property SimulationDayID: String read FSimulationDayID write FSimulationDayID;
    property SimulationID: String read FSimulationID write FSimulationID;
    property DayNumber: Integer read FDayNumber write FDayNumber;
    property RunNumber: Integer read FRunNumber write FRunNumber;
    property CountSusceptible: Integer read FCountSusceptible write FCountSusceptible;
    property CountIncubated: Integer read FCountIncubated write FCountIncubated;
    property CountDiseased: Integer read FCountDiseased write FCountDiseased;
    property CountInfected: Integer read GetCountInfected;
    property CountImmune: Integer read FCountImmune write FCountImmune;
    property CountDeceased: Integer read FCountDeceased write FCountDeceased;
    property CountRemoved: Integer read GetCountRemoved;
    property CountInfectious: Integer read FCountInfectious write FCountInfectious;
    property DeltaSusceptible: Integer read FDeltaSusceptible write FDeltaSusceptible;
    property DeltaIncubated: Integer read FDeltaIncubated write FDeltaIncubated;
    property DeltaDiseased: Integer read FDeltaDiseased write FDeltaDiseased;
    property DeltaInfected: Integer read GetDeltaInfected;
    property DeltaImmune: Integer read FDeltaImmune write FDeltaImmune;
    property DeltaDeceased: Integer read FDeltaDeceased write FDeltaDeceased;
    property DeltaRemoved: Integer read GetDeltaRemoved;
    property DeltaInfectious: Integer read GetDeltaRemoved write FDeltaRemoved;
    property ReproductionCountInfected: Integer read FReproductionCountInfected write FReproductionCountInfected;
    property ReproductionCountInfectious: Integer read FReproductionCountInfectious write FReproductionCountInfectious;
    property CountNewInfected: Integer read FCountNewInfected write FCountNewInfected;
    property InfectedHistory1: Integer read FInfectedHistory1 write FInfectedHistory1;
    property InfectedHistory2: Integer read FInfectedHistory2 write FInfectedHistory2;
    property InfectedHistory3: Integer read FInfectedHistory3 write FInfectedHistory3;
    property InfectedHistory4: Integer read FInfectedHistory4 write FInfectedHistory4;
    property InfectedHistory5: Integer read FInfectedHistory5 write FInfectedHistory5;
    property InfectedHistory6: Integer read FInfectedHistory6 write FInfectedHistory6;
    property InfectedHistory7: Integer read FInfectedHistory7 write FInfectedHistory7;
    property SumInfected7Days: Integer read GetSumInfected7Days;
    property CountRiskyContacts: Integer read FCountRiskyContacts write FCountRiskyContacts;
  end;


implementation

{ TSimulationRunDay }

procedure TSimulationRunDay.CalculateCurrentValues(
  APreviousRunDay: TSimulationRunDay);
begin
  // count Susceptible
  var SusceptibleStatement: IZPreparedStatement := FConnection.PrepareStatement(
    'SELECT count(sps.status_id) AS value FROM simulation_people_status sps ' +
    'JOIN simulation_run_days srd ON (srd.simulation_run_day_id = sps.run_day_id) ' +
    'WHERE (srd.simulation_run_day_id = ?) AND (sps.susceptible);');
  SusceptibleStatement.SetString(1, FSimulationRunDayID);
  var SusceptibleResultSet: IZResultSet := SusceptibleStatement.ExecuteQueryPrepared;
  if not(IsSQLiteConnection) then SusceptibleResultSet.First;
  CountSusceptible := SusceptibleResultSet.GetIntByName('value');

  // count Incubated
  var IncubatedStatement: IZPreparedStatement := FConnection.PrepareStatement(
    'SELECT count(sps.status_id) AS value FROM simulation_people_status sps ' +
    'JOIN simulation_run_days srd ON (srd.simulation_run_day_id = sps.run_day_id) ' +
    'WHERE (srd.simulation_run_day_id = ?) AND (sps.incubated);');
  IncubatedStatement.SetString(1, FSimulationRunDayID);
  var IncubatedResultSet: IZResultSet := IncubatedStatement.ExecuteQueryPrepared;
  if not(IsSQLiteConnection) then IncubatedResultSet.First;
  CountIncubated := IncubatedResultSet.GetIntByName('value');

  // count Diseased
  var DiseasedStatement: IZPreparedStatement := FConnection.PrepareStatement(
    'SELECT count(sps.status_id) AS value FROM simulation_people_status sps ' +
    'JOIN simulation_run_days srd ON (srd.simulation_run_day_id = sps.run_day_id) ' +
    'WHERE (srd.simulation_run_day_id = ?) AND (sps.diseased);');
  DiseasedStatement.SetString(1, FSimulationRunDayID);
  var DiseasedResultSet: IZResultSet := DiseasedStatement.ExecuteQueryPrepared;
  if not(IsSQLiteConnection) then DiseasedResultSet.First;
  CountDiseased := DiseasedResultSet.GetIntByName('value');

  // count Immune
  var ImmuneStatement: IZPreparedStatement := FConnection.PrepareStatement(
    'SELECT count(sps.status_id) AS value FROM simulation_people_status sps ' +
    'JOIN simulation_run_days srd ON (srd.simulation_run_day_id = sps.run_day_id) ' +
    'WHERE (srd.simulation_run_day_id = ?) AND (sps.immune);');
  ImmuneStatement.SetString(1, FSimulationRunDayID);
  var ImmuneResultSet: IZResultSet := ImmuneStatement.ExecuteQueryPrepared;
  if not(IsSQLiteConnection) then ImmuneResultSet.First;
  CountImmune := ImmuneResultSet.GetIntByName('value');

  // count Deceased
  var DeceasedStatement: IZPreparedStatement := FConnection.PrepareStatement(
    'SELECT count(sps.status_id) AS value FROM simulation_people_status sps ' +
    'JOIN simulation_run_days srd ON (srd.simulation_run_day_id = sps.run_day_id) ' +
    'WHERE (srd.simulation_run_day_id = ?) AND (sps.deceased);');
  DeceasedStatement.SetString(1, FSimulationRunDayID);
  var DeceasedResultSet: IZResultSet := DeceasedStatement.ExecuteQueryPrepared;
  if not(IsSQLiteConnection) then DeceasedResultSet.First;
  CountDeceased := DeceasedResultSet.GetIntByName('value');

  // count Infectious
  var InfectiousStatement: IZPreparedStatement := FConnection.PrepareStatement(
    'SELECT count(sps.status_id) AS value FROM simulation_people_status sps ' +
    'JOIN simulation_run_days srd ON (srd.simulation_run_day_id = sps.run_day_id) ' +
    'WHERE (srd.simulation_run_day_id = ?) AND (sps.infectious);');
  InfectiousStatement.SetString(1, FSimulationRunDayID);
  var InfectiousResultSet: IZResultSet := InfectiousStatement.ExecuteQueryPrepared;
  if not(IsSQLiteConnection) then InfectiousResultSet.First;
  CountInfectious := InfectiousResultSet.GetIntByName('value');

  // count Infectious on last day of infection (reproduction_count_infectious)
  var ReproCountInfectiousStatement: IZPreparedStatement := FConnection.PrepareStatement(
    'SELECT count(sps.status_id) AS value FROM simulation_people_status sps ' +
    'JOIN simulation_run_days srd ON (srd.simulation_run_day_id = sps.run_day_id) ' +
    'WHERE (srd.simulation_run_day_id = ?) AND (sps.days_left_infectious = 1);');
  ReproCountInfectiousStatement.SetString(1, FSimulationRunDayID);
  var ReproCountInfectiousResultSet: IZResultSet := ReproCountInfectiousStatement.ExecuteQueryPrepared;
  if not(IsSQLiteConnection) then ReproCountInfectiousResultSet.First;
  ReproductionCountInfectious := ReproCountInfectiousResultSet.GetIntByName('value');

  // count sum of infected people of an Infectious on last day of infection (reproduction_count_infected)
  var ReproCountInfectedStatement: IZPreparedStatement := FConnection.PrepareStatement(
    'SELECT sum(sps.count_infected + sps.sum_infected) AS value FROM simulation_people_status sps ' +
    'JOIN simulation_run_days srd ON (srd.simulation_run_day_id = sps.run_day_id) ' +
    'WHERE (srd.simulation_run_day_id = ?) AND (sps.days_left_infectious = 1);');
  ReproCountInfectedStatement.SetString(1, FSimulationRunDayID);
  var ReproCountInfectedResultSet: IZResultSet := ReproCountInfectedStatement.ExecuteQueryPrepared;
  if not(IsSQLiteConnection) then ReproCountInfectedResultSet.First;
  ReproductionCountInfected := ReproCountInfectedResultSet.GetIntByName('value');

  // count the newly infected people on this day
  var CountNewInfectedStatement: IZPreparedStatement := FConnection.PrepareStatement(
    'SELECT sum(sps.count_infected) AS value FROM simulation_people_status sps ' +
    'JOIN simulation_run_days srd ON (srd.simulation_run_day_id = sps.run_day_id) ' +
    'WHERE (srd.simulation_run_day_id = ?) AND (sps.infectious);');
  CountNewInfectedStatement.SetString(1, FSimulationRunDayID);
  var CountNewInfectedResultSet: IZResultSet := CountNewInfectedStatement.ExecuteQueryPrepared;
  if not(IsSQLiteConnection) then CountNewInfectedResultSet.First;
  CountNewInfected := CountNewInfectedResultSet.GetIntByName('value');

  // count the risky contacts on this day
  var CountRiskyContactsStatement: IZPreparedStatement := FConnection.PrepareStatement(
    'SELECT sum(sps.count_risky_contacts) AS value FROM simulation_people_status sps ' +
    'JOIN simulation_run_days srd ON (srd.simulation_run_day_id = sps.run_day_id) ' +
    'WHERE (srd.simulation_run_day_id = ?) AND (sps.infectious);');
  CountRiskyContactsStatement.SetString(1, FSimulationRunDayID);
  var CountRiskyContactsResultSet: IZResultSet := CountRiskyContactsStatement.ExecuteQueryPrepared;
  if not(IsSQLiteConnection) then CountRiskyContactsResultSet.First;
  CountRiskyContacts := CountRiskyContactsResultSet.GetIntByName('value');

  DeltaSusceptible := Self.CountSusceptible - APreviousRunDay.CountSusceptible;
  DeltaIncubated := Self.CountIncubated - APreviousRunDay.CountIncubated;
  DeltaDiseased := Self.CountDiseased - APreviousRunDay.CountDiseased;
  DeltaImmune := Self.CountImmune - APreviousRunDay.CountImmune;
  DeltaDeceased := Self.CountDeceased - APreviousRunDay.CountDeceased;
  DeltaInfectious := Self.CountInfectious - APreviousRunDay.CountInfectious;
end;

constructor TSimulationRunDay.CreateFromDatabase(const AConnection: IZConnection; const
    ASimulationID: String; const ADayNumber, ARunNumber: Integer);
begin
  inherited Create;

  FConnectionStr := MainModel.ConnectionURL;
  FConnection := AConnection;
  FSimulationID := ASimulationID;
  FDayNumber := ADayNumber;
  FRunNumber := ARunNumber;

  // Read the values of the RunDay record in database.
  var Statement: IZPreparedStatement := FConnection.PrepareStatement(
    'SELECT srd.simulation_run_day_id, srd.simulation_day_id, srd.count_incubated, srd.count_diseased, ' +
    'srd.count_susceptible, srd.count_immune, srd.count_deceased, srd.count_infectious, ' +
    'srd.delta_susceptible, srd.delta_incubated, srd.delta_diseased, srd.delta_immune, ' +
    'srd.delta_deceased, srd.delta_infectious, srd.reproduction_count_infected, ' +
    'srd.reproduction_count_infectious, srd.count_new_infected, srd.infected_history_1, ' +
    'srd.infected_history_2, srd.infected_history_3, srd.infected_history_4, srd.infected_history_5, ' +
    'srd.infected_history_6, srd.infected_history_7, srd.count_risky_contacts ' +
    'FROM simulation_run_days srd ' +
    'JOIN simulation_days sd ON (sd.simulation_day_id = srd.simulation_day_id) ' +
    'WHERE (sd.simulation_id = ?) AND (srd.day_number = ?) AND (srd.run_number = ?);');
  Statement.SetString(1, FSimulationID);
  Statement.SetInt(2, FDayNumber);
  Statement.SetInt(3, FRunNumber);
  var ResultSet: IZResultSet := Statement.ExecuteQueryPrepared;
  if not(IsSQLiteConnection) then ResultSet.First;

  FSimulationRunDayID := ResultSet.GetStringByName('simulation_run_day_id');
  FSimulationDayID := ResultSet.GetStringByName('simulation_day_id');
  FCountIncubated := ResultSet.GetIntByName('count_incubated');
  FCountDiseased := ResultSet.GetIntByName('count_diseased');
  FCountSusceptible := ResultSet.GetIntByName('count_susceptible');
  FCountImmune := ResultSet.GetIntByName('count_immune');
  FCountDeceased := ResultSet.GetIntByName('count_deceased');
  FCountInfectious := ResultSet.GetIntByName('count_infectious');
  FDeltaSusceptible := ResultSet.GetIntByName('delta_susceptible');
  FDeltaIncubated := ResultSet.GetIntByName('delta_incubated');
  FDeltaDiseased := ResultSet.GetIntByName('delta_diseased');
  FDeltaImmune := ResultSet.GetIntByName('delta_immune');
  FDeltaDeceased := ResultSet.GetIntByName('delta_deceased');
  FDeltaInfectious := ResultSet.GetIntByName('delta_infectious');
  FReproductionCountInfected := ResultSet.GetIntByName('reproduction_count_infected');
  FReproductionCountInfectious := ResultSet.GetIntByName('reproduction_count_infectious');
  FCountNewInfected := ResultSet.GetIntByName('count_new_infected');
  FInfectedHistory1 := ResultSet.GetIntByName('infected_history_1');
  FInfectedHistory2 := ResultSet.GetIntByName('infected_history_2');
  FInfectedHistory3 := ResultSet.GetIntByName('infected_history_3');
  FInfectedHistory4 := ResultSet.GetIntByName('infected_history_4');
  FInfectedHistory5 := ResultSet.GetIntByName('infected_history_5');
  FInfectedHistory6 := ResultSet.GetIntByName('infected_history_6');
  FInfectedHistory7 := ResultSet.GetIntByName('infected_history_7');
  FCountRiskyContacts := ResultSet.GetIntByName('count_risky_contacts');
end;

constructor TSimulationRunDay.CreateNextRunDay(APreviousRunDay: TSimulationRunDay);
begin
  inherited Create;

  FConnectionStr := APreviousRunDay.ConnectionStr;
  FConnection := APreviousRunDay.Connection;
  FSimulationRunDayID := MainModel.GetPrimaryKeyValue;
  FSimulationID := APreviousRunDay.SimulationID;
  FDayNumber := APreviousRunDay.DayNumber + 1;
  FRunNumber := APreviousRunDay.RunNumber;
  FSimulationDayID := ReadDayIDFromDatabase(FSimulationID, FDayNumber);

  FCountIncubated := APreviousRunDay.CountIncubated;
  FCountDiseased := APreviousRunDay.CountDiseased;
  FCountSusceptible := APreviousRunDay.CountSusceptible;
  FCountImmune := APreviousRunDay.CountImmune;
  FCountDeceased := APreviousRunDay.CountDeceased;
  FCountInfectious := APreviousRunDay.CountInfectious;
  FDeltaSusceptible := 0;
  FDeltaIncubated := 0;
  FDeltaDiseased := 0;
  FDeltaImmune := 0;
  FDeltaDeceased := 0;
  FDeltaInfectious := 0;
  FReproductionCountInfected := 0;
  FReproductionCountInfectious := 0;
  FInfectedHistory1 := APreviousRunDay.CountNewInfected;
  FInfectedHistory2 := APreviousRunDay.InfectedHistory1;
  FInfectedHistory3 := APreviousRunDay.InfectedHistory2;
  FInfectedHistory4 := APreviousRunDay.InfectedHistory3;
  FInfectedHistory5 := APreviousRunDay.InfectedHistory4;
  FInfectedHistory6 := APreviousRunDay.InfectedHistory5;
  FInfectedHistory7 := APreviousRunDay.InfectedHistory6;
  FCountRiskyContacts := 0;
end;

procedure TSimulationRunDay.DeletePersonStatesFromDatabase;
begin
  var Statement: IZPreparedStatement := FConnection.PrepareStatement(
    'DELETE FROM simulation_people_status WHERE (run_day_id = ?);');
  Statement.SetString(1, FSimulationRunDayID);
  Statement.ExecutePrepared;
end;

function TSimulationRunDay.GetCountInfected: Integer;
begin
  Result := CountIncubated + CountDiseased;
end;

function TSimulationRunDay.GetCountRemoved: Integer;
begin
  Result := CountImmune + CountDeceased;
end;

function TSimulationRunDay.GetDeltaInfected: Integer;
begin
  Result := DeltaIncubated + DeltaDiseased;
end;

function TSimulationRunDay.GetDeltaRemoved: Integer;
begin
  Result := DeltaImmune + DeltaDeceased;
end;

function TSimulationRunDay.GetSumInfected7Days: Integer;
begin
  Result := InfectedHistory1 + InfectedHistory2 + InfectedHistory3 +
            InfectedHistory4 + InfectedHistory5 + InfectedHistory6 +
            InfectedHistory7;
end;

procedure TSimulationRunDay.InsertIntoDatabase;
begin
  var Statement: IZPreparedStatement := FConnection.PrepareStatement(
    'INSERT INTO simulation_run_days (simulation_run_day_id, simulation_day_id, day_number, ' +
    'run_number, count_susceptible, count_incubated, count_diseased, count_immune, count_deceased, ' +
    'count_infectious, delta_susceptible, delta_incubated, delta_diseased, delta_immune, ' +
    'delta_deceased, delta_infectious, reproduction_count_infected, reproduction_count_infectious, ' +
    'count_new_infected, infected_history_1, infected_history_2, infected_history_3, ' +
    'infected_history_4, infected_history_5, infected_history_6, infected_history_7, count_risky_contacts) ' +
    'VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);');
  Statement.SetString(1, SimulationRunDayID);
  Statement.SetString(2, SimulationDayID);
  Statement.SetInt(3, DayNumber);
  Statement.SetInt(4, RunNumber);
  Statement.SetInt(5, CountSusceptible);
  Statement.SetInt(6, CountIncubated);
  Statement.SetInt(7, CountDiseased);
  Statement.SetInt(8, CountImmune);
  Statement.SetInt(9, CountDeceased);
  Statement.SetInt(10, CountInfectious);
  Statement.SetInt(11, DeltaSusceptible);
  Statement.SetInt(12, DeltaIncubated);
  Statement.SetInt(13, DeltaDiseased);
  Statement.SetInt(14, DeltaImmune);
  Statement.SetInt(15, DeltaDeceased);
  Statement.SetInt(16, DeltaInfectious);
  Statement.SetInt(17, ReproductionCountInfected);
  Statement.SetInt(18, ReproductionCountInfectious);
  Statement.SetInt(19, CountNewInfected);
  Statement.SetInt(20, InfectedHistory1);
  Statement.SetInt(21, InfectedHistory2);
  Statement.SetInt(22, InfectedHistory3);
  Statement.SetInt(23, InfectedHistory4);
  Statement.SetInt(24, InfectedHistory5);
  Statement.SetInt(25, InfectedHistory6);
  Statement.SetInt(26, InfectedHistory7);
  Statement.SetInt(27, CountRiskyContacts);
  Statement.ExecutePrepared;
end;

function TSimulationRunDay.IsSQLiteConnection: Boolean;
begin
  Result := (Copy(FConnectionStr, 6, 6) = 'sqlite');
end;

function TSimulationRunDay.ReadDayIDFromDatabase(const SimulationID: String;
  const DayNumber: Integer): String;
begin
  var Statement: IZPreparedStatement := FConnection.PrepareStatement(
    'SELECT simulation_day_id FROM simulation_days WHERE (simulation_id = ?) and (day_number = ?);');
  Statement.SetString(1, FSimulationID);
  Statement.SetInt(2, FDayNumber);
  var ResultSet: IZResultSet := Statement.ExecuteQueryPrepared;
  if not(IsSQLiteConnection) then ResultSet.First;

  Result := ResultSet.GetStringByName('simulation_day_id');
end;

procedure TSimulationRunDay.SetDeltas(APreviousRunDay: TSimulationRunDay);
begin
  DeltaSusceptible := Self.CountSusceptible - APreviousRunDay.CountSusceptible;
  DeltaIncubated := Self.CountIncubated - APreviousRunDay.CountIncubated;
  DeltaDiseased := Self.CountDiseased - APreviousRunDay.CountDiseased;
  DeltaImmune := Self.CountImmune - APreviousRunDay.CountImmune;
  DeltaDeceased := Self.CountDeceased - APreviousRunDay.CountDeceased;
  DeltaInfectious := Self.CountInfectious - APreviousRunDay.CountInfectious;
end;

function TSimulationRunDay.ReadDayIDFromDatabase: String;
begin
  Result := ReadDayIDFromDatabase(SimulationID, DayNumber);
end;

procedure TSimulationRunDay.UpdateToDataBase;
begin
  // Update with new values.
  var Statement: IZPreparedStatement := FConnection.PrepareStatement(
    'UPDATE simulation_run_days SET ' +
    'count_susceptible = ?, count_incubated = ?, count_diseased = ?, count_immune = ?, ' +
    'count_deceased = ?, count_infectious = ?, delta_susceptible = ?, delta_incubated = ?, ' +
    'delta_diseased = ?, delta_immune = ?, delta_deceased = ?, delta_infectious = ?, ' +
    'reproduction_count_infected = ?, reproduction_count_infectious = ?, count_new_infected = ?, ' +
    'count_risky_contacts = ? WHERE simulation_run_day_id = ?;');
  Statement.SetInt(1, FCountSusceptible);
  Statement.SetInt(2, FCountIncubated);
  Statement.SetInt(3, FCountDiseased);
  Statement.SetInt(4, FCountImmune);
  Statement.SetInt(5, FCountDeceased);
  Statement.SetInt(6, FCountInfectious);
  Statement.SetInt(7, FDeltaSusceptible);
  Statement.SetInt(8, FDeltaIncubated);
  Statement.SetInt(9, FDeltaDiseased);
  Statement.SetInt(10, FDeltaImmune);
  Statement.SetInt(11, FDeltaDeceased);
  Statement.SetInt(12, FDeltaInfectious);
  Statement.SetInt(13, FReproductionCountInfected);
  Statement.SetInt(14, FReproductionCountInfectious);
  Statement.SetInt(15, FCountNewInfected);
  Statement.SetInt(16, FCountRiskyContacts);
  Statement.SetString(17, FSimulationRunDayID);
  Statement.ExecutePrepared;
end;

end.
