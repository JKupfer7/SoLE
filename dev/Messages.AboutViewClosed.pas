unit Messages.AboutViewClosed;

interface

uses
  System.Classes,
  System.Messaging;

type
  /// Will be sent after closing about view.
  /// Sender: TAboutView
  /// Receiver: TMainFormView
  /// Inheritance tree: TMsgAboutClosed --> TMessage
  TMsgAboutClosed = class(TMessage)
  end;

implementation

end.
