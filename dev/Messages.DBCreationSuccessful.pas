unit Messages.DBCreationSuccessful;

interface

uses
  System.Classes,
  System.Messaging;

type
  /// Will be sent after a successful database creation.
  /// Sender: TMainModel
  /// Receiver: ConnectionAssistantView
  /// Inheritance tree: TMsgDBCreationSuccessful --> TMessage
  TMsgDBCreationSuccessful = class(TMessage)
  end;

implementation

end.
