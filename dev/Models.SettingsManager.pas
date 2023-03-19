unit Models.SettingsManager;

interface

uses
  Winapi.Windows,
  System.Win.Registry,
  System.UITypes,
  System.SysUtils,
  Models.Nullable;

type
  TSettingsManager = class(TObject)
  private
    FRootKey: HKEY;
    FTasksCreatedQueued: Boolean;
    FKeyMainForm: String;
    FKeyMainFormTop: String;
    FKeyMainFormLeft: String;
    FKeyMainFormHeight: String;
    FKeyMainFormWidth: String;
    FKeyMainFormState: String;
    FKeyConnection: String;
    FKeyConnectionType: String;
    FKeyConnectionServer: String;
    FKeyConnectionPort: String;
    FKeyConnectionDatabase: String;
    FKeyConnectionUser: String;
    FKeyConnectionPassword: String;
    FKeyTasks: String;
    FKeyTasksCreateQueued: String;
    FKeyTasksHideFinished: String;
    FKeyTasksExecuteAllRuns: String;
    FKeyTasksKeepPeopleStates: String;
    FKeyTasksKeepContactInformation: String;
    FMainFormTop: Integer;
    FMainFormLeft: Integer;
    FMainFormWidth: Integer;
    FMainFormHeight: Integer;
    FMainFormState: TWindowState;
    FConnectionType: String;
    FConnectionServer: TNullable<String>;
    FConnectionDatabase: String;
    FConnectionPort: TNullable<Integer>;
    FConnectionUser: TNullable<String>;
    FConnectionPassword: TNullable<String>;
    FTasksHideFinished: Boolean;
    FTasksExecuteAllRuns: Boolean;
    FTasksKeepPeopleStates: Boolean;
    FTasksKeepContactInformation: Boolean;
    FTasksCreateQueued: Boolean;
    FKeyDefaults: String;
    FKeyDefaultPopulationSize: String;
    FKeyDefaultInfectiousOnStart: String;
    FKeyDefaultSimulationDays: String;
    FKeyDefaultMeanContactsPerPerson: String;
    FKeyDefaultDeviationContactsPerPerson: String;
    FKeyDefaultMeanContactPropability: String;
    FKeyDefaultDeviationContactPropability: String;
    FKeyDefaultNumberOfRuns: String;
    FDefaultPopulationSize: Integer;
    FDefaultInfectiousOnStart: Integer;
    FDefaultSimulationDays: Integer;
    FDefaultMeanContactsPerPerson: Integer;
    FDefaultDeviationContactsPerPerson: Integer;
    FDefaultMeanContactPropability: Double;
    FDefaultDeviationContactPropability: Double;
    FDefaultNumberOfRuns: Integer;
    function GetOwnComputerName: String;
    function SettingsExists(const AKey: String): Boolean;
    function GetFirstStartOnThisMachine: Boolean;
    procedure LoadMainFormSettings;
    procedure LoadConnectionSettings;
    procedure LoadTasksSettings;
    procedure LoadDefaultsSettings;
    function GetApplicationVersion: String;
    function GetDefaultLogsPath: TFileName;
    function GetDefaultSamplesPath: TFileName;
    function GetDefaultSQLPath: TFileName;
  public
    constructor Create;
    procedure SaveMainFormSettings(const ATop, ALeft, AWidth, AHeight: Integer;
        const AState: TWindowState);
    procedure SaveConnectionSettings(const AType, AServer, ADatabase: String;
        const APort: Integer; const AUser: String);
    procedure SaveTasksSettings(const ACreateQueued, AHideFinished, AExecuteAllRuns,
        AKeepPeopleStates, AKeepContactInformation: Boolean);
    procedure SaveDefaultsSettings(const APopulationSize, AInfectiousOnStart, ASimulationDays,
        AMeanContactsPerPerson, ADeviationContactsPerPerson: Integer; const AMeanContactProbability,
        ADeviationContactProbability: Double; ANumberOfRuns: Integer);
    procedure RefreshConnectionSettings;
    procedure RefreshTasksSettings;
    procedure RefreshDefaultsSettings;
    property ApplicationVersion: String read GetApplicationVersion;
    property FirstStartOnThisMachine: Boolean read GetFirstStartOnThisMachine;
    property ConnectionType: String read FConnectionType;
    property ConnectionServer: TNullable<String> read FConnectionServer;
    property ConnectionDatabase: String read FConnectionDatabase;
    property ConnectionPort: TNullable<Integer> read FConnectionPort;
    property ConnectionUser: TNullable<String> read FConnectionUser;
    property ConnectionPassword: TNullable<String> read FConnectionPassword;
    property DefaultLogsPath: TFileName read GetDefaultLogsPath;
    property DefaultSamplesPath: TFileName read GetDefaultSamplesPath;
    property DefaultSQLPath: TFileName read GetDefaultSQLPath;
    property MainFormTop: Integer read FMainFormTop;
    property MainFormLeft: Integer read FMainFormLeft;
    property MainFormWidth: Integer read FMainFormWidth;
    property MainFormHeight: Integer read FMainFormHeight;
    property MainFormState: TWindowState read FMainFormState;
    property TasksCreateQueued: Boolean read FTasksCreateQueued;
    property TasksHideFinished: Boolean read FTasksHideFinished;
    property TasksExecuteAllRuns: Boolean read FTasksExecuteAllRuns;
    property TasksKeepPeopleStates: Boolean read FTasksKeepPeopleStates;
    property TasksKeepContactInformation: Boolean read FTasksKeepContactInformation;
    property DefaultPopulationSize: Integer read FDefaultPopulationSize;
    property DefaultInfectiousOnStart: Integer read FDefaultInfectiousOnStart;
    property DefaultSimulationDays: Integer read FDefaultSimulationDays;
    property DefaultMeanContactsPerPerson: Integer read FDefaultMeanContactsPerPerson;
    property DefaultDeviationContactsPerPerson: Integer read FDefaultDeviationContactsPerPerson;
    property DefaultMeanContactPropability: Double read FDefaultMeanContactPropability;
    property DefaultDeviationContactPropability: Double read FDefaultDeviationContactPropability;
    property DefaultNumberOfRuns: Integer read FDefaultNumberOfRuns;
    property OwnComputerName: String read GetOwnComputerName;
  end;

