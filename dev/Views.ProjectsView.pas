unit Views.ProjectsView;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.ImageList,
  System.Messaging,
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
  Vcl.DBCtrls,
  Vcl.Mask,
  Views.CustomDBMainDependentModuleView,
  ZSqlUpdate,
  ZDataset,
  ZAbstractRODataset,
  ZAbstractDataset,
  ZAbstractTable;

type
  TProjectsView = class(TCustomDBMainDependentModuleView)
    DependentData2TabSheet: TTabSheet;
    DependentData2LeftBgPanel: TPanel;
    DependentData2Grid: TDBGrid;
    DependentData2Splitter: TSplitter;
    DependentData2RightBgPanel: TPanel;
    DependentData2DetailsScrollBox: TScrollBox;
    ProjectPopulationBox: TGroupBox;
    ProjectPopulationSizeEdit: TDBEdit;
    ProjectPopulationSizeLabel: TLabel;
    ProjectContactsMeanEdit: TDBEdit;
    ProjectContactsMeanLabel: TLabel;
    ProjectContactsCountLabel: TLabel;
    ProjectContactsDeviationEdit: TDBEdit;
    ProjectContactsDeviationLabel: TLabel;
    ProjectContactProbabilityMeanEdit: TDBEdit;
    ProjectContactProbabilityDeviationEdit: TDBEdit;
    ProjectContactProbabilityLabel: TLabel;
    ProjectContactsLabel: TLabel;
    ProjectNameBox: TGroupBox;
    ProjectNameLabel: TLabel;
    ProjectNameEdit: TDBEdit;
    ProjectsDescriptionLabel: TLabel;
    ProjectDescriptionEdit: TDBMemo;
    ProjectInfectiousOnStartLabel: TLabel;
    ProjectInfectiousOnStartEdit: TDBEdit;
    ProjectCountSimulationDaysLabel: TLabel;
    ProjectCountSimulationDaysEdit: TDBEdit;
    ProjectDiseaseBox: TGroupBox;
    ProjectDiseasePeriodsLabel: TLabel;
    ProjectIncubationPeriodLabel: TLabel;
    ProjectInfectiousPeriodLabel: TLabel;
    ProjectDiseasePeriodLabel: TLabel;
    ProjectsDiseasePeriodsMeanLabel: TLabel;
    ProjectsDiseasePeriodsDeviationLabel: TLabel;
    ProjectMeanIncubationPeriodEdit: TDBEdit;
    ProjectDeviationIncubationPeriodEdit: TDBEdit;
    ProjectMeanInfectiousPeriodEdit: TDBEdit;
    ProjectDeviationInfectiousPeriodEdit: TDBEdit;
    ProjectMeanDiseasePeriodEdit: TDBEdit;
    ProjectDeviationDiseasePeriodEdit: TDBEdit;
    ProjectMeanInfectiousDelayPeriodEdit: TDBEdit;
    ProjectsDiseaseProbabilitiesLabel: TLabel;
    ProjectsDiseaseProbabilitiesMeanLabel: TLabel;
    ProjectsDiseaseProbabilitiesDeviationLabel: TLabel;
    ProjectSusceptibilityProbabilityLabel: TLabel;
    ProjectSusceptibilityInfectiousnessLabel: TLabel;
    ProjectMeanSusceptibilityProbabilityEdit: TDBEdit;
    ProjectDeviationSusceptibilityProbabilityEdit: TDBEdit;
    ProjectMeanInfectiousnessProbabilityEdit: TDBEdit;
    ProjectDeviationInfectiousnessProbabilityEdit: TDBEdit;
    ProjectMeanInitialImmunityEdit: TDBEdit;
    ProjectDeviationInitialImmunityEdit: TDBEdit;
    ProjectSusceptibilityMortalityLabel: TLabel;
    ProjectMeanMortalityProbabilityEdit: TDBEdit;
    ProjectDeviationMortalityProbabilityEdit: TDBEdit;
    ProjectsTable: TZTable;
    ProjectsSource: TDataSource;
    SimulationSetupsTable: TZTable;
    SimulationsQuery: TZQuery;
    SimulationsQueryProjectID: TStringField;
    SimulationsQuerySetupName: TStringField;
    SimulationsQuerySimulationID: TStringField;
    SimulationsQuerySimulationSetupID: TStringField;
    SimulationsQueryName: TStringField;
    SimulationsQueryDescription: TMemoField;
    SimulationsQuerySimulationDuration: TIntegerField;
    SimulationsUpdateSQL: TZUpdateSQL;
    SimulationSetupsSource: TDataSource;
    SimulationsSource: TDataSource;
    ProjectMeanHalvingImmunityPeriodEdit: TDBEdit;
    SetupSetupBox: TGroupBox;
    SetupNameLabel: TLabel;
    SetupNameEdit: TDBEdit;
    SetupCountSimulationDaysEdit: TDBEdit;
    SimulationCountSimulationDaysLabel: TLabel;
    SetupInfectiousOnStartLabel: TLabel;
    SetupInfectiousOnStartEdit: TDBEdit;
    SetupPeopleBox: TGroupBox;
    SetupPeoplePeriodsDoyOfInfectiousnessLabel: TLabel;
    SetupPeopleProbabilitiesSusceptibilityLabel: TLabel;
    SetupPeopleInfectiousnessLabel: TLabel;
    SetupPeoplePeriodsIncubationLabel: TLabel;
    SetupPeoplePeriodsDiseaseLabel: TLabel;
    SetupPeopleProbabilitiesImmunityLabel: TLabel;
    SetupPeopleProbabilitiesMortalityLabel: TLabel;
    SetupPeoplePeriodsInfectiousText: TDBText;
    SetupPeoplePeriodsDoyOfInfectiousnessText: TDBText;
    SetupPeopleProbabilitiesSusceptibilityText: TDBText;
    SetupPeoplePeriodsIncubationText: TDBText;
    SetupPeoplePeriodsInfectiousDelayText: TDBText;
    SetupPeopleInfectiousnessText: TDBText;
    SetupPeopleProbabilitiesMortalityText: TDBText;
    SimulationPeopleTable: TZTable;
    SimulationPeopleSource: TDataSource;
    PersonKnowsPersonSource: TDataSource;
    SimulationPeopleTablePersonID: TStringField;
    SimulationPeopleTableSimulationSetupID: TStringField;
    SimulationPeopleTableContacts: TIntegerField;
    SimulationPeopleTableSusceptibility: TFloatField;
    SimulationPeopleTableInfectiousness: TFloatField;
    SimulationPeopleTableIncubationPeriod: TIntegerField;
    SimulationPeopleTableDiseasePeriod: TIntegerField;
    SimulationPeopleTableMortality: TFloatField;
    SimulationPeopleTablePersonNumber: TIntegerField;
    SimulationPeopleGrid: TDBGrid;
    SimulationPeopleTableInfectious: TBooleanField;
    PersonKnowsPersonQuery: TZQuery;
    PersonKnowsPersonQueryInfectious: TBooleanField;
    DBGrid1: TDBGrid;
    SetupPeoplePeriodsInfectiousLabel: TLabel;
    SetupPeoplePeriodsDiseaseText: TDBText;
    SimulationPeopleTableInfectiousPeriod: TIntegerField;
    SimulationBox: TGroupBox;
    SimulationUsedSetupLabel: TLabel;
    SimulationNameEdit: TDBEdit;
    SimulationNumberOfRunsLabel: TLabel;
    SimulationNumberOfRunsEdit: TDBEdit;
    SimulationDurationLabel: TLabel;
    SimulationDurationEdit: TDBEdit;
    SimulationDescriptionEdit: TDBMemo;
    SimulationUsedSetupEdit: TDBLookupComboBox;
    SimulationDescriptionLabel: TLabel;
    SimulationNameLabel: TLabel;
    PersonKnowsPersonQueryperson_knows_person_id: TStringField;
    PersonKnowsPersonQuerymaster_id: TStringField;
    PersonKnowsPersonQuerycontact_id: TStringField;
    PersonKnowsPersonQueryContactProbability: TFloatField;
    PersonKnowsPersonQueryContactNumber: TIntegerField;
    PersonKnowsPersonQueryContactContacts: TIntegerField;
    SimulationsQueryNumberOfRuns: TIntegerField;
    ProjectsTableProjectID: TStringField;
    ProjectsTableName: TStringField;
    ProjectsTableDescription: TMemoField;
    ProjectsTablePopulationNumber: TIntegerField;
    ProjectsTableDefaultInfectiousOnStart: TIntegerField;
    ProjectsTableDefaultSimulationDuration: TIntegerField;
    ProjectsTableMeanContacts: TFloatField;
    ProjectsTableDeviationContacts: TFloatField;
    ProjectsTableMeanContactProbability: TFloatField;
    ProjectsTableDeviationContactProbability: TFloatField;
    ProjectsTableMeanSusceptibility: TFloatField;
    ProjectsTableDeviationSusceptibility: TFloatField;
    ProjectsTableMeanInfectiousness: TFloatField;
    ProjectsTableDeviationInfectiousness: TFloatField;
    ProjectsTableMeanInitialImmunity: TFloatField;
    ProjectsTableDeviationInitialImmunity: TFloatField;
    ProjectsTableMeanMortality: TFloatField;
    ProjectsTableDeviationMortality: TFloatField;
    ProjectsTableMeanInfectiousDelayPeriod: TFloatField;
    ProjectsTableDeviationInfectiousDelayPeriod: TFloatField;
    ProjectsTableMeanInfectiousPeriod: TFloatField;
    ProjectsTableDeviationInfectiousPeriod: TFloatField;
    ProjectsTableMeanIncubationPeriod: TFloatField;
    ProjectsTableDeviationIncubationPeriod: TFloatField;
    ProjectsTableMeanDiseasePeriod: TFloatField;
    ProjectsTableDeviationDiseasePeriod: TFloatField;
    ProjectsTableMeanHalvingImmunityPeriod: TFloatField;
    ProjectsTableDeviationHalvingImmunityPeriod: TFloatField;
    ProjectsTableMeanImmunityPeriod: TFloatField;
    ProjectsTableDeviationImmunityPeriod: TFloatField;
    ProjectDeviationInfectiousDelayPeriod: TDBEdit;
    ProjectInfectiousDelayLabel: TLabel;
    ProjectsDiseaseImmunityLabel: TLabel;
    ProjectMeanInitialImmunityPeriod: TLabel;
    ProjectImmunityPeriodEdit: TLabel;
    ProjectHalvingImmunityPeriodLabel: TLabel;
    ProjectsDiseaseImmunityMeanLabel: TLabel;
    ProjectsDiseaseImmunityDeviationLabel: TLabel;
    ProjectDeviationHalvingImmunityPeriodEdit: TDBEdit;
    ProjectMeanImmunityPeriodEdit: TDBEdit;
    ProjectDeviationImmunityPeriodEdit: TDBEdit;
    SimulationSetupsTableSimulationSetupID: TStringField;
    SimulationSetupsTableProjectID: TStringField;
    SimulationSetupsTableName: TStringField;
    SimulationSetupsTableDefaultSimulationDuration: TIntegerField;
    SimulationSetupsTableInfectiousOnStart: TIntegerField;
    SimulationSetupsTableSetupState: TStringField;
    ProposeSetupNumberQuery: TZReadOnlyQuery;
    ProposeSetupNumberQuerySetupNumber: TLargeintField;
    SimulationPeopleTableInitialDayOfInfectiousness: TIntegerField;
    SimulationPeopleTableInfectiousDelayPeriod: TIntegerField;
    SimulationPeopleTableHalvingImmunityPeriod: TIntegerField;
    SimulationPeopleTableImmunityPeriod: TIntegerField;
    SimulationPeopleTableInitialImmunity: TFloatField;
    SetupPeoplePeriodsLabel: TLabel;
    SetupPeoplePeriodsInfectiousDelayLabel: TLabel;
    SetupPeopleProbabilitiesLabel: TLabel;
    SetupPeopleProbabilitiesImmunityText: TDBText;
    SetupPeoplePeriodsImmunityDetectableLabel: TLabel;
    SetupPeoplePeriodsImmunityHalvingLabel: TLabel;
    SetupPeoplePeriodsImmunityDetectableText: TDBText;
    SetupPeoplePeriodsImmunityHalvingText: TDBText;
    PersonKnowsPersonQueryContactDayOfInfectiousness: TIntegerField;
    ProposeSimulationNumberQuery: TZReadOnlyQuery;
    LookupSimulationSetupQuery: TZReadOnlyQuery;
    LookupSimulationSetupSource: TDataSource;
    ProposeSimulationNumberQuerySimulationNumber: TLargeintField;
    LookupSimulationSetupQuerysimulationSetupID: TStringField;
    LookupSimulationSetupQueryProjectID: TStringField;
    LookupSimulationSetupQueryName: TStringField;
    LookupSimulationSetupQueryDefaultSimulationDuration: TIntegerField;
    TasksTable: TZTable;
    TasksTableTaskID: TStringField;
    TasksTableRecordID: TStringField;
    TasksTableTaskType: TStringField;
    TasksTableTaskPriority: TIntegerField;
    TasksTableTaskStatus: TStringField;
    TasksTableTaskOwner: TStringField;
    TasksTableDayNumber: TIntegerField;
    TasksTableRunNumber: TIntegerField;
    TasksTableCreatedOn: TDateField;
    TasksTableFirstStartOn: TDateTimeField;
    TasksTableLastStartOn: TDateTimeField;
    TasksTableCompletedOn: TDateTimeField;
    TasksTableCalculationTime: TTimeField;
    TenMoreDaysBtn: TButton;
    ProjectStartedTasksQuery: TZReadOnlyQuery;
    ProjectStartedTasksQueryCount: TLargeintField;
    SetupStartedTasksQuery: TZReadOnlyQuery;
    SetupStartedTasksQueryCount: TLargeintField;
    procedure TenMoreDaysBtnClick(Sender: TObject);
    procedure ButtonsCardPanelCardChange(Sender: TObject; PrevCard, NextCard: TCard);
    procedure CancelBtnClick(Sender: TObject);
    procedure DeleteBtnClick(Sender: TObject);
    procedure EditBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure NewBtnClick(Sender: TObject);
    procedure PostBtnClick(Sender: TObject);
    procedure RefreshBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PersonKnowsPersonQueryCalcFields(DataSet: TDataSet);
    procedure ProjectsSourceDataChange(Sender: TObject; Field: TField);
    procedure SimulationPeopleSourceDataChange(Sender: TObject; Field: TField);
    procedure SimulationPeopleTableCalcFields(DataSet: TDataSet);
    procedure SimulationsQuerySimulationSetupIDChange(Sender: TField);
  private
    { Private-Deklarationen }
    function GetProjectsRecordCount: Integer;
    function GetSimulationSetupsRecordCount: Integer;
    function GetSimulationsRecordCount: Integer;
    procedure CreateSetupInitTask;
    procedure CreateSimulationInitTask;
    procedure CreateSimulationRunInitTask;
    procedure CreateSimulationRunExecTask(ADayNo: Integer);
    procedure CreateSimulationRunExecTasks(AFirstDay, ALastDay: Integer);
    procedure CreateSimulationRunEvalTask(ADayNo: Integer);
    procedure CreateSimulationRunEvalTasks(AFirstDay, ALastDay: Integer);
    procedure EditProject;
    procedure EditSetup;
    procedure EditSimulation;
    procedure EnableProjectControls;
    procedure DisableProjectControls;
    procedure EnableSetupControls;
    procedure DisableSetupControls;
    procedure EnableSimulationControls;
    procedure DisableSimulationControls;
  protected
    function DataSetEmpty: Boolean; override;
    function FormatModuleInfo: String; override;
    function ValidateData: Boolean; override;
    property ProjectsRecordCount: Integer read GetProjectsRecordCount;
    property SimulationSetupsRecordCount: Integer read GetSimulationSetupsRecordCount;
    property SimulationsRecordCount: Integer read GetSimulationsRecordCount;
  public
    { Public-Deklarationen }
  end;

