unit Settings.Constants;

interface

uses
  Windows;

const
  // keys and values used in the registry
//SettingsRootKey = HKEY_CURRENT_USER;
//SettingsClientConnection = 'SOFTWARE\JKupfer\SoLE\Client\Connection';
//SettingsClientMainForm = 'SOFTWARE\JKupfer\SoLE\Client\MainForm';
//SettingsValueConnType = 'Type';
//SettingsValueConnServer = 'Server';
//SettingsValueConnPort = 'Port';
//SettingsValueConnDatabase = 'Database';
//SettingsValueConnUser = 'User';
//SettingsValueConnPassword = 'Password';
//SettingsValueMFormTop = 'Top';
//SettingsValueMFormLeft = 'Left';
//SettingsValueMFormHeight = 'Height';
//SettingsValueMFormWidth = 'Width';
//SettingsValueMFormMaximized = 'Maximized';
  // application folders
//SamplesFolder = 'samples\';
//SQLFolder = 'sql\';
//LogsFolder = 'logs\';
  // server types
  ServerTypeMySQL = 'MySQL';
  ServerTypeMariaDB = 'MariaDB';
  ServerTypeSQLite = 'SQLite';
  // server defaults
  DefaultServerPort = 3306;
  DefaultDatabaseName = 'sole_data';
  // simulation setup states
  SimulationSetupNotInitialized = 'Not Initialized';
  SimulationSetupInitializationInProgress = 'Initialization in Progress';
  SimulationSetupInitializationFinished = 'Initialization finished';
  // task types
  TaskTypeSetupInitialization = 'Setup Initialization';
  TaskTypeSimulationInitialization = 'Simulation Initialization';
  TaskTypeRunInitialization = 'Run Initialization';
  TaskTypeRunExecution = 'Run Execution';
  TaskTypeDayEvaluation = 'Day Evaluation';
  // task states
  TaskStatusNotStarted = 'not started';
  TaskStatusQueued = 'queued';
  TaskStatusRunning = 'running';
  TaskStatusStopped = 'stopped';
  TaskStatusFinished = 'finished';
  // task priorities
  TaskPrioritySetupInitialization = 100;
  TaskPrioritySimulationInitialization = 80;
  TaskPriorityRunInitialization = 60;
  TaskPriorityRunExecution = 40;
  TaskPriorityDayEvaluation = 20;

implementation

end.
