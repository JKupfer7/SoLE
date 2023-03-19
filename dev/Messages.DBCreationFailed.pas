unit Messages.DBCreationFailed;

interface

uses
  System.Classes,
  System.Messaging;

type
  /// Sent when a new database could not be created.
  /// Sender: TMainModel
  /// Receiver: TConnectionAssistantView
  /// Inheritance tree: TMsgDBCreationFailed --> TMessage
  TMsgDBCreationFailed = class(TMessage)
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

{ TMsgConnectionFailed }

constructor TMsgDBCreationFailed.Create(const AServerCode: Integer;
  const AServerMessage: String);
begin
  inherited Create;

  FServerCode := AServerCode;
  FServerMessage := AServerMessage;
end;

function TMsgDBCreationFailed.GetErrorMessage: String;
begin
  Result := Format('The database could not be created. (Server message: %s, Error code: %d)', [ServerMessage, ServerCode]);
end;

end.
