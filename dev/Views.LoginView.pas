unit Views.LoginView;

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
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.Imaging.pngimage,
  Vcl.Buttons,
  Vcl.ImgList,
  Views.CustomView;

type
  /// TLoginView ist the class witch holds the login form.
  /// Inheritance tree: TLoginForm --> TCustomView --> TForm
  TLoginView = class(TCustomView)
    EditImageList: TImageList;
    FileOpenDialog: TOpenDialog;
    InputPanel: TPanel;
    LoginBox: TGroupBox;
    Image1: TImage;
    UsernameLabel: TLabel;
    PasswordLabel: TLabel;
    UsernameEdit: TEdit;
    PasswordEdit: TEdit;
    DatabaseBox: TGroupBox;
    Image2: TImage;
    ServerLabel: TLabel;
    PortLabel: TLabel;
    DatabaseLabel: TLabel;
    ServerTypeLabel: TLabel;
    ServerEdit: TEdit;
    ServerTypeEdit: TComboBox;
    DatabaseEdit: TButtonedEdit;
    PortEdit: TEdit;
    BtnsPanel: TPanel;
    SettingsBtn: TBitBtn;
    ConnectBtn: TBitBtn;
    AssistantBtn: TBitBtn;
    procedure AssistantBtnClick(Sender: TObject);
    procedure DatabaseEditRightButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ConnectBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ServerTypeEditChange(Sender: TObject);
    procedure SettingsBtnClick(Sender: TObject);
  private
    { Private-Deklarationen }
    procedure PositionInputPanel;
    procedure UpdateInputBox(const DataBoxRequested: Boolean = false);
    function LoadLastConnectionSettings: Boolean;
    /// Message listener method for TMsgConnectionFailed
    procedure RespondMsgConnectionFailed(const Sender: TObject; const M: TMessage);
    /// Message listener method for TMsgConnectionSuccessful
    procedure RespondMsgConnectionSuccessful(const Sender: TObject; const M: TMessage);
  protected
    function FormatModuleInfo: String; override;
    function ValidateData: Boolean; override;
  public
  end;

implementation

{$R *.dfm}

uses
  System.Win.Registry,
  System.StrUtils,
  System.Math,
  Dialogs.ErrorDialog,
  Models.MainModel,
  Messages.ConnectionAssistantRequested,
  Messages.ConnectionFailed,
  Messages.ConnectionSuccessful,
  Messages.LoginSuccessful,
  Settings.Constants;

const
  // Height of the database box if visible.
  LOGINBOX_HEIGHT = 88;
  DATABASEBOX_HEIGHT = 121;

procedure TLoginView.AssistantBtnClick(Sender: TObject);
begin
  inherited;

  // From the main window, request the Database Connection Assistant.
  TMessageManager.DefaultManager.SendMessage(nil, TMsgConnectionAssistantRequested.Create, true);
end;

procedure TLoginView.DatabaseEditRightButtonClick(Sender: TObject);
begin
  inherited;
  if ((DatabaseEdit.Text <> '') and FileExists(DatabaseEdit.Text)) then
  begin
    FileOpenDialog.FileName := ExtractFileName(DatabaseEdit.Text);
    FileOpenDialog.InitialDir := ExtractFilePath(DatabaseEdit.Text);
  end
  else
  begin
    FileOpenDialog.FileName := '';
    FileOpenDialog.InitialDir := OwnDocumentsPath;
  end;
  if FileOpenDialog.Execute then
    DatabaseEdit.Text := ExpandFileName(FileOpenDialog.FileName);
end;

function TLoginView.FormatModuleInfo: String;
begin
  Result := 'Connect to the database.';
end;

procedure TLoginView.FormCreate(Sender: TObject);
begin
  inherited;

  // Subscribe to messages of the classes TMsgConnectionFailed and TMsgConnectionSuccessful.
  TMessageManager.DefaultManager.SubscribeToMessage(TMsgConnectionFailed, RespondMsgConnectionFailed);
  TMessageManager.DefaultManager.SubscribeToMessage(TMsgConnectionSuccessful, RespondMsgConnectionSuccessful);
end;

procedure TLoginView.FormResize(Sender: TObject);
begin
  inherited;

  PositionInputPanel;
end;

procedure TLoginView.SettingsBtnClick(Sender: TObject);
begin
  inherited;

  UpdateInputBox(not(DatabaseBox.Visible));
end;

procedure TLoginView.PositionInputPanel;
begin
  InputPanel.Top := (ClientHeight - InputPanel.Height) div 2;
  InputPanel.Left := (ClientWidth - InputPanel.Width) div 2;
end;

procedure TLoginView.RespondMsgConnectionFailed(const Sender: TObject;
  const M: TMessage);
begin
  // Check if the message belongs to the class TMsgConnectionFailed ...
  if (M is TMsgConnectionFailed) then
  begin
    // ... cast the Message as TMsgConnectionFailed and display the error message.
    TErrorDialog.ShowDlg((M as TMsgConnectionFailed).ErrorMessage);
  end;
end;

procedure TLoginView.RespondMsgConnectionSuccessful(const Sender: TObject;
  const M: TMessage);
begin
  // Send a message to the main form about successful login.
  TMessageManager.DefaultManager.SendMessage(nil, TMsgLoginSuccessful.Create, true);
end;

