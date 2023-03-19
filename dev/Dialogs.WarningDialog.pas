unit Dialogs.WarningDialog;

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
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.Imaging.pngimage,
  Vcl.Buttons,
  Dialogs.CustomPicturedDialog;

type
  /// Modal dialog box for for displaying a warning.
  /// Inheritance tree: TWarningDialog --> TCustomPicturedDialog --> TCustomDialog --> TForm
  TWarningDialog = class(TCustomPicturedDialog)
    YesBtn: TBitBtn;
    NoBtn: TBitBtn;
    procedure FormShow(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    class function ShowDlg(const AMessage: String): TModalResult; override;
    class function ShowDlg(const AMessage: String; const AHeight: Integer): TModalResult; override;
    class function ShowDlg(const AMessage: String; const AHeight, AWidth: Integer): TModalResult; override;
  end;

implementation

{$R *.dfm}

{ TWarningDialog }

procedure TWarningDialog.FormShow(Sender: TObject);
begin
  inherited;
  ActiveControl := NoBtn;
end;

class function TWarningDialog.ShowDlg(const AMessage: String): TModalResult;
begin
  Result := ShowDlg(AMessage, 0, 0);
end;

class function TWarningDialog.ShowDlg(const AMessage: String;
  const AHeight: Integer): TModalResult;
begin
  Result := ShowDlg(AMessage, AHeight, 0);
end;

class function TWarningDialog.ShowDlg(const AMessage: String; const AHeight,
  AWidth: Integer): TModalResult;
begin
  var Dlg: TWarningDialog := TWarningDialog.Create(Application);
  try
    if (AHeight > 0) then Dlg.Height := AHeight;
    if (AWidth > 0) then Dlg.Width := AWidth;
    Dlg.MessageText := AMessage;
    Result := Dlg.ShowModal;
    if (Result <> mrYes) then Result := mrNo;
  finally
    FreeAndNil(Dlg);
  end;
end;

end.
