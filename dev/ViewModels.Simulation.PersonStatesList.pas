unit ViewModels.Simulation.PersonStatesList;

interface

uses
  System.Generics.Collections,
  System.Generics.Defaults,
  Models.MainModel,
  ViewModels.Simulation.RunDay,
  ViewModels.Simulation.PersonState,
  ZDbcIntfs;

type
  TSimulationPersonStatesList = class(TObject)
  private
    FPeople: TObjectList<TSimulationPersonState>;
    FCurrentRunDay: TSimulationRunDay;
    FPreviousRunDay: TSimulationRunDay;
    FConnection: IZConnection;
    FConnectionStr: String;
    FSimulationID: String;
    FRunNumber: Integer;
    FDayNumber: Integer;
    function IsSQLiteConnection: Boolean;
  public
    constructor Create(const AConnection: IZConnection; const ASimulationID: String; const
        ADayNumber, ARunNumber: Integer);
    procedure Free;
    procedure InsertIntoDatabase;
    procedure DeletePreviousPersonStatesFromDatabase;
    procedure InitializePersonStates;
    procedure SimulateContacts;
  end;

implementation

uses
  ViewModels.Simulation.Contacts;

{ TSimulationPersonStatesList }

constructor TSimulationPersonStatesList.Create(const AConnection: IZConnection; const ASimulationID: String;
    const ADayNumber, ARunNumber: Integer);
begin
  inherited Create;

  // Internal list to save attributes of people.
  FPeople := TObjectList<TSimulationPersonState>.Create(
    // Creates comparer to use the method IndexOf.
    TComparer<TSimulationPersonState>.Construct(
      function(const Left, Right: TSimulationPersonState): Integer
      begin
        if (Left.PersonID < Right.PersonID) then
          Result := -1
        else if (Left.PersonID > Right.PersonID) then
          Result := 1
        else
          Result := 0;
      end),
    true);

  FConnectionStr := MainModel.ConnectionURL;
  FConnection := AConnection;
  FSimulationID := ASimulationID;
  FDayNumber := ADayNumber;
  FRunNumber := ARunNumber;

  FPreviousRunDay := TSimulationRunDay.CreateFromDatabase(FConnection, FSimulationID, FDayNumber - 1, FRunNumber);
  FCurrentRunDay := TSimulationRunDay.CreateNextRunDay(FPreviousRunDay);
end;

procedure TSimulationPersonStatesList.DeletePreviousPersonStatesFromDatabase;
begin
  FPreviousRunDay.DeletePersonStatesFromDatabase;
end;

procedure TSimulationPersonStatesList.Free;
begin
  FCurrentRunDay.Free;
  FPreviousRunDay.Free;
  FPeople.Clear;
  FPeople.Free;

  inherited Free;
end;

function TSimulationPersonStatesList.IsSQLiteConnection: Boolean;
begin
  Result := (Copy(FConnectionStr, 6, 6) = 'sqlite');
end;