implementation

uses
  Winapi.ShlObj,
  System.Math,
  System.TypInfo,
  System.StrUtils,
  Vcl.Forms;

constructor TSettingsManager.Create;
begin
  inherited;

  // Rootkey for registry access
  FRootKey := HKEY_CURRENT_USER;

  // Key names for the database connection
  FKeyConnection := 'SOFTWARE\JKupfer\SoLE\Client\Connection';
  FKeyConnectionType := 'Type';
  FKeyConnectionServer := 'Server';
  FKeyConnectionPort := 'Port';
  FKeyConnectionDatabase := 'Database';
  FKeyConnectionUser := 'User';
  FKeyConnectionPassword := 'Password';

  // Key names for the main form properties
  FKeyMainForm := 'SOFTWARE\JKupfer\SoLE\Client\MainForm';
  FKeyMainFormTop := 'Top';
  FKeyMainFormLeft := 'Left';
  FKeyMainFormHeight := 'Height';
  FKeyMainFormWidth := 'Width';
  FKeyMainFormState := 'State';

  //
  FKeyTasks := 'SOFTWARE\JKupfer\SoLE\Client\Tasks';
  FKeyTasksCreateQueued := 'CreateQueued';
  FKeyTasksHideFinished := 'HideFinished';
  FKeyTasksExecuteAllRuns := 'ExecuteAllRuns';
  FKeyTasksKeepPeopleStates := 'KeepPeopleStates';
  FKeyTasksKeepContactInformation := 'KeepContactInformation';

  FKeyDefaults := 'SOFTWARE\JKupfer\SoLE\Client\Defaults';
  FKeyDefaultPopulationSize := 'DefaultPopulationSize';
  FKeyDefaultInfectiousOnStart := 'DefaultInfectiousOnStart';
  FKeyDefaultSimulationDays := 'DefaultSimulationDays';
  FKeyDefaultMeanContactsPerPerson := 'DefaultMeanContactsPerPerson';
  FKeyDefaultDeviationContactsPerPerson := 'DefaultDeviationContactsPerPerson';
  FKeyDefaultMeanContactPropability := 'DefaultMeanContactPropability';
  FKeyDefaultDeviationContactPropability := 'DefaultDeviationContactPropability';
  FKeyDefaultNumberOfRuns := 'DefaultNumberOfRuns';

  LoadMainFormSettings;
  LoadConnectionSettings;
  LoadTasksSettings;
  LoadDefaultsSettings;
