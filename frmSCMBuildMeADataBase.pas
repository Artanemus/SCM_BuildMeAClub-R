unit frmSCMBuildMeADataBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Phys, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, FireDAC.Stan.Pool, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.DataSet,

  FireDAC.Stan.Consts, System.IOUtils, System.Types, Registry, Vcl.ComCtrls,
  System.UITypes, FireDAC.Phys.MSSQLDef, FireDAC.Phys.ODBCBase,
  FireDAC.Phys.MSSQL, System.Actions, Vcl.ActnList, Vcl.BaseImageCollection,
  Vcl.ImageCollection, Vcl.VirtualImage, scmBuildConfig,

  System.Generics.Collections;

type
  TSCMBuildMeADataBase = class(TForm)
    ActionList1: TActionList;
    actnBMAC: TAction;
    actnConnect: TAction;
    actnDisconnect: TAction;
    actnSelectDataBase: TAction;
    btnBMAC: TButton;
    btnCancel: TButton;
    btnConnect: TButton;
    btnDisconnect: TButton;
    btnSelectDatabase: TButton;
    chkbUseOSAuthentication: TCheckBox;
    edtPassword: TEdit;
    edtServerName: TEdit;
    edtUser: TEdit;
    GroupBox1: TGroupBox;
    Image2: TImage;
    ImageCollection1: TImageCollection;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    lblDatabaseVersion: TLabel;
    lblPreRelease: TLabel;
    Memo1: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    progressBar: TProgressBar;
    qryDBExists: TFDQuery;
    qryVersion: TFDQuery;
    scmConnection: TFDConnection;
    vimgPassed: TVirtualImage;
    VirtualImage1: TVirtualImage;
    procedure actnBMACExecute(Sender: TObject);
    procedure actnBMACUpdate(Sender: TObject);
    procedure actnConnectExecute(Sender: TObject);
    procedure actnConnectUpdate(Sender: TObject);
    procedure actnDisconnectExecute(Sender: TObject);
    procedure actnDisconnectUpdate(Sender: TObject);
    procedure actnSelectDataBaseExecute(Sender: TObject);
    procedure actnSelectDataBaseUpdate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
  const
    OUT_Major = 5;
    OUT_Minor = 1;
    // ---------------------------------------------------------
    // NEW SCMSystem UPDATE VALUES
    // ---------------------------------------------------------
    OUT_Model = 1;
    OUT_Version = 1;
    SCMCONFIGFILENAME = 'SCMConfig.ini';
  var
    BuildConfigList: TObjectList<TscmBuildConfig>;

    // Flags that building is finalised or can't proceed.
    // Once set - btnBMAC is not long visible. User may only exit.
    BuildDone: Boolean;
    FDBMajor: Integer;
    FDBMinor: Integer;
    // ---------------------------------------------------------
    // VALUES AFTER READ OF SCMSystem
    // ---------------------------------------------------------
    FDBModel: Integer;
    // Version Control Display Strings
    FDBVerCtrlStr: string;
    FDBVerCtrlStrVerbose: string;
    FDBVersion: Integer;
    fSelectedBuildConfig: TscmBuildConfig; // reference to selected build object
    function ExecuteProcess(const FileName, Params: string; Folder: string;
      WaitUntilTerminated, WaitUntilIdle, RunMinimized: Boolean;
      var ErrorCode: Integer): Boolean;
    function ExecuteProcessSQLcmd(SQLFile, ServerName, UserName,
      Password: String; var errCode: Integer; UseOSAthent: Boolean = true;
      RunMinimized: Boolean = false; Log: Boolean = false): Boolean;
    procedure GetFileList(filePath, fileMask: String; var sl: TStringList);
    procedure GetSCM_DB_Version();
    procedure LoadConfigData;
    procedure SaveConfigData;
    procedure SimpleLoadSettingString(ASection, AName: String;
      var AValue: String);
    procedure SimpleMakeTemporyFDConnection(Server, User, Password: String;
      OsAuthent: Boolean);
    procedure SimpleSaveSettingString(ASection, AName, AValue: String);
  end;

var
  SCMBuildMeADataBase: TSCMBuildMeADataBase;

const
  logOutFn = '\Documents\SCM_BuildMeAClub.log';
  SectionName = 'SCM_BuildMeAClub';
  logOutFnTmp = '\Documents\SCM_BuildMeAClub.tmp';
  defSubPath = 'BMAC_SCRIPTS\';

