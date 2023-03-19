program SoLEC;

uses
  Vcl.Forms,
  Views.MainForm in 'Views.MainForm.pas' {MainFormView},
  Vcl.Themes,
  Vcl.Styles,
  Views.CustomView in 'Views.CustomView.pas' {CustomView},
  Models.MainModel in 'Models.MainModel.pas' {MainModel: TDataModule},
  Views.LoginView in 'Views.LoginView.pas' {LoginView},
  Messages.LoginSuccessful in 'Messages.LoginSuccessful.pas',
  Views.CustomDBModuleView in 'Views.CustomDBModuleView.pas' {CustomDBModuleView},
  Views.CustomDBMainDependentModuleView in 'Views.CustomDBMainDependentModuleView.pas' {CustomDBMainDependentModuleView},
  Dialogs.CustomDialog in 'Dialogs.CustomDialog.pas' {CustomDialog},
  Dialogs.CustomPicturedDialog in 'Dialogs.CustomPicturedDialog.pas' {CustomPicturedDialog},
  Dialogs.InformationDialog in 'Dialogs.InformationDialog.pas' {InformationDialog},
  Dialogs.ErrorDialog in 'Dialogs.ErrorDialog.pas' {ErrorDialog},
  Dialogs.ConfirmationDialog in 'Dialogs.ConfirmationDialog.pas' {ConfirmationDialog},
  Dialogs.WarningDialog in 'Dialogs.WarningDialog.pas' {WarningDialog},
  Messages.ConnectionSuccessful in 'Messages.ConnectionSuccessful.pas',
  Messages.ConnectionFailed in 'Messages.ConnectionFailed.pas',
  Messages.ConnectionAssistantRequested in 'Messages.ConnectionAssistantRequested.pas',
  Views.ConnectionAssistantView in 'Views.ConnectionAssistantView.pas' {ConnectionAssistantView},
  Messages.LoginRequested in 'Messages.LoginRequested.pas',
  Messages.DBCreationSuccessful in 'Messages.DBCreationSuccessful.pas',
  Messages.DBCreationFailed in 'Messages.DBCreationFailed.pas',
  Settings.Constants in 'Settings.Constants.pas',
  Messages.ModuleInfoChanged in 'Messages.ModuleInfoChanged.pas',
  Views.ProjectsView in 'Views.ProjectsView.pas' {ProjectsView},
  AMRandom in 'AMRandom.pas',
  AMRandomRS in 'AMRandomRS.pas',
  ViewModels.SimulationSetup in 'ViewModels.SimulationSetup.pas',
  ViewModels.Simulation in 'ViewModels.Simulation.pas',
  Views.TasksView in 'Views.TasksView.pas' {TasksView},
  Models.SettingsManager in 'Models.SettingsManager.pas',
  Dialogs.WaitingDialog in 'Dialogs.WaitingDialog.pas' {WaitingDialog},
  ViewModels.Simulation.RunDay in 'ViewModels.Simulation.RunDay.pas',
  ViewModels.Simulation.PersonState in 'ViewModels.Simulation.PersonState.pas',
  ViewModels.Simulation.PersonStatesList in 'ViewModels.Simulation.PersonStatesList.pas',
  ViewModels.Simulation.Task in 'ViewModels.Simulation.Task.pas',
  ViewModels.Simulation.Day in 'ViewModels.Simulation.Day.pas',
  Models.Nullable in 'Models.Nullable.pas',
  Views.ResultsView in 'Views.ResultsView.pas' {ResultsView},
  Views.SettingsView in 'Views.SettingsView.pas' {SettingsView},
  Messages.SettingsViewSaved in 'Messages.SettingsViewSaved.pas',
  Messages.SettingsViewCanceled in 'Messages.SettingsViewCanceled.pas',
  ViewModels.Simulation.Contacts in 'ViewModels.Simulation.Contacts.pas',
  Views.AboutView in 'Views.AboutView.pas' {AboutView},
  Messages.AboutViewClosed in 'Messages.AboutViewClosed.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainFormView, MainFormView);
  Application.CreateForm(TMainModel, MainModel);
  Application.Run;
end.
