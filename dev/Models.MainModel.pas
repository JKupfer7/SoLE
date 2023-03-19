unit Models.MainModel;

interface

uses
  System.Classes,
  ZAbstractConnection,
  ZConnection,
  ZSqlProcessor,
  ZSqlMonitor,
  ZDbcIntfs,
  Models.SettingsManager;

type
  /// Holds the data model of the app.
  TMainModel = class(TDataModule)
    DBConnection: TZConnection;
    CreateDBProcessor: TZSQLProcessor;
    CreateDBConnection: TZConnection;
    SQLMonitor: TZSQLMonitor;
    DeleteProcessor: TZSQLProcessor;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private-Deklarationen }
    FSettings: TSettingsManager;
    function GetDatabaseName: String;
    function GetServerAddress: String;
    function GetServerPort: Integer;
    function GetServerVersion: String;
    function GetUserName: String;
    function GetUserPassword: String;
    procedure SetDatabaseName(const Value: String);
    procedure SetServerAddress(const Value: String);
    procedure SetServerPort(const Value: Integer);
    procedure SetUserName(const Value: String);
    procedure SetUserPassword(const Value: String);
    function GetServerClientVersion: String;
    function GetServerProtocol: String;
    function GetServerType: String;
    procedure SetServerProtocol(const Value: String);
    procedure SetServerType(const Value: String);
    function GetSQLPath: String;
    function GetSamplesPath: String;
    function Connect(AConnection: TZConnection; const SilentOnSuccess: Boolean =
        false): Boolean;
    procedure Disconnect(AConnection: TZConnection);
    procedure SetupConnectionSettings(AConnection: TZConnection; const AFileName:
        String); overload;
    procedure SetupConnectionSettings(AConnection: TZConnection; const AType,
        AServer: String; const APort: Integer; const ADatabase, AUsername,
        APassword: String); overload;
    procedure ClearConnectionSettings(AConnection: TZConnection);
    function GetServerProtocolDLLName(const AProtocol: String): String;
    function GetConnectionDLLPath(const AConnection: TZConnection): String;
    function ServerProtocolToType(const AProtocol: String): String;
    function ServerTypeToProtocol(const AType: String): String;
    function GetWorkingConnectionInfo: String;
    function GetWorkingConnectionActive: Boolean;
    function GetActiveUser: String;
    function GetLogsPath: String;
    function GetConnectionURL: String;
    property SamplesPath: String read GetSamplesPath;
    property SQLPath: String read GetSQLPath;
    property LogsPath: String read GetLogsPath;
    property DatabaseName: String read GetDatabaseName write SetDatabaseName;
    property ServerAddress: String read GetServerAddress write SetServerAddress;
    property ServerPort: Integer read GetServerPort write SetServerPort;
    property ServerVersion: String read GetServerVersion;
    property ServerClientVersion: String read GetServerClientVersion;
    property ServerType: String read GetServerType write SetServerType;
    property ServerProtocol: String read GetServerProtocol write SetServerProtocol;
    property UserName: String read GetUserName write SetUserName;
    property UserPassword: String read GetUserPassword write SetUserPassword;
  public
    { Public-Deklarationen }
    function OpenSampleConnection: Boolean;
    function OpenWorkingConnection(const AFileName: String): Boolean; overload;
    function OpenWorkingConnection(const AType, AServer: String; const APort: Integer; const ADatabase, AUsername, APassword: String): Boolean; overload;
    procedure CloseWorkingConnection;
    function CreateDatabase(const AFileName: String): Boolean; overload;
    function CreateDatabase(const AType, AServer: String; const APort: Integer; const ADatabase, AUsername, APassword: String): Boolean; overload;
    function GetPrimaryKeyValue: String;
    procedure DeleteProject(const AProjectID: String);
    procedure DeleteSetup(const ASetupID: String);
    procedure DeleteSimulation(const ASimulationID: String);
    property ActiveUser: String read GetActiveUser;
    property WorkingConnectionInfo: String read GetWorkingConnectionInfo;
    property WorkingConnectionActive: Boolean read GetWorkingConnectionActive;
    property ConnectionURL: String read GetConnectionURL;
    property Settings: TSettingsManager read FSettings;
  end;

var
  MainModel: TMainModel;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  Winapi.Windows,
  System.Win.Registry,
  System.Messaging,
  System.Types,
  System.UITypes,
  System.SysUtils,
  System.StrUtils,
  Vcl.Forms,
  Vcl.Dialogs,
  Messages.ConnectionSuccessful,
  Messages.ConnectionFailed,
  Messages.DBCreationSuccessful,
  Messages.DBCreationFailed,
  ZClasses,
  Settings.Constants;

