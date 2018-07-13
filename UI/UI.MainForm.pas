unit UI.MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, TU.Tokens,
  System.Classes, Vcl.Controls, Vcl.Forms, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Menus, Vcl.Dialogs, UI.TokenListFrame, System.ImageList,
  Vcl.ImgList, Vcl.AppEvnts;

type
  TFormMain = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    MainMenu: TMainMenu;
    Program1: TMenuItem;
    View1: TMenuItem;
    Help1: TMenuItem;
    RunAsAdmin: TMenuItem;
    RunAsSystem: TMenuItem;
    RunasSYSTEM2: TMenuItem;
    PopupMenu: TPopupMenu;
    TokenDuplicate: TMenuItem;
    TokenRestrict: TMenuItem;
    TokenRename: TMenuItem;
    TokenClose: TMenuItem;
    HLine1: TMenuItem;
    TokenRun: TMenuItem;
    TokenSendHandle: TMenuItem;
    NewMenu: TMenuItem;
    NewOpenSelf: TMenuItem;
    NewOpenProcess: TMenuItem;
    NewOpenThread: TMenuItem;
    HLine3: TMenuItem;
    NewLogonUser: TMenuItem;
    NewQueryUserToken: TMenuItem;
    NewSaferApi: TMenuItem;
    NewNtCreateToken: TMenuItem;
    HLine4: TMenuItem;
    NewCopyHandle: TMenuItem;
    NewSearchHandle: TMenuItem;
    ProgramRun: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    HLine2: TMenuItem;
    RunTaskAsInteractiveUser1: TMenuItem;
    TokenDuplicateHandle: TMenuItem;
    Propmtonhandleclose1: TMenuItem;
    Showiconsinprocesslist1: TMenuItem;
    Frame: TFrameTokenList;
    TokenImpersonate: TMenuItem;
    Displayallsearchresults1: TMenuItem;
    TokenOpenLinked: TMenuItem;
    TokenOpenInfo: TMenuItem;
    SmallIcons: TImageList;
    ApplicationEvents: TApplicationEvents;
    procedure FormCreate(Sender: TObject);
    procedure ActionDuplicate(Sender: TObject);
    procedure ActionClose(Sender: TObject);
    procedure ActionOpenProcess(Sender: TObject);
    procedure ActionRename(Sender: TObject);
    procedure ActionRunWithToken(Sender: TObject);
    procedure ListViewTokenSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure ActionOpenSelf(Sender: TObject);
    procedure RunAsAdminClick(Sender: TObject);
    procedure ActionSendHandle(Sender: TObject);
    procedure ActionDuplicateHandle(Sender: TObject);
    procedure ActionSearch(Sender: TObject);
    procedure ActionOpenLinked(Sender: TObject);
    procedure ActionOpen(Sender: TObject);
    procedure FrameListViewTokensDblClick(Sender: TObject);
    procedure RunAsSystemClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ApplicationEventsException(Sender: TObject; E: Exception);
    procedure ActionSteal(Sender: TObject);
  end;

var
  FormMain: TFormMain;

implementation

uses
  Winapi.ShellApi,
  TU.Common, TU.Handles, TU.RestartSvc, TU.Suggestions,
  UI.Information, UI.Duplicate, UI.ProcessList, UI.Run, UI.HandleSearch;

{$R *.dfm}

{ TForm1 }

procedure TFormMain.ActionClose(Sender: TObject);
begin
  Frame.DeleteToken(Frame.ListViewTokens.Selected, True);
end;

procedure TFormMain.ActionDuplicate(Sender: TObject);
begin
  Frame.AddToken(TDuplicateDialog.Execute(Self, Frame.GetSelectedToken));
end;

procedure TFormMain.ActionDuplicateHandle(Sender: TObject);
begin
  Frame.AddToken(TToken.CreateDuplicateHandle(Frame.GetSelectedToken, 0, True));
end;

procedure TFormMain.ActionOpen(Sender: TObject);
begin
  TInfoDialog.CreateFromToken(Self, Frame.GetSelectedToken);
end;

procedure TFormMain.ActionOpenLinked(Sender: TObject);
begin
  Frame.AddToken(Frame.GetSelectedToken.LinkedToken.GetValueOrRaise);
end;

procedure TFormMain.ActionOpenProcess(Sender: TObject);
begin
  Frame.AddToken(TToken.CreateFromProcess(TProcessListDialog.Execute(Self)));
end;

procedure TFormMain.ActionOpenSelf(Sender: TObject);
begin
  Frame.AddToken(TToken.CreateFromCurrent);
end;

procedure TFormMain.ActionRename(Sender: TObject);
var
  NewName: string;
begin
  // TODO: Strange bugs with OnEdited, enabled ReadOnly. Test and revert it.
  if InputQuery('Rename token', 'New token name: ', NewName) then
    Frame.RenameToken(NewName, Frame.ListViewTokens.Selected);
end;

procedure TFormMain.ActionRunWithToken(Sender: TObject);
begin
  TRunDialog.Execute(Self, Frame.GetSelectedToken);
end;

procedure TFormMain.ActionSearch(Sender: TObject);
begin
  TFormHandleSearch.Create(Self).Show;
end;

procedure TFormMain.ActionSendHandle(Sender: TObject);
var
  NewHandle: NativeUInt;
begin
  NewHandle := Frame.GetSelectedToken.SendHandleToProcess(
    TProcessListDialog.Execute(Self));

  MessageDlg(Format('The handle was successfully sent.'#$D#$A +
    'It''s value is %d (0x%0.6x)', [NewHandle, NewHandle]), mtInformation,
    [mbOK], 0);
end;

procedure TFormMain.ActionSteal(Sender: TObject);
begin
  TProcessListDialog.Execute(Self);//TODO: Copy handle from process
end;

procedure TFormMain.ApplicationEventsException(Sender: TObject; E: Exception);
begin
  ShowErrorSuggestions(E);
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  with Frame.AddToken(TToken.CreateFromCurrent), Elevation do
    if IsValid then
      if Elevation.Value <> TokenElevationTypeDefault then
        with LinkedToken do
          if IsValid then
            Frame.AddToken(Value);
  SetForegroundWindow(Handle);
end;

procedure TFormMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F3 then
    Frame.SearchBox.SetFocus;

  if Key = VK_ESCAPE then
    Frame.SearchBox.Text := '';
end;

procedure TFormMain.FrameListViewTokensDblClick(Sender: TObject);
begin
  if Frame.ListViewTokens.SelCount <> 0 then
    ActionOpen(Self);
end;

procedure TFormMain.RunAsAdminClick(Sender: TObject);
begin
  ReSvcDelegate(Handle, False);
  Close;
end;

procedure TFormMain.RunAsSystemClick(Sender: TObject);
begin
  try
    ReSvcCreateService;
  except
    on E: EOSError do
      if E.ErrorCode = ERROR_ACCESS_DENIED then
        ReSvcDelegate(Handle, True);
      else
        raise;
  end;
  Close;
end;

procedure TFormMain.ListViewTokenSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
var
  Menu: TMenuItem;
begin
  for Menu in PopupMenu.Items do
    if (Menu <> NewMenu) and (Menu <> ProgramRun)  then
      Menu.Enabled := Selected;
end;

end.