implementation

{$R *.dfm}

uses utilVersion, System.IniFiles, System.Math, Vcl.FileCtrl,
  dlgSelectBuild;

procedure TSCMBuildMeADataBase.actnBMACExecute(Sender: TObject);
var
  sl: TStringList;
  s, Str, fp, fn: String;
  errCount, errCode: Integer;
  mr: TModalResult;
  success: Boolean;
  fScriptPath: string;
begin
  // UPDATE THE DATABASE...
  progressBar.Position := 0;
  progressBar.Min := 0;
  btnBMAC.Visible := false;
  Memo1.Clear;

  if not scmConnection.Connected then exit;
  if not Assigned(fSelectedBuildConfig) then exit;


  // ---------------------------------------------------------------
  // Does the SwimClubMeet database already exists on MS SQLEXPRESS?
  // ---------------------------------------------------------------
  qryDBExists.Open;
  if qryDBExists.Active then
  begin
    errCount := qryDBExists.FieldByName('Result').AsInteger;
    qryDBExists.Close;
    // non zero value indicates SwimClubMeet already exists.
    if not(errCount = 0) then
    begin
      // {$IFNDEF DEBUG}  // grant developer's permission
      // SwimClubMeet exists!
      s := 'A SwimClubMeet database already exists!' + sLineBreak +
        'Cannot overwrite the current swimming club.' + sLineBreak +
        'Press EXIT when ready.';
      MessageDlg(s, TMsgDlgType.mtError, [mbOk], 0);
      // only one shot at building granted
      btnBMAC.Visible := false;
      BuildDone := true;
      Memo1.Lines.Add(s);
      exit;
      // {$ENDIF}
    end;

  end;

  success := ExecuteProcess('sqlcmd.exe', '-?', '', true, true, true, errCode);

  if not success then
  begin
    s := 'The application ''sqlcmd.exe'' wasn''t found!' + sLineBreak +
      'The MS SQLEXPRESS utility is missing.' + sLineBreak +
      'Press EXIT when ready.';
    MessageDlg(s, TMsgDlgType.mtError, [mbOk], 0);
    // only one shot at building granted
    btnBMAC.Visible := false;
    BuildDone := true;
    Memo1.Lines.Add(s);
    exit;
  end;

    fScriptPath := IncludeTrailingPathDelimiter
    (ExtractFilePath(fSelectedBuildConfig.FileName));

  // DOES PATH EXISTS?
  if not System.SysUtils.DirectoryExists(fScriptPath, true) then
  begin
    s := 'The folder containing the build scripts is missing!' + sLineBreak +
      'Cannot continue with building a swimming club.' + sLineBreak +
      'Press EXIT when ready.';
    MessageDlg(s, TMsgDlgType.mtError, [mbOk], 0);
    // only one shot at building granted
    btnBMAC.Visible := false;
    BuildDone := true;
    Memo1.Lines.Add(s);
    exit;
  end;

  // Look for SQL file to execute ...
  sl := TStringList.Create;
  GetFileList(fScriptPath, '*.SQL', sl);
  sl.Sort; // Perform an ANSI sort

  // Are there SQL files in this directory?
  if sl.Count = 0 then
  begin
    s := 'No build scripts to run!' + sLineBreak +
      'Unable to build a swimming club. Press EXIT when ready.';
    MessageDlg(s, TMsgDlgType.mtError, [mbOk], 0);
    // only one shot at building granted
    btnBMAC.Visible := false;
    BuildDone := true;
    FreeAndNil(sl);
    Memo1.Lines.Add(s);
    exit;
  end;

  // Final message before running executing
  s := 'Found ' + IntToStr(sl.Count) + ' scripts to run.' + sLineBreak +
    'Select yes to start building a swimming club.';
  mr := MessageDlg(s, TMsgDlgType.mtConfirmation, [mbNo, mbYes], 0);
  if mr = mrYes then
  begin
    progressBar.Visible := true;
    progressBar.Max := sl.Count;
    errCount := 0;
    // echo message in memopad
    Memo1.Lines.Add('Found ' + IntToStr(sl.Count) + ' scripts to run.');
    Str := GetEnvironmentVariable('USERPROFILE') + logOutFn;
    Memo1.Lines.Add('Sending log to ' + Str + sLineBreak);

    // clear the log file
    if FileExists(Str) then DeleteFile(Str);

    for fp in sl do
    begin
      // get filename ...
      fn := ExtractFileName(fp);
      // display the info and break
      Memo1.Lines.Add(fn);

      // -------------------------------------------------------------------
      // SQL file, servername, rtn errCode, run silent, create log file ...
      // -------------------------------------------------------------------
      success := ExecuteProcessSQLcmd(fp, edtServerName.Text, edtUser.Text,
        edtPassword.Text, errCode, chkbUseOSAuthentication.Checked, true, true);
      // -------------------------------------------------------------------

      if not success then
      begin
        errCount := errCount + 1;
        Memo1.Lines.Add('Error: ' + IntToStr(errCode) + fn);
      end;

      progressBar.Position := progressBar.Position + 1;
    end;
    Memo1.Lines.Add(sLineBreak + 'FINISHED');
    if errCount = 0 then
    begin
      // green 'tick' checkbox
      vimgPassed.Visible := true;

      // * Version number of SwimClubMeet DataBase *
      // Only read this table if not errors reported.
      GetSCM_DB_Version;
      s := 'QUERY: SwimClubMeet database version ... ' + FDBVerCtrlStr;
      Memo1.Lines.Add(s);

      Memo1.Lines.Add('ExecuteProcess completed without errors.' + sLineBreak);
      Memo1.Lines.Add
        ('You should check SCM_BuildMeAClub.log to ensure that sqlcmd.exe also reported no errors.'
        + sLineBreak);
    end
    else
    begin
      Memo1.Lines.Add('ExecuteProcess reported: ' + IntToStr(errCount) +
        ' errors.' + sLineBreak);
      Memo1.Lines.Add('View the SCM_BuildMeAClub.log for sqlcmd.exe errors.' +
        sLineBreak);
    end;
    // only one shot at building granted
    btnBMAC.Visible := false;
    BuildDone := true;
    progressBar.Visible := false;

    // finished with database - do a disconnect? (But it hides the Memo1 cntrl)
    Memo1.Lines.Add(sLineBreak +
      'BuildMeAClub has completed. Press EXIT when ready.');
  end
  else
    // we had scripts ... but user didn't do a build
      btnBMAC.Visible := true;

  FreeAndNil(sl);

