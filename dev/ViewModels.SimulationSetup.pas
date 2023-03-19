unit ViewModels.SimulationSetup;

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
  /// <summary> Class to initialize a simulation setup.</summary>
  TSimulationSetup = class(TObject)
  private
    type
      /// <summary>A key to identify a person in the person dictionary.</summary>
      TPersonKey = class(TObject)
      private
        FNumber: integer;
      public
        /// <summary>Initializes TPersonKey with value -1 for the property Number. </summary>
        constructor Create; overload;
        /// <summary>Intializes TPersonKey with ANumber for the property Number. </summary>
        constructor Create(const ANumber: Integer); overload;
        /// <summary>Compares current TPersonKey with other TObject Obj.</summary>
        /// <returns>true if 1st: Obj is assigned, 2nd: Obj has type TPersonKey,
        /// 3rd: Obj has the same number as the current TPersonKey. Else, returns false. </returns>
        function Equals(Obj: TObject): Boolean; override;
        /// <summary>Returns a unique Hashcode for the object. </summary>
        function GetHashCode: Integer; override;
        /// <summary>Returns a string representation for the object. </summary>
        function ToString: String; override;
        /// <summary>Unique identifying number for a person within a simulation setup </summary>
        property Number: Integer read FNumber write FNumber;
      end;
      /// <summary>Helper class for TPersonKey in order to enable searching
      /// in a dictionary of TPersons. </summary>
      TPersonKeyComparer = class(TInterfacedObject, IEqualityComparer<TPersonKey>)
      public
        /// <summary>Compares whether two TPersonKeys are the same. </summary>
        /// <returns>True, if Left and Right have the same number property, otherwise returns false. </returns>
        function Equals(const Left, Right: TPersonKey): Boolean; reintroduce;
        /// <summary>Returns the same unique Hashcode as TPersonKey. </summary>
        function GetHashCode(const Value: TPersonKey): Integer; reintroduce;
      end;
      TPerson = class; // Forward declaration, since TPerson contains objects of TPerson.
      /// <summary>Describes a person during the simulation setup. </summary>
      TPerson = class(TObject)
      private
        FID: String;
        FNumber: integer;
        FContactsExpected: Integer;
        FContacts: TObjectList<TPerson>;
        FInfectious: Boolean;
        FInfectiousPeriod: Integer;
        function GetContactsNotLinked: Integer;
        function GetContactsNotUsable: Integer;
      public
        /// <summary>Initializes TPerson with the passed values. </summary>
        constructor Create(const ANumber: Integer; const AID: String; const
            ADiseasePeriod, AContactsExpected: Integer);
        /// <summary>Destroyes the object. </summary>
        destructor Destroy; override;
        /// <summary>Compares current TPerson with other TObject Obj.</summary>
        /// <returns>True if 1st: Obj is assigned, 2nd: Obj has type TPerson,
        /// 3rd: Obj has the same number as the current TPerson. Else, returns false. </returns>
        function Equals(Obj: TObject): Boolean; override;
        /// <summary>Returns a unique Hashcode for the object. </summary>
        function GetHashCode: Integer; override;
        /// <summary>Returns a string representation for the object. </summary>
        function ToString: String; override;
        /// <summary>Checks whether the people already have a contact. </summary>
        /// <returns>True, if there is already an established contact. </returns>
        function Knows(const APerson: TPerson): Boolean;
        /// <summary>Unique identifying number for a person within a simulation setup </summary>
        property Number: Integer read FNumber;
        /// <summary>Primary key value in the table simulation_people. </summary>
        property ID: String read FID;
        /// <summary>Marks an Infectious person. </summary>
        property Infectious: Boolean read FInfectious write FInfectious;
        /// <summary>Contains the number of days a person has shown symptoms. </summary>
        property InfectiousPeriod: Integer read FInfectiousPeriod write FInfectiousPeriod;
        /// <summary>The randomly generated number of contacts for a person. </summary>
        property ContactsExpected: Integer read FContactsExpected write FContactsExpected;
        /// <summary>Number of not yet established contacts. </summary>
        property ContactsNotLinked: Integer read GetContactsNotLinked;
        /// <summary>Number of possible contacts that cannot be used,
        /// either because they already exist or refer to themself. </summary>
        property ContactsNotUsable: Integer read GetContactsNotUsable;
        /// <summary>List of already existing contacts. </summary>
        property Contacts: TObjectList<TPerson> read FContacts;
      end;
      /// <summary>Used in order to save possible contacts. </summary>
      TPersonList = class(TObjectList<TPerson>);
      /// <summary>Saves properties of the people during the initialization of the simulation setup. </summary>
      TPeopleDictionary = class(TObjectDictionary<TPersonKey, TPerson>);
  public
    /// <summary>Initializes the people and the connections in a setup with a SetupID. </summary>
    class procedure Initialize(const SetupID: String);
    /// <summary>Rollback of a not finished Setup Initialization. </summary>
    class procedure Rollback(const SetupID: String);
  end;