end;

function TSettingsManager.GetApplicationVersion: String;
begin
  // Implementation following Wolf at Stack Overflow.
  // https://stackoverflow.com/questions/1717844/how-to-determine-delphi-application-version

  Result := '';

  var Dummy: DWORD;
  var VerInfoSize: DWORD := GetFileVersionInfoSize(PChar(ParamStr(0)), Dummy);
  if VerInfoSize = 0 then Exit;

  var VerInfo: Pointer;
  var VerValueSize: DWORD;
  var VerValue: PVSFixedFileInfo;
  GetMem(VerInfo, VerInfoSize);
  GetFileVersionInfo(PChar(ParamStr(0)), 0, VerInfoSize, VerInfo);
  VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);

  with VerValue^ do
  begin
    Result := IntToStr(dwFileVersionMS shr 16);
    Result := Result + '.' + IntToStr(dwFileVersionMS and $FFFF);
    Result := Result + '.' + IntToStr(dwFileVersionLS shr 16);
    Result := Result + '.' + IntToStr(dwFileVersionLS and $FFFF);
  end;

  FreeMem(VerInfo, VerInfoSize);
end;

function TSettingsManager.GetDefaultLogsPath: TFileName;
begin
  Result := ExtractFilePath(Application.ExeName) + 'logs\';
end;

function TSettingsManager.GetDefaultSamplesPath: TFileName;
begin
  Result := ExtractFilePath(Application.ExeName) + 'samples\';
end;

function TSettingsManager.GetDefaultSQLPath: TFileName;
begin
  Result := ExtractFilePath(Application.ExeName) + 'sql\';
end;

function TSettingsManager.GetFirstStartOnThisMachine: Boolean;
begin
  Result := not(SettingsExists(FKeyConnection));
end;

function TSettingsManager.GetOwnComputerName: String;
var
  buffer: Array[0..MAX_COMPUTERNAME_LENGTH] of char;
begin
  var l: DWORD := MAX_COMPUTERNAME_LENGTH + 1;
  if GetComputerName(buffer, l) then
    Result := buffer
  else
    Result := '';
end;

procedure TSettingsManager.LoadConnectionSettings;
begin
  var reg: TRegistry := TRegistry.Create(KEY_READ);
  reg.RootKey := FRootKey;
  try
    if reg.KeyExists(FKeyConnection) then
    begin
      if reg.OpenKey(FKeyConnection, false) then
      begin
        FConnectionType := System.StrUtils.IfThen(reg.ValueExists(FKeyConnectionType), reg.ReadString(FKeyConnectionType), '');
        if reg.ValueExists(FKeyConnectionServer) then
          FConnectionServer.Value := reg.ReadString(FKeyConnectionServer)
        else
          FConnectionServer.Clear;
        FConnectionDatabase := System.StrUtils.IfThen(reg.ValueExists(FKeyConnectionDatabase), reg.ReadString(FKeyConnectionDatabase), '');
        if reg.ValueExists(FKeyConnectionPort) then
          FConnectionPort.Value := reg.ReadInteger(FKeyConnectionPort)
        else
          FConnectionPort.Clear;
        if reg.ValueExists(FKeyConnectionUser) then
          FConnectionUser.Value := reg.ReadString(FKeyConnectionUser)
        else
          FConnectionUser.Clear;
        if reg.ValueExists(FKeyConnectionPassword) then
          FConnectionPassword.Value := reg.ReadString(FKeyConnectionPassword)
        else
          FConnectionPassword.Clear;
      end;
      reg.CloseKey;
    end
    else
    begin
      FConnectionType := '';
      FConnectionServer.Clear;
      FConnectionDatabase := '';
      FConnectionPort.Clear;
      FConnectionUser.Clear;
      FConnectionPassword.Clear;
    end;
  finally
    FreeAndNil(reg);
  end;
