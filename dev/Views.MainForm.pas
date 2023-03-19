unit Views.MainForm;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Messaging,
  System.ImageList,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ComCtrls,
  Vcl.Buttons,
  Vcl.ExtCtrls,
  Vcl.ImgList,
  Vcl.WinXPanels,
  Views.CustomView;

type
  /// Class type for TCustomView class.
  TViewClass = class of TCustomView;
  /// TMainFormView is the class which holds the main form of the app.
  /// Inheritance tree: TMainFormView --> TForm
  TMainFormView = class(TForm)
    StatusBar: TStatusBar;
    MenuPanel: TPanel;
    LoginBtn: TSpeedButton;
    ProjectsBtn: TSpeedButton;
    TasksBtn: TSpeedButton;
    ResultsBtn: TSpeedButton;
    SettingsBtn: TSpeedButton;
    AboutBtn: TSpeedButton;
    MenuBarBevel: TBevel;
    ButtonsImageList: TImageList;
    ViewCardPanel: TCardPanel;
    ConnectionAssistentCard: TCard;
    LoginCard: TCard;
    ProjectsCard: TCard;
    TasksCard: TCard;
    ResultsCard: TCard;
    SettingsCard: TCard;
    AboutCard: TCard;
    procedure AboutBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure LoginBtnClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ProjectsBtnClick(Sender: TObject);
    procedure ResultsBtnClick(Sender: TObject);
    procedure SettingsBtnClick(Sender: TObject);
    procedure TasksBtnClick(Sender: TObject);
  private
    { Private-Deklarationen }
    // Pointers for the registered views in the application.
    ConnectionAssistentView: TCustomView;
    LoginView: TCustomView;
    ProjectsView: TCustomView;
    TasksView: TCustomView;
    ResultsView: TCustomView;
    SettingsView: TCustomView;
    AboutView: TCustomView;
    // Pointers to the view to be displayed after login in its menu button.
    DefaultView: TCustomView;
    DefaultMenuBtn: TSpeedButton;
    LastView: TCustomView;
    LastBtn: TSpeedButton;
    procedure SaveLastView;
    /// Adjusts the size of the sections in the status bar to the current window size.
    procedure ResizeStatusBarPanels;
    /// Creates a view of AViewClass  and loads it into ACard. Returns a pointer to the created view.
    function LoadView(AViewClass: TViewClass; ACard: TCard): TCustomView;
    /// Brings AView to the foreground and updates the button bar.
    procedure ShowView(AView: TCustomView);
    /// Message listener method for TMsgLoginSuccessful.
    procedure RespondMsgLoginSuccessful(const Sender: TObject; const M: TMessage);
    /// Message listener method for TMsgLoginRequested.
    procedure RespondMsgLoginRequested(const Sender: TObject; const M: TMessage);
    /// Message listener method for TMsgConnectionAssistantRequested.
    procedure RespondMsgConnectionAssistantRequested(const Sender: TObject; const M: TMessage);
    /// Message listener method for TMsgModuleInfoChanged.
    procedure RespondMsgModuleInfoChanged(const Sender: TObject; const M: TMessage);
    procedure RespondMsgSettingsViewClosed(const Sender: TObject; const M: TMessage);
    procedure RespondMsgAboutViewClosed(const Sender: TObject; const M: TMessage);
  public
    { Public-Deklarationen }
  end;

var
  MainFormView: TMainFormView;

implementation

{$R *.dfm}

uses
  System.Win.Registry,
  System.UITypes,
  System.Math,
  Dialogs.InformationDialog,
  Views.LoginView,
  Views.ConnectionAssistantView,
  Views.ProjectsView,
  Views.TasksView,
  Views.ResultsView,
  Views.SettingsView,
  Views.AboutView,
  Models.MainModel,
  Messages.LoginSuccessful,
  Messages.LoginRequested,
  Messages.ConnectionAssistantRequested,
  Messages.ModuleInfoChanged,
  Messages.SettingsViewCanceled,
  Messages.SettingsViewSaved,
  Messages.AboutViewClosed,
  Settings.Constants;

const
  // Image indices
  II_LOGIN = 0;
  II_LOGOUT = 1;
  II_PROJECTS = 2;
  II_TASKS = 3;
  II_RESULTS = 4;
  II_SETTINGS = 5;
  II_ABOUT = 6;

  // Button captions
  BC_LOGIN = 'Login|Logs you into the selected database with the specified account data.';
  BC_LOGOUT = 'Logout|Logs you out of the currently open database and opens the login view.';

  // Application captions
  AC_CONNECTED = 'SoLEC - Simulation of Local Epidemics Client - %s';
  AC_DISCONNECTED = 'SoLEC - Simulation of Local Epidemics Client';

