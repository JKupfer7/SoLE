unit Views.CustomView;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  Winapi.ShlObj,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.ImageList,
  System.Messaging,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.ImgList,
  Vcl.StdCtrls;

type
  /// Type for storing a file path.
  TFilePath = Array [0 .. 260] of Char;
  /// Basic type of all modules, please do not instantiate.
  /// Inheritance tree: TCustomView --> TForm
  TCustomView = class(TForm)
    ButtonImageList: TImageList;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private-Deklarationen }
    FMessagesEnabled: Boolean;
    function GetOwnComputerName: String;
    function GetOwnDocumentsPath: String;
    function GetOwnPicturesPath: String;
  protected
    function ValidateComboBoxItemSelected(const AName: String; AComboBox: TComboBox; const AShowDialog: Boolean = true): Boolean;
    function ValidateInteger(const AName, AValue: String; const AShowDialog: Boolean = true): Boolean;
    function ValidateIntegerBetween(const AName, AValue: String; const ALowerBound, AUpperBound: Integer; const AShowDialog: Boolean = true): Boolean;
    function ValidateIntegerGreater(const AName, AValue: String; const ALowerBound: Integer; const AShowDialog: Boolean = true): Boolean;
    function ValidateIntegerLess(const AName, AValue: String; const AUpperBound: Integer; const AShowDialog: Boolean = true): Boolean;
    function ValidateFileExists(const AName, AValue: String; const AShowDialog: Boolean = true): Boolean;
    function ValidateFileNotExists(const AName, AValue: String; const AShowDialog: Boolean = true): Boolean;
    function ValidateFloat(const AName, AValue: String; const AShowDialog: Boolean = true): Boolean;
    function ValidateFloatBetween(const AName, AValue: String; const ALowerBound, AUpperBound: Double;
        const AShowDialog: Boolean = true): Boolean;
    function ValidateFloatGreater(const AName, AValue: String; const ALowerBound: Double; const
        AShowDialog: Boolean = true): Boolean;
    function ValidateFloatGreaterEqual(const AName, AValue: String; const ALowerBound: Double; const
        AShowDialog: Boolean = true): Boolean;
    function ValidateFloatLess(const AName, AValue: String; const AUpperBound: Double; const
        AShowDialog: Boolean = true): Boolean;
    function ValidateFloatLessEqual(const AName, AValue: String; const AUpperBound: Double; const
        AShowDialog: Boolean = true): Boolean;
    function ValidatePathExists(const AName, AValue: String; const AShowDialog: Boolean = true): Boolean;
    function ValidateStringNotEmpty(const AName, AValue: String; const AShowDialog: Boolean = true): Boolean;
    function FormatModuleInfo: String; virtual; abstract;
    procedure SendModuleInfoChanged(const AModuleInfo: String);
    function ValidateData: Boolean; virtual; abstract;
    property OwnComputerName: String read GetOwnComputerName;
    property OwnDocumentsPath: String read GetOwnDocumentsPath;
    property OwnPicturesPath: String read GetOwnPicturesPath;
    property MessagesEnabled: Boolean read FMessagesEnabled write FMessagesEnabled;
  public
    { Public-Deklarationen }
  end;

implementation

{$R *.dfm}

uses
  Dialogs.ErrorDialog,
  Messages.ModuleInfoChanged;

procedure TCustomView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TCustomView.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := true;
end;

function TCustomView.GetOwnComputerName: String;
var
  buffer: Array[0..MAX_COMPUTERNAME_LENGTH] of char;
begin
  var l: DWORD := MAX_COMPUTERNAME_LENGTH + 1;
  if GetComputerName(buffer, l) then
    Result := buffer
  else
    Result := '';
end;

function TCustomView.GetOwnDocumentsPath: String;
begin
  var FilePath : TFilePath;
  SHGetSpecialFolderPath(0, FilePath, CSIDL_PERSONAL, false);
  Result := FilePath;
end;

function TCustomView.GetOwnPicturesPath: String;
begin
  var FilePath : TFilePath;
  SHGetSpecialFolderPath(0, FilePath, CSIDL_MYPICTURES, false);
  Result := FilePath;
end;