implementation

uses
  System.Math,
  System.DateUtils,
  Dialogs.InformationDialog,
  Dialogs.WarningDialog,
  Dialogs.WaitingDialog,
  ViewModels.SimulationSetup,
  Models.MainModel,
  Messages.ModuleInfoChanged,
  Settings.Constants;

{$R *.dfm}

procedure TProjectsView.TenMoreDaysBtnClick(Sender: TObject);
begin
  inherited;
  var OldDaysCount: Integer := SimulationsQuerySimulationDuration.AsInteger;
  var NewDaysCount: Integer := OldDaysCount + 10;
  var WaitingDlg := TWaitingDialog.ShowDlg('The associated tasks are created. Please wait...');
  try
    SimulationsQuery.Edit;
    SimulationsQuerySimulationDuration.AsInteger := NewDaysCount;
    SimulationsQuery.Post;
    for var I := OldDaysCount + 1 to NewDaysCount do
    begin
      CreateSimulationRunExecTask(I);
      CreateSimulationRunEvalTask(I);
    end;
  finally
    WaitingDlg.HideDlg;
  end;
end;

procedure TProjectsView.ButtonsCardPanelCardChange(Sender: TObject; PrevCard, NextCard: TCard);
begin
  inherited;

  if (PageControl.ActivePage = MainDetailsTabSheet) then
  begin
    ProjectNameBox.Enabled := (NextCard = EditModeCard);
    ProjectPopulationBox.Enabled := (NextCard = EditModeCard);
    ProjectDiseaseBox.Enabled := (NextCard = EditModeCard);
  end
  else if (PageControl.ActivePage = DependentData1TabSheet) then
  begin
    SetupSetupBox.Enabled := (NextCard = EditModeCard);
  end
  else if (PageControl.ActivePage = DependentData2TabSheet) then
  begin
    SimulationBox.Enabled := (NextCard = EditModeCard);
  end;
