unit Views.ConnectionAssistantView;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.Classes,
  System.Messaging,
  System.SysUtils,
  System.Variants,
  System.ImageList,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ImgList,
  Vcl.StdCtrls,
  Vcl.Imaging.pngimage,
  Vcl.ExtCtrls,
  Vcl.WinXPanels,
  Vcl.Buttons,
  Views.CustomView;

type
  TConnectionAssistantView = class(TCustomView)
    InputPanel: TPanel;
    CaptionPanel: TPanel;
    Image: TImage;
    Label1: TLabel;
    ButtonsBgPanel: TPanel;
    BackBtn: TBitBtn;
    NextBtn: TBitBtn;
    CardPanel: TCardPanel;
    ConnectOrCreateCard: TCard;
    Label2: TLabel;
    ConnectRadioBtn: TRadioButton;
    CreateRadioBtn: TRadioButton;
    Label3: TLabel;
    Label4: TLabel;
    ServerTypeCard: TCard;
    Label5: TLabel;
    MySQLRadioBtn: TRadioButton;
    Label6: TLabel;
    MariaDBRadioBtn: TRadioButton;
    Label7: TLabel;
    SQLiteRadioBtn: TRadioButton;
    Label8: TLabel;
    ServerSettingsCard: TCard;
    Label9: TLabel;
    ServerLabel: TLabel;
    ServerEdit: TEdit;
    Label11: TLabel;
    PortLabel: TLabel;
    Label13: TLabel;
    DatabaseLabel: TLabel;
    DatabaseEdit: TEdit;
    Label15: TLabel;
    UsernameLabel: TLabel;
    UsernameEdit: TEdit;
    Label17: TLabel;
    PasswordLabel: TLabel;
    PasswordEdit: TEdit;
    Label19: TLabel;
    EmbeddedSettingsCard: TCard;
    Label20: TLabel;
    FileNameEdit: TButtonedEdit;
    EditImageList: TImageList;
    Label21: TLabel;
    SaveDialog: TSaveDialog;
    SampleRadioBtn: TRadioButton;
    Label10: TLabel;
    PortEdit: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure BackBtnClick(Sender: TObject);
    procedure ConnectRadioBtnClick(Sender: TObject);
    procedure CreateRadioBtnClick(Sender: TObject);
    procedure FileNameEditRightButtonClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MariaDBRadioBtnClick(Sender: TObject);
    procedure MySQLRadioBtnClick(Sender: TObject);
    procedure NextBtnClick(Sender: TObject);
    /// Message listener method for TMsgConnectionFailed
    procedure RespondMsgConnectionFailed(const Sender: TObject; const M: TMessage);
    /// Message listener method for TMsgConnectionSuccessful
    procedure RespondMsgConnectionSuccessful(const Sender: TObject; const M: TMessage);
    /// Message listener method for TMsgDBCreationFailed
    procedure RespondMsgDBCreationFailed(const Sender: TObject; const M: TMessage);
    /// Message listener method for TMsgDBCreationSuccessful
    procedure RespondMsgDBCreationSuccessful(const Sender: TObject; const M: TMessage);
    procedure SQLiteRadioBtnClick(Sender: TObject);
  private
    { Private-Deklarationen }
    FServerType: String;
    procedure PositionInputPanel;
  protected
    function FormatModuleInfo: String; override;
    function ValidateData: Boolean; override;
    property ServerType: String read FServerType write FServerType;
  public
  end;

implementation

{$R *.dfm}

uses
  Dialogs.ErrorDialog,
  Models.MainModel,
  Messages.LoginRequested,
  Messages.LoginSuccessful,
  Messages.DBCreationFailed,
  Messages.DBCreationSuccessful,
  Messages.ConnectionFailed,
  Messages.ConnectionSuccessful,
  Settings.Constants;

function TConnectionAssistantView.FormatModuleInfo: String;
begin
  Result := 'Create a new database or connect to an existing one.';
end;