procedure TCustomView.SendModuleInfoChanged(const AModuleInfo: String);
begin
  // Send a message if the module information has changed.
  TMessageManager.DefaultManager.SendMessage(nil, TMsgModuleInfoChanged.Create(AModuleInfo), true);
end;

function TCustomView.ValidateComboBoxItemSelected(const AName: String;
  AComboBox: TComboBox; const AShowDialog: Boolean): Boolean;
begin
  Result := (AComboBox.ItemIndex >= 0);
  if (not(Result) and AShowDialog) then
    TErrorDialog.ShowDlg(Format('A value must be selected in the field %s.', [AName]));
end;

function TCustomView.ValidateFileExists(const AName, AValue: String;
  const AShowDialog: Boolean): Boolean;
begin
  Result := FileExists(AValue);
  if (not(Result) and AShowDialog) then
    TErrorDialog.ShowDlg(Format('The file specified as %s does not exist.', [AName]));
end;

function TCustomView.ValidateFileNotExists(const AName, AValue: String;
  const AShowDialog: Boolean): Boolean;
begin
  Result := not(FileExists(AValue));
  if (not(Result) and AShowDialog) then
    TErrorDialog.ShowDlg(Format('The file specified as %s already exists.', [AName]));
end;

function TCustomView.ValidateFloat(const AName, AValue: String;
  const AShowDialog: Boolean): Boolean;
begin
  Result := false;
  try
    StrToFloat(AValue);
    Result := true;
  except
    on E: EConvertError do
    begin
    if (not(Result) and AShowDialog) then
      TErrorDialog.ShowDlg(Format('The value in the field %s must be a floating point number.', [AName]));
    end;
  end;
end;

function TCustomView.ValidateFloatBetween(const AName, AValue: String; const ALowerBound,
    AUpperBound: Double; const AShowDialog: Boolean = true): Boolean;
begin
  Result := false;
  try
    var FloatVal: Double := StrToFloat(AValue);
    Result := ((FloatVal >= ALowerBound) and (FloatVal <= AUpperBound));
    if (not(Result) and AShowDialog) then
      TErrorDialog.ShowDlg(Format('The value in the field %s must be a floating point number between %g and %g.', [AName, ALowerBound, AUpperBound]));
  except
    on E: EConvertError do
    begin
    if (not(Result) and AShowDialog) then
      TErrorDialog.ShowDlg(Format('The value in the field %s must be a floating point number.', [AName]));
    end;
  end;
end;

function TCustomView.ValidateFloatGreater(const AName, AValue: String; const ALowerBound: Double;
    const AShowDialog: Boolean = true): Boolean;
begin
  Result := false;
  try
    var FloatVal: Double := StrToFloat(AValue);
    Result := (FloatVal > ALowerBound);
    if (not(Result) and AShowDialog) then
      TErrorDialog.ShowDlg(Format('The value in the field %s must be a floating point number greater than %g.', [AName, ALowerBound]));
  except
    on E: EConvertError do
    begin
    if (not(Result) and AShowDialog) then
      TErrorDialog.ShowDlg(Format('The value in the field %s must be a floating point number.', [AName]));
    end;
  end;
end;

function TCustomView.ValidateFloatGreaterEqual(const AName, AValue: String;
  const ALowerBound: Double; const AShowDialog: Boolean): Boolean;
begin
  Result := false;
  try
    var FloatVal: Double := StrToFloat(AValue);
    Result := (FloatVal >= ALowerBound);
    if (not(Result) and AShowDialog) then
      TErrorDialog.ShowDlg(Format('The value in the field %s must be a floating point number greater than or equal to %g.', [AName, ALowerBound]));
  except
    on E: EConvertError do
    begin
    if (not(Result) and AShowDialog) then
      TErrorDialog.ShowDlg(Format('The value in the field %s must be a floating point number.', [AName]));
    end;
  end;
end;

function TCustomView.ValidateFloatLess(const AName, AValue: String; const AUpperBound: Double;
    const AShowDialog: Boolean = true): Boolean;
