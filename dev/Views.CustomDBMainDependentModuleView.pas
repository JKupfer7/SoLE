unit Views.CustomDBMainDependentModuleView;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.ImageList,
  Data.DB,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ImgList,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.ExtCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.Mask,
  Vcl.DBCtrls,
  Vcl.ComCtrls,
  Vcl.WinXPanels,
  Views.CustomDBModuleView;

type
  TCustomDBMainDependentModuleView = class(TCustomDBModuleView)
    DependentData1TabSheet: TTabSheet;
    DependentData1LeftBgPanel: TPanel;
    DependentData1Splitter: TSplitter;
    DependentData1RightBgPanel: TPanel;
    DependentData1DetailsScrollBox: TScrollBox;
    DependentData1Grid: TDBGrid;
  private
  public
  end;

implementation

{$R *.dfm}

end.