procedure TMainFormView.AboutBtnClick(Sender: TObject);
begin
  SaveLastView;
  ShowView(AboutView);
end;

procedure TMainFormView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Close the database connection if it is still active and save the window settings.
  if MainModel.WorkingConnectionActive then MainModel.CloseWorkingConnection;
  MainModel.Settings.SaveMainFormSettings(Top, Left, Width, Height, WindowState);
end;

procedure TMainFormView.FormCreate(Sender: TObject);
begin
  // Activation of the random number generator to determine the correct random values.
  Randomize;

  // Subscribe to messages from the class TMsgLoginSuccessful.
  TMessageManager.DefaultManager.SubscribeToMessage(TMsgLoginSuccessful, RespondMsgLoginSuccessful);
  // Subscribe to messages from the class TMsgLoginRequested.
  TMessageManager.DefaultManager.SubscribeToMessage(TMsgLoginRequested, RespondMsgLoginRequested);
  // Subscribe to messages from the class TMsgConnectionAssistantRequested.
  TMessageManager.DefaultManager.SubscribeToMessage(TMsgConnectionAssistantRequested, RespondMsgConnectionAssistantRequested);
  // Subcribe to messages from the class TMsgModuleInfoChanged.
  TMessageManager.DefaultManager.SubscribeToMessage(TMsgModuleInfoChanged, RespondMsgModuleInfoChanged);

  TMessageManager.DefaultManager.SubscribeToMessage(TMsgSettingsSaved, RespondMsgSettingsViewClosed);
  TMessageManager.DefaultManager.SubscribeToMessage(TMsgSettingsCanceled, RespondMsgSettingsViewClosed);
  TMessageManager.DefaultManager.SubscribeToMessage(TMsgAboutClosed, RespondMsgAboutViewClosed);
end;

procedure TMainFormView.LoginBtnClick(Sender: TObject);
begin
  // If LoginBtn.ImageIndex holds the value II_LOGOUT, a logout is requested.
  if (LoginBtn.ImageIndex = II_LOGOUT) then
  begin
     // Close the database connection, and display the login view.
     MainModel.CloseWorkingConnection;
     ShowView(LoginView);
  end;
end;

procedure TMainFormView.FormResize(Sender: TObject);
begin
  // Adjust the size of the status bar sections.
  ResizeStatusBarPanels;
end;

procedure TMainFormView.FormShow(Sender: TObject);
begin
  // Load the saved window settings.
  Top := MainModel.Settings.MainFormTop;
  Left := MainModel.Settings.MainFormLeft;
  Width := MainModel.Settings.MainFormWidth;
  Height := MainModel.Settings.MainFormHeight;
  WindowState := MainModel.Settings.MainFormState;

  // Load the registered views.
  ConnectionAssistentView := LoadView(TConnectionAssistantView, ConnectionAssistentCard);
  LoginView := LoadView(TLoginView, LoginCard);
  ProjectsView := LoadView(TProjectsView, ProjectsCard);
  TasksView := LoadView(TTasksView, TasksCard);
  ResultsView := LoadView(TResultsView, ResultsCard);
  SettingsView := LoadView(TSettingsView, SettingsCard);
  AboutView := LoadView(TAboutView, AboutCard);

  // Define the default view and its menu bar button.
  DefaultView := ProjectsView;
  DefaultMenuBtn := ProjectsBtn;

  // Show the login view.
  if MainModel.Settings.FirstStartOnThisMachine then
    ShowView(ConnectionAssistentView)
  else
    ShowView(LoginView);
end;

procedure TMainFormView.RespondMsgAboutViewClosed(const Sender: TObject;
  const M: TMessage);
begin
  ShowView(LastView);
  LastBtn.Down := true;
end;

procedure TMainFormView.RespondMsgConnectionAssistantRequested(
  const Sender: TObject; const M: TMessage);
begin
  ShowView(ConnectionAssistentView);
end;

procedure TMainFormView.RespondMsgLoginRequested(const Sender: TObject;
  const M: TMessage);
begin
  ShowView(LoginView);
end;

procedure TMainFormView.RespondMsgLoginSuccessful(const Sender: TObject;
  const M: TMessage);
begin
  ShowView(DefaultView);
  DefaultMenuBtn.Down := true;

  // Actualize application caption.
  var ConnectionInfo: String := MainModel.WorkingConnectionInfo;
  if (ConnectionInfo = '') then
    Caption := AC_DISCONNECTED
  else
    Caption := Format(AC_CONNECTED, [ConnectionInfo]);
end;

procedure TMainFormView.RespondMsgModuleInfoChanged(const Sender: TObject;
  const M: TMessage);
begin
end;