procedure TConnectionAssistantView.FormCreate(Sender: TObject);
begin
  inherited;

  // Subscribe to messages of the classes TMsgDBCreationFailed and TMsgDBCreationSuccessful.
  TMessageManager.DefaultManager.SubscribeToMessage(TMsgDBCreationFailed, RespondMsgDBCreationFailed);
  TMessageManager.DefaultManager.SubscribeToMessage(TMsgDBCreationSuccessful, RespondMsgDBCreationSuccessful);
  // Subscribe to messages of the classes TMsgConnectionFailed and TMsgConnectionSuccessful.
  TMessageManager.DefaultManager.SubscribeToMessage(TMsgConnectionFailed, RespondMsgConnectionFailed);
  TMessageManager.DefaultManager.SubscribeToMessage(TMsgConnectionSuccessful, RespondMsgConnectionSuccessful);
end;

procedure TConnectionAssistantView.BackBtnClick(Sender: TObject);
begin
  inherited;

  if (CardPanel.ActiveCard = ServerTypeCard) then
  begin
    CardPanel.ActiveCard := ConnectOrCreateCard;
    BackBtn.Enabled := false;
  end

  else if ((CardPanel.ActiveCard = ServerSettingsCard) or
      (CardPanel.ActiveCard = EmbeddedSettingsCard)) then
  begin
    CardPanel.ActiveCard := ServerTypeCard;
    NextBtn.Caption := 'Next';
    NextBtn.ImageIndex := 12;
    NextBtn.Layout := blGlyphRight;
  end;
end;

procedure TConnectionAssistantView.ConnectRadioBtnClick(Sender: TObject);
begin
  inherited;

  // Update NextBtn.
  NextBtn.Caption := 'Execute';
  NextBtn.ImageIndex := 10;
  NextBtn.Layout := blGlyphLeft;
end;

procedure TConnectionAssistantView.CreateRadioBtnClick(Sender: TObject);
begin
  inherited;

  // Update NextBtn.
  NextBtn.Caption := 'Next';
  NextBtn.ImageIndex := 12;
  NextBtn.Layout := blGlyphRight;
end;

procedure TConnectionAssistantView.FileNameEditRightButtonClick(Sender: TObject);
begin
  inherited;
  SaveDialog.InitialDir := OwnDocumentsPath;
  SaveDialog.FileName := 'sole_data.sqlite3';
  if SaveDialog.Execute then
    FileNameEdit.Text := ExpandFileName(SaveDialog.FileName);
end;

procedure TConnectionAssistantView.FormResize(Sender: TObject);
begin
  inherited;

  PositionInputPanel;
end;

procedure TConnectionAssistantView.FormShow(Sender: TObject);
begin
  inherited;

  // Initialie view.
  ConnectRadioBtn.Checked := true;
  MySQLRadioBtn.Checked := true;
  ServerEdit.Text := '';
  PortEdit.Text := IntToStr(DefaultServerPort);
  DatabaseEdit.Text := DefaultDatabaseName;
  UsernameEdit.Text := '';
  PasswordEdit.Text := '';
  FileNameEdit.Text := '';

  CardPanel.ActiveCard := ConnectOrCreateCard;
  NextBtn.Caption := 'Execute';
  NextBtn.ImageIndex := 10;
  NextBtn.Layout := blGlyphLeft;

  ServerType := ServerTypeMySQL;

  // Send view info to main view.
  SendModuleInfoChanged(FormatModuleInfo);
end;

procedure TConnectionAssistantView.MariaDBRadioBtnClick(Sender: TObject);
begin
  inherited;

  ServerType := ServerTypeMariaDB;
end;

procedure TConnectionAssistantView.MySQLRadioBtnClick(Sender: TObject);
begin
  inherited;

  ServerType := ServerTypeMySQL;
end;

