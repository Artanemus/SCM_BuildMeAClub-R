unit frmMain;

// this definition determines the SQL folder used by the build of BMAC
{$Define SCMSQLVER1.1.1}

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
  FireDAC.Phys.MSSQL;

type
  TMain = class(TForm)
    prefServer: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    prefUser: TEdit;
    Label3: TLabel;
    prefPassword: TEdit;
    prefUseOSAuthentication: TCheckBox;
    Panel1: TPanel;
    btnCancel: TButton;
    btnOk: TButton;
    FDConnection1: TFDConnection;
    Memo1: TMemo;
    ProgressBar1: TProgressBar;
    FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
    function AddTempConnectionDef(): boolean;
    function DeleteTempConnectionDef(): boolean;
    function ExecuteSQLcmdProcess(SQLFile: String; ServerName: String): boolean;
    function ExecuteRegKeyProcess(RegKeyFIle: String): boolean;
    function ExecuteProcess(const FileName, Params: string; Folder: string;
      WaitUntilTerminated, WaitUntilIdle, RunMinimized: boolean;
      var ErrorCode: integer): boolean;
    procedure GetFileList(filePath, fileMask: String; var sl: TStringList);
    function GetRegistryAppPath(appName: String): String;
    function GetSQLPath(var SQLPath: String): boolean;
    function ProcessSQLFiles(): boolean;
    function ProcessREGFiles(): boolean;

  public
    { Public declarations }
  end;

var
  Main: TMain;

const
  TempConnectionDefName = 'MSSQL_Master';
  AppPathKeyName = '\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\';
{$IFDEF SCMSQLVER1.1.1}
  SQLFolder = 'SQLV010101';
  SQLVersion = '1.1.1';
  SQLDescription = 'Build a SwimClubMeet DB V1.1.1 for MSSQL';
{$ENDIF}

implementation

{$R *.dfm}

uses utilVersion;

/// <remarks>
/// [MSSQL_SwimClubMeet]
/// Database=SwimClubMeet
/// OSAuthent=Yes
/// Server=DESKTOP-PNP1I3O
/// DriverID=MSSQL
/// MetaDefSchema=dbo
/// ExtendedMetadata=False
/// MetaDefCatalog=
/// ApplicationName=SwimClubMeet
/// Workstation=DESKTOP-PNP1I3O
/// MARS=yes
/// User_Name=
/// Password=
/// </remarks>

function TMain.AddTempConnectionDef: boolean;

var
  oList: TStringList;

begin
  Result := true;

  oList := TStringList.Create;
  oList.Add('Server=' + prefServer.Text);
  oList.Add('Database=master');
  oList.Add('MetaDefSchema=dbo');
  oList.Add('ExtendedMetadata=False');
  oList.Add('MARS=yes');

  if prefUseOSAuthentication.Checked then
  begin
    oList.Add('OSAuthent=Yes');
  end
  else
  begin
    oList.Add('Password=' + prefPassword.Text);
    oList.Add('User_Name=' + prefUser.Text);
  end;

  // open a tempory connection.
  try
    FDManager.AddConnectionDef(TempConnectionDefName, 'MSSQL', oList);

  except
    on E: Exception do
    begin
      MessageDlg('FDManger:' + sLineBreak +
        'A tempory connection definition couldn''t be added.', mtError,
        [mbOk], 0);
      Result := false;
    end;

  end;

  oList.Free;

end;

procedure TMain.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TMain.btnOkClick(Sender: TObject);
var
  sql: String;
  dbstr: String;
  ID: Variant;
  passed: boolean;