procedure TMainFormView.RespondMsgSettingsViewClosed(const Sender: TObject;
  const M: TMessage);
begin
  ShowView(LastView);
  LastBtn.Down := true;
end;

procedure TMainFormView.ShowView(AView: TCustomView);
begin
  // Bring the corresponding card of the ViewCardPanel to the foreground.
  if (AView = ConnectionAssistentView) then
    ViewCardPanel.ActiveCard := ConnectionAssistentCard
  else if (AView = LoginView) then
    ViewCardPanel.ActiveCard := LoginCard
  else if (AView = ProjectsView) then
    ViewCardPanel.ActiveCard := ProjectsCard
  else if (AView = TasksView) then
    ViewCardPanel.ActiveCard := TasksCard
  else if (AView = ResultsView) then
    ViewCardPanel.ActiveCard := ResultsCard
  else if (AView = SettingsView) then
    ViewCardPanel.ActiveCard := SettingsCard
  else if (AView = AboutView) then
    ViewCardPanel.ActiveCard := AboutCard;

  // Adjust the visibility of the registered views to trigger either the OnShow or OnHide event.
  ConnectionAssistentView.Visible := (ViewCardPanel.ActiveCard = ConnectionAssistentCard);
  LoginView.Visible := (ViewCardPanel.ActiveCard = LoginCard);
  ProjectsView.Visible := (ViewCardPanel.ActiveCard = ProjectsCard);
  TasksView.Visible := (ViewCardPanel.ActiveCard = TasksCard);
  ResultsView.Visible := (ViewCardPanel.ActiveCard = ResultsCard);
  SettingsView.Visible := (ViewCardPanel.ActiveCard = SettingsCard);
  AboutView.Visible := (ViewCardPanel.ActiveCard = AboutCard);

  // ShowDataView is true when a data-bound view is displayed.
  var ShowDataView: Boolean := not((ViewCardPanel.ActiveCard = ConnectionAssistentCard) or
                                   (ViewCardPanel.ActiveCard = LoginCard));

  // Update the logout/login button.
  if not(ShowDataView) then
  begin
    LoginBtn.ImageIndex := II_LOGIN;
    LoginBtn.Hint := BC_LOGIN;
  end
  else
  begin
    LoginBtn.ImageIndex := II_LOGOUT;
    LoginBtn.Hint := BC_LOGOUT;
  end;

  // Hide/show the data module view buttons.
  ProjectsBtn.Visible := ShowDataView;
  TasksBtn.Visible := ShowDataView;
  ResultsBtn.Visible := ShowDataView;
  SettingsBtn.Visible := ShowDataView;
  AboutBtn.Visible := ShowDataView;

  // Actualize application caption.
  var ConnectionInfo: String := MainModel.WorkingConnectionInfo;
  if (ConnectionInfo = '') then
    Caption := AC_DISCONNECTED
  else
    Caption := Format(AC_CONNECTED, [ConnectionInfo]);
end;

function TMainFormView.LoadView(AViewClass: TViewClass; ACard: TCard): TCustomView;
begin
  // Create an instance of the requested module class.
  var View: TCustomView := AViewClass.Create(ACard);

  // Initialize the created View form.
  View.Parent := ACard;
  View.Align := alClient;
  View.BorderStyle := bsNone;
  View.FormStyle := fsNormal;
  View.Visible := false;

  Result := View;
end;

procedure TMainFormView.ProjectsBtnClick(Sender: TObject);
begin
  ShowView(ProjectsView);
end;

procedure TMainFormView.ResizeStatusBarPanels;
begin
  // Actualize the size of the status bar sections.
  StatusBar.Panels[0].Width := StatusBar.ClientWidth - 15;
end;

procedure TMainFormView.ResultsBtnClick(Sender: TObject);
begin
  ShowView(ResultsView);
end;

procedure TMainFormView.SaveLastView;
begin
  if ViewCardPanel.ActiveCard = ProjectsCard then
  begin
    LastView := ProjectsView;
    LastBtn := ProjectsBtn;
  end
  else if ViewCardPanel.ActiveCard = TasksCard then
  begin
    LastView := TasksView;
    LastBtn := TasksBtn;
  end
  else if ViewCardPanel.ActiveCard = ResultsCard then
  begin
    LastView := ResultsView;
    LastBtn := ResultsBtn;
  end
  else
  begin
    LastView := ProjectsView;
    LastBtn := ProjectsBtn;
  end;
end;

procedure TMainFormView.SettingsBtnClick(Sender: TObject);
begin
  SaveLastView;
  ShowView(SettingsView);
end;

procedure TMainFormView.TasksBtnClick(Sender: TObject);
begin
  ShowView(TasksView);
end;

end.
