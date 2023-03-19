unit Messages.ModuleInfoChanged;

interface

uses
  System.Classes,
  System.Messaging;

type
  /// Sent when the information about the active module has changed.
  /// Sender: all modules
  /// Receiver: TMainForm
  /// Inheritance tree: TMsgModuleInfoChanged --> TMessage
  TMsgModuleInfoChanged = class(TMessage)
  private
    FModuleInfo: String;
  public
    constructor Create(const AModuleInfo: String); overload;
    property ModuleInfo: String read FModuleInfo write FModuleInfo;
  end;

implementation

{ TMsgModuleInfoChanged }

constructor TMsgModuleInfoChanged.Create(const AModuleInfo: String);
begin
  inherited Create;

  ModuleInfo := AModuleInfo;
end;

end.