end;

procedure TProjectsView.CancelBtnClick(Sender: TObject);
begin
  inherited;

  if (PageControl.ActivePage = MainDetailsTabSheet) then
  begin
    if (ProjectsTable.State in [dsEdit, dsInsert]) then
      ProjectsTable.Cancel;
  end
  else if (PageControl.ActivePage = DependentData1TabSheet) then
  begin
    if (SimulationSetupsTable.State in [dsEdit, dsInsert]) then
      SimulationSetupsTable.Cancel;
  end
  else if (PageControl.ActivePage = DependentData2TabSheet) then
  begin
    if (SimulationsQuery.State in [dsEdit, dsInsert]) then
      SimulationsQuery.Cancel;
  end;

  TenMoreDaysBtn.Enabled := true;
  ButtonsCardPanel.ActiveCard := ViewModeCard;
end;

procedure TProjectsView.CreateSetupInitTask;
begin
  TasksTable.Insert;
  TasksTableTaskID.AsString := MainModel.GetPrimaryKeyValue;
  TasksTableRecordID.AsString := SimulationSetupsTableSimulationSetupID.AsString;
  TasksTableTaskType.AsString := TaskTypeSetupInitialization;
  TasksTableTaskPriority.AsInteger := TaskPrioritySetupInitialization;
  if MainModel.Settings.TasksCreateQueued then
    TasksTableTaskStatus.AsString := TaskStatusQueued
  else
    TasksTableTaskStatus.AsString := TaskStatusNotStarted;
  TasksTableTaskOwner.Clear;
  TasksTableDayNumber.Clear;
  TasksTableRunNumber.Clear;
  TasksTableCreatedOn.AsDateTime := Date;
  TasksTableFirstStartOn.Clear;
  TasksTableLastStartOn.Clear;
  TasksTableCompletedOn.Clear;
  TasksTableCalculationTime.AsDateTime := 0;
  TasksTable.Post;
end;

procedure TProjectsView.CreateSimulationInitTask;
begin
  TasksTable.Insert;
  TasksTableTaskID.AsString := MainModel.GetPrimaryKeyValue;
  TasksTableRecordID.AsString := SimulationsQuerySimulationID.AsString;
  TasksTableTaskType.AsString := TaskTypeSimulationInitialization;
  TasksTableTaskPriority.AsInteger := TaskPrioritySimulationInitialization;
  if MainModel.Settings.TasksCreateQueued then
    TasksTableTaskStatus.AsString := TaskStatusQueued
  else
    TasksTableTaskStatus.AsString := TaskStatusNotStarted;
  TasksTableTaskOwner.Clear;
  TasksTableDayNumber.Clear;
  TasksTableRunNumber.Clear;
  TasksTableCreatedOn.AsDateTime := Date;
  TasksTableFirstStartOn.Clear;
  TasksTableLastStartOn.Clear;
  TasksTableCompletedOn.Clear;
  TasksTableCalculationTime.AsDateTime := 0;
  TasksTable.Post;