end;

procedure TSettingsManager.LoadDefaultsSettings;
begin
  var reg: TRegistry := TRegistry.Create(KEY_READ);
  reg.RootKey := FRootKey;
  try
    if reg.KeyExists(FKeyDefaults) then
    begin
      if reg.OpenKey(FKeyDefaults, false) then
      begin
        FDefaultPopulationSize := System.Math.IfThen(reg.ValueExists(FKeyDefaultPopulationSize), reg.ReadInteger(FKeyDefaultPopulationSize), 1000);
        FDefaultInfectiousOnStart := System.Math.IfThen(reg.ValueExists(FKeyDefaultInfectiousOnStart), reg.ReadInteger(FKeyDefaultInfectiousOnStart), 3);
        FDefaultSimulationDays := System.Math.IfThen(reg.ValueExists(FKeyDefaultSimulationDays), reg.ReadInteger(FKeyDefaultSimulationDays), 100);
        FDefaultMeanContactsPerPerson := System.Math.IfThen(reg.ValueExists(FKeyDefaultMeanContactsPerPerson), reg.ReadInteger(FKeyDefaultMeanContactsPerPerson), 25);
        FDefaultDeviationContactsPerPerson := System.Math.IfThen(reg.ValueExists(FKeyDefaultDeviationContactsPerPerson), reg.ReadInteger(FKeyDefaultDeviationContactsPerPerson), 10);
        FDefaultMeanContactPropability := System.Math.IfThen(reg.ValueExists(FKeyDefaultMeanContactPropability), reg.ReadInteger(FKeyDefaultMeanContactPropability), 0.5);
        FDefaultDeviationContactPropability := System.Math.IfThen(reg.ValueExists(FKeyDefaultDeviationContactPropability), reg.ReadInteger(FKeyDefaultDeviationContactPropability), 0.25);
        FDefaultNumberOfRuns := System.Math.IfThen(reg.ValueExists(FKeyDefaultNumberOfRuns), reg.ReadInteger(FKeyDefaultNumberOfRuns), 10);
      end;
      reg.CloseKey;
    end
    else
    begin
      FDefaultPopulationSize := 1000;
      FDefaultInfectiousOnStart := 3;
      FDefaultSimulationDays := 100;
      FDefaultMeanContactsPerPerson := 25;
      FDefaultDeviationContactsPerPerson := 10;
      FDefaultMeanContactPropability := 0.5;
      FDefaultDeviationContactPropability := 0.25;
      FDefaultNumberOfRuns := 10;
    end;
  finally
    FreeAndNil(reg);
  end;
end;