procedure TConnectionAssistantView.NextBtnClick(Sender: TObject);
begin
  inherited;

  if (CardPanel.ActiveCard = ConnectOrCreateCard) then
  begin
    if ConnectRadioBtn.Checked then
    begin
      // From the main window, request the login view.
      TMessageManager.DefaultManager.SendMessage(nil, TMsgLoginRequested.Create, true);
    end
    else if CreateRadioBtn.Checked then
    begin
      CardPanel.ActiveCard := ServerTypeCard;
      BackBtn.Enabled := true;
    end
    else if SampleRadioBtn.Checked then
    begin
      MainModel.OpenSampleConnection;
    end;
  end

  else if (CardPanel.ActiveCard = ServerTypeCard) then
  begin
    if (MySQLRadioBtn.Checked or MariaDBRadioBtn.Checked) then
    begin
      CardPanel.ActiveCard := ServerSettingsCard;
    end
    else if SQLiteRadioBtn.Checked then
    begin
      CardPanel.ActiveCard := EmbeddedSettingsCard;
    end;
    NextBtn.Caption := 'Execute';
    NextBtn.ImageIndex := 10;
    NextBtn.Layout := blGlyphLeft;
  end

  else if (CardPanel.ActiveCard = ServerSettingsCard) then
  begin
    // Input validation.
    if not(ValidateData) then Exit;

    // Create the new database
    MainModel.CreateDatabase(ServerType, ServerEdit.Text, StrToInt(PortEdit.Text), DatabaseEdit.Text, UsernameEdit.Text, PasswordEdit.Text);
  end

  else if (CardPanel.ActiveCard = EmbeddedSettingsCard) then
  begin
    // Input validation.
    if not(ValidateData) then Exit;

    // Create the new database
    MainModel.CreateDatabase(FileNameEdit.Text);
  end;
end;

procedure TConnectionAssistantView.PositionInputPanel;
begin
  InputPanel.Top := (ClientHeight - InputPanel.Height) div 2;
  InputPanel.Left := (ClientWidth - InputPanel.Width) div 2;
end;

procedure TConnectionAssistantView.RespondMsgConnectionFailed(
  const Sender: TObject; const M: TMessage);
begin
  // Check if the message belongs to the class TMsgConnectionFailed ...
  if (M is TMsgConnectionFailed) then
  begin
    // ... cast the Message as TMsgConnectionFailed and display the error message.
    TErrorDialog.ShowDlg((M as TMsgConnectionFailed).ErrorMessage);
  end;
end;

procedure TConnectionAssistantView.RespondMsgConnectionSuccessful(
  const Sender: TObject; const M: TMessage);
begin
  // Send a message to the main form about successful login.
  TMessageManager.DefaultManager.SendMessage(nil, TMsgLoginSuccessful.Create, true);
end;

procedure TConnectionAssistantView.RespondMsgDBCreationFailed(
  const Sender: TObject; const M: TMessage);
begin
  // Check if the message belongs to the class TMsgDBCreationFailed ...
  if (M is TMsgDBCreationFailed) then
  begin
    // ... cast the Message as TMsgDBCreationFailed and display the error message.
    TErrorDialog.ShowDlg((M as TMsgDBCreationFailed).ErrorMessage, 200);
  end;
end;

procedure TConnectionAssistantView.RespondMsgDBCreationSuccessful(
  const Sender: TObject; const M: TMessage);
begin
  if SQLiteRadioBtn.Checked then
    MainModel.OpenWorkingConnection(FileNameEdit.Text)
  else
    MainModel.OpenWorkingConnection(ServerType, ServerEdit.Text, StrToInt(PortEdit.Text), DatabaseEdit.Text, UsernameEdit.Text, PasswordEdit.Text)
end;

procedure TConnectionAssistantView.SQLiteRadioBtnClick(Sender: TObject);
begin
  inherited;

  ServerType := ServerTypeSQLite;
end;

function TConnectionAssistantView.ValidateData: Boolean;
begin
  Result := false;

  if (ServerType = ServerTypeSQLite) then
  begin
    if not(ValidateStringNotEmpty('SQLite database', FileNameEdit.Text)) then exit;
    if not(ValidatePathExists('SQLite database', FileNameEdit.Text)) then exit;
    if not(ValidateFileNotExists('SQLite database', FileNameEdit.Text)) then exit;
  end
  else
  begin
    if not(ValidateStringNotEmpty(ServerLabel.Caption, ServerEdit.Text)) then exit;
    if not(ValidateIntegerBetween(PortLabel.Caption, PortEdit.Text, 1, 65535)) then exit;
    if not(ValidateStringNotEmpty(DatabaseLabel.Caption, DatabaseEdit.Text)) then exit;
    if not(ValidateStringNotEmpty(UsernameLabel.Caption, UsernameEdit.Text)) then exit;
    if not(ValidateStringNotEmpty(PasswordLabel.Caption, PasswordEdit.Text)) then exit;
  end;

  Result := true;
end;

end.