begin
  Result := false;
  try
    var FloatVal: Double := StrToInt(AValue);
    Result := (FloatVal < AUpperBound);
    if (not(Result) and AShowDialog) then
      TErrorDialog.ShowDlg(Format('The value in the field %s must be a floating point number less than %g.', [AName, AUpperBound]));
  except
    on E: EConvertError do
    begin
    if (not(Result) and AShowDialog) then
      TErrorDialog.ShowDlg(Format('The value in the field %s must be a floating point number.', [AName]));
    end;
  end;
end;

function TCustomView.ValidateFloatLessEqual(const AName, AValue: String;
  const AUpperBound: Double; const AShowDialog: Boolean): Boolean;
begin
  Result := false;
  try
    var FloatVal: Double := StrToInt(AValue);
    Result := (FloatVal <= AUpperBound);
    if (not(Result) and AShowDialog) then
      TErrorDialog.ShowDlg(Format('The value in the field %s must be a floating point number less than or equal to %g.', [AName, AUpperBound]));
  except
    on E: EConvertError do
    begin
    if (not(Result) and AShowDialog) then
      TErrorDialog.ShowDlg(Format('The value in the field %s must be a floating point number.', [AName]));
    end;
  end;
end;

function TCustomView.ValidateInteger(const AName, AValue: String;
  const AShowDialog: Boolean): Boolean;
begin
  Result := false;
  try
    StrToInt(AValue);
    Result := true;
  except
    on E: EConvertError do
    begin
    if (not(Result) and AShowDialog) then
      TErrorDialog.ShowDlg(Format('The value in the field %s must be an integer.', [AName]));
    end;
  end;
end;

function TCustomView.ValidateIntegerBetween(const AName, AValue: String;
  const ALowerBound, AUpperBound: Integer; const AShowDialog: Boolean): Boolean;
begin
  Result := false;
  try
    var IntVal: Integer := StrToInt(AValue);
    Result := ((IntVal >= ALowerBound) and (IntVal <= AUpperBound));
    if (not(Result) and AShowDialog) then
      TErrorDialog.ShowDlg(Format('The value in the field %s must be an integer between %d and %d.', [AName, ALowerBound, AUpperBound]));
  except
    on E: EConvertError do
    begin
    if (not(Result) and AShowDialog) then
      TErrorDialog.ShowDlg(Format('The value in the field %s must be an integer.', [AName]));
    end;
  end;
end;

function TCustomView.ValidateIntegerGreater(const AName, AValue: String;
  const ALowerBound: Integer; const AShowDialog: Boolean): Boolean;
begin
  Result := false;
  try
    var IntVal: Integer := StrToInt(AValue);
    Result := (IntVal > ALowerBound);
    if (not(Result) and AShowDialog) then
      TErrorDialog.ShowDlg(Format('The value in the field %s must be an integer greater than %d.', [AName, ALowerBound]));
  except
    on E: EConvertError do
    begin
    if (not(Result) and AShowDialog) then
      TErrorDialog.ShowDlg(Format('The value in the field %s must be an integer.', [AName]));
    end;
  end;
end;

function TCustomView.ValidateIntegerLess(const AName, AValue: String;
  const AUpperBound: Integer; const AShowDialog: Boolean): Boolean;
begin
  Result := false;
  try
    var IntVal: Integer := StrToInt(AValue);
    Result := (IntVal < AUpperBound);
    if (not(Result) and AShowDialog) then
      TErrorDialog.ShowDlg(Format('The value in the field %s must be an integer less than %d.', [AName, AUpperBound]));
  except
    on E: EConvertError do
    begin
    if (not(Result) and AShowDialog) then
      TErrorDialog.ShowDlg(Format('The value in the field %s must be an integer.', [AName]));
    end;
  end;
end;

function TCustomView.ValidatePathExists(const AName, AValue: String;
  const AShowDialog: Boolean): Boolean;
begin
  Result := DirectoryExists(ExtractFilePath(AValue));
  if (not(Result) and AShowDialog) then
    TErrorDialog.ShowDlg(Format('The path specified for %s does not exist.', [AName]));
end;

function TCustomView.ValidateStringNotEmpty(const AName, AValue: String;
  const AShowDialog: Boolean): Boolean;
begin
  Result := (Trim(AValue) <> '');
  if (not(Result) and AShowDialog) then
    TErrorDialog.ShowDlg(Format('The value in the field %s must not be empty.', [AName]));
end;

end.