procedure TMainModel.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(FSettings);
end;

procedure TMainModel.DeleteProject(const AProjectID: String);
begin
  var ServerType: String := GetServerType;
  DeleteProcessor.Script.Clear;
  if (ServerType = ServerTypeMySQL) then
    DeleteProcessor.Script.LoadFromFile(SQLPath + 'mysql_delete_project.sql')
  else if (ServerType = ServerTypeMariaDB) then
    DeleteProcessor.Script.LoadFromFile(SQLPath + 'mariadb_delete_project.sql')
  else if (ServerType = ServerTypeSQLite) then
    DeleteProcessor.Script.LoadFromFile(SQLPath + 'sqlite_delete_project.sql');
  DeleteProcessor.ParamByName('ID').AsString := AProjectID;
  DeleteProcessor.Execute;
end;

procedure TMainModel.DeleteSetup(const ASetupID: String);
begin
  var ServerType: String := GetServerType;
  DeleteProcessor.Script.Clear;
  if (ServerType = ServerTypeMySQL) then
    DeleteProcessor.Script.LoadFromFile(SQLPath + 'mysql_delete_setup.sql')
  else if (ServerType = ServerTypeMariaDB) then
    DeleteProcessor.Script.LoadFromFile(SQLPath + 'mariadb_delete_setup.sql')
  else if (ServerType = ServerTypeSQLite) then
    DeleteProcessor.Script.LoadFromFile(SQLPath + 'sqlite_delete_setup.sql');
  DeleteProcessor.ParamByName('ID').AsString := ASetupID;
  DeleteProcessor.Execute;
end;

procedure TMainModel.DeleteSimulation(const ASimulationID: String);
begin
  var ServerType: String := GetServerType;
  DeleteProcessor.Script.Clear;
  if (ServerType = ServerTypeMySQL) then
    DeleteProcessor.Script.LoadFromFile(SQLPath + 'mysql_delete_simulation.sql')
  else if (ServerType = ServerTypeMariaDB) then
    DeleteProcessor.Script.LoadFromFile(SQLPath + 'mariadb_delete_simulation.sql')
  else if (ServerType = ServerTypeSQLite) then
    DeleteProcessor.Script.LoadFromFile(SQLPath + 'sqlite_delete_simulation.sql');
  DeleteProcessor.ParamByName('ID').AsString := ASimulationID;
  DeleteProcessor.Execute;
end;

{ TMainModel }

function TMainModel.CreateDatabase(const AType, AServer: String;
  const APort: Integer; const ADatabase, AUsername, APassword: String): Boolean;
begin
  // Always remain pessimistic.
  Result := false;

  // Initialize connection and connect.
  // The database does not exist yet.
  SetupConnectionSettings(CreateDBConnection, AType, AServer, APort, '', AUsername, APassword);
  // Do not send success messages to the caller.
  var connected := Connect(CreateDBConnection, true);

  try
    if connected then
    begin
      // Load the script.
      if (AType = 'MySQL') then
        CreateDBProcessor.Script.LoadFromFile(SQLPath +  'mysql_create_db.sql')
      else
        CreateDBProcessor.Script.LoadFromFile(SQLPath +  'mariadb_create_db.sql');
      // Paste the database name into the script.
      CreateDBProcessor.Script.Strings[9] := Format(CreateDBProcessor.Script.Strings[9], [ADatabase]);
      CreateDBProcessor.Script.Strings[14] := Format(CreateDBProcessor.Script.Strings[14], [ADatabase]);
      try
        CreateDBProcessor.Execute;
        TMessageManager.DefaultManager.SendMessage(nil, TMsgDBCreationSuccessful.Create, true);
        Result := true;
      except
        on E: EZSQLException do
        begin
          TMessageManager.DefaultManager.SendMessage(nil, TMsgDBCreationFailed.Create(E.ErrorCode, E.Message), true);
        end;
      end;
    end;
  finally
    // Always disconnect and clean up.
    CreateDBProcessor.Script.Clear;
    Disconnect(CreateDBConnection);
    ClearConnectionSettings(CreateDBConnection);
  end;
end;