end;

procedure TProjectsView.CreateSimulationRunEvalTask(ADayNo: Integer);
begin
  TasksTable.Insert;
  TasksTableTaskID.AsString := MainModel.GetPrimaryKeyValue;
  TasksTableRecordID.AsString := SimulationsQuerySimulationID.AsString;
  TasksTableTaskType.AsString := TaskTypeDayEvaluation;
  TasksTableTaskPriority.AsInteger := TaskPriorityDayEvaluation;
  if MainModel.Settings.TasksCreateQueued then
    TasksTableTaskStatus.AsString := TaskStatusQueued
  else
    TasksTableTaskStatus.AsString := TaskStatusNotStarted;
  TasksTableTaskOwner.Clear;
  TasksTableDayNumber.AsInteger := ADayNo;
  TasksTableRunNumber.Clear;
  TasksTableCreatedOn.AsDateTime := Date;
  TasksTableFirstStartOn.Clear;
  TasksTableLastStartOn.Clear;
  TasksTableCompletedOn.Clear;
  TasksTableCalculationTime.AsDateTime := 0;
  TasksTable.Post;
end;

procedure TProjectsView.CreateSimulationRunEvalTasks(AFirstDay,
  ALastDay: Integer);
begin
  for var I := AFirstDay to ALastDay do
    CreateSimulationRunEvalTask(I);
end;

procedure TProjectsView.CreateSimulationRunExecTask(ADayNo: Integer);
begin
  for var RunNo := 1 to SimulationsQueryNumberOfRuns.AsInteger do
  begin // RunNo = number of run
    TasksTable.Insert;
    TasksTableTaskID.AsString := MainModel.GetPrimaryKeyValue;
    TasksTableRecordID.AsString := SimulationsQuerySimulationID.AsString;
    TasksTableTaskType.AsString := TaskTypeRunExecution;
    TasksTableTaskPriority.AsInteger := TaskPriorityRunExecution;
    if MainModel.Settings.TasksCreateQueued then
      TasksTableTaskStatus.AsString := TaskStatusQueued
    else
      TasksTableTaskStatus.AsString := TaskStatusNotStarted;
    TasksTableTaskOwner.Clear;
    TasksTableDayNumber.AsInteger := ADayNo;
    TasksTableRunNumber.AsInteger := RunNo;
    TasksTableCreatedOn.AsDateTime := Date;
    TasksTableFirstStartOn.Clear;
    TasksTableLastStartOn.Clear;
    TasksTableCompletedOn.Clear;
    TasksTableCalculationTime.AsDateTime := 0;
    TasksTable.Post;
  end;
end;

procedure TProjectsView.CreateSimulationRunExecTasks(AFirstDay, ALastDay:
    Integer);
begin
  for var I := AFirstDay to ALastDay do
    CreateSimulationRunExecTask(I);
end;

procedure TProjectsView.CreateSimulationRunInitTask;
begin
  for var RunNo := 1 to SimulationsQueryNumberOfRuns.AsInteger do
  begin // RunNo = number of run
    TasksTable.Insert;
    TasksTableTaskID.AsString := MainModel.GetPrimaryKeyValue;
    TasksTableRecordID.AsString := SimulationsQuerySimulationID.AsString;
    TasksTableTaskType.AsString := TaskTypeRunInitialization;
    TasksTableTaskPriority.AsInteger := TaskPriorityRunInitialization;
    if MainModel.Settings.TasksCreateQueued then
      TasksTableTaskStatus.AsString := TaskStatusQueued
    else
      TasksTableTaskStatus.AsString := TaskStatusNotStarted;
    TasksTableTaskOwner.Clear;
    TasksTableDayNumber.AsInteger := 0;
    TasksTableRunNumber.AsInteger := RunNo;
    TasksTableCreatedOn.AsDateTime := Date;
    TasksTableFirstStartOn.Clear;
    TasksTableLastStartOn.Clear;
    TasksTableCompletedOn.Clear;
    TasksTableCalculationTime.AsDateTime := 0;
    TasksTable.Post;
  end;
end;

procedure TProjectsView.FormCreate(Sender: TObject);
begin
  inherited;
  MessagesEnabled := false;
end;

{ TProjectsView }

function TProjectsView.DataSetEmpty: Boolean;
begin
  Result := true;
  if (PageControl.ActivePage = MainDetailsTabSheet) then
    Result := (ProjectsRecordCount = 0)
  else if (PageControl.ActivePage = DependentData1TabSheet) then
    Result := (SimulationSetupsRecordCount = 0)
  else if (PageControl.ActivePage = DependentData2TabSheet) then
    Result := (SimulationsRecordCount = 0);
end;

procedure TProjectsView.DeleteBtnClick(Sender: TObject);
begin
  inherited;

  if DataSetEmpty then
  begin
    TInformationDialog.ShowDlg('No record can be deleted because the table is empty.');
    Exit;
  end;

  if (PageControl.ActivePage = MainDetailsTabSheet) then
  begin
    if (TWarningDialog.ShowDlg(
        Format('Do you really want to delete the project "%s"? This data cannot be restored afterwards.',
        [ProjectsTableName.AsString])) = mrYes) then
    begin
      var WaitingDlg := TWaitingDialog.ShowDlg(
          Format('Delete project "%s". Please wait...',
            [ProjectsTableName.AsString]));
      try
        MainModel.DeleteProject(ProjectsTableProjectID.AsString);
        ProjectsTable.Refresh;
      finally
        WaitingDlg.HideDlg;
      end;
    end;
  end
  else if (PageControl.ActivePage = DependentData1TabSheet) then
  begin
    if (TWarningDialog.ShowDlg(
        Format('Do you really want to delete the simulation setup "%s"? This data cannot be restored afterwards.',
        [SimulationSetupsTableName.AsString])) = mrYes) then
    begin
      var WaitingDlg := TWaitingDialog.ShowDlg(
          Format('Delete simulation setup "%s". Please wait...',
            [SimulationSetupsTableName.AsString]));
      try
        MainModel.DeleteSetup(SimulationSetupsTableSimulationSetupID.AsString);
        SimulationSetupsTable.Refresh;
      finally
        WaitingDlg.HideDlg;
      end;
    end;
  end
  else if (PageControl.ActivePage = DependentData2TabSheet) then
  begin
    if (TWarningDialog.ShowDlg(
        Format('Do you really want to delete the simulation "%s"? This data cannot be restored afterwards.',
        [SimulationsQueryName.AsString])) = mrYes) then
    begin
      var WaitingDlg := TWaitingDialog.ShowDlg(
          Format('Delete simulation "%s". Please wait...',
            [SimulationsQueryName.AsString]));
      try
        MainModel.DeleteSimulation(SimulationsQuerySimulationID.AsString);
        SimulationsQuery.Refresh;
      finally
        WaitingDlg.HideDlg;
      end;
    end;
  end;
