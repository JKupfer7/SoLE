unit Views.CustomModuleView;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.ImageList,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.ImgList,
  Views.CustomView;

type
  /// Basic type of all data modules, please do not instantiate.
  /// Inheritance tree: TCustomModuleView --> TCustomView --> TForm
  TCustomModuleView = class(TCustomView)
    MainPanel: TPanel;
    LeftPanel: TPanel;
    Splitter: TSplitter;
    RightPanel: TPanel;
    ButtonsBgPanel: TPanel;
    ButtonsPanel: TPanel;
    NewBtn: TBitBtn;
    EditBtn: TBitBtn;
    DeleteBtn: TBitBtn;
    BtnBevel: TBevel;
    procedure FormResize(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

implementation

{$R *.dfm}

procedure TCustomModuleView.FormResize(Sender: TObject);
begin
  inherited;

  ButtonsPanel.Left := (ClientWidth - ButtonsPanel.Width) div 2;
end;

end.
