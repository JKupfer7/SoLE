unit ViewModels.Simulation.PersonState;

interface

uses
  Models.MainModel,
  ViewModels.Simulation.RunDay,
  ZDbcIntfs;

type
  TSimulationPersonState = class(TObject)
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
    FConnection: IZConnection;
    FConnectionStr: String;
    FCountRiskyContacts: Integer;
    function GetDiseased: Boolean;
    function GetImmune: Boolean;
    function GetIncubated: Boolean;
    function GetInfected: Boolean;
    function GetInfectious: Boolean;
    function GetRemoved: Boolean;
    function GetSusceptible: Boolean;
  public
    class function GetSearchValue(APersonID: String): TSimulationPersonState;
    constructor Create(const AConnection: IZConnection); overload;
    constructor Create(const APersonID: String); overload;
    procedure LoadFromDataBase(AResultSet: IZResultSet);
    procedure InsertIntoDatabase(AStatement: IZPreparedStatement);
    procedure UpdateToDatabase;
    procedure InitializeDayZero(const APersonID: String; const APersonNumber:
        Integer; const AStatusID, ARunDayID: String; const ARunNumber,
        AInitialDayOfInfectious: Integer; const ASusceptibility, AInfectiousness,
        AMortality, AInitialImmunity: Double; const AIncubationPeriod,
        ADiseasePeriod, AInfectiousDelayPeriod, AInfectiousPeriod,
        AHalvingImmunityPeriod, AImmunityPeriod: Integer);
    procedure InitializeValues(const ARunDayID: String);
    function DecideAboutContact(const AContactProbability: Double): Boolean;
    function DecideAboutInfection(const AnInfectiousness: Double): Boolean;
    function DecideAboutDecease: Boolean;
    function CalculateCurrentImmunity: Double;
    procedure SetAsInfected;
    procedure IncreaseCountInfected;
    property ConnectionStr: String read FConnectionStr;
    property Connection: IZConnection read FConnection;
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
    property CountRiskyContacts: Integer read FCountRiskyContacts write FCountRiskyContacts; // simulation_people_status.count_risky_contacts
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

implementation

uses
  System.SysUtils,
  System.Math;

{ TSimulationPersonState }

function TSimulationPersonState.CalculateCurrentImmunity: Double;
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

procedure TSimulationPersonState.InitializeValues(const ARunDayID: String);
begin
  // Calculate values of the current day. (Values in simulation_people_status only.)
  // PersonID: remains unchanged
  // PersonNumber: remains unchanged
  StatusID := MainModel.GetPrimaryKeyValue; // Get a new ID for this state record.
  RunDayID := ARunDayID; // Get the ID of the corresponing RunDay record.
  DayNumber := DayNumber + 1; // next day --> increase DayNumber
  // RunNumber: remains unchanged

  if not(Deceased) then // for living persons only
  begin
    // incubation state
    var WasIncubated := (DaysLeftIncubated > 0); // Incubated on previous day?
    if WasIncubated then // If so...
      DaysLeftIncubated := DaysLeftIncubated - 1; // ... decrease number of incubation days left.

    // disease state
    var WasDiseased := (DaysLeftDiseased > 0); // Diseased on previous day?
    if WasIncubated then // If incubated on previous day ...
    begin
      if (DaysLeftIncubated = 0) then // Change from incubation to disease
        DaysLeftDiseased := DiseasePeriod; // initialize disease phase
    end
    else // If not incubated on previous day ...
    begin
      if WasDiseased then // If person was already diseased on previous day
        DaysLeftDiseased := DaysLeftDiseased - 1; // decrease number of disease days left
    end;

    // immunity/decease state
    var WasImmune := (DaysLeftImmune > 0); // Immune on previous day?
    if WasDiseased then // If diseased on previuos day ...
    begin
      if (DaysLeftDiseased = 0) then // Change from disease to immunity/decease
      begin
        Deceased := DecideAboutDecease;
        if not(Deceased) then // person becomes immune
        begin
          CurrentImmunity := InitialImmunity;
          DaysLeftImmune := ImmunityPeriod;
        end;
      end;
    end
    else // If not diseased on prevoius day ...
    begin
      if WasImmune then // If person was already immune on previous day
      begin
        DaysLeftImmune := DaysLeftImmune - 1; // decrease number of immunity days left
        CurrentImmunity := CalculateCurrentImmunity; // adjust immunity value
      end;
    end;

    // infectious delay state
    var WasInfectiousDelay := (DaysLeftInfectiousDelay > 0); // In infectious delay period on previous day?
    if WasInfectiousDelay then
      DaysLeftInfectiousDelay := DaysLeftInfectiousDelay - 1;

    // infectious state
    var WasInfectious := (DaysLeftInfectious > 0); // Infectious on previous day?
    if WasInfectiousDelay then // in infectious delay period on previous day
    begin
      if (DaysLeftInfectiousDelay = 0) then // Change form infectious delay to infectious period
        DaysLeftInfectious := InfectiousPeriod;
    end
    else // within infectious period
    begin
      if WasInfectious then
        DaysLeftInfectious := DaysLeftInfectious - 1;
    end;

    // Set values for dead people.
    if Deceased then
    begin
      DaysLeftIncubated := 0;
      DaysLeftDiseased := 0;
      CurrentImmunity := 0;
      DaysLeftImmune := 0;
      // Dead people can not be infectious in this simulation.
      DaysLeftInfectiousDelay := 0;
      DaysLeftInfectious := 0;
    end;

    CountRiskyContacts := 0;
    SumInfected := IfThen(DaysLeftInfectious = 0, 0, SumInfected + CountInfected);
    CountInfected := 0;
  end;