end;

procedure TProjectsView.DisableProjectControls;
begin
  ProjectPopulationSizeEdit.ReadOnly := true;
  ProjectInfectiousOnStartEdit.ReadOnly := true;
  ProjectCountSimulationDaysEdit.ReadOnly := true;
  ProjectContactsMeanEdit.ReadOnly := true;
  ProjectContactsDeviationEdit.ReadOnly := true;
  ProjectContactProbabilityMeanEdit.ReadOnly := true;
  ProjectContactProbabilityDeviationEdit.ReadOnly := true;
  ProjectMeanIncubationPeriodEdit.ReadOnly := true;
  ProjectDeviationIncubationPeriodEdit.ReadOnly := true;
  ProjectMeanDiseasePeriodEdit.ReadOnly := true;
  ProjectDeviationDiseasePeriodEdit.ReadOnly := true;
  ProjectMeanInfectiousDelayPeriodEdit.ReadOnly := true;
  ProjectDeviationInfectiousDelayPeriod.ReadOnly := true;
  ProjectMeanInfectiousPeriodEdit.ReadOnly := true;
  ProjectDeviationInfectiousPeriodEdit.ReadOnly := true;
  ProjectMeanSusceptibilityProbabilityEdit.ReadOnly := true;
  ProjectDeviationSusceptibilityProbabilityEdit.ReadOnly := true;
  ProjectMeanInfectiousnessProbabilityEdit.ReadOnly := true;
  ProjectDeviationInfectiousnessProbabilityEdit.ReadOnly := true;
  ProjectMeanMortalityProbabilityEdit.ReadOnly := true;
  ProjectDeviationMortalityProbabilityEdit.ReadOnly := true;
  ProjectMeanInitialImmunityEdit.ReadOnly := true;
  ProjectDeviationInitialImmunityEdit.ReadOnly := true;
  ProjectMeanHalvingImmunityPeriodEdit.ReadOnly := true;
  ProjectDeviationHalvingImmunityPeriodEdit.ReadOnly := true;
  ProjectMeanImmunityPeriodEdit.ReadOnly := true;
  ProjectDeviationImmunityPeriodEdit.ReadOnly := true;
end;

procedure TProjectsView.DisableSetupControls;
begin
  SetupCountSimulationDaysEdit.ReadOnly := true;
  SetupInfectiousOnStartEdit.ReadOnly := true;
end;

procedure TProjectsView.DisableSimulationControls;
begin
  SimulationUsedSetupEdit.ReadOnly := true;
  SimulationDurationEdit.ReadOnly := true;
  SimulationNumberOfRunsEdit.ReadOnly := true;
end;

procedure TProjectsView.EditBtnClick(Sender: TObject);
begin
  inherited;
  TenMoreDaysBtn.Enabled := false;

  if DataSetEmpty then
  begin
    TInformationDialog.ShowDlg('There is no record to edit because the table is empty.');
    Exit;
  end;

  if (PageControl.ActivePage = MainDetailsTabSheet) then
  begin
    if not(ProjectsTable.State in [dsEdit, dsInsert]) then
      EditProject;
  end
  else if (PageControl.ActivePage = DependentData1TabSheet) then
  begin
    if not(SimulationSetupsTable.State in [dsEdit, dsInsert]) then
      EditSetup;
  end
  else if (PageControl.ActivePage = DependentData2TabSheet) then
  begin
    if not(SimulationsQuery.State in [dsEdit, dsInsert]) then
      EditSimulation;
  end;

  ButtonsCardPanel.ActiveCard := EditModeCard;
end;

procedure TProjectsView.EditProject;
begin
  ProjectStartedTasksQuery.Open;
  ProjectStartedTasksQuery.ParamByName('PROJECT_ID').AsString := ProjectsTableProjectID.AsString;
  ProjectStartedTasksQuery.Refresh;
  var count: Integer := ProjectStartedTasksQueryCount.AsInteger;
  ProjectStartedTasksQuery.Close;
  ProjectStartedTasksQuery.ParamByName('PROJECT_ID').Clear;

  if count > 0 then
  begin
    TInformationDialog.ShowDlg(
      Format('%d tasks of the project "%s" have already been queued, started or finished. ' +
             'Therefore, only the name and description of the project can be edited.',
            [count, ProjectsTableName.AsString]));
    DisableProjectControls;
  end;
  ProjectsTable.Edit;
end;

procedure TProjectsView.EditSetup;
begin
  SetupStartedTasksQuery.Open;
  SetupStartedTasksQuery.ParamByName('SETUP_ID').AsString := SimulationSetupsTableSimulationSetupID.AsString;
  SetupStartedTasksQuery.Refresh;
  var count: Integer := SetupStartedTasksQueryCount.AsInteger;
  SetupStartedTasksQuery.Close;
  SetupStartedTasksQuery.ParamByName('SETUP_ID').Clear;

  if count > 0 then
  begin
    TInformationDialog.ShowDlg(
      Format('%d tasks of the setup "%s" have already been queued, started or finished. ' +
             'Therefore, only the name of the setup can be edited.',
            [count, SimulationSetupsTableName.AsString]));
    DisableSetupControls;
  end;
  SimulationSetupsTable.Edit;
end;

procedure TProjectsView.EditSimulation;
begin
  TInformationDialog.ShowDlg('After creating a simulation, only its name and description can be changed.');
  DisableSimulationControls;
  SimulationsQuery.Edit;
end;