implementation

uses
  Settings.Constants;

class procedure TSimulationSetup.Initialize(const SetupID: String);
begin
  { TODO -oJanis : Use manual transaction management to speed up the procedure. }

  // Creating in memory structures.
  var People: TPeopleDictionary := TPeopleDictionary.Create([doOwnsKeys, doOwnsValues], TPersonKeyComparer.Create);
  var PossibleContacts: TPersonList := TPersonList.Create(true);

  // Establishing Connection.
  var ConnectionStr: String := MainModel.ConnectionURL;
  var IsSQLite: Boolean := (Copy(ConnectionStr, 6, 6) = 'sqlite');
  var Connection: IZConnection := DriverManager.GetConnection(ConnectionStr);

  try
    // Read the values of the associated task.
    var ReadTaskStatement: IZPreparedStatement := Connection.PrepareStatement(
      'SELECT * FROM tasks WHERE record_id=?;');
    ReadTaskStatement.SetString(1, SetupID);
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

    // Read the parameters of the simulation setup.
    var SetupsStatement: IZPreparedStatement := Connection.PrepareStatement(
      'SELECT * FROM simulation_setups WHERE simulation_setup_id=?;');
    SetupsStatement.SetString(1, SetupID);
    var SetupsResultSet: IZResultSet := SetupsStatement.ExecuteQueryPrepared;

    if not(IsSQLite) then SetupsResultSet.First; // select the first (and only) record into the ResultSet to avoid an exception
    var ProjectID: String := SetupsResultSet.GetStringByName('project_id');
    var InfectiousOnStart: Integer := SetupsResultSet.GetIntByName('infectious_on_start');
    var DefaultSimulationDuration: Integer := SetupsResultSet.GetIntByName('default_simulation_duration');

    // Read the parameters of the according project.
    var ProjectsStatement: IZPreparedStatement := Connection.PrepareStatement(
      'SELECT * FROM projects WHERE project_id=?');
    ProjectsStatement.SetString(1, ProjectID);
    var ProjectsResultSet: IZResultSet := ProjectsStatement.ExecuteQueryPrepared;

    if not(IsSQLite) then ProjectsResultSet.First; // select the first (and only) record into the ResultSet to avoid an exception
    var PopulationNumber: Integer := ProjectsResultSet.GetIntByName('population_number');
    var MeanContacts: Double := ProjectsResultSet.GetDoubleByName('mean_contacts');
    var DeviationContacts: Double := ProjectsResultSet.GetDoubleByName('deviation_contacts');
    var MeanContactProbability: Double := ProjectsResultSet.GetDoubleByName('mean_contact_probability');
    var DeviationContactProbability: Double := ProjectsResultSet.GetDoubleByName('deviation_contact_probability');
    var MeanSusceptibility: Double := ProjectsResultSet.GetDoubleByName('mean_susceptibility');
    var DeviationSusceptibility: Double := ProjectsResultSet.GetDoubleByName('deviation_susceptibility');
    var MeanInfectiousness: Double := ProjectsResultSet.GetDoubleByName('mean_infectiousness');
    var DeviationInfectiousness: Double := ProjectsResultSet.GetDoubleByName('deviation_infectiousness');
    var MeanInitialImmunity: Double := ProjectsResultSet.GetDoubleByName('mean_initial_immunity');
    var DeviationInitialImmunity: Double := ProjectsResultSet.GetDoubleByName('deviation_initial_immunity');
    var MeanMortality: Double := ProjectsResultSet.GetDoubleByName('mean_mortality');
    var DeviationMortality: Double := ProjectsResultSet.GetDoubleByName('deviation_mortality');
    var MeanInfectiousDelayPeriod: Double := ProjectsResultSet.GetDoubleByName('mean_infectious_delay_period');
    var DeviationInfectiousDelayPeriod: Double := ProjectsResultSet.GetDoubleByName('deviation_infectious_delay_period');
    var MeanInfectiousPeriod: Double := ProjectsResultSet.GetDoubleByName('mean_infectious_period');
    var DeviationInfectiousPeriod: Double := ProjectsResultSet.GetDoubleByName('deviation_infectious_period');
    var MeanIncubationPeriod: Double := ProjectsResultSet.GetDoubleByName('mean_incubation_period');
    var DeviationIncubationPeriod: Double := ProjectsResultSet.GetDoubleByName('deviation_incubation_period');
    var MeanDiseasePeriod: Double := ProjectsResultSet.GetDoubleByName('mean_disease_period');
    var DeviationDiseasePeriod: Double := ProjectsResultSet.GetDoubleByName('deviation_disease_period');
    var MeanHalvingImmunityPeriod: Double := ProjectsResultSet.GetDoubleByName('mean_halving_immunity_period');
    var DeviationHalvingImmunityPeriod: Double := ProjectsResultSet.GetDoubleByName('deviation_halving_immunity_period');
    var MeanImmunityPeriod: Double := ProjectsResultSet.GetDoubleByName('mean_immunity_period');
    var DeviationImmunityPeriod: Double := ProjectsResultSet.GetDoubleByName('deviation_immunity_period');

    Randomize;  // Initialize the random number generator.

    // Calculate and save properties of people in table simulation_people.
    var PeopleInsertStatement: IZPreparedStatement := Connection.PrepareStatement(
      'INSERT INTO simulation_people ' +
      '(person_id, simulation_setup_id, person_number, contacts, initial_day_of_infectious, ' +
      ' susceptibility, infectiousness, infectious_delay_period, infectious_period, incubation_period, ' +
      ' disease_period, halving_immunity_period, immunity_period, initial_immunity, mortality) ' +
      'VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);');
    for var I := 1 to PopulationNumber do
    begin
      // Calculating properties of person I.
      var PersonID: String := MainModel.GetPrimaryKeyValue;
      var SimulationSetupID: String := SetupID;
      var PersonNumber: Integer := I;
      // Constraint: ContactsCount must be between 1 and PopulationNumber - 1.
      var ContactsCount: Integer := Round(RandG(MeanContacts, DeviationContacts));
      ContactsCount := IfThen(ContactsCount < 1, 1, ContactsCount);
      ContactsCount := IfThen(ContactsCount > PopulationNumber - 1, PopulationNumber - 1, ContactsCount);
      // Since the infectious people are generated later on, set
      // InitialDayOfInfectiousness as 0 (not infectious) for now.
      var InitialDayOfInfectiousness: Integer := 0;
      // Constraint: Susceptibility must be between 0 and 1.
      var Susceptibility: Double := RandG(MeanSusceptibility, DeviationSusceptibility);
      Susceptibility := IfThen(Susceptibility < 0, 0, Susceptibility);
      Susceptibility := IfThen(Susceptibility > 1, 1, Susceptibility);
      // Constraint: Infectiousness must be between 0 and 1.
      var Infectiousness: Double := RandG(MeanInfectiousness, DeviationInfectiousness);
      Infectiousness := IfThen(Infectiousness < 0, 0, Infectiousness);
      Infectiousness := IfThen(Infectiousness > 1, 1, Infectiousness);
      // Constraints: The infectious period must start before the disease ends.
      //              IncubationPeriod, InfectiousDelayPeriod must not be negative.
      //              DiseasePeriod must be greater than zero.
      var IncubationPeriod, DiseasePeriod, InfectiousDelayPeriod: Integer;
      repeat
        IncubationPeriod := Round(RandG(MeanIncubationPeriod, DeviationIncubationPeriod));
        IncubationPeriod := IfThen(IncubationPeriod < 0, 0, IncubationPeriod);
        DiseasePeriod := Round(RandG(MeanDiseasePeriod, DeviationDiseasePeriod));
        DiseasePeriod := IfThen(DiseasePeriod < 1, 1, DiseasePeriod);
        InfectiousDelayPeriod := Round(RandG(MeanInfectiousDelayPeriod, DeviationInfectiousDelayPeriod));
        InfectiousDelayPeriod := IfThen(InfectiousDelayPeriod < 0, 0, InfectiousDelayPeriod);
      until (InfectiousDelayPeriod < IncubationPeriod + DiseasePeriod);
      // Constraint: Infectiousness must be greater than zero.
      var InfectiousPeriod: Integer := Round(RandG(MeanInfectiousPeriod, DeviationInfectiousPeriod));
      InfectiousPeriod := IfThen(InfectiousPeriod < 1, 1, InfectiousPeriod);
      // Constraints: The halving time for immunity must not exceed the time of its
      //              detectability. Equal values mean that immunity does not decrease.
      var HalvingImmunityPeriod, ImmunityPeriod: Integer;
      repeat
        HalvingImmunityPeriod := Round(RandG(MeanHalvingImmunityPeriod, DeviationHalvingImmunityPeriod));
        HalvingImmunityPeriod := IfThen(HalvingImmunityPeriod < 0, 0, HalvingImmunityPeriod);
        if (MeanHalvingImmunityPeriod = MeanImmunityPeriod) then
          ImmunityPeriod := HalvingImmunityPeriod
        else
        begin
          ImmunityPeriod := Round(RandG(MeanImmunityPeriod, DeviationImmunityPeriod));
          ImmunityPeriod := IfThen(ImmunityPeriod < 0, 0, ImmunityPeriod);
        end;
      until (HalvingImmunityPeriod <= ImmunityPeriod);
      // Constraint: InitailImmunity must be between 0 and 1.
      var InitialImmunity: Double := RandG(MeanInitialImmunity, DeviationInitialImmunity);
      InitialImmunity := IfThen(InitialImmunity < 0, 0, InitialImmunity);
      InitialImmunity := IfThen(InitialImmunity > 1, 1, InitialImmunity);
      // Constraint: Mortality must be between 0 and 1.
      var Mortality: Double := RandG(MeanMortality, DeviationMortality);
      Mortality := IfThen(Mortality < 0, 0, Mortality);
      Mortality := IfThen(Mortality > 1, 1, Mortality);

      // Save properties of person I.
      PeopleInsertStatement.SetString(1, PersonID);
      PeopleInsertStatement.SetString(2, SimulationSetupID);
      PeopleInsertStatement.SetInt(3, PersonNumber);
      PeopleInsertStatement.SetInt(4, ContactsCount);
      PeopleInsertStatement.SetInt(5, InitialDayOfInfectiousness);
      PeopleInsertStatement.SetDouble(6, Susceptibility);
      PeopleInsertStatement.SetDouble(7, Infectiousness);
      PeopleInsertStatement.SetInt(8, InfectiousDelayPeriod);
      PeopleInsertStatement.SetInt(9, InfectiousPeriod);
      PeopleInsertStatement.SetInt(10, IncubationPeriod);
      PeopleInsertStatement.SetInt(11, DiseasePeriod);
      PeopleInsertStatement.SetInt(12, HalvingImmunityPeriod);
      PeopleInsertStatement.SetInt(13, ImmunityPeriod);
      PeopleInsertStatement.SetDouble(14, InitialImmunity);
      PeopleInsertStatement.SetDouble(15, Mortality);
      PeopleInsertStatement.ExecutePrepared;

      // Save created person into the dictionary.
      People.Add(TPersonKey.Create(I), TPerson.Create(I, PersonID, InfectiousPeriod, ContactsCount));

      // Add created person for each requested contact to the possible contacts list.
      for var J := 1 to ContactsCount do
        PossibleContacts.Add(TPerson.Create(I, PersonID, InfectiousPeriod, ContactsCount));
    end;

    // Make sure that count of possible contacts is even.
    if ((PossibleContacts.Count mod 2) = 1) then
    begin
      var r: Integer := Random(PossibleContacts.Count);
      var p: TPerson := PossibleContacts.Items[r];
      PossibleContacts.Add(TPerson.Create(p.Number, p.ID, 0, p.ContactsExpected))
    end;

    { TODO -oJanis : Calculate actual values for mean and deviation and save them into the database. }

    // Create contacts between people randomly.
    var Person1Key: TPersonKey := TPersonKey.Create;
    var Person2Key: TPersonKey := TPersonKey.Create;
    var ContactInsertStatement: IZPreparedStatement := Connection.PrepareStatement(
      'INSERT INTO person_knows_person (person_knows_person_id, person1_id, person2_id, contact_probability) VALUES (?, ?, ?, ?);');
    try
      // while contacts are still available...
      while (PossibleContacts.Count > 0) do
      begin
        var Person1Pos: Integer;
        var Person2Pos: Integer;
        var Person1: TPerson;
        var Person2: TPerson;
        var ContactsAvailable: Boolean;
        var ContactAllowed: Boolean;

        // Looking for a correct contact pair:
        repeat
          // Get random positions of two entries in PossibleContacts list:
          Person1Pos := IfThen(PossibleContacts.Count <= 2, 0, Random(PossibleContacts.Count));
          Person2Pos := IfThen(PossibleContacts.Count <= 2, 1, Random(PossibleContacts.Count));
          // Get the Numbers of selected people on Person1Pos and Person2Pos in PossibleContacts.
          Person1Key.Number := PossibleContacts.Items[Person1Pos].Number;
          Person2Key.Number := PossibleContacts.Items[Person2Pos].Number;
          // Get the people from the dictionary.
          Person1 := People.Items[Person1Key];
          Person2 := People.Items[Person2Key];
          var NotMe: Boolean := not(Person1.Equals(Person2));
          var ContactNotExists: Boolean := not(Person1.Knows(Person2));
          ContactAllowed := (NotMe and ContactNotExists);
          // If not a valid contact pair...
          if not(ContactAllowed) then
          begin
            // ... check whether possible contact pairs are available in PossibleContacts list ...
            ContactsAvailable := (PossibleContacts.Count > Person1.GetContactsNotUsable) and
                                 (PossibleContacts.Count > 2);
            // ... if not, get a second person randomly from People dictionary:
            if not(ContactsAvailable) then
            repeat
              // The property ContactsCount of Person in People dictionary is ignored.
              Person2Key.Number := Random(PopulationNumber) + 1;
              Person2 := People.Items[Person2Key];
              NotMe := not(Person1.Equals(Person2));
              ContactNotExists := not(Person1.Knows(Person2));
              ContactAllowed := (NotMe and ContactNotExists);
            until ContactAllowed;
          end;
        until ContactAllowed;

        // Contact pair found:
        // 1st: Mark contact in the people dictionary:
        Person1.Contacts.Add(Person2);
        Person2.Contacts.Add(Person1);

        // 2nd: Delete the selected entries possible contacts list:
        // Always delete the later entry first.
        if (Person1Pos < Person2Pos) then
        begin
          if (Person2Pos <= PossibleContacts.Count - 1) then PossibleContacts.Delete(Person2Pos);
          if (Person1Pos <= PossibleContacts.Count - 1) then PossibleContacts.Delete(Person1Pos);
        end
        else
        begin
          if (Person1Pos <= PossibleContacts.Count - 1) then PossibleContacts.Delete(Person1Pos);
          if (Person2Pos <= PossibleContacts.Count - 1) then PossibleContacts.Delete(Person2Pos);
        end;

        // 3rd: Calculate contact probability:
        // Constraint: ContactProbability must be between 0 and 1.
        var ContactProbability: Double := RandG(MeanContactProbability, DeviationContactProbability);
        ContactProbability := IfThen(ContactProbability < 0, 0, ContactProbability);
        ContactProbability := IfThen(ContactProbability > 1, 1, ContactProbability);

        // 4th: Insert record into table person_knows_person:
        var PersonKnowsPersonID: String := MainModel.GetPrimaryKeyValue;
        ContactInsertStatement.SetString(1, PersonKnowsPersonID);
        // ID of Person1 should always come first in alphabetical order in person_knows_person
        if (Person1.ID < Person2.ID) then
        begin
          ContactInsertStatement.SetString(2, Person1.ID);
          ContactInsertStatement.SetString(3, Person2.ID);
        end
        else
        begin
          ContactInsertStatement.SetString(2, Person2.ID);
          ContactInsertStatement.SetString(3, Person1.ID);
        end;
        ContactInsertStatement.SetDouble(4, ContactProbability);
        ContactInsertStatement.ExecutePrepared;
      end;
    finally
      FreeAndNil(Person1Key);
      FreeAndNil(Person2Key);
    end;

    { TODO -oJanis : Update the number of contacts to fit the actual number of contacts after possibly assigning new ones. }

    // Mark randomly selected people in simulation_people as Infectious according to InfectedOnStart value.
    var PeopleUpdateStatement: IZPreparedStatement := Connection.PrepareStatement(
      'UPDATE simulation_people SET initial_day_of_infectious = ? WHERE person_id = ?;');
    var PersonKey: TPersonKey := TPersonKey.Create;
    var Person: TPerson;
    try
      for var I := 1 to InfectiousOnStart do
      begin
        var PersonID: String := '';
        var NewInfection: Boolean;
        repeat
          PersonKey.Number := Random(PopulationNumber) + 1;
          Person := People.Items[PersonKey];
          if not(Person.Infectious) then
          begin
            Person.Infectious := true;
            PersonID := Person.ID;
            NewInfection := true;
          end
          else
            NewInfection := false;
        until NewInfection;

        var temp: Integer := Person.InfectiousPeriod;
        var DayOfInfectious: Integer := Random(temp) + 1;
        PeopleUpdateStatement.SetInt(1, DayOfInfectious);
        PeopleUpdateStatement.SetString(2, Person.ID);
        PeopleUpdateStatement.ExecutePrepared;
      end;
    finally
      PersonKey.Free;
    end;

    // Update the associated task.
    var UpdateTaskStatement: IZPreparedStatement := Connection.PrepareStatement(
      'UPDATE tasks SET task_status = ?, task_owner = ?, completed_on = ?, calculation_time = ? WHERE task_id = ?;');
    UpdateTaskStatement.SetString(1, TaskStatusFinished);
    UpdateTaskStatement.SetNull(2, stString);
    var TaskCompletedOn: TDateTime := Now;
    var TaskNewCalculationTime: TDateTime := TaskCompletedOn - TaskLastStartOn;
    UpdateTaskStatement.SetTimestamp(3, TaskCompletedOn);
    UpdateTaskStatement.SetTime(4, TaskNewCalculationTime + TaskLastCalculationTime);
    UpdateTaskStatement.SetString(5, TaskID);
    UpdateTaskStatement.ExecutePrepared;
  finally
    // Shut down data connection.
    Connection.Close;

    // Free in memory structures.
    PossibleContacts.Free;
    People.Free;
  end;
