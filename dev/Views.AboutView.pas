unit Views.AboutView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Views.CustomView, System.ImageList,
  Vcl.ImgList, Vcl.StdCtrls, Vcl.WinXPanels, Vcl.Buttons, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls;

type
  TAboutView = class(TCustomView)
    InputPanel: TPanel;
    CaptionPanel: TPanel;
    Image: TImage;
    Label1: TLabel;
    ButtonsBgPanel: TPanel;
    SaveBtn: TBitBtn;
    CardPanel: TCardPanel;
    EmbeddedSettingsCard: TCard;
    Image1: TImage;
    Label2: TLabel;
    VersionLabel: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Label11Click(Sender: TObject);
    procedure Label15Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Label7Click(Sender: TObject);
    procedure Label9Click(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
  private
    { Private declarations }
    procedure PositionInputPanel;
  public
    { Public declarations }
  end;

var
  AboutView: TAboutView;

implementation

{$R *.dfm}

uses
  Winapi.ShellAPI,
  System.Messaging,
  Models.MainModel,
  Messages.AboutViewClosed;

procedure TAboutView.FormResize(Sender: TObject);
begin
  inherited;

  PositionInputPanel;
end;

procedure TAboutView.FormShow(Sender: TObject);
begin
  inherited;

  VersionLabel.Caption := 'Version ' + MainModel.Settings.ApplicationVersion;
end;

procedure TAboutView.Label11Click(Sender: TObject);
begin
  inherited;
  ShellExecute( 0, nil, 'https://icons8.com', nil, nil, SW_SHOW);
end;

procedure TAboutView.Label15Click(Sender: TObject);
begin
  inherited;
  ShellExecute( 0, nil, 'license.txt', nil, nil, SW_SHOW);
end;

procedure TAboutView.Label5Click(Sender: TObject);
begin
  inherited;
  ShellExecute( 0, nil, 'https://www.embarcadero.com/products/delphi/starter?aldSet=en-GB', nil, nil, SW_SHOW);
end;

procedure TAboutView.Label7Click(Sender: TObject);
begin
  inherited;
  ShellExecute( 0, nil, 'https://www.steema.com/product/vcl', nil, nil, SW_SHOW);
end;

procedure TAboutView.Label9Click(Sender: TObject);
begin
  inherited;
  ShellExecute( 0, nil, 'https://sourceforge.net/projects/zeoslib/', nil, nil, SW_SHOW);
end;

procedure TAboutView.PositionInputPanel;
begin
  InputPanel.Top := (ClientHeight - InputPanel.Height) div 2;
  InputPanel.Left := (ClientWidth - InputPanel.Width) div 2;
end;

procedure TAboutView.SaveBtnClick(Sender: TObject);
begin
  inherited;

  TMessageManager.DefaultManager.SendMessage(nil, TMsgAboutClosed.Create, true)
end;

end.