procedure TProjectsView.EnableProjectControls;
begin
  ProjectPopulationSizeEdit.ReadOnly := false;
  ProjectInfectiousOnStartEdit.ReadOnly := false;
  ProjectCountSimulationDaysEdit.ReadOnly := false;
  ProjectContactsMeanEdit.ReadOnly := false;
  ProjectContactsDeviationEdit.ReadOnly := false;
  ProjectContactProbabilityMeanEdit.ReadOnly := false;
  ProjectContactProbabilityDeviationEdit.ReadOnly := false;
  ProjectMeanIncubationPeriodEdit.ReadOnly := false;
  ProjectDeviationIncubationPeriodEdit.ReadOnly := false;
  ProjectMeanDiseasePeriodEdit.ReadOnly := false;
  ProjectDeviationDiseasePeriodEdit.ReadOnly := false;
  ProjectMeanInfectiousDelayPeriodEdit.ReadOnly := false;
  ProjectDeviationInfectiousDelayPeriod.ReadOnly := false;
  ProjectMeanInfectiousPeriodEdit.ReadOnly := false;
  ProjectDeviationInfectiousPeriodEdit.ReadOnly := false;
  ProjectMeanSusceptibilityProbabilityEdit.ReadOnly := false;
  ProjectDeviationSusceptibilityProbabilityEdit.ReadOnly := false;
  ProjectMeanInfectiousnessProbabilityEdit.ReadOnly := false;
  ProjectDeviationInfectiousnessProbabilityEdit.ReadOnly := false;
  ProjectMeanMortalityProbabilityEdit.ReadOnly := false;
  ProjectDeviationMortalityProbabilityEdit.ReadOnly := false;
  ProjectMeanInitialImmunityEdit.ReadOnly := false;
  ProjectDeviationInitialImmunityEdit.ReadOnly := false;
  ProjectMeanHalvingImmunityPeriodEdit.ReadOnly := false;
  ProjectDeviationHalvingImmunityPeriodEdit.ReadOnly := false;
  ProjectMeanImmunityPeriodEdit.ReadOnly := false;
  ProjectDeviationImmunityPeriodEdit.ReadOnly := false;
end;

procedure TProjectsView.EnableSetupControls;
begin
  SetupCountSimulationDaysEdit.ReadOnly := false;
  SetupInfectiousOnStartEdit.ReadOnly := false;
end;

procedure TProjectsView.EnableSimulationControls;
begin
  SimulationUsedSetupEdit.ReadOnly := false;
  SimulationDurationEdit.ReadOnly := false;
  SimulationNumberOfRunsEdit.ReadOnly := false;
end;

function TProjectsView.FormatModuleInfo: String;
begin
  Result := Format('Count of Projects: %d, Count of Setups: %d, Count of Simulations: %d', [ProjectsRecordCount, SimulationSetupsRecordCount, SimulationsRecordCount]);
end;

procedure TProjectsView.FormHide(Sender: TObject);
begin
  inherited;
  MessagesEnabled := false;

  // Closing the data sources.
  TasksTable.Close;
  SimulationsQuery.Close;
  LookupSimulationSetupQuery.Close;
  PersonKnowsPersonQuery.Close;
  SimulationPeopleTable.Close;
  SimulationSetupsTable.Close;
  ProjectsTable.Close;
end;

procedure TProjectsView.FormShow(Sender: TObject);
begin
  inherited;
  // Opening the data sources.
  ProjectsTable.Open;
  SimulationSetupsTable.Open;
  SimulationPeopleTable.Open;
  PersonKnowsPersonQuery.Open;
  LookupSimulationSetupQuery.Open;
  SimulationsQuery.Open;
  TasksTable.Open;

  // Initialization
  PageControl.ActivePage := MainDetailsTabSheet;
  ProjectNameBox.Enabled := false;
  ProjectPopulationBox.Enabled := false;
  ProjectDiseaseBox.Enabled := false;
  SetupSetupBox.Enabled := false;
  SimulationBox.Enabled := false;



  // Send view info to main view.
  SendModuleInfoChanged(FormatModuleInfo);
end;

function TProjectsView.GetProjectsRecordCount: Integer;
begin
  Result := IfThen(ProjectsTable.Active, ProjectsTable.RecordCount, 0);
end;

function TProjectsView.GetSimulationSetupsRecordCount: Integer;
begin
  Result := IfThen(SimulationSetupsTable.Active, SimulationSetupsTable.RecordCount, 0);
end;

function TProjectsView.GetSimulationsRecordCount: Integer;
begin
  Result := IfThen(SimulationsQuery.Active, SimulationsQuery.RecordCount, 0);
end;

procedure TProjectsView.NewBtnClick(Sender: TObject);
begin
  inherited;
  TenMoreDaysBtn.Enabled := false;

  // Initialize a new project.
  if (PageControl.ActivePage = MainDetailsTabSheet) then
  begin
    if not(ProjectsTable.State in [dsEdit, dsInsert]) then
    begin
      ProjectsTable.Insert;
      ProjectsTableProjectID.AsString := MainModel.GetPrimaryKeyValue;
      ProjectsTablePopulationNumber.AsInteger := MainModel.Settings.DefaultPopulationSize;
      ProjectsTableDefaultInfectiousOnStart.AsInteger := MainModel.Settings.DefaultInfectiousOnStart;
      ProjectsTableDefaultSimulationDuration.AsInteger := MainModel.Settings.DefaultSimulationDays;
      ProjectsTableMeanContacts.AsInteger := MainModel.Settings.DefaultMeanContactsPerPerson;
      ProjectsTableDeviationContacts.AsInteger := MainModel.Settings.DefaultDeviationContactsPerPerson;
      ProjectsTableMeanContactProbability.AsFloat := MainModel.Settings.DefaultMeanContactPropability;
      ProjectsTableDeviationContactProbability.AsFloat := MainModel.Settings.DefaultDeviationContactPropability;
    end;
  end
  // Initialize a new simulation setup.
  else if (PageControl.ActivePage = DependentData1TabSheet) then
  begin
    if not(SimulationSetupsTable.State in [dsEdit, dsInsert]) then
    begin
      SimulationSetupsTable.Insert;
      SimulationSetupsTableSimulationSetupID.AsString := MainModel.GetPrimaryKeyValue;
      // Suggest a setup name.
      ProposeSetupNumberQuery.ParamByName('PROJECTID').AsString := ProjectsTableProjectID.AsString;
      ProposeSetupNumberQuery.Open;
      SimulationSetupsTableName.AsString := Format('Setup %d', [ProposeSetupNumberQuerySetupNumber.AsInteger]);
      ProposeSetupNumberQuery.Close;
      { TODO -oJanis : Field setup_state ist depricated. }
      SimulationSetupsTableSetupState.AsString := SimulationSetupNotInitialized;
      // Read in default value from project.
      SimulationSetupsTableDefaultSimulationDuration.AsInteger := ProjectsTableDefaultSimulationDuration.AsInteger;
      SimulationSetupsTableInfectiousOnStart.AsInteger := ProjectsTableDefaultInfectiousOnStart.AsInteger;
    end;
  end
  // Initialize a new simulation.
  else if (PageControl.ActivePage = DependentData2TabSheet) then
  begin
    if not(SimulationsQuery.State in [dsEdit, dsInsert]) then
    begin
      SimulationsQuery.Insert;
      SimulationsQuerySimulationID.AsString := MainModel.GetPrimaryKeyValue;
      SimulationsQuerySimulationDuration.AsInteger := ProjectsTableDefaultSimulationDuration.AsInteger;
      SimulationsQueryNumberOfRuns.AsInteger := MainModel.Settings.DefaultNumberOfRuns;
      // Suggest a simulation name.
      ProposeSimulationNumberQuery.ParamByName('PROJECTID').AsString := ProjectsTableProjectID.AsString;
      ProposeSimulationNumberQuery.Open;
      SimulationsQueryName.AsString := Format('Simulation %d', [ProposeSimulationNumberQuerySimulationNumber.AsInteger]);
      ProposeSimulationNumberQuery.Close;
    end;
  end;

  ButtonsCardPanel.ActiveCard := EditModeCard;
