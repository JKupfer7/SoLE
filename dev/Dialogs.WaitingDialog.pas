unit Dialogs.WaitingDialog;

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
  Vcl.ExtCtrls,
  Vcl.WinXCtrls;

type
  TWaitingDialog = class(TForm)
    InformationPanel: TPanel;
    MessageLabel: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    function GetMessageText: String;
    procedure SetMessageText(const Value: String);
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    class function ShowDlg(const AMessageText: String): TWaitingDialog;
    procedure HideDlg(const AMessageText: String; const ADelay: Integer = 2000); overload;
    procedure HideDlg; overload;
    procedure UpdateMsg(const AMessageText: String);
    property MessageText: String read GetMessageText write SetMessageText;
  end;

implementation

{$R *.dfm}

procedure TWaitingDialog.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TWaitingDialog.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := true;
end;

{ TWaitingDialog }

function TWaitingDialog.GetMessageText: String;
begin
  Result := MessageLabel.Caption;
end;

procedure TWaitingDialog.HideDlg;
begin
  Screen.Cursor := crDefault;
  Close;
end;

procedure TWaitingDialog.HideDlg(const AMessageText: String;
  const ADelay: Integer);
begin
  MessageText := AMessageText;
  Application.ProcessMessages;
  Screen.Cursor := crDefault;
  Sleep(ADelay);
  Close;
end;

procedure TWaitingDialog.SetMessageText(const Value: String);
begin
  MessageLabel.Caption := Value;
end;

class function TWaitingDialog.ShowDlg(
  const AMessageText: String): TWaitingDialog;
begin
  Screen.Cursor := crHourGlass;
  var Dlg: TWaitingDialog := TWaitingDialog.Create(Application);
  Dlg.MessageText := AMessageText;
  Dlg.Show;
  Application.ProcessMessages;
  Result := Dlg;
end;

procedure TWaitingDialog.UpdateMsg(const AMessageText: String);
begin
  MessageText := AMessageText;
  Application.ProcessMessages;
end;

end.