begin

  // add a tempory connection using the params entered.
  passed := AddTempConnectionDef;
  if not passed then
    exit;

  // test the tempory connection
  FDConnection1.ConnectionDefName := TempConnectionDefName;
  try
    FDConnection1.Connected := true;
  except
    on E: EMSSQLNativeException do
    begin
      MessageDlg('FDConnection:' + sLineBreak + 'EMS SQL Native exception.' +
        sLineBreak + E.Message, mtError, [mbOk], 0);
    end
    else
    begin
      MessageDlg('FDConnection:' + sLineBreak +
        'The connection couldn''t be made.', mtError, [mbOk], 0);
    end;

    (*
      on E: EFDException do
      // only valid when using FireDAC's login dialogue
      if E.FDCode = er_FD_ClntDbLoginAborted then
      begin
      MessageDlg('FDConnection:' + sLineBreak +
      'User pressed Cancel button in Login dialog.', mtError, [mbOk], 0);
      passed := false;
      end;
      on E: EFDDBEngineException do
      case E.Kind of
      ekUserPwdInvalid:
      MessageDlg('FDConnection:' + sLineBreak +
      'User name or password are incorrect.', mtError, [mbOk], 0);
      ekUserPwdExpired:
      begin
      MessageDlg('FDConnection:' + sLineBreak +
      'User password is expired.', mtError, [mbOk], 0);
      passed := false;
      end;
      ekServerGone:
      begin
      MessageDlg('FDConnection:' + sLineBreak +
      'DBMS is not accessible due to some reason.', mtError, [mbOk], 0);
      passed := false;
      end;
      else // other issues
      begin
      MessageDlg('FDConnection:' + sLineBreak +
      'The connection couldn''t be made.', mtError, [mbOk], 0);
      passed := false;
      end;
      end;
    *)

  end;

  if FDConnection1.Connected then
  begin
    {
      ... test that SwimClubMeet doesn't exist.
      ExecSQLScalar returns the value of the first column in the
      first row of the first result set
    }
    // used later in connection query
    dbstr := 'SwimClubMeet';
    sql := 'SELECT ID = DB_ID(' + quotedstr(dbstr) + ')';
    ID := FDConnection1.ExecSQLScalar(sql);
    // DB SwimClubMeet not found ... proceed
    if (ID = NULL) then
    begin
      Memo1.Clear;
      btnOk.Enabled := false;
      Memo1.Lines.Add('BMAC: Build begin:');
      ProcessSQLFiles;
      ProcessREGFiles;
      Memo1.Lines.Add('BMAC: Build end:');
      MessageDlg('BMAC:' + sLineBreak + 'All tasks were completed.' + sLineBreak
        + 'Press Cancel to exit BMAC.', mtInformation, [mbOk], 0);
    end
    else
    begin
      Memo1.Clear;
      btnOk.Enabled := false;
      MessageDlg('MSSQL:' + sLineBreak +
        'The SwimClubMeet database already exists.' + sLineBreak +
        'BMAC cannot proceed.', mtError, [mbOk], 0);
      // end application
      Close;
    end;

  end;

  // clean FDManager
  DeleteTempConnectionDef;

end;

procedure TMain.FormCreate(Sender: TObject);
var
  SQLPath, fn, fp: String;
  sl: TStringList;
  success: boolean;

begin
  // display the version number of this application in the title bar
  Caption := 'BuildMeAClub ver' + utilVersion.ProductVersion;
  Memo1.Clear;
  sl := TStringList.Create;
  ProgressBar1.Visible := false;
  // see const for SQL file path required
  success := GetSQLPath(SQLPath);
  if success then
  begin
    GetFileList(SQLPath, '*.txt', sl);
  end
  else
  begin
    Memo1.Lines.Add
      ('Unable to locate the SQL folder required to construct the');
    Memo1.Lines.Add
      ('MSSQL database that is paired to this version of SwimClubMeet.');
    Memo1.Lines.Add('');
    Memo1.Lines.Add('Press close to exit BuildMeAClub.');
    sl.Free;
    // let user close applicaiton - Application.Terminate;
    btnOk.Enabled := false;
    btnCancel.Caption := 'Close';
    exit;
  end;

  // found path .. look for readme text and load
  if success and (sl.Count <> 0) then
  begin
    for fp in sl do
    begin
      fn := ExtractFileName(fp);
      if CompareText(fn, 'readme.txt') = 0 then
      begin
        Memo1.Lines.LoadFromFile(fp);
        break;
      end;
    end;
  end
  else
    MessageDlg('MESSAGE: ' + sLineBreak + 'No readme.txt file found for BMAC.',
      mtInformation, [mbOk], 0);
  sl.Free;
end;

procedure TMain.GetFileList(filePath, fileMask: String; var sl: TStringList);

var
  list: TStringDynArray;
  // list: array of String;

  searchOption: TSearchOption;
  fn: String;