end;

procedure TSimulationPersonState.InsertIntoDatabase(
    AStatement: IZPreparedStatement);
begin
  AStatement.SetString(1, StatusID);
  AStatement.SetString(2, RunDayID);
  AStatement.SetString(3, PersonID);
  AStatement.SetDouble(4, CurrentImmunity);
  AStatement.SetInt(5, DaysLeftIncubated);
  AStatement.SetInt(6, DaysLeftDiseased);
  AStatement.SetInt(7, DaysLeftInfectiousDelay);
  AStatement.SetInt(8, DaysLeftInfectious);
  AStatement.SetInt(9, DaysLeftImmune);
  AStatement.SetInt(10, CountRiskyContacts);
  AStatement.SetInt(11, CountInfected);
  AStatement.SetInt(12, SumInfected);
  AStatement.SetInt(13, IfThen(Deceased, 1, 0));
  AStatement.ExecutePrepared;
end;

procedure TSimulationPersonState.LoadFromDataBase(AResultSet: IZResultSet);
begin
  // Read in values from database of the previous day.
  PersonID := AResultSet.GetStringByName('person_id');
  PersonNumber := AResultSet.GetIntByName('person_number');
  StatusID := AResultSet.GetStringByName('status_id');
  RunDayID:= AResultSet.GetStringByName('run_day_id');
  DayNumber := AResultSet.GetIntByName('day_number');
  RunNumber := AResultSet.GetIntByName('run_number');
  InitialDayOfInfectious := AResultSet.GetIntByName('initial_day_of_infectious');
  Susceptibility := AResultSet.GetDoubleByName('susceptibility');
  Infectiousness := AResultSet.GetDoubleByName('infectiousness');
  Mortality := AResultSet.GetDoubleByName('mortality');
  InitialImmunity := AResultSet.GetDoubleByName('initial_immunity');
  IncubationPeriod := AResultSet.GetIntByName('incubation_period');
  DiseasePeriod := AResultSet.GetIntByName('disease_period');
  InfectiousDelayPeriod := AResultSet.GetIntByName('infectious_delay_period');
  InfectiousPeriod := AResultSet.GetIntByName('infectious_period');
  HalvingImmunityPeriod := AResultSet.GetIntByName('halving_immunity_period');
  ImmunityPeriod := AResultSet.GetIntByName('immunity_period');
  CurrentImmunity := AResultSet.GetDoubleByName('current_immunity');
  DaysLeftIncubated := AResultSet.GetIntByName('days_left_incubated');
  DaysLeftDiseased := AResultSet.GetIntByName('days_left_diseased');
  DaysLeftInfectiousDelay := AResultSet.GetIntByName('days_left_infectious_delay');
  DaysLeftInfectious := AResultSet.GetIntByName('days_left_infectious');
  DaysLeftImmune := AResultSet.GetIntByName('days_left_immune');
  CountRiskyContacts := AResultSet.GetIntByName('count_risky_contacts');
  CountInfected := AResultSet.GetIntByName('count_infected');
  SumInfected := AResultSet.GetIntByName('sum_infected');
  Deceased := AResultSet.GetBooleanByName('deceased');
