unit Dialogs.InformationDialog;

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
  /// Modal dialog box for displaying an information.
  /// Inheritance tree: TInformationDialog --> TCustomPicturedDialog --> TCustomDialog --> TForm
  TInformationDialog = class(TCustomPicturedDialog)
    CloseBtn: TBitBtn;
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

{ TInformationDialog }

class function TInformationDialog.ShowDlg(const AMessage: String): TModalResult;
begin
  Result := ShowDlg(AMessage, 0, 0);
end;

class function TInformationDialog.ShowDlg(const AMessage: String;
  const AHeight: Integer): TModalResult;
begin
  Result := ShowDlg(AMessage, AHeight, 0);
end;

class function TInformationDialog.ShowDlg(const AMessage: String; const AHeight,
  AWidth: Integer): TModalResult;
begin
  var Dlg: TInformationDialog := TInformationDialog.Create(Application);
  try
    if (AHeight > 0) then Dlg.Height := AHeight;
    if (AWidth > 0) then Dlg.Width := AWidth;
    Dlg.MessageText := AMessage;
    Dlg.ShowModal;
    Result := mrClose;
  finally
    FreeAndNil(Dlg);
  end;
end;

end.
