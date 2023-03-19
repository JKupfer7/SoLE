unit Messages.LoginSuccessful;

interface

uses
  System.Classes,
  System.Messaging;

type
  /// Will be sent after a successful login.
  /// Sender: TLoginView
  /// Receiver: TMainFormView
  /// Inheritance tree: TMsgLoginSuccessful --> TMessage
  TMsgLoginSuccessful = class(TMessage)
  end;

implementation

end.
