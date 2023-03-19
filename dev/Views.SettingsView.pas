unit Views.SettingsView;

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
  Views.CustomView,
  System.ImageList,
  Vcl.ImgList,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.WinXPanels,
  Vcl.Buttons,
  Vcl.Imaging.pngimage,
  Vcl.ToolWin,
  Vcl.ComCtrls;

type
  TSettingsView = class(TCustomView)
    InputPanel: TPanel;
    CaptionPanel: TPanel;
    Image: TImage;
    Label1: TLabel;
    ButtonsBgPanel: TPanel;
    CancelBtn: TBitBtn;
    SaveBtn: TBitBtn;
    CardPanel: TCardPanel;
    EmbeddedSettingsCard: TCard;
    CreateQueuedCheckBox: TCheckBox;
    HideFinishedCheckBox: TCheckBox;
    Label2: TLabel;
    Label3: TLabel;
    ExecuteAllCheckBox: TCheckBox;
    Label4: TLabel;
    KeepPeopleStatesCheckBox: TCheckBox;
    Label5: TLabel;
    KeepContactInformationCheckBox: TCheckBox;
    Label6: TLabel;
    StatusBar1: TStatusBar;
    procedure CancelBtnClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
  private
    { Private declarations }
    procedure PositionInputPanel;
  public
    { Public declarations }
  end;

var
  SettingsView: TSettingsView;

implementation

{$R *.dfm}

uses
  System.Messaging,
  Models.MainModel,
  Messages.SettingsViewSaved,
  Messages.SettingsViewCanceled;

procedure TSettingsView.CancelBtnClick(Sender: TObject);
begin
  inherited;

  TMessageManager.DefaultManager.SendMessage(nil, TMsgSettingsCanceled.Create, true)
end;

procedure TSettingsView.FormResize(Sender: TObject);
begin
  inherited;

  PositionInputPanel;
end;

procedure TSettingsView.FormShow(Sender: TObject);
begin
  inherited;

  CreateQueuedCheckBox.Checked := MainModel.Settings.TasksCreateQueued;
  HideFinishedCheckBox.Checked := MainModel.Settings.TasksHideFinished;
  ExecuteAllCheckBox.Checked := MainModel.Settings.TasksExecuteAllRuns;
  KeepPeopleStatesCheckBox.Checked := MainModel.Settings.TasksKeepPeopleStates;
  KeepContactInformationCheckBox.Checked := MainModel.Settings.TasksKeepContactInformation;
end;

procedure TSettingsView.PositionInputPanel;
begin
  InputPanel.Top := (ClientHeight - InputPanel.Height) div 2;
  InputPanel.Left := (ClientWidth - InputPanel.Width) div 2;
end;

procedure TSettingsView.SaveBtnClick(Sender: TObject);
begin
  inherited;

  MainModel.Settings.SaveTasksSettings(CreateQueuedCheckBox.Checked,
                                       HideFinishedCheckBox.Checked,
                                       ExecuteAllCheckBox.Checked,
                                       KeepPeopleStatesCheckBox.Checked,
                                       KeepContactInformationCheckBox.Checked);
  MainModel.Settings.RefreshTasksSettings;
  TMessageManager.DefaultManager.SendMessage(nil, TMsgSettingsSaved.Create, true)
end;




end.