function TMainModel.CreateDatabase(const AFileName: String): Boolean;
begin
  // Always remain pessimistic.
  Result := false;

  // Initialize connection and connect.
  SetupConnectionSettings(CreateDBConnection, AFileName);
  // Do not send success messages to the caller.
  var connected := Connect(CreateDBConnection, true);

  try
    if connected then
    begin
      // Load the script and execute it.
      CreateDBProcessor.Script.LoadFromFile(SQLPath +  'sqlite_create_db.sql');
      try
        CreateDBProcessor.Execute;
        TMessageManager.DefaultManager.SendMessage(nil, TMsgDBCreationSuccessful.Create, true);
        Result := true;
      except
        on E: EZSQLException do
        begin
          TMessageManager.DefaultManager.SendMessage(nil, TMsgDBCreationFailed.Create(E.ErrorCode, E.Message), true);
        end;
      end;
    end;
  finally
    // Disconnect and clean up.
    CreateDBProcessor.Script.Clear;
    Disconnect(CreateDBConnection);
    ClearConnectionSettings(CreateDBConnection);
  end;
end;

procedure TMainModel.DataModuleCreate(Sender: TObject);
begin
  // Initialization
  DBConnection.LibraryLocation := '';
  FSettings := TSettingsManager.Create;
end;

procedure TMainModel.ClearConnectionSettings(AConnection: TZConnection);
begin
  AConnection.Protocol := '';
  AConnection.LibraryLocation := '';
  AConnection.HostName := '';
  AConnection.Port := 0;
  AConnection.Database := '';
  AConnection.User := '';
  AConnection.Password := '';
end;

procedure TMainModel.CloseWorkingConnection;
begin
  Disconnect(DBConnection);
  Settings.SaveConnectionSettings(ServerType, ServerAddress, DatabaseName, ServerPort, UserName);
  Settings.RefreshConnectionSettings;
  ClearConnectionSettings(DBConnection);
end;

function TMainModel.Connect(AConnection: TZConnection; const SilentOnSuccess:
    Boolean = false): Boolean;
begin
  try
    // Try to connect...
    AConnection.Connect;

    // ... if successful, send message TMsgConnectionSuccessful and return true.
    if not(SilentOnSuccess) then TMessageManager.DefaultManager.SendMessage(nil, TMsgConnectionSuccessful.Create, true);
    Result := true;
  except
    // ... if an error occurs ...
    on E: EZSQLException do
    begin
      // ... send message TMsgConnectionFailed and return false.
      TMessageManager.DefaultManager.SendMessage(nil, TMsgConnectionFailed.Create(E.ErrorCode, E.Message), true);
      Result := false;
    end;
  end;
end;

procedure TMainModel.Disconnect(AConnection: TZConnection);
begin
  AConnection.Disconnect;
end;

function TMainModel.GetActiveUser: String;
begin
  Result := IfThen((ServerType = ServerTypeSQLite), '(SQLite)', UserName);
end;

function TMainModel.GetConnectionDLLPath(const AConnection: TZConnection): String;
begin
  Result := ExtractFilePath(Application.ExeName) + GetServerProtocolDLLName(AConnection.Protocol);
end;

function TMainModel.GetConnectionURL: String;
begin
  if (ServerType = ServerTypeSQLite) then
    Result := Format('zdbc:%s://localhost/%s', [DBConnection.Protocol, DBConnection.Database])
  else
    Result := Format('zdbc:%s://%s:%d/%s?username=%s;password=%s;compress=yes', [DBConnection.Protocol, DBConnection.HostName, DBConnection.Port, DBConnection.Database, DBConnection.User, DBConnection.Password]);
end;

function TMainModel.GetDatabaseName: String;
begin
  Result := DBConnection.Database;
end;

function TMainModel.GetLogsPath: String;
begin
  Result := Settings.DefaultLogsPath;
end;

function TMainModel.GetPrimaryKeyValue: String;
begin
  var GUID : TGUID := TGUID.NewGuid;
  var GUIDString : String := GUIDToString(GUID);
  GUIDString := Copy(GUIDString, 2, 36);
  Result := GUIDString;
end;

function TMainModel.GetServerAddress: String;
begin
  Result := DBConnection.HostName;
end;

function TMainModel.GetServerClientVersion: String;
begin
  Result := DBConnection.ClientVersionStr;
end;

function TMainModel.GetServerPort: Integer;
begin
  Result := DBConnection.Port;
end;

function TMainModel.GetServerProtocol: String;
begin
  Result := DBConnection.Protocol;
end;