end;

procedure TSCMBuildMeADataBase.actnBMACUpdate(Sender: TObject);
begin

  if scmConnection.Connected then
  begin
    if not btnBMAC.Visible then btnBMAC.Visible := true;
  end
  else
  begin
    if btnBMAC.Visible then btnBMAC.Visible := false;
  end;

  // stops UI flickering if enable state is tested before changing.
  if BuildDone then // re-run the application to build again
  begin
    if btnBMAC.Enabled then btnBMAC.Enabled := false;
    exit;
  end;

  if not Assigned(fSelectedBuildConfig) then
  begin
    if btnBMAC.Enabled then btnBMAC.Enabled := false;
    exit;
  end;

  if not btnBMAC.Enabled then  btnBMAC.Enabled := true;
end;

procedure TSCMBuildMeADataBase.actnConnectExecute(Sender: TObject);
begin
  if edtServerName.Text = '' then exit;
  if not chkbUseOSAuthentication.Checked then
    if edtUser.Text = '' then exit;

  // attempt a 'simple' connection to SQLEXPRESS
  SimpleMakeTemporyFDConnection(edtServerName.Text, edtUser.Text,
    edtPassword.Text, chkbUseOSAuthentication.Checked);
  if scmConnection.Connected then
  begin
    Memo1.Clear;
    Memo1.Lines.Add('Connected to master on MSSQL');
    if not BuildDone then
    begin
      if not Assigned(fSelectedBuildConfig) then
          Memo1.Lines.Add('READY ... Press ''Select Database'' to continue.')
      else Memo1.Lines.Add('READY ... Press ''Build Me A Club'' to continue.');
    end
    else Memo1.Lines.Add('READY ...');
  end;
  // REQUIRED: update button state.
  actnDisconnect.Update;
  actnBMAC.Update;
end;