begin
  {
    ** Select the search option **
    if (cbDoRecursive->Checked)
    searchOption = TSearchOption::soAllDirectories;
    else
  }
  searchOption := TSearchOption.soTopDirectoryOnly;

  try

    {
      ** For all entries use GetFileSystemEntries method **
      if (cbIncludeDirectories->Checked && cbIncludeFiles->Checked)
      list = TDirectory::GetFileSystemEntries(edtPath->Text, searchOption, NULL);

      ** For directories use GetDirectories method **
      if (cbIncludeDirectories->Checked && !cbIncludeFiles->Checked)
      list = TDirectory::GetDirectories(edtPath->Text, edtFileMask->Text, searchOption);

      ** For files use GetFiles method **
      if (!cbIncludeDirectories->Checked && cbIncludeFiles->Checked)
    }
    list := TDirectory.GetFiles(filePath, fileMask, searchOption);

  except
    // Catch the possible exceptions
    on E: Exception do
    begin
      MessageDlg('Incorrect path or search mask', mtError, [mbOk], 0);
      exit;
    end

  end;

  // * Populate the stringlist with matching filenames
  sl.Clear();
  for fn in list do
  begin
    sl.Add(fn);
  end;

end;

function TMain.GetRegistryAppPath(appName: String): String;
var
  reg: TRegistry;
  // AppPathKeyName
  rtnStr, KeyName: String;

begin
  rtnStr := '';
  KeyName := AppPathKeyName + appName + '\';

  reg := TRegistry.Create(KEY_READ);
  try
    reg.RootKey := HKEY_LOCAL_MACHINE;
    if reg.KeyExists(KeyName) then
    begin
      // param false - don't create key - even if it doesn't exists
      reg.OpenKey(KeyName, false);
      rtnStr := reg.ReadString('Path');
    end;
  finally
    reg.Free;
  end;

  Result := rtnStr;

end;

function TMain.GetSQLPath(var SQLPath: String): boolean;
var
  success: boolean;
  AppPath: String;
  s: String;
  i: integer;

begin
  success := false;
  SQLPath := '';

  AppPath := GetRegistryAppPath('SwimClubMeet.exe');

  if not AppPath.IsEmpty then
  begin
    s := ExtractFilePath(AppPath);
    i := s.IndexOf('SCM');
    if i <> -1 then
    begin
      // cd to SCM root directory
      s := s.Substring(0, i) + SQLFolder;
      s := IncludeTrailingPathDelimiter(s);
      if DirectoryExists(s) then
      begin
        SQLPath := s;
        success := true;
      end
      else
        MessageDlg('SQL Path: ' + sLineBreak + 'Directory doesn''t exist.',
          mtError, [mbOk], 0);

    end
    else
      MessageDlg('SQL Path: ' + sLineBreak + 'Substring BMAC not found.',
        mtError, [mbOk], 0);

  end
  else
    MessageDlg('SQL Path: ' + sLineBreak +
      'SwimClubMeet ''App Path'' in registry not found.', mtError, [mbOk], 0);

  Result := success;

end;

function TMain.ProcessREGFiles: boolean;
var
  sl: TStringList;
  success: boolean;
  errCount: integer;
  s: String;

begin

  sl := TStringList.Create();
  // all files are prefixed with a padded 3 digit number
  sl.Sorted := true;
  sl.CaseSensitive := false;
  errCount := 0;
  Result := false;
  // find the path to the SQL Folder
  success := GetSQLPath(s);

  if success then
  begin

    GetFileList(s, '*.reg', sl);
    Memo1.Lines.Add('REG Files found :' + IntToStr(sl.Count));
    // no SQL file found
    if sl.Count = 0 then
    begin
      sl.Free;
      exit;
    end;

    ProgressBar1.Max := sl.Count;
    ProgressBar1.Visible := true;

    for s in sl do
    begin

      if FileExists(s) then
      begin
        // line commented for debug ....
        success := ExecuteRegKeyProcess(s);
      end
      else
      begin
        success := false;
      end;

      // If CreateProcess succeeds, the return value is nonzero.
      if success then
      begin
        Memo1.Lines.Add('PROCESSED : ' + ExtractFileName(s));
      end
      else
      begin
        inc(errCount);
        Memo1.Lines.Add('FAILED : ' + ExtractFileName(s));
      end;
      ProgressBar1.Position := ProgressBar1.Position + 1;

      Application.ProcessMessages();

    end;

  end;
  sl.Free;
  if errCount = 0 then
    Result := true
  else
    Result := false;
end;

function TMain.ProcessSQLFiles: boolean;
var
  sl: TStringList;
  success: boolean;
  errCount: integer;
  s: String;

