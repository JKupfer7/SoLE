unit Dialogs.ConfirmationDialog;

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
  Vcl.Buttons,
  Vcl.Imaging.pngimage,
  Dialogs.CustomPicturedDialog;

type
  /// Modal dialog box for obtaining confirmation from the user.
  /// Inheritance tree: TConfirmationDialog --> TCustomPicturedDialog --> TCustomDialog --> TForm
  TConfirmationDialog = class(TCustomPicturedDialog)
    YesBtn: TBitBtn;
    NoBtn: TBitBtn;
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

{ TConfirmationDialog }

class function TConfirmationDialog.ShowDlg(
  const AMessage: String): TModalResult;
begin
  Result := ShowDlg(AMessage, 0, 0);
end;

class function TConfirmationDialog.ShowDlg(const AMessage: String;
  const AHeight: Integer): TModalResult;
begin
  Result := ShowDlg(AMessage, AHeight, 0);
end;

class function TConfirmationDialog.ShowDlg(const AMessage: String;
  const AHeight, AWidth: Integer): TModalResult;
begin
  var Dlg: TConfirmationDialog := TConfirmationDialog.Create(Application);
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
