unit Messages.ConnectionFailed;

interface

uses
  System.Classes,
  System.Messaging;

type
  /// Sent when the connection has failed.
  /// Sender: TMainModel
  /// Receiver: TLoginView, TConnectionAssistantView
  /// Inheritance tree: TMsgConnectionFailed --> TMessage
  TMsgConnectionFailed = class(TMessage)
  private
    FServerCode: Integer;
    FServerMessage: String;
    function GetErrorMessage: String;
  public
    constructor Create(const AServerCode: Integer; const AServerMessage: String); overload;
    property ServerCode: Integer read FServerCode write FServerCode;
    property ServerMessage: String read FServerMessage write FServerMessage;
    property ErrorMessage: String read GetErrorMessage;
  end;

implementation

uses
  System.SysUtils;

const
  // Database connection error codes
  CE_MYSQL_USER = 1045;     // username or password wrong
  CE_MYSQL_DATABASE = 1049; // database name wrong
  CE_MYSQL_PORT = 2003;     // port number wrong
  CE_MYSQL_SERVER = 2005;   // server name wrong

{ TMsgConnectionFailed }

constructor TMsgConnectionFailed.Create(const AServerCode: Integer;
  const AServerMessage: String);
begin
  inherited Create;

  FServerCode := AServerCode;
  FServerMessage := AServerMessage;
end;

function TMsgConnectionFailed.GetErrorMessage: String;
begin
  Result := '';
  case ServerCode of
    CE_MYSQL_USER     : Result := Format('The specified user account does not exist or the password is incorrect. (Error code: %d)', [ServerCode]);
    CE_MYSQL_DATABASE : Result := Format('The specified database was not found on this server. (Error code: %d)', [ServerCode]);
    CE_MYSQL_PORT     : Result := Format('The specified database port is incorrect. (Error code: %d)', [ServerCode]);
    CE_MYSQL_SERVER   : Result := Format('The database server name is incorrect or the server is not active. (Error code: %d)', [ServerCode]);
  end;
end;

end.