begin

  sl := TStringList.Create();
  // all files are prefixed with a padded 3 digit number
  sl.Sorted := true;
  sl.CaseSensitive := false;
  errCount := 0;
  Result := false;
  // find the path to the SQL Folder
  success := GetSQLPath(s);

  if success then
  begin

    GetFileList(s, '*.sql', sl);
    Memo1.Lines.Add('SQL Files found :' + IntToStr(sl.Count));
    // no SQL file found
    if sl.Count = 0 then
      exit;

    ProgressBar1.Max := sl.Count;
    ProgressBar1.Visible := true;

    for s in sl do
    begin

      if FileExists(s) then
      begin
        // line commented for debug ....
        success := ExecuteSQLcmdProcess(s, prefServer.Text);
      end
      else
      begin
        success := false;
      end;

      // If CreateProcess succeeds, the return value is nonzero.
      if success then
      begin
        Memo1.Lines.Add('PROCESSED : ' + ExtractFileName(s));
      end
      else
      begin
        inc(errCount);
        Memo1.Lines.Add('FAILED : ' + ExtractFileName(s));
      end;

      ProgressBar1.Position := ProgressBar1.Position + 1;

      Application.ProcessMessages();

    end;

  end;

  ProgressBar1.Visible := false;
  sl.Free;

  if errCount = 0 then
    Result := true
  else
    Result := false;

end;

function TMain.DeleteTempConnectionDef: boolean;
begin
  Result := true;
  try
    FDManager.DeleteConnectionDef(TempConnectionDefName);
    // if the specified name is not found, an exception is raised.
  except
    on E: Exception do
    begin
      MessageDlg('FDManger: ' + sLineBreak +
        'The tempory connection definition couldn''t be deleted.', mtError,
        [mbOk], 0);
      Result := false;
    end;
  end;
end;

/// <remarks>
/// EXAMPLE HOW TO CALL PROCEDURE ExecuteProcess(...)
/// var
/// FileName, Parameters, WorkingFolder: string;
/// Error: integer;
/// OK: boolean;
/// begin
/// FileName := 'C:\FullPath\myapp.exe';
/// WorkingFolder := ''; // if empty function will extract path from FileName
/// Parameters := '-p'; // can be empty
/// OK := ExecuteProcess(FileName, Parameters, WorkingFolder, false, false, false, Error);
/// if not OK then ShowMessage('Error: ' + IntToStr(Error));
/// end;
/// </remarks>
function TMain.ExecuteProcess(const FileName, Params: string; Folder: string;
  WaitUntilTerminated, WaitUntilIdle, RunMinimized: boolean;
  var ErrorCode: integer): boolean;
var
  CmdLine: string;
  WorkingDirP: PChar;
  STARTUPINFO: TStartupInfo;
  ProcessInfo: TProcessInformation;
begin
  Result := true;
  CmdLine := '"' + FileName + '" ' + Params;
  if Folder = '' then
    Folder := ExcludeTrailingPathDelimiter(ExtractFilePath(FileName));
  ZeroMemory(@STARTUPINFO, sizeof(STARTUPINFO));
  STARTUPINFO.cb := sizeof(STARTUPINFO);
  if RunMinimized then
  begin
    STARTUPINFO.dwFlags := STARTF_USESHOWWINDOW;
    STARTUPINFO.wShowWindow := SW_SHOWMINIMIZED;
  end;
  if Folder <> '' then
    WorkingDirP := PChar(Folder)
  else
    WorkingDirP := nil;
  if not CreateProcess(nil, PChar(CmdLine), nil, nil, false, 0, nil,
    WorkingDirP, STARTUPINFO, ProcessInfo) then
  begin
    Result := false;
    ErrorCode := GetLastError;
    exit;
  end;
  with ProcessInfo do
  begin
    CloseHandle(hThread);
    if WaitUntilIdle then
      WaitForInputIdle(hProcess, INFINITE);
    if WaitUntilTerminated then
      repeat
        Application.ProcessMessages;
      until MsgWaitForMultipleObjects(1, hProcess, false, INFINITE, QS_ALLINPUT)
        <> WAIT_OBJECT_0 + 1;
    CloseHandle(hProcess);
  end;
end;

function TMain.ExecuteRegKeyProcess(RegKeyFIle: String): boolean;
var
  FileName, Parameters, WorkingFolder, quotedstr: String;
  OK, passed: boolean;
  Error: integer;