procedure TSimulationPersonStatesList.SimulateContacts;
begin
  // Statement to the count of infectious people
  var InfectiousCountStatement: IZPreparedStatement := FConnection.PrepareStatement(
    'SELECT COUNT(sps.person_id) as infectious_count ' +
    'FROM simulation_people_status sps ' +
    'JOIN simulation_run_days srd ON (sps.run_day_id = srd.simulation_run_day_id) '+
    'JOIN simulation_days sd ON (sd.simulation_day_id = srd.simulation_day_id) ' +
    'WHERE (sd.simulation_id = ?) AND (srd.day_number = ?) AND (srd.run_number = ?) AND (sps.infectious);');
  // Statement to select IDs of infectious people
  var InfectiousStatement: IZPreparedStatement := FConnection.PrepareStatement(
    'SELECT sps.person_id ' +
    'FROM simulation_people_status sps ' +
    'JOIN simulation_run_days srd ON (sps.run_day_id = srd.simulation_run_day_id) '+
    'JOIN simulation_days sd ON (sd.simulation_day_id = srd.simulation_day_id) ' +
    'WHERE (sd.simulation_id = ?) AND (srd.day_number = ?) AND (srd.run_number = ?) AND (sps.infectious);');
  // Statement to select contacts of infectious people
  // SQLite uses IIF instead of IF in conditional field requests.
  var ContactsStatementSQL: String;
  if IsSQLiteConnection then
    ContactsStatementSQL :=
    'SELECT IIF (pkp.person1_id = ?, pkp.person2_id, pkp.person1_id) AS contact_id, ' +
    'pkp.contact_probability ' +
    'FROM person_knows_person pkp ' +
    'WHERE ((pkp.person1_id = ?) OR (pkp.person2_id = ?));'
  else
    ContactsStatementSQL :=
    'SELECT IF (pkp.person1_id = ?, pkp.person2_id, pkp.person1_id) AS contact_id, ' +
    'pkp.contact_probability ' +
    'FROM person_knows_person pkp ' +
    'WHERE ((pkp.person1_id = ?) OR (pkp.person2_id = ?));';
  var ContactsStatement: IZPreparedStatement := FConnection.PrepareStatement(ContactsStatementSQL);

  // Select count of infectious people
  InfectiousCountStatement.SetString(1, FSimulationID);
  InfectiousCountStatement.SetInt(2, FDayNumber);
  InfectiousCountStatement.SetInt(3, FRunNumber);
  var InfectiousCountResultSet: IZResultSet := InfectiousCountStatement.ExecuteQueryPrepared;
  if not(IsSQLiteConnection) then InfectiousCountResultSet.First; // select the first (and only) record into the ResultSet to avoid an exception
  var InfectiousCount: Integer := InfectiousCountResultSet.GetIntByName('infectious_count');

  if InfectiousCount > 0 then
  begin
    // Select IDs of infectious people
    InfectiousStatement.SetString(1, FSimulationID);
    InfectiousStatement.SetInt(2, FDayNumber);
    InfectiousStatement.SetInt(3, FRunNumber);
    var SelectInfectiousResultSet: IZResultSet := InfectiousStatement.ExecuteQueryPrepared;
    if not(IsSQLiteConnection) then SelectInfectiousResultSet.First; // select the first (and only) record into the ResultSet to avoid an exception

    // for each infectious person...
    repeat
      // get ID of current infectious person
      var InfectiousID: String := SelectInfectiousResultSet.GetStringByName('person_id');

      // looking for the concats of the infectious person
      ContactsStatement.SetString(1, InfectiousID);
      ContactsStatement.SetString(2, InfectiousID);
      ContactsStatement.SetString(3, InfectiousID);
      var SelectContactsResultSet: IZResultSet := ContactsStatement.ExecuteQueryPrepared;
      if not(IsSQLiteConnection) then SelectContactsResultSet.First; // select the first (and only) record into the ResultSet to avoid an exception

      // create object for search with IndexOf
      var InfectiousSearchValue: TSimulationPersonState := TSimulationPersonState.GetSearchValue(InfectiousID);
      try // to free InfectiousSearchValue
        var InfectiousIndex: Integer := FPeople.IndexOf(InfectiousSearchValue);

        // infectious is found
        if (InfectiousIndex >= 0) then
        begin
          var InfectiousPerson: TSimulationPersonState := FPeople.Items[InfectiousIndex];

          // for each possible contact of the current infectious person
          repeat
            var ContactTookPlace: Boolean;
            var ImmunityWorks: Boolean := false;
            var InfectionTookPlace: Boolean := false;

            // get contact id and probability
            var ContactID: String := SelectContactsResultSet.GetStringByName('contact_id');
            var ContactProbability: Double := SelectContactsResultSet.GetDoubleByName('contact_probability');

            // check if contact takes place
            var DecisionValue: Double := Random;
            ContactTookPlace := (DecisionValue < ContactProbability);
            if ContactTookPlace then
            begin // contact will take place on this day
              // create object for search with IndexOf
              var ContactSearchValue: TSimulationPersonState := TSimulationPersonState.GetSearchValue(ContactID);

              try // to free ContactSearchValue
                var ContactIndex: Integer := FPeople.IndexOf(ContactSearchValue);

                // contact is found
                if (ContactIndex >= 0) then
                begin
                  // get contact person
                  var ContactPerson: TSimulationPersonState := FPeople.Items[ContactIndex];

                  // only susceptible or immune people can be infected
                  // why immune people: immunity mostly less then 100 %
                  if (ContactPerson.Susceptible or ContactPerson.Immune) then
                  begin
                    // count this contact to count_risky_contacts of infectious person
                    InfectiousPerson.CountRiskyContacts := InfectiousPerson.CountRiskyContacts + 1;

                    // consider immunity
                    var ImmunityDecisionValue: Double := Random;
                    ImmunityWorks := (ImmunityDecisionValue > (1 - ContactPerson.CurrentImmunity));
                    if not(ImmunityWorks) then
                    begin
                      InfectionTookPlace := ContactPerson.DecideAboutInfection(InfectiousPerson.Infectiousness);
                      if InfectionTookPlace then
                      begin // an infection takes place
                        ContactPerson.CurrentImmunity := 0;
                        ContactPerson.DaysLeftImmune := 0;
                        ContactPerson.DaysLeftIncubated := ContactPerson.IncubationPeriod;
                        if (ContactPerson.IncubationPeriod = 0) then ContactPerson.DaysLeftDiseased := ContactPerson.DiseasePeriod;
                        // TODO -oJanis -cBusiness Logic : How to handle an immune but infectious contact person?
                        ContactPerson.DaysLeftInfectious := 0;
                        ContactPerson.DaysLeftInfectiousDelay := ContactPerson.InfectiousDelayPeriod;
                        if (ContactPerson.InfectiousDelayPeriod = 0) then ContactPerson.DaysLeftInfectious := ContactPerson.InfectiousPeriod;

                        InfectiousPerson.CountInfected := InfectiousPerson.CountInfected + 1;

                        ContactPerson.UpdateToDatabase;
                      end;
                    end;
                  end;
                end;
              finally
                ContactSearchValue.Free;
              end;
            end;

            if MainModel.Settings.TasksKeepContactInformation then
              TRiskyContact.InsertIntoDatabase(FConnection, InfectiousID, ContactID, InfectiousPerson.RunDayID, ContactTookPlace, ImmunityWorks, InfectionTookPlace);
          until not(SelectContactsResultSet.Next);

          InfectiousPerson.UpdateToDatabase;
        end;

      finally
        InfectiousSearchValue.Free;
      end;

    until not(SelectInfectiousResultSet.Next);
  end;

  FCurrentRunDay.CalculateCurrentValues(FPreviousRunDay);
  FCurrentRunDay.UpdateToDataBase;