end;

{ TPersonKey }

constructor TSimulationSetup.TPersonKey.Create(const ANumber: Integer);
begin
  inherited Create;
  Number := ANumber;
end;

function TSimulationSetup.TPersonKey.Equals(Obj: TObject): Boolean;
begin
  Result := false;
  if Assigned(Obj) then
    if (Obj is TPersonKey) then
      Result := ((Obj as TPersonKey).Number = Self.Number);
end;

function TSimulationSetup.TPersonKey.GetHashCode: Integer;
begin
  Result := Number;
end;

function TSimulationSetup.TPersonKey.ToString: String;
begin
  Result := Format('%s(Number=%d)', [Self.ClassName, Self.Number]);
end;

constructor TSimulationSetup.TPersonKey.Create;
begin
  inherited;
  Number := -1;
end;

{ TPerson }

constructor TSimulationSetup.TPerson.Create(const ANumber: Integer; const AID: String; const
    ADiseasePeriod, AContactsExpected: Integer);
begin
  inherited Create;

  FContacts := TObjectList<TPerson>.Create(
    // Anonymous method to compare two list items.
    // Needed for IndexOf method.
    TComparer<TPerson>.Construct(
      function(const Left, Right: TPerson): Integer
      begin
        Result := (Left.Number - Right.Number);
      end),
    // Items are not owned by the list.
    // There are links only.
    false);
  FNumber := ANumber;
  FID := AID;
  FInfectiousPeriod := ADiseasePeriod;
  FContactsExpected := AContactsExpected;
  FInfectious := false;
