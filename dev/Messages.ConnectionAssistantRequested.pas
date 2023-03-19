unit Messages.ConnectionAssistantRequested;

interface

uses
  System.Classes,
  System.Messaging;

type
  /// Sent if the database connection assistant is requested.
  /// Sender: TLoginView
  /// Receiver: TMainFormView
  /// Inheritance tree: TMsgConnectionAssistantRequested --> TMessage
  TMsgConnectionAssistantRequested = class(TMessage)
  end;

implementation

end.