end;

procedure TProjectsView.PersonKnowsPersonQueryCalcFields(DataSet: TDataSet);
begin
  inherited;
  PersonKnowsPersonQueryInfectious.AsBoolean := (PersonKnowsPersonQueryContactDayOfInfectiousness.AsInteger > 0)
end;

procedure TProjectsView.PostBtnClick(Sender: TObject);
begin
  inherited;

  // Save only if user input is valid.
  if not(ValidateData) then Exit;

  // Save a project.
  if (PageControl.ActivePage = MainDetailsTabSheet) then
  begin
    if (ProjectsTable.State = dsEdit) then
      EnableProjectControls;
    if (ProjectsTable.State in [dsEdit, dsInsert]) then
      ProjectsTable.Post;
  end
  // Save a setup.
  else if (PageControl.ActivePage = DependentData1TabSheet) then
  begin
    // First create/edit the task record ...
    if (SimulationSetupsTable.State in [dsEdit, dsInsert]) then
    begin
      if (SimulationSetupsTable.State = dsInsert) then
      begin
        // Create the required initialization setup task.
        CreateSetupInitTask;
      end
      else if (SimulationSetupsTable.State = dsEdit) then
      begin
        EnableSetupControls;
      end;
      // ... then save the simulation setup record.
      SimulationSetupsTable.Post;
      // Update lookup list for simulations used setup
      LookupSimulationSetupQuery.Refresh;
    end;
  end
  // Save a simulation.
  else if (PageControl.ActivePage = DependentData2TabSheet) then
  begin
    if (SimulationsQuery.State in [dsEdit, dsInsert]) then
    begin
      if (SimulationsQuery.State = dsInsert) then
      begin
        var WaitingDlg := TWaitingDialog.ShowDlg('The associated tasks are created. Please wait...');
        try
          // Create fitting required simulation tasks.
          // 1. Initialization task for simulation.
          // 2. Initialization tasks (day zero) for each run.
          // 3. Calculation tasks for each day and each run.
          // 4. Evaluation tasks for each day.
          CreateSimulationInitTask;
          CreateSimulationRunInitTask;
          CreateSimulationRunExecTasks(1, SimulationsQuerySimulationDuration.AsInteger);
          CreateSimulationRunEvalTasks(0, SimulationsQuerySimulationDuration.AsInteger);
        finally
          WaitingDlg.HideDlg;
        end;
      end
      else if (SimulationsQuery.State = dsEdit) then
      begin
        EnableSimulationControls;
      end;
      // ...then save the simulation record.
      SimulationsQuery.Post;
    end;
  end;

  TenMoreDaysBtn.Enabled := true;
  ButtonsCardPanel.ActiveCard := ViewModeCard;
end;

procedure TProjectsView.ProjectsSourceDataChange(Sender: TObject; Field:
    TField);
begin
  inherited;
  if MessagesEnabled then TMessageManager.DefaultManager.SendMessage(nil, TMsgModuleInfoChanged.Create(FormatModuleInfo), true);
end;

procedure TProjectsView.RefreshBtnClick(Sender: TObject);
begin
  inherited;

  ProjectsTable.Refresh;
  SimulationSetupsTable.Refresh;
  SimulationPeopleTable.Refresh;
  //PersonKnowsPersonQuery.Refresh;
  SimulationsQuery.Refresh;
end;

procedure TProjectsView.SimulationPeopleSourceDataChange(Sender: TObject;
    Field: TField);
begin
  inherited;
  PersonKnowsPersonQuery.Close;
  PersonKnowsPersonQuery.ParamByName('person_id').AsString := SimulationPeopleTablePersonID.AsString;
  PersonKnowsPersonQuery.Open;
end;

procedure TProjectsView.SimulationPeopleTableCalcFields(DataSet: TDataSet);
begin
  inherited;
  SimulationPeopleTableInfectious.AsBoolean := (SimulationPeopleTableInitialDayOfInfectiousness.AsInteger > 0)
end;

procedure TProjectsView.SimulationsQuerySimulationSetupIDChange(Sender: TField);
begin
  inherited;
  // Read in default value for simulation duration from setup.
  if not(SimulationsQuerySimulationSetupID.IsNull) then
    if SimulationsQuerySimulationDuration.IsNull then
      SimulationsQuerySimulationDuration.AsInteger := LookupSimulationSetupQueryDefaultSimulationDuration.AsInteger;
end;