procedure TLoginView.UpdateInputBox(const DataBoxRequested: Boolean = false);
begin
  // The embedded server does not need a login.
  UsernameEdit.Enabled := (ServerTypeEdit.Text <> ServerTypeSQLite);
  UsernameLabel.Enabled := (ServerTypeEdit.Text <> ServerTypeSQLite);
  PasswordEdit.Enabled := (ServerTypeEdit.Text <> ServerTypeSQLite);
  PasswordLabel.Enabled := (ServerTypeEdit.Text <> ServerTypeSQLite);

  // No server host and port is specified for the embedded server.
  ServerEdit.Enabled := (ServerTypeEdit.Text <> ServerTypeSQLite);
  ServerLabel.Enabled := (ServerTypeEdit.Text <> ServerTypeSQLite);
  PortEdit.Enabled := (ServerTypeEdit.Text <> ServerTypeSQLite);
  PortLabel.Enabled := (ServerTypeEdit.Text <> ServerTypeSQLite);

  // Show button for file selection by dialog box for the embedded server.
  DatabaseEdit.RightButton.Visible := (ServerTypeEdit.Text = ServerTypeSQLite);
  DatabaseEdit.RightButton.Enabled := (ServerTypeEdit.Text = ServerTypeSQLite);

  // Always show box for database specification for embedded server.
  SettingsBtn.Enabled := (ServerTypeEdit.Text <> ServerTypeSQLite);

  // The embedded server does not need a login.
  if (ServerTypeEdit.Text <> ServerTypeSQLite) then
  begin
    LoginBox.Visible := true;
    LoginBox.Height := LOGINBOX_HEIGHT;
    var SettingsComplete :=
      ValidateStringNotEmpty(ServerLabel.Caption, ServerEdit.Text, false) and
      ValidateIntegerBetween(PortLabel.Caption, PortEdit.Text, 1, 65535, false) and
      ValidateStringNotEmpty(DatabaseLabel.Caption, DatabaseEdit.Text, false);
    if (SettingsComplete and not(DataBoxRequested)) then
    begin
      DatabaseBox.Visible := false;
      DatabaseBox.Height := 0;
    end
    else
    begin
      DatabaseBox.Visible := true;
      DatabaseBox.Height := DATABASEBOX_HEIGHT;
    end;
  end
  else
  begin
    LoginBox.Visible := false;
    LoginBox.Height := 0;
    DatabaseBox.Visible := true;
    DatabaseBox.Height := DATABASEBOX_HEIGHT;
  end;
  InputPanel.Height := BtnsPanel.Height + LoginBox.Height + DatabaseBox.Height;
  PositionInputPanel;
end;

function TLoginView.ValidateData: Boolean;
begin
  Result := false;

  if not(ValidateComboBoxItemSelected(ServerTypeLabel.Caption, ServerTypeEdit)) then Exit;

  if (ServerTypeEdit.Text = ServerTypeSQLite) then
  begin
    if not(ValidateFileExists(DatabaseLabel.Caption, DatabaseEdit.Text)) then Exit;
  end
  else
  begin
    if not(ValidateStringNotEmpty(UsernameLabel.Caption, UsernameEdit.Text)) then Exit;
    if not(ValidateStringNotEmpty(PasswordLabel.Caption, PasswordEdit.Text)) then Exit;
    if not(ValidateStringNotEmpty(ServerLabel.Caption, ServerEdit.Text)) then Exit;
    if not(ValidateIntegerBetween(PortLabel.Caption, PortEdit.Text, 1, 65535)) then Exit;
    if not(ValidateStringNotEmpty(DatabaseLabel.Caption, DatabaseEdit.Text)) then Exit;
  end;

  Result := true;
end;

function TLoginView.LoadLastConnectionSettings: Boolean;
begin
  Result := false;

  if MainModel.Settings.ConnectionUser.HasValue then
    UsernameEdit.Text := MainModel.Settings.ConnectionUser.Value
  else
    UsernameEdit.Text := '';

  if MainModel.Settings.ConnectionPassword.HasValue then
    PasswordEdit.Text := MainModel.Settings.ConnectionPassword.Value
  else
    PasswordEdit.Text := '';

  ServerTypeEdit.ItemIndex := ServerTypeEdit.Items.IndexOf(MainModel.Settings.ConnectionType);

  if MainModel.Settings.ConnectionServer.HasValue then
    ServerEdit.Text := MainModel.Settings.ConnectionServer.Value
  else
    ServerEdit.Text := '';

  if MainModel.Settings.ConnectionPort.HasValue then
    PortEdit.Text := IntToStr(MainModel.Settings.ConnectionPort.Value)
  else
    PortEdit.Text := '';

  DatabaseEdit.Text := MainModel.Settings.ConnectionDatabase;
end;

procedure TLoginView.ConnectBtnClick(Sender: TObject);
begin
  inherited;

  // Abort if the inputs could not be positively validated.
  if not(ValidateData) then Exit;

  // Try to connect to the database.
  // MainModel returns
  // * TMsgConnectionFailed (handled by RespondMsgConnectionFailed) or
  // * TMsgConnectionSuccessful (handled by RespondMsgConnectionSuccessful).
  if (ServerTypeEdit.Text = ServerTypeSQLite) then
    MainModel.OpenWorkingConnection(DatabaseEdit.Text)
  else
    MainModel.OpenWorkingConnection(ServerTypeEdit.Text, ServerEdit.Text, StrToInt(PortEdit.Text), DatabaseEdit.Text, UsernameEdit.Text, PasswordEdit.Text);
end;

procedure TLoginView.FormShow(Sender: TObject);
begin
  inherited;

  // Load the connection settings from last login.
  LoadLastConnectionSettings;

  // Adjust the input box according to the values read in.
  UpdateInputBox;

  // Send view info to main view.
  SendModuleInfoChanged(FormatModuleInfo);
end;

procedure TLoginView.ServerTypeEditChange(Sender: TObject);
begin
  inherited;

  DatabaseEdit.Text := '';
  if (ServerTypeEdit.Text <> ServerTypeSQLite) then
    PortEdit.Text := '3306'
  else
    PortEdit.Text := '';

  UpdateInputBox;
end;

end.
