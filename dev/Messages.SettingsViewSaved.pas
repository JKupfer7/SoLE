unit Messages.SettingsViewSaved;

interface

uses
  System.Classes,
  System.Messaging;

type
  /// Will be sent after a successful saving settings.
  /// Sender: TSettingsView
  /// Receiver: TMainFormView
  /// Inheritance tree: TMsgLoginSuccessful --> TMessage
  TMsgSettingsSaved = class(TMessage)
  end;

implementation

end.