function TMainModel.GetServerProtocolDLLName(const AProtocol: String): String;
begin
  Result := '';
  if (AProtocol = 'mysql') then Result := 'libmysql.dll'
  else if (AProtocol = 'MariaDB-10') then Result := 'libmariadb.dll'
  else if (AProtocol = 'sqlite') then Result := 'sqlite3.dll';
end;

function TMainModel.GetServerType: String;
begin
  Result := ServerProtocolToType(DBConnection.Protocol);
end;

function TMainModel.GetServerVersion: String;
begin
  Result := DBConnection.ServerVersionStr;
end;

function TMainModel.GetSQLPath: String;
begin
  Result := Settings.DefaultSQLPath;
end;

function TMainModel.GetUserName: String;
begin
  Result := DBConnection.User;
end;

function TMainModel.GetUserPassword: String;
begin
  Result := DBConnection.Password;
end;

function TMainModel.GetWorkingConnectionActive: Boolean;
begin
  Result := DBConnection.Connected;
end;

function TMainModel.GetWorkingConnectionInfo: String;
begin
  Result := '';
  if (DBConnection.Connected) then
    if (ServerType = ServerTypeSQLite) then
      Result := Format('%s (%s)', [ExtractFileName(DatabaseName), ServerType])
    else
      Result := Format('%s@%s (%s)', [DatabaseName, ServerAddress, ServerType]);
end;

function TMainModel.OpenWorkingConnection(const AFileName: String): Boolean;
begin
  SetupConnectionSettings(DBConnection, AFileName);
  Result := Connect(DBConnection);
end;

function TMainModel.OpenSampleConnection: Boolean;
begin
  Result := OpenWorkingConnection(SamplesPath + 'sole_sample_data.sqlite3');
end;

function TMainModel.OpenWorkingConnection(const AType, AServer: String;
  const APort: Integer; const ADatabase, AUsername, APassword: String): Boolean;
begin
  SetupConnectionSettings(DBConnection, AType, AServer, APort, ADatabase, AUsername, APassword);
  Result := Connect(DBConnection);
end;

function TMainModel.GetSamplesPath: String;
begin
  Result := Settings.DefaultSamplesPath;
end;

function TMainModel.ServerProtocolToType(const AProtocol: String): String;
begin
  Result := '';
  if (AProtocol = 'mysql') then Result := 'MySQL'
  else if (AProtocol = 'MariaDB-10') then Result := 'MariaDB'
  else if (AProtocol = 'sqlite') then Result := 'SQLite';
end;

function TMainModel.ServerTypeToProtocol(const AType: String): String;
begin
  Result := '';
  if (AType = 'MySQL') then Result := 'mysql'
  else if (AType = 'MariaDB') then Result := 'MariaDB-10'
  else if (AType = 'SQLite') then Result := 'sqlite';
end;

procedure TMainModel.SetDatabaseName(const Value: String);
begin
  DBConnection.Database := Value;
end;

procedure TMainModel.SetServerAddress(const Value: String);
begin
  DBConnection.HostName := Value;
end;

procedure TMainModel.SetServerPort(const Value: Integer);
begin
  DBConnection.Port := Value;
end;

procedure TMainModel.SetServerProtocol(const Value: String);
begin
  DBConnection.Protocol := Value;
end;

procedure TMainModel.SetServerType(const Value: String);
begin
  DBConnection.Protocol := ServerTypeToProtocol(Value);
end;

procedure TMainModel.SetupConnectionSettings(AConnection: TZConnection; const
    AFileName: String);
begin
  AConnection.Protocol := 'sqlite';
  AConnection.LibraryLocation := GetConnectionDLLPath(AConnection);
  AConnection.HostName := '';
  AConnection.Port := 0;
  AConnection.Database := AFileName;
  AConnection.User := '';
  AConnection.Password := '';
end;

procedure TMainModel.SetupConnectionSettings(AConnection: TZConnection; const
    AType, AServer: String; const APort: Integer; const ADatabase, AUsername,
    APassword: String);
begin
  AConnection.Protocol := ServerTypeToProtocol(AType);
  AConnection.LibraryLocation := GetConnectionDLLPath(AConnection);
  AConnection.HostName := AServer;
  AConnection.Port := APort;
  AConnection.Database := ADatabase;
  AConnection.User := AUsername;
  AConnection.Password := APassword;
end;

procedure TMainModel.SetUserName(const Value: String);
begin
  DBConnection.User := Value;
end;

procedure TMainModel.SetUserPassword(const Value: String);
begin
  DBConnection.Password := Value;
end;

end.
