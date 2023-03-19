unit Messages.ConnectionSuccessful;

interface

uses
  System.Classes,
  System.Messaging;

type
  /// Will be sent after a successful connection.
  /// Sender: TMainModel
  /// Receiver: TLoginView, TConnectionAssistantView
  /// Inheritance tree: TMsgConnectionSuccessful --> TMessage
  TMsgConnectionSuccessful = class(TMessage)
  end;

implementation

end.