procedure TSCMBuildMeADataBase.actnConnectUpdate(Sender: TObject);
begin
  // update TCONTROL visibility
  if scmConnection.Connected then
  begin
    if btnConnect.Visible then btnConnect.Visible := false;
  end
  else
  begin
    if not btnConnect.Visible then btnConnect.Visible := true;
  end;
end;

procedure TSCMBuildMeADataBase.actnDisconnectExecute(Sender: TObject);
begin
  // disconnect
  scmConnection.Close;
  Memo1.Clear;
  Memo1.Lines.Add('Disconnected ...' + sLineBreak);
  // REQUIRED: update button state.
  actnConnect.Update;
  actnBMAC.Update;
end;

procedure TSCMBuildMeADataBase.actnDisconnectUpdate(Sender: TObject);
begin
  // update TCONTROL visibility
  if scmConnection.Connected then
  begin
    if not btnDisconnect.Visible then btnDisconnect.Visible := true;
  end
  else
  begin
    if btnDisconnect.Visible then btnDisconnect.Visible := false;
  end;
end;

procedure TSCMBuildMeADataBase.actnSelectDataBaseExecute(Sender: TObject);
{
NOTES:
  Build Congiguration :
    - PATCH is ignored.
    - BuildOUT is ignored
}
var
  dlg: TSelectBuild;
  rootDIR, s: string;
begin
  lblDatabaseVersion.Caption := '';
  fSelectedBuildConfig := nil;

  Memo1.Clear;

  // DEFAULT:
  // BUILDMEACLUB USES THE SUB-FOLDER WITHIN IT'S EXE PATH
  // ---------------------------------------------------------------
{$IFDEF DEBUG}
  rootDIR := TPath.GetDocumentsPath + '\GitHub\SCM_ERStudio\' +
    IncludeTrailingPathDelimiter(defSubPath);
{$ELSE}
  // up to and including the colon or backslash .... SAFE
  rootDIR := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName))
    + IncludeTrailingPathDelimiter(defSubPath);
{$IFEND}

  // DOES PATH EXISTS?
  if not System.SysUtils.DirectoryExists(rootDIR, true) then
  begin
    s := 'The build scripts sub-folder is missing!' + sLineBreak +
      '(Default name : ''#EXEPATH#\BMAC_SCRIPTS\''.)' + sLineBreak +
      'Cannot continue. Missing BMAC system sub-folder.' + sLineBreak +
      'Press EXIT when ready.';
    MessageDlg(s, TMsgDlgType.mtError, [mbOk], 0);
    // only one shot at building granted
    btnBMAC.Visible := false;
    BuildDone := true;
    Memo1.Lines.Add(s);
    exit;
  end;

  // Let the user select a database build configuration.
  dlg := TSelectBuild.Create(self);
  dlg.RootPath := rootDIR;
  dlg.ConfigList := BuildConfigList;
  var mr: TModalResult;
  mr := dlg.ShowModal;
  if IsPositiveResult(mr) then
  begin
    if Assigned(dlg.SelectedConfig) then
        fSelectedBuildConfig := dlg.SelectedConfig;
  end;
  dlg.Free;

  if Assigned(fSelectedBuildConfig) then
  begin
    lblDatabaseVersion.Caption := fSelectedBuildConfig.GetVersionStr(bvIN);
    s := '';
    if fSelectedBuildConfig.IsRelease then
      s := 'Release '
    else
      s := 'Pre-Release ';
    {
      // create database ignores this switch
      if fSelectedBuildConfig.IsPatch = true then
            s := s + 'Patch ';
    }
    if fSelectedBuildConfig.IsDepreciated = true then
      s := s + 'Depreciated ';

    lblPreRelease.Caption := s;

  end
  else
  begin
    lblDatabaseVersion.Caption := '';
    lblPreRelease.Caption := '';
  end;

  Memo1.Lines.Add('Selection done. READY ...');

end;

procedure TSCMBuildMeADataBase.actnSelectDataBaseUpdate(Sender: TObject);
begin
  if Assigned(fSelectedBuildConfig) then
  begin
    lblDatabaseVersion.Visible := true;
    lblPreRelease.Visible := true;
  end
  else
  begin
    lblDatabaseVersion.Visible := false;
    lblPreRelease.Visible := false;
  end;
end;

procedure TSCMBuildMeADataBase.btnCancelClick(Sender: TObject);
begin
  scmConnection.Close;
  ModalResult := mrCancel;
  Close;