procedure TSettingsManager.LoadMainFormSettings;
begin
  var reg: TRegistry := TRegistry.Create(KEY_READ);
  reg.RootKey := FRootKey;
  try
    if reg.KeyExists(FKeyMainForm) then
    begin
      if reg.OpenKey(FKeyMainForm, false) then
      begin
        FMainFormTop := System.Math.IfThen(reg.ValueExists(FKeyMainFormTop), reg.ReadInteger(FKeyMainFormTop), 100);
        FMainFormLeft := System.Math.IfThen(reg.ValueExists(FKeyMainFormLeft), reg.ReadInteger(FKeyMainFormLeft), 100);
        FMainFormWidth := System.Math.IfThen(reg.ValueExists(FKeyMainFormWidth), reg.ReadInteger(FKeyMainFormWidth), Screen.Width - 200);
        FMainFormHeight := System.Math.IfThen(reg.ValueExists(FKeyMainFormHeight), reg.ReadInteger(FKeyMainFormHeight), Screen.Height - 200);
        if reg.ValueExists(FKeyMainFormState) then
          case reg.ReadInteger(FKeyMainFormState) of
            0 : FMainFormState := TWindowState.wsNormal;
            1 : FMainFormState := TWindowState.wsMinimized;
            2 : FMainFormState := TWindowState.wsMaximized;
          end
        else
          FMainFormState := TWindowState.wsNormal;
      end;
      reg.CloseKey;
    end
    else
    begin
      FMainFormTop := 100;
      FMainFormLeft := 100;
      FMainFormWidth := Screen.Width - 200;
      FMainFormHeight := Screen.Height - 200;
      FMainFormState := TWindowState.wsNormal;
    end;
  finally
    FreeAndNil(reg);
  end;
end;

procedure TSettingsManager.LoadTasksSettings;
begin
  var reg: TRegistry := TRegistry.Create(KEY_READ);
  reg.RootKey := FRootKey;
  try
    if reg.KeyExists(FKeyTasks) then
    begin
      if reg.OpenKey(FKeyTasks, false) then
      begin
        if reg.ValueExists(FKeyTasksCreateQueued) then
          FTasksCreateQueued := reg.ReadBool(FKeyTasksCreateQueued)
        else
          FTasksCreateQueued := true;

        if reg.ValueExists(FKeyTasksHideFinished) then
          FTasksHideFinished := reg.ReadBool(FKeyTasksHideFinished)
        else
          FTasksHideFinished := true;

        if reg.ValueExists(FKeyTasksExecuteAllRuns) then
          FTasksExecuteAllRuns := reg.ReadBool(FKeyTasksExecuteAllRuns)
        else
          FTasksExecuteAllRuns := true;

        if reg.ValueExists(FKeyTasksKeepPeopleStates) then
          FTasksKeepPeopleStates := reg.ReadBool(FKeyTasksKeepPeopleStates)
        else
          FTasksKeepPeopleStates := false;

        if reg.ValueExists(FKeyTasksKeepContactInformation) then
          FTasksKeepContactInformation := reg.ReadBool(FKeyTasksKeepContactInformation)
        else
          FTasksKeepContactInformation := false;
      end;
      reg.CloseKey;
    end
    else
    begin
      FTasksCreateQueued := true;
      FTasksHideFinished := true;
      FTasksExecuteAllRuns := true;
      FTasksKeepPeopleStates := false;
      FTasksKeepContactInformation := false;
    end;
  finally
    FreeAndNil(reg);
  end;

end;

procedure TSettingsManager.RefreshConnectionSettings;
begin
  LoadConnectionSettings;
end;

procedure TSettingsManager.RefreshDefaultsSettings;
begin
  LoadDefaultsSettings;
end;

procedure TSettingsManager.RefreshTasksSettings;
begin
  LoadTasksSettings;
end;

function TSettingsManager.SettingsExists(const AKey: String): Boolean;
begin
  Result := false;

  var reg: TRegistry := TRegistry.Create(KEY_READ);
  reg.RootKey := FRootKey;
  try
    Result := reg.KeyExists(AKey);
  finally
    FreeAndNil(reg);
  end;
end;

procedure TSettingsManager.SaveConnectionSettings(
    const AType, AServer, ADatabase: String; const APort: Integer; const AUser:
    String);
