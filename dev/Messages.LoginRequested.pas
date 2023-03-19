unit Messages.LoginRequested;

interface

uses
  System.Classes,
  System.Messaging;

type
  /// Sent if the login form is requested.
  /// Sender: TConnectionAssistantView
  /// Receiver: TMainFormView
  /// Inheritance tree: TMsgLoginRequested --> TMessage
  TMsgLoginRequested = class(TMessage)
  end;

implementation

end.
