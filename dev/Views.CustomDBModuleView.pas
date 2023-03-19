unit Views.CustomDBModuleView;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Messaging,
  System.ImageList,
  Data.DB,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.ImgList,
  Vcl.WinXPanels,
  Vcl.ComCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  Views.CustomView;

type
  /// Basic type of all data modules, please do not instantiate.
  /// Inheritance tree: TCustomDBModuleView --> TCustomView --> TForm
  TCustomDBModuleView = class(TCustomView)
    MainPanel: TPanel;
    LeftPanel: TPanel;
    Splitter: TSplitter;
    RightPanel: TPanel;
    ButtonsBgPanel: TPanel;
    BtnBevel: TBevel;
    ButtonsCardPanel: TCardPanel;
    ViewModeCard: TCard;
    EditModeCard: TCard;
    PostBtn: TBitBtn;
    CancelBtn: TBitBtn;
    NewBtn: TBitBtn;
    EditBtn: TBitBtn;
    DeleteBtn: TBitBtn;
    RefreshBtn: TBitBtn;
    MainTableBgPanel: TPanel;
    MainGrid: TDBGrid;
    PageControl: TPageControl;
    MainDetailsTabSheet: TTabSheet;
    MainDetailsTabSheetBgPanel: TPanel;
    MainCaptionLabel: TLabel;
    MainDetailsScrollBox: TScrollBox;
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private-Deklarationen }
  protected
    function DataSetEmpty: Boolean; virtual; abstract;
  public
    { Public-Deklarationen }
  end;

implementation

{$R *.dfm}

procedure TCustomDBModuleView.FormResize(Sender: TObject);
begin
  inherited;

  ButtonsCardPanel.Left := (ClientWidth - ButtonsCardPanel.Width) div 2;
end;

procedure TCustomDBModuleView.FormShow(Sender: TObject);
begin
  inherited;

  ButtonsCardPanel.ActiveCard := ViewModeCard;
end;

end.