begin
  // TShellExecuteInfo info;
  // ShellExecute(0,nil,'regedit.exe',PChar('/s "keyfile.reg"'),nil,0);
  passed := false;

  if not RegKeyFIle.IsEmpty() then
  begin
    quotedstr := AnsiQuotedStr(RegKeyFIle, '"');
    Parameters := '/s' + quotedstr;
    FileName := 'regedit.exe';
    WorkingFolder := '';
    OK := ExecuteProcess(FileName, Parameters, WorkingFolder, true, true,
      false, Error);
    if not OK then
    begin
      MessageDlg('Regedit.exe:' + sLineBreak + 'During registration of ' +
        RegKeyFIle + sLineBreak + 'the process return with error code: ' +
        IntToStr(Error), mtError, [mbOk], 0);
    end
    else
      passed := true;

  end;

  Result := passed;

end;

/// <summary>Run SQLcmd.exe with SQL file and params
/// </summary>
/// <param name="SQLFile">Path + SQL file to be parsed by SQLcmd
/// </param>
/// <param name="ServerName">MSSQL SERVER. (Instance or IP:Port)
/// </param>
/// <remarks>
/// CreateProcess.lpApplicationName ...
/// If the executable module is a 16-bit application, lpApplicationName
/// should be NULL, and the string pointed to by lpCommandLine should
/// specify the executable module as well as its arguments.
/// </remarks>
/// <returns>True if the process completes - otherwise False is returned.
/// </returns>
function TMain.ExecuteSQLcmdProcess(SQLFile, ServerName: String): boolean;
var
  Param: String;
  logOutFile, filePath: String;
  passed: boolean;
  si: STARTUPINFO;
  pi: PROCESS_INFORMATION;
  l: integer;
  buffer: TByteDynArray;
  RunMinimized: boolean;

begin
  // initialise as failed
  Result := false;
  RunMinimized := false;

  // the string isn't empty
  if (SQLFile <> '') then
  begin
    logOutFile := TPath.ChangeExtension(TPath.GetFileName(SQLFile), '.log');
    SQLFile := AnsiQuotedStr(SQLFile, '"');
    {
      NOTE: -E is not specified because it is the default and sqlcmd
      connects to the default instance by using Windows Authentication.
    }
    Param := '-S ';
    Param := Param + ServerName;
    Param := Param + ' -E -i ';
    Param := Param + SQLFile + ' ';

    {$IFDEF DEBUG}
    // ... build log filename - with write permissions
    filePath := IncludeTrailingPathDelimiter(TPath.GetDocumentsPath);
    logOutFile := filePath + logOutFile;
    // ... surround in quotes
    logOutFile := AnsiQuotedStr(logOutFile, '"');
    Memo1.Lines.Add('DEBUG: log file ' + logOutFile);
    // ... output to log file ....
    Param := Param + ' -o ' + logOutFile + ' ';
    {$ENDIF}

    Param := 'sqlcmd.exe ' + Param;
  end

  else
    exit; // Result is false

  // clear the structures
  ZeroMemory(@si, sizeof(si));
  si.cb := sizeof(si);
  ZeroMemory(@pi, sizeof(pi));

  // run silent
  if RunMinimized then
  begin
    si.dwFlags := STARTF_USESHOWWINDOW;
    si.wShowWindow := SW_SHOWMINIMIZED;
  end;

  // Copy to writable buffer (including null terminator)
  // - traps a bug
  l := (Length(Param) + 1) * sizeof(Char);
  SetLength(buffer, l);
  Move(Param[1], buffer[0], l);

  // Start the child process.
  // Windows 10 may require CreateProcessW
  passed := CreateProcess(PChar(nil),
    // lpApplicationName - No module name (use command line)
    @buffer[0], // lpCommandline. Originally coded as... PChar(param),
    nil, // Process handle not inheritable
    nil, // Thread handle not inheritable
    false, // Set handle inheritance to FALSE
    0, // No creation flags
    nil, // Use parent's environment block
    nil, // Use parent's starting directory
    si, // Pointer to STARTUPINFO structure
    pi); // Pointer to PROCESS_INFORMATION structure

  // CreateProcess may have terminated because hProcess initialisation failed.
  if (passed = false) then
    exit; // Result is false

  if (pi.hProcess <> 0) then
  begin
    // Wait until child process exits.
    WaitForSingleObject(pi.hProcess, INFINITE);

    // Close process and thread handles.
    CloseHandle(pi.hProcess);
    CloseHandle(pi.hThread);
    Result := true; // flag success
  end;

end;

end.