end;

function TSCMBuildMeADataBase.ExecuteProcess(const FileName, Params: string;
  Folder: string; WaitUntilTerminated, WaitUntilIdle, RunMinimized: Boolean;
  var ErrorCode: Integer): Boolean;
var
  cmdLine: string;
  WorkingDirP: PChar;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
begin
  Result := true;
  cmdLine := '"' + FileName + '" ' + Params;
  if Folder = '' then
      Folder := ExcludeTrailingPathDelimiter(ExtractFilePath(FileName));
  ZeroMemory(@StartupInfo, SizeOf(StartupInfo));
  StartupInfo.cb := SizeOf(StartupInfo);
  if RunMinimized then
  begin
    StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
    StartupInfo.wShowWindow := SW_SHOWMINIMIZED;
  end;
  if Folder <> '' then WorkingDirP := PChar(Folder)
  else WorkingDirP := nil;
  if not CreateProcess(nil, PChar(cmdLine), nil, nil, false, 0, nil,
    WorkingDirP, StartupInfo, ProcessInfo) then
  begin
    Result := false;
    ErrorCode := GetLastError;
    exit;
  end;
  with ProcessInfo do
  begin
    CloseHandle(hThread); // CHECK - CLOSE HERE? or move line down?
    if WaitUntilIdle then WaitForInputIdle(hProcess, INFINITE);
    // CHECK ::WaitUntilTerminated was used in C++ sqlcmd.exe
    if WaitUntilTerminated then
      repeat Application.ProcessMessages;
      until MsgWaitForMultipleObjects(1, hProcess, false, INFINITE, QS_ALLINPUT)
        <> WAIT_OBJECT_0 + 1;
    CloseHandle(hProcess);
    // CHECK :: CloseHandle(hThread); was originally placed here in C++ ...
  end;

end;

function TSCMBuildMeADataBase.ExecuteProcessSQLcmd(SQLFile, ServerName,
  UserName, Password: String; var errCode: Integer; UseOSAthent: Boolean;
  RunMinimized: Boolean; Log: Boolean): Boolean;
var
  Param: String;
  logOutFile, logOutFileTmp, quotedSQLFile: String;
  passed: Boolean;

  Str: string;
  F1, F2: TextFile;

begin
  Result := false;   // initialise as failed
  errCode := 0;

  // the string isn't empty
  if SQLFile.IsEmpty then exit;

  quotedSQLFile := AnsiQuotedStr(SQLFile, '"');
  {
    NOTE: -S [protocol:]server[instance_name][,port]
    NOTE: -E is not specified because it is the default and sqlcmd
    connects to the default instance by using Windows Authentication.
    TODO: include name and password authentication.
    NOTE: -i input file
    NOTE: -V (uppercase V)  error_severity_level. Any error above value
    will be reported
  }

  // ServerName ...
  Param := '-S ' + ServerName;
  if UseOSAthent then
    // using windows OS Authentication
      Param := Param + ' -E '
  else
    // UserName and Password
      Param := Param + ' -U ' + UserName + ' -P ' + Password;
  // input file
  Param := Param + ' -i ' + quotedSQLFile + ' ';

  if Log then
  begin
    Str := GetEnvironmentVariable('USERPROFILE');
    logOutFile := Str + logOutFn;
    logOutFileTmp := Str + logOutFnTmp;
    // ENSURE an ouput file exist else the PIPE redirection won't work.
    if not FileExists(logOutFile) then
    begin
      AssignFile(F2, logOutFile);
      // create a header string with some useful info.
      Str := 'SwimClubMeet BuildMeAClub log file ' +
        FormatDateTime('dd/mmmm/yyyy hh:nn', Now);
      Rewrite(F2);
      Writeln(F2, Str);
      CloseFile(F2);
    end;
    // ... surround output file in quotes
    quotedSQLFile := AnsiQuotedStr(logOutFileTmp, '"');
    Param := Param + ' -o ' + quotedSQLFile + ' ';
    // DRATS!!!! NOT WORKING :-(
    // NOTE: Last in param list - PIPE - APPEND TO EXISTING FILE.
    // Param := Param + ' >> ' + logOutFileTmp + ' ';
  end;

  // ---------------------------------------------------------------
  // Folder param(3) not required. Wait until process is completed.
  // ---------------------------------------------------------------
  passed := ExecuteProcess('sqlcmd.exe', Param, '', true, true,
    RunMinimized, errCode);

  if (Log) then
  begin
    if (FileExists(logOutFileTmp) = true) and (FileExists(logOutFile) = true)
    then
    begin
      AssignFile(F1, logOutFileTmp);
      AssignFile(F2, logOutFile);
      Reset(F1);
      Append(F2);

      while not(EOF(F1)) do
      begin
        Readln(F1, Str);
        Writeln(F2, Str);
      end;
      CloseFile(F1);
      CloseFile(F2);
      DeleteFile(logOutFileTmp);
    end;
  end;

  if passed then Result := true; // flag success