function TProjectsView.ValidateData: Boolean;
begin
  // Always stay pessimistic.
  Result := false;

  // Validating project settings.
  if (PageControl.ActivePage = MainDetailsTabSheet) then
  begin
    // Constraint: The name of the project must not be empty.
    if not(ValidateStringNotEmpty(ProjectsTableName.DisplayLabel, ProjectsTableName.AsString)) then Exit;
    // Constraints: Population size, number of infectious on start and simulation duration must be greater then zero.
    if not(ValidateIntegerGreater(ProjectsTablePopulationNumber.DisplayLabel, ProjectsTablePopulationNumber.AsString, 0)) then Exit;
    if not(ValidateIntegerGreater(ProjectsTableDefaultInfectiousOnStart.DisplayLabel, ProjectsTableDefaultInfectiousOnStart.AsString, 0)) then Exit;
    if not(ValidateIntegerGreater(ProjectsTableDefaultSimulationDuration.DisplayLabel, ProjectsTableDefaultSimulationDuration.AsString, 0)) then Exit;
    // Constraint: Number of contacts must be greater than zero.
    if not(ValidateFloatGreater(ProjectsTableMeanContacts.DisplayLabel, ProjectsTableMeanContacts.AsString, 0)) then Exit;
    if not(ValidateFloatGreater(ProjectsTableDeviationContacts.DisplayLabel, ProjectsTableDeviationContacts.AsString, 0)) then Exit;
    // Constraint: Contact probability must be between 0 and 1.
    if not(ValidateFloatBetween(ProjectsTableMeanContactProbability.DisplayLabel, ProjectsTableMeanContactProbability.AsString, 0, 1)) then Exit;
    if not(ValidateFloatBetween(ProjectsTableDeviationContactProbability.DisplayLabel, ProjectsTableDeviationContactProbability.AsString, 0, 1)) then Exit;
    // Constraint: Negative values are not allowed for the incubation period.
    if not(ValidateFloatGreaterEqual(ProjectsTableMeanIncubationPeriod.DisplayLabel, ProjectsTableMeanIncubationPeriod.AsString, 0)) then Exit;
    if not(ValidateFloatGreaterEqual(ProjectsTableDeviationIncubationPeriod.DisplayLabel, ProjectsTableDeviationIncubationPeriod.AsString, 0)) then Exit;
    // Constraint: The duration of the disease must be greater than zero.
    if not(ValidateFloatGreater(ProjectsTableMeanDiseasePeriod.DisplayLabel, ProjectsTableMeanDiseasePeriod.AsString, 0)) then Exit;
    if not(ValidateFloatGreaterEqual(ProjectsTableDeviationDiseasePeriod.DisplayLabel, ProjectsTableDeviationDiseasePeriod.AsString, 0)) then Exit;
    // Constraint: Negative values are not allowed for the infectious delay period.
    if not(ValidateFloatGreaterEqual(ProjectsTableMeanInfectiousDelayPeriod.DisplayLabel, ProjectsTableMeanInfectiousDelayPeriod.AsString, 0)) then Exit;
    if not(ValidateFloatGreaterEqual(ProjectsTableDeviationInfectiousDelayPeriod.DisplayLabel, ProjectsTableDeviationInfectiousDelayPeriod.AsString, 0)) then Exit;
    // Constraint: The infectious period must be greater than zero.
    if not(ValidateFloatGreater(ProjectsTableMeanInfectiousPeriod.DisplayLabel, ProjectsTableMeanInfectiousPeriod.AsString, 0)) then Exit;
    if not(ValidateFloatGreaterEqual(ProjectsTableDeviationInfectiousPeriod.DisplayLabel, ProjectsTableDeviationInfectiousPeriod.AsString, 0)) then Exit;
    // Constraint: The infectious period must start before the disease ends.
    var IncubationPeriod: Double := ProjectsTableMeanIncubationPeriod.AsFloat;
    var DiseasePeriod: Double := ProjectsTableMeanDiseasePeriod.AsFloat;
    var DelayPeriod: Double := ProjectsTableMeanInfectiousDelayPeriod.AsFloat;
    if not(IncubationPeriod + DiseasePeriod > DelayPeriod) then
      if not(ValidateFloatLess(ProjectsTableMeanInfectiousDelayPeriod.DisplayLabel, ProjectsTableMeanInfectiousDelayPeriod.AsString, IncubationPeriod + DiseasePeriod)) then Exit;
    // Constraint: Susceptibility must be between 0 and 1.
    if not(ValidateFloatBetween(ProjectsTableMeanSusceptibility.DisplayLabel, ProjectsTableMeanSusceptibility.AsString, 0, 1)) then Exit;
    if not(ValidateFloatBetween(ProjectsTableDeviationSusceptibility.DisplayLabel, ProjectsTableDeviationSusceptibility.AsString, 0, 1)) then Exit;
    // Constraint: Infectiousness must be between 0 and 1.
    if not(ValidateFloatBetween(ProjectsTableMeanInfectiousness.DisplayLabel, ProjectsTableMeanInfectiousness.AsString, 0, 1)) then Exit;
    if not(ValidateFloatBetween(ProjectsTableDeviationInfectiousness.DisplayLabel, ProjectsTableDeviationInfectiousness.AsString, 0, 1)) then Exit;
    // Constraint: Mortality must be between 0 and 1.
    if not(ValidateFloatBetween(ProjectsTableMeanMortality.DisplayLabel, ProjectsTableMeanMortality.AsString, 0, 1)) then Exit;
    if not(ValidateFloatBetween(ProjectsTableDeviationMortality.DisplayLabel, ProjectsTableDeviationMortality.AsString, 0, 1)) then Exit;
    // Constraint: Initial immunity after disease must be between 0 and 1.
    if not(ValidateFloatBetween(ProjectsTableMeanInitialImmunity.DisplayLabel, ProjectsTableMeanInitialImmunity.AsString, 0, 1)) then Exit;
    if not(ValidateFloatBetween(ProjectsTableDeviationInitialImmunity.DisplayLabel, ProjectsTableDeviationInitialImmunity.AsString, 0, 1)) then Exit;
    // Constraint: Immunity halving period must be greater than zero.
    if not(ValidateFloatGreaterEqual(ProjectsTableMeanHalvingImmunityPeriod.DisplayLabel, ProjectsTableMeanHalvingImmunityPeriod.AsString, 0)) then Exit;
    if not(ValidateFloatGreaterEqual(ProjectsTableDeviationHalvingImmunityPeriod.DisplayLabel, ProjectsTableDeviationHalvingImmunityPeriod.AsString, 0)) then Exit;
    // Constraint: The period of detectable immunity must not be less than the halving period of immunity.
    if not(ValidateFloatGreaterEqual(ProjectsTableMeanImmunityPeriod.DisplayLabel, ProjectsTableMeanImmunityPeriod.AsString, ProjectsTableMeanHalvingImmunityPeriod.AsFloat)) then Exit;
    if not(ValidateFloatGreaterEqual(ProjectsTableDeviationImmunityPeriod.DisplayLabel, ProjectsTableDeviationImmunityPeriod.AsString, 0)) then Exit;
  end
  // Validating simulation setup settings.
  else if (PageControl.ActivePage = DependentData1TabSheet) then
  begin
    // Constraint: The name of the setup must not be empty.
    if not(ValidateStringNotEmpty(SimulationSetupsTableName.DisplayLabel, SimulationSetupsTableName.AsString)) then Exit;
    // Constraint: Simulation duration must be greater then zero.
    if not(ValidateIntegerGreater(SimulationSetupsTableDefaultSimulationDuration.DisplayLabel, SimulationSetupsTableDefaultSimulationDuration.AsString, 0)) then Exit;
    // Constraint: Number of infectious on start must be greater then zero.
    if not(ValidateIntegerGreater(SimulationSetupsTableInfectiousOnStart.DisplayLabel, SimulationSetupsTableInfectiousOnStart.AsString, 0)) then Exit;
  end
  // Validating simulation settings.
  else if (PageControl.ActivePage = DependentData2TabSheet) then
  begin
    // Constraint: The name of the simulation must not be empty.
    if not(ValidateStringNotEmpty(SimulationsQueryName.DisplayLabel, SimulationsQueryName.AsString)) then Exit;
    // Constraint: A simulation setup must be selected.
    if not(ValidateStringNotEmpty(SimulationsQuerySimulationSetupID.DisplayLabel, SimulationsQuerySimulationSetupID.AsString)) then Exit;
    // Constraint: Simulation duration must be greater then zero.
    if not(ValidateIntegerGreater(SimulationsQuerySimulationDuration.DisplayLabel, SimulationsQuerySimulationDuration.AsString, 0)) then Exit;
    // Constraint: Number of runs must be greater then zero.
    if not(ValidateIntegerGreater(SimulationsQueryNumberOfRuns.DisplayLabel, SimulationsQueryNumberOfRuns.AsString, 0)) then Exit;
  end;

  // When you get here, the user input is valid.
  Result := true;
end;

end.
