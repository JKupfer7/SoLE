unit Dialogs.CustomDialog;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  /// Basic type of all dialog forms, please do not instantiate.
  /// Inheritance tree: TCustomDialog --> TForm
  TCustomDialog = class(TForm)
    ButtonsBgPanel: TPanel;
    BtnBevel: TBevel;
    ButtonsPanel: TPanel;
    InformationPanel: TPanel;
    MessageLabel: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private-Deklarationen }
    function GetMessageText: String;
    procedure SetMessageText(const Value: String);
  public
    { Public-Deklarationen }
    class function ShowDlg(const AMessage: String): TModalResult; overload; virtual; abstract;
    class function ShowDlg(const AMessage: String; const AHeight: Integer): TModalResult; overload; virtual; abstract;
    class function ShowDlg(const AMessage: String; const AHeight, AWidth: Integer): TModalResult; overload; virtual; abstract;
    property MessageText: String read GetMessageText write SetMessageText;
  end;

implementation

{$R *.dfm}

{ TCustomDialog }

procedure TCustomDialog.FormShow(Sender: TObject);
begin
  ButtonsPanel.Left := (ButtonsBgPanel.ClientWidth - ButtonsPanel.Width) div 2;
end;

function TCustomDialog.GetMessageText: String;
begin
  Result := MessageLabel.Caption;
end;

procedure TCustomDialog.SetMessageText(const Value: String);
begin
  MessageLabel.Caption := Value;
end;

end.