end;

procedure TSCMBuildMeADataBase.FormCreate(Sender: TObject);
begin
  BuildDone := false; // clear BMAC critical error flag
  // Prepare the display
  GroupBox1.Visible := true;
  btnConnect.Visible := true;
  progressBar.Visible := false;
  btnBMAC.Visible := false;
  btnDisconnect.Visible := false;
  LoadConfigData;
  // green 'tick' checkbox
  vimgPassed.Visible := false;

  // Memo already populated with useful user info... indicate ready...
  Memo1.Lines.Add('READY ...');
  // init DB version control
  FDBVersion := 0;
  FDBMajor := 0;
  FDBMinor := 0;
  FDBVerCtrlStr := '';
  FDBVerCtrlStrVerbose := '';

  // SwimClubMeet database version number
  lblDatabaseVersion.Caption := '';

  // Object to hold all the info on each build variant.
  // Info extracted from the file, SCM_Config.ini
  // Object includes the SQL folder path
  fSelectedBuildConfig := nil;
  // A custom collection. Contains TUDBConfig objects
  BuildConfigList := TObjectList<TscmBuildConfig>.Create(true); // owns object

end;

procedure TSCMBuildMeADataBase.FormDestroy(Sender: TObject);
begin
  // release custom class data.
  BuildConfigList.Clear;
  BuildConfigList.Free;
end;

procedure TSCMBuildMeADataBase.GetFileList(filePath, fileMask: String;
  var sl: TStringList);
var
  List: TStringDynArray;
  searchOption: TSearchOption;
  fn: String;
begin
  searchOption := TSearchOption.soTopDirectoryOnly;
  try
    List := TDirectory.GetFiles(filePath, fileMask, searchOption);
  except
    // Not expecting errors as the filePath has been asserted.
    // Catch unexpected exceptions.
    on E: Exception do
    begin
      MessageDlg('Incorrect path or search mask', mtError, [mbOk], 0);
      exit;
    end
  end;
  // * Populate the stringlist with matching filenames
  sl.Clear();
  for fn in List do sl.Add(fn);
end;

procedure TSCMBuildMeADataBase.GetSCM_DB_Version();
var
  fld: TField;
begin
  FDBModel := 0;
  FDBVersion := 0;
  FDBMajor := 0;
  FDBMinor := 0;
  FDBVerCtrlStr := '';
  FDBVerCtrlStrVerbose := '';
  if scmConnection.Connected then
  begin
    // opening and closing a query performs a full refresh.
    qryVersion.Close;
    qryVersion.Open;
    if qryVersion.Active then
    begin
      FDBModel := qryVersion.FieldByName('SCMSystemID').AsInteger;
      FDBVersion := qryVersion.FieldByName('DBVersion').AsInteger;
      fld := qryVersion.FieldByName('Major');
      if Assigned(fld) then
      begin
        FDBMajor := fld.AsInteger;
      end;
      fld := qryVersion.FieldByName('Minor');
      if Assigned(fld) then
      begin
        FDBMinor := fld.AsInteger;
      end;
      // DISPLAY STRINGS
      FDBVerCtrlStr := IntToStr(FDBModel) + '.' + IntToStr(FDBVersion) + '.' +
        IntToStr(FDBMajor) + '.' + IntToStr(FDBMinor) + '.';
      FDBVerCtrlStrVerbose := 'Base: ' + IntToStr(FDBModel) + ' Version: ' +
        IntToStr(FDBVersion) + ' Major: ' + IntToStr(FDBMajor) + ' Minor: ' +
        IntToStr(FDBMinor)
    end;
  end;

end;

{$REGION 'SIMPLE LOAD ROUTINES FOR TEMPORY FDAC CONNECTION'}

