unit Dialogs.CustomPicturedDialog;

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
  Dialogs.CustomDialog;

type
  /// Basic type of all dialog forms with a picture, please do not instantiate.
  /// Inheritance tree: TCustomPicturedDialog --> TCustomDialog --> TForm
  TCustomPicturedDialog = class(TCustomDialog)
    Image: TImage;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

implementation

{$R *.dfm}

end.
