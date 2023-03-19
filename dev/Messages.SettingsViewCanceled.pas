unit Messages.SettingsViewCanceled;

interface

uses
  System.Classes,
  System.Messaging;

type
  /// Will be sent after canceling saving settings.
  /// Sender: TSettingsView
  /// Receiver: TMainFormView
  /// Inheritance tree: TMsgLoginSuccessful --> TMessage
  TMsgSettingsCanceled = class(TMessage)
  end;

implementation

end.