procedure TSCMBuildMeADataBase.LoadConfigData;
var
  ASection: string;
  Server: string;
  User: string;
  Password: string;
  AValue: string;
  AName: string;

begin
  ASection := SectionName;
  AName := 'Server';
  SimpleLoadSettingString(ASection, AName, Server);
  if Server.IsEmpty then edtServerName.Text := 'localHost\SQLEXPRESS'
  else edtServerName.Text := Server;
  AName := 'User';
  SimpleLoadSettingString(ASection, AName, User);
  edtUser.Text := User;
  AName := 'Password';
  SimpleLoadSettingString(ASection, AName, Password);
  edtPassword.Text := Password;
  AName := 'OSAuthent';
  SimpleLoadSettingString(ASection, AName, AValue);
  if (Pos('y', AValue) <> 0) or (Pos('Y', AValue) <> 0) then
      chkbUseOSAuthentication.Checked := true
  else chkbUseOSAuthentication.Checked := false;
end;

procedure TSCMBuildMeADataBase.SaveConfigData;
var
  ASection, AName, AValue: String;
begin
  begin
    ASection := SectionName;
    AName := 'Server';
    SimpleSaveSettingString(ASection, AName, edtServerName.Text);
    AName := 'User';
    SimpleSaveSettingString(ASection, AName, edtUser.Text);
    AName := 'Password';
    SimpleSaveSettingString(ASection, AName, edtPassword.Text);
    AName := 'OSAuthent';
    if chkbUseOSAuthentication.Checked = true then AValue := 'Yes'
    else AValue := 'No';
    SimpleSaveSettingString(ASection, AName, AValue);
  end

end;

procedure TSCMBuildMeADataBase.SimpleLoadSettingString(ASection, AName: String;
  var AValue: String);
var
  ini: TIniFile;
begin
  // Note: OneDrive enabled: 'Personal'
  // The routine TPath.GetDocumentsPath normally returns ...
  // C:\Users\<username>\Documents (Windows Vista or later)
  // but is instead mapped to C:\Users\<username>\OneDrive\Documents.
  //
  ini := TIniFile.Create(TPath.GetDocumentsPath + PathDelim +
    SCMCONFIGFILENAME);
  try
    AValue := ini.ReadString(ASection, AName, '');
  finally
    ini.Free;
  end;
end;

procedure TSCMBuildMeADataBase.SimpleMakeTemporyFDConnection(Server, User,
  Password: String; OsAuthent: Boolean);
var
  Value: String;
begin

  if Server.IsEmpty then exit;

  if not OsAuthent then
    if User.IsEmpty then exit;

  if (scmConnection.Connected) then scmConnection.Connected := false;

  // REQUIRED for multi-login attempts
  scmConnection.Params.Clear();

  scmConnection.Params.Add('Server=' + Server);
  scmConnection.Params.Add('DriverID=MSSQL');
  // NOTE SwimClubMeet doesn't exist - so we must connect to root.
  scmConnection.Params.Add('Database=master');
  scmConnection.Params.Add('User_name=' + User);
  scmConnection.Params.Add('Password=' + Password);
  if OsAuthent then Value := 'Yes'
  else Value := 'No';
  scmConnection.Params.Add('OSAuthent=' + Value);
  scmConnection.Params.Add('Mars=yes');
  scmConnection.Params.Add('MetaDefSchema=dbo');
  scmConnection.Params.Add('ExtendedMetadata=False');
  scmConnection.Params.Add('Encrypt=No');
  scmConnection.Params.Add('ODBCAdvanced=Encrypt=no;Trust Server');
  scmConnection.Params.Add('Certificate =Yes');
  scmConnection.Params.Add('ApplicationName=SCM_BuildMeAClub');

  // FINALLY PERFORM THE CONNECTION
  scmConnection.Connected := true;

  // ON SUCCESS - Save connection details.
  if scmConnection.Connected Then SaveConfigData;
end;

procedure TSCMBuildMeADataBase.SimpleSaveSettingString(ASection, AName,
  AValue: String);
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(TPath.GetDocumentsPath + PathDelim +
    SCMCONFIGFILENAME);
  try
    ini.WriteString(ASection, AName, AValue);
  finally
    ini.Free;
  end;

end;

{$ENDREGION}

end.