begin
  var reg: TRegistry := TRegistry.Create;
  reg.RootKey := FRootKey;
  try
    if reg.OpenKey(FKeyConnection, true) then
    begin
      reg.WriteString(FKeyConnectionType, AType);

      if AServer = '' then
      begin
        if reg.ValueExists(FKeyConnectionServer) then
          reg.DeleteValue(FKeyConnectionServer);
      end
      else
        reg.WriteString(FKeyConnectionServer, AServer);

      reg.WriteString(FKeyConnectionDatabase, ADatabase);

      if APort = 0 then
      begin
        if reg.ValueExists(FKeyConnectionPort) then
          reg.DeleteValue(FKeyConnectionPort);
      end
      else
        reg.WriteInteger(FKeyConnectionPort, APort);

      if AUser = '' then
      begin
        if reg.ValueExists(FKeyConnectionUser) then
          reg.DeleteValue(FKeyConnectionUser);
      end
      else
        reg.WriteString(FKeyConnectionUser, AUser);

      reg.CloseKey;
    end;
  finally
    FreeAndNil(reg);
  end;
end;

procedure TSettingsManager.SaveDefaultsSettings(const APopulationSize,
  AInfectiousOnStart, ASimulationDays, AMeanContactsPerPerson,
  ADeviationContactsPerPerson: Integer; const AMeanContactProbability,
  ADeviationContactProbability: Double; ANumberOfRuns: Integer);
begin
  var reg: TRegistry := TRegistry.Create;
  reg.RootKey := FRootKey;
  try
    if reg.OpenKey(FKeyDefaults, true) then
    begin
      reg.WriteInteger(FKeyDefaultPopulationSize, APopulationSize);
      reg.WriteInteger(FKeyDefaultInfectiousOnStart, AInfectiousOnStart);
      reg.WriteInteger(FKeyDefaultSimulationDays, ASimulationDays);
      reg.WriteInteger(FKeyDefaultMeanContactsPerPerson, AMeanContactsPerPerson);
      reg.WriteInteger(FKeyDefaultDeviationContactsPerPerson, ADeviationContactsPerPerson);
      reg.WriteFloat(FKeyDefaultMeanContactPropability, AMeanContactProbability);
      reg.WriteFloat(FKeyDefaultDeviationContactPropability, ADeviationContactProbability);
      reg.WriteInteger(FKeyDefaultNumberOfRuns, ANumberOfRuns);
      reg.CloseKey;
    end;
  finally
    FreeAndNil(reg);
  end;
end;

procedure TSettingsManager.SaveMainFormSettings(
    const ATop, ALeft, AWidth, AHeight: Integer; const AState: TWindowState);
begin
  var reg: TRegistry := TRegistry.Create;
  reg.RootKey := FRootKey;
  try
    if reg.OpenKey(FKeyMainForm, true) then
    begin
      reg.WriteInteger(FKeyMainFormTop, ATop);
      reg.WriteInteger(FKeyMainFormLeft, ALeft);
      reg.WriteInteger(FKeyMainFormHeight, AHeight);
      reg.WriteInteger(FKeyMainFormWidth, AWidth);
      reg.WriteInteger(FKeyMainFormState, Ord(AState));
      reg.CloseKey;
    end;
  finally
    FreeAndNil(reg);
  end;
end;

procedure TSettingsManager.SaveTasksSettings(const ACreateQueued, AHideFinished,
  AExecuteAllRuns, AKeepPeopleStates, AKeepContactInformation: Boolean);
begin
  var reg: TRegistry := TRegistry.Create;
  reg.RootKey := FRootKey;
  try
    if reg.OpenKey(FKeyTasks, true) then
    begin
      reg.WriteBool(FKeyTasksCreateQueued, ACreateQueued);
      reg.WriteBool(FKeyTasksHideFinished, AHideFinished);
      reg.WriteBool(FKeyTasksExecuteAllRuns, AExecuteAllRuns);
      reg.WriteBool(FKeyTasksKeepPeopleStates, AKeepPeopleStates);
      reg.WriteBool(FKeyTasksKeepContactInformation, AKeepContactInformation);
      reg.CloseKey;
    end;
  finally
    FreeAndNil(reg);
  end;

end;

end.