end;

procedure TSimulationPersonStatesList.InitializePersonStates;
begin
  var Statement: IZPreparedStatement := FConnection.PrepareStatement(
    'SELECT * FROM view_people_previous_status ' +
    'WHERE (run_number = ?) AND (day_number = ?) AND (simulation_id = ?);');
  Statement.SetInt(1, FRunNumber);
  Statement.SetInt(2, (FDayNumber - 1)); // Read in the previous day.
  Statement.SetString(3, FSimulationID);
  var ResultSet: IZResultSet := Statement.ExecuteQueryPrepared;
  if not(IsSQLiteConnection) then ResultSet.First; // select the first record into the ResultSet to avoid an exception

  if IsSQLiteConnection then ResultSet.Next; // SQLite will otherwise store the first record twice.
  repeat
    var PersonState: TSimulationPersonState := TSimulationPersonState.Create(FConnection);
    PersonState.LoadFromDataBase(ResultSet);
    PersonState.InitializeValues(FCurrentRunDay.SimulationRunDayID);
    FPeople.Add(PersonState);
  until not(ResultSet.Next);
end;

procedure TSimulationPersonStatesList.InsertIntoDatabase;
begin
  // Save current day first.
  FCurrentRunDay.InsertIntoDatabase;

  // Insert status records for current day.
  var Statement: IZPreparedStatement := FConnection.PrepareStatement(
    'INSERT INTO simulation_people_status ' +
    '(status_id, run_day_id, person_id, current_immunity, days_left_incubated, ' +
    'days_left_diseased, days_left_infectious_delay, days_left_infectious, days_left_immune, ' +
    'count_risky_contacts, count_infected, sum_infected, deceased) ' +
    'VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);');
  for var S: TSimulationPersonState in FPeople do
    S.InsertIntoDatabase(Statement);
end;

end.