end;

destructor TSimulationSetup.TPerson.Destroy;
begin
  FreeAndNil(FContacts);
  inherited;
end;

function TSimulationSetup.TPerson.Equals(Obj: TObject): Boolean;
begin
  Result := false;
  if Assigned(Obj) then
    if (Obj is TPerson) then
      Result := ((Obj as TPerson).Number = Self.FNumber);
end;

function TSimulationSetup.TPerson.GetContactsNotLinked: Integer;
begin
  Result := FContactsExpected - FContacts.Count;
end;

function TSimulationSetup.TPerson.GetContactsNotUsable: Integer;
begin
  var temp: Integer := ContactsNotLinked;
  for var I := 0 to Contacts.Count - 1 do
    temp := temp + Contacts.Items[I].ContactsNotLinked;
  Result := temp;
end;

function TSimulationSetup.TPerson.GetHashCode: Integer;
begin
  Result := FNumber;
end;

function TSimulationSetup.TPerson.Knows(const APerson: TPerson): Boolean;
begin
  Result := FContacts.Contains(APerson);
end;

function TSimulationSetup.TPerson.ToString: String;
begin
  Result := Format('%s(Number=%d | ID=%s | ContactsExpected=%d)', [Self.ClassName, Self.FNumber, Self.FID, Self.FContactsExpected]);
end;

{ TPersonKeyComparer }

function TSimulationSetup.TPersonKeyComparer.Equals(const Left, Right: TPersonKey): Boolean;
begin
  Result := (Left.Number = Right.Number);
end;

function TSimulationSetup.TPersonKeyComparer.GetHashCode(const Value: TPersonKey): Integer;
begin
  Result := Value.Number;
end;

class procedure TSimulationSetup.Rollback(const SetupID: String);
begin
  { TODO -oJanis : Implement this procedure (Rollback of a not finished Setup Initialization) }
end;

end.