end;

constructor TSimulationPersonState.Create(const AConnection: IZConnection);
begin
  inherited Create;

  FConnection := AConnection;
  FConnectionStr := MainModel.ConnectionURL;
end;

constructor TSimulationPersonState.Create(const APersonID: String);
begin
  inherited Create;

  FPersonID := APersonID;
end;

function TSimulationPersonState.DecideAboutContact(
  const AContactProbability: Double): Boolean;
begin
  var Risk: Double := AContactProbability;
  var DecisionValue: Double := Random;
  Result := (DecisionValue <= Risk);
end;

function TSimulationPersonState.DecideAboutDecease: Boolean;
begin
  var Risk: Double := Mortality;
  var DecisionValue: Double := Random;
  Result := (DecisionValue <= Risk);
end;

function TSimulationPersonState.DecideAboutInfection(
  const AnInfectiousness: Double): Boolean;
begin
  var Risk: Double := Susceptibility * AnInfectiousness;
//var Risk: Double := Susceptibility * (1 - CurrentImmunity) * AnInfectiousness;
  var DecisionValue: Double := Random;
  Result := (DecisionValue <= Risk);
end;

function TSimulationPersonState.GetDiseased: Boolean;
begin
  Result := (DaysLeftDiseased > 0);
end;

function TSimulationPersonState.GetImmune: Boolean;
begin
  Result := (DaysLeftImmune > 0);
end;

function TSimulationPersonState.GetIncubated: Boolean;
begin
  Result := (DaysLeftIncubated > 0);
end;

function TSimulationPersonState.GetInfected: Boolean;
begin
  Result := (Incubated or Diseased);
end;

function TSimulationPersonState.GetInfectious: Boolean;
begin
  Result := (DaysLeftInfectious > 0);
end;

function TSimulationPersonState.GetRemoved: Boolean;
begin
  Result := (Immune or Deceased);
end;

class function TSimulationPersonState.GetSearchValue(
  APersonID: String): TSimulationPersonState;
begin
  Result := TSimulationPersonState.Create(APersonID);
end;

function TSimulationPersonState.GetSusceptible: Boolean;
begin
  Result := not(Infected or Removed);
end;

procedure TSimulationPersonState.IncreaseCountInfected;
begin
  CountInfected := CountInfected + 1;
end;

procedure TSimulationPersonState.InitializeDayZero(const APersonID: String;
  const APersonNumber: Integer; const AStatusID, ARunDayID: String;
  const ARunNumber, AInitialDayOfInfectious: Integer; const ASusceptibility,
  AInfectiousness, AMortality, AInitialImmunity: Double;
  const AIncubationPeriod, ADiseasePeriod, AInfectiousDelayPeriod,
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
  CountRiskyContacts := 0;
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

procedure TSimulationPersonState.SetAsInfected;
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

procedure TSimulationPersonState.UpdateToDatabase;
begin
  var Statement: IZPreparedStatement := Connection.PrepareStatement(
    'UPDATE simulation_people_status SET ' +
    'current_immunity = ?, days_left_incubated = ?, ' +
    'days_left_diseased = ?, days_left_infectious_delay = ?, ' +
    'days_left_infectious = ?, days_left_immune = ?, ' +
    'count_risky_contacts = ?, count_infected = ?, sum_infected = ?, deceased = ? ' +
    'WHERE status_id = ?;');
  Statement.SetDouble(1, CurrentImmunity);
  Statement.SetInt(2, DaysLeftIncubated);
  Statement.SetInt(3, DaysLeftDiseased);
  Statement.SetInt(4, DaysLeftInfectiousDelay);
  Statement.SetInt(5, DaysLeftInfectious);
  Statement.SetInt(6, DaysLeftImmune);
  Statement.SetInt(7, CountRiskyContacts);
  Statement.SetInt(8, CountInfected);
  Statement.SetInt(9, SumInfected);
  Statement.SetInt(10, IfThen(Deceased, 1, 0));
  Statement.SetString(11, StatusID);
  Statement.ExecutePrepared;
end;

end.
