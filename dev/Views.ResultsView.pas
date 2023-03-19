unit Views.ResultsView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Views.CustomDBModuleView, Data.DB,
  System.ImageList, Vcl.ImgList, Vcl.StdCtrls, Vcl.Buttons, Vcl.WinXPanels,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, ZAbstractRODataset,
  ZDataset, Models.MainModel, VclTee.TeeGDIPlus, VCLTee.TeEngine, VCLTee.Series,
  VCLTee.TeeProcs, VCLTee.Chart, VCLTee.DBChart, VCLTee.TeeDBCrossTab;

type
  TResultsView = class(TCustomDBModuleView)
    SimulationsQuery: TZReadOnlyQuery;
    SimulationsSource: TDataSource;
    SimulationsQueryProject: TStringField;
    SimulationsQuerySetup: TStringField;
    SimulationsQuerySimulation: TStringField;
    SimulationsQuerysimulation_id: TStringField;
    Panel1: TPanel;
    Splitter1: TSplitter;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    Panel3: TPanel;
    Panel4: TPanel;
    SIRProportionsChart: TDBChart;
    Series2: TLineSeries;
    Series3: TLineSeries;
    Series1: TLineSeries;
    SIRDeltasTabSheet: TTabSheet;
    Panel5: TPanel;
    ScrollBox1: TScrollBox;
    Splitter2: TSplitter;
    Panel6: TPanel;
    Panel7: TPanel;
    DBGrid2: TDBGrid;
    Panel8: TPanel;
    Panel9: TPanel;
    SIRDeltasChart: TDBChart;
    LineSeries1: TLineSeries;
    LineSeries2: TLineSeries;
    LineSeries3: TLineSeries;
    IncidenceTabSheet: TTabSheet;
    Panel10: TPanel;
    ScrollBox2: TScrollBox;
    Splitter3: TSplitter;
    Panel11: TPanel;
    Panel12: TPanel;
    DBGrid3: TDBGrid;
    Panel13: TPanel;
    Panel14: TPanel;
    IncidenceChart: TDBChart;
    LineSeries5: TLineSeries;
    LineSeries4: TLineSeries;
    InfectionRiskTabSheet: TTabSheet;
    Panel15: TPanel;
    ScrollBox3: TScrollBox;
    Splitter4: TSplitter;
    Panel16: TPanel;
    Panel17: TPanel;
    DBGrid4: TDBGrid;
    Panel18: TPanel;
    Panel19: TPanel;
    InfectionRiskChart: TDBChart;
    Series4: TLineSeries;
    ReproductionTabSheet: TTabSheet;
    Panel20: TPanel;
    ScrollBox4: TScrollBox;
    Splitter5: TSplitter;
    Panel21: TPanel;
    Panel22: TPanel;
    DBGrid5: TDBGrid;
    Panel23: TPanel;
    Panel24: TPanel;
    ReproductionChart: TDBChart;
    Series5: TBarSeries;
    PopulationSharesTabSheet: TTabSheet;
    Panel25: TPanel;
    ScrollBox5: TScrollBox;
    Splitter6: TSplitter;
    Panel26: TPanel;
    Panel27: TPanel;
    DBGrid6: TDBGrid;
    Panel28: TPanel;
    Panel29: TPanel;
    PopulationSharesChart: TDBChart;
    Series7: TAreaSeries;
    Series8: TAreaSeries;
    Series9: TAreaSeries;
    Series6: TAreaSeries;
    Series10: TAreaSeries;
    DaysQuery: TZReadOnlyQuery;
    DaysQuerySimulationID: TStringField;
    DaysQueryDayNumber: TIntegerField;
    DaysQueryMeanSusceptible: TFloatField;
    DaysQueryDevSusceptible: TFloatField;
    DaysQueryDeltaSusceptible: TFloatField;
    DaysQuerymean_incubated: TFloatField;
    DaysQuerydeviation_incubated: TFloatField;
    DaysQuerydelta_incubated: TFloatField;
    DaysQuerymean_diseased: TFloatField;
    DaysQuerydeviation_diseased: TFloatField;
    DaysQuerydelta_diseased: TFloatField;
    DaysQuerymean_infected: TFloatField;
    DaysQuerydeviation_infected: TFloatField;
    DaysQuerydelta_infected: TFloatField;
    DaysQuerymean_immune: TFloatField;
    DaysQuerydeviation_immune: TFloatField;
    DaysQuerydelta_immune: TFloatField;
    DaysQuerymean_deceased: TFloatField;
    DaysQuerydeviation_deceased: TFloatField;
    DaysQuerydelta_deceased: TFloatField;
    DaysQuerymean_removed: TFloatField;
    DaysQuerydeviation_removed: TFloatField;
    DaysQuerydelta_removed: TFloatField;
    DaysQuerymean_infectious: TFloatField;
    DaysQuerydeviation_infectious: TFloatField;
    DaysQuerydelta_infectious: TFloatField;
    DaysQuerymean_reproduction: TFloatField;
    DaysQuerydeviation_reproduction: TFloatField;
    DaysQuerydelta_reproduction: TFloatField;
    DaysQuerymean_infection_risk: TFloatField;
    DaysQuerydeviation_infection_risk: TFloatField;
    DaysQuerydelta_infection_risk: TFloatField;
    DaysQuerymean_infected_last_7_days: TFloatField;
    DaysQuerydeviation_infected_last_7_days: TFloatField;
    DaysQuerydelta_infected_last_7_days: TFloatField;
    DaysQuerymean_new_infected: TFloatField;
    DaysQuerydeviation_new_infected: TFloatField;
    DaysQuerydelta_new_infected: TFloatField;
    SimulationDaysSource: TDataSource;
    InfectiousTabSheet: TTabSheet;
    Panel30: TPanel;
    ScrollBox6: TScrollBox;
    Splitter7: TSplitter;
    Panel31: TPanel;
    Panel32: TPanel;
    DBGrid7: TDBGrid;
    Panel33: TPanel;
    Panel34: TPanel;
    InfectiousChart: TDBChart;
    LineSeries6: TLineSeries;
    ChartSaveDialog: TFileSaveDialog;
    DataSaveDialog: TFileSaveDialog;
    procedure DeleteBtnClick(Sender: TObject);
    procedure EditBtnClick(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure SimulationsSourceDataChange(Sender: TObject; Field: TField);
    procedure FormShow(Sender: TObject);
    procedure NewBtnClick(Sender: TObject);
    procedure RefreshBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ResultsView: TResultsView;

implementation

uses
  Printers;

{$R *.dfm}

procedure TResultsView.DeleteBtnClick(Sender: TObject);
begin
  inherited;
  var PrintChart: TDBChart := nil;

  if PageControl.ActivePage = MainDetailsTabSheet then
    PrintChart := SIRProportionsChart
  else if PageControl.ActivePage = SIRDeltasTabSheet then
    PrintChart := SIRDeltasChart
  else if PageControl.ActivePage = IncidenceTabSheet then
    PrintChart := IncidenceChart
  else if PageControl.ActivePage = InfectionRiskTabSheet then
    PrintChart := InfectionRiskChart
  else if PageControl.ActivePage = ReproductionTabSheet then
    PrintChart := ReproductionChart
  else if PageControl.ActivePage = PopulationSharesTabSheet then
    PrintChart := PopulationSharesChart
  else if PageControl.ActivePage = InfectiousTabSheet then
    PrintChart := InfectiousChart;

  if Assigned(PrintChart) then
    with PrintChart do
    begin
      SubTitle.Text.Add(Format('Project: %s - Setup: %s - Simulation: %s', [SimulationsQueryProject.AsString, SimulationsQuerySetup.AsString, SimulationsQuerySimulation.AsString]));
      Title.Visible := true;
      SubTitle.Visible := true;
      PrintOrientation(poLandscape);
      SubTitle.Visible := false;
      Title.Visible := false;
      SubTitle.Text.Clear;
    end;
end;

procedure TResultsView.EditBtnClick(Sender: TObject);
begin
  inherited;
  var ExportChart: TDBChart := nil;

  // Change ExportChart based on currently opened chart.
  if PageControl.ActivePage = MainDetailsTabSheet then
    ExportChart := SIRProportionsChart
  else if PageControl.ActivePage = SIRDeltasTabSheet then
    ExportChart := SIRDeltasChart
  else if PageControl.ActivePage = IncidenceTabSheet then
    ExportChart := IncidenceChart
  else if PageControl.ActivePage = InfectionRiskTabSheet then
    ExportChart := InfectionRiskChart
  else if PageControl.ActivePage = ReproductionTabSheet then
    ExportChart := ReproductionChart
  else if PageControl.ActivePage = PopulationSharesTabSheet then
    ExportChart := PopulationSharesChart
  else if PageControl.ActivePage = InfectiousTabSheet then
    ExportChart := InfectiousChart;

    // Save Chart as Image.
  if Assigned(ExportChart) then
  begin
    ChartSaveDialog.DefaultFolder := OwnPicturesPath;
    ChartSaveDialog.FileName := Format('%s_%s_%s_%s', [SimulationsQueryProject.AsString, SimulationsQuerySetup.AsString, SimulationsQuerySimulation.AsString, PageControl.ActivePage.Caption]);
    if ChartSaveDialog.Execute then
    begin
      ExportChart.SaveToBitmapFile(ChartSaveDialog.FileName);
    end;
  end;

end;

procedure TResultsView.FormHide(Sender: TObject);
begin
  inherited;

  // Closing the data sources.
  DaysQuery.Close;
  SimulationsQuery.Close;
end;

procedure TResultsView.FormShow(Sender: TObject);
begin
  inherited;

  // Opening the data sources.
  SimulationsQuery.Open;
  DaysQuery.Open;

  // Initialization
  PageControl.ActivePage := MainDetailsTabSheet;
end;

procedure TResultsView.NewBtnClick(Sender: TObject);
begin
  inherited;
  var FieldSeparator: String := ';';

  // Export data to ducemts path.
  DataSaveDialog.DefaultFolder := OwnDocumentsPath;
  DataSaveDialog.FileName := Format('%s_%s_%s', [SimulationsQueryProject.AsString, SimulationsQuerySetup.AsString, SimulationsQuerySimulation.AsString]);
  if DataSaveDialog.Execute then
  begin
    var ExportFile: TStringList := TStringList.Create;
    var TextLine: String := '';
    try
      // Save every field name except the last one with separators.
      for var I := 1 to DaysQuery.Fields.Count - 2 do
        TextLine := TextLine + DaysQuery.Fields[I].FieldName + FieldSeparator;
      // Save the last field name without separator.
      TextLine := TextLine + DaysQuery.Fields[DaysQuery.Fields.Count - 1].FieldName;
      ExportFile.Add(TextLine);

      DaysQuery.DisableControls;
      try
        DaysQuery.First;
        while not(DaysQuery.EoF) do
        begin
          TextLine := '';
          TextLine := TextLine + IntToStr(DaysQuery.Fields[1].AsInteger) + FieldSeparator;
          // Save every item except the last one with separators.
          for var I := 2 to DaysQuery.Fields.Count - 2 do
            TextLine := TextLine + FloatToStr(DaysQuery.Fields[I].AsFloat) + FieldSeparator;
          // Save the last item without separator.
          TextLine := TextLine + FloatToStr(DaysQuery.Fields[DaysQuery.Fields.Count - 1].AsFloat);
          ExportFile.Add(TextLine);
          DaysQuery.Next;
        end;
      finally
        DaysQuery.First;
        DaysQuery.EnableControls;
      end;

      ExportFile.SaveToFile(DataSaveDialog.FileName);

    finally
      ExportFile.Free;
    end;
  end;
end;

procedure TResultsView.RefreshBtnClick(Sender: TObject);
begin
  inherited;

  SimulationsQuery.Refresh;
  DaysQuery.Refresh;
end;

procedure TResultsView.SimulationsSourceDataChange(Sender: TObject;
    Field: TField);
begin
  inherited;
  SIRProportionsChart.RefreshData;
  SIRDeltasChart.RefreshData;
  IncidenceChart.RefreshData;
  InfectionRiskChart.RefreshData;
  ReproductionChart.RefreshData;
  PopulationSharesChart.RefreshData;
  InfectiousChart.RefreshData;
end;

end.
