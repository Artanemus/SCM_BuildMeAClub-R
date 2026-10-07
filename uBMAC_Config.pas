unit uBMAC_Config;

interface

uses system.IniFiles, system.SysUtils;

type

  TscmBuildVersion = (bvUnknown, bvIN, bvOUT);

  TBMAC_Config = class(TObject)
  private
    { private declarations }
    fDBName: string; // =SwimClubMeet
    fIsRelease: boolean; // =false
    fIsPatch: boolean;
    fDescription: string; // ="v1.1.5.1 to v1.1.5.2"
    fNotes: string; // ="FINA disqualification codes."

    fBaseOut: integer;  // internal use only
    fVersionOut: integer;  // not used.
    fPatchOut: integer;   // not used.

    // RAD STUDIO VERSIONING
    fMajorOut: integer;
    fMinorOut: integer;
    fReleaseOut: integer;
    fBuildOut: integer;

    fFileName: string;  // full path and filename to UDBConfig.ini
    fIsRetired: Boolean;

  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create; reintroduce;
    destructor Destroy; override;
    procedure LoadIniFile(aFileName: string);
    procedure SaveIniFile(aFileName: string);
    function GetVersionStr(PickVersion: TscmBuildVersion): string;
    function GetScriptPath():string;

    property IsRelease: boolean read fIsRelease;
    property IsPatch: boolean read fIsPatch;
    property IsRetired: boolean read fIsRetired;
    property FileName: string read fFileName write fFileName;
    property Description: string read fDescription;
    property Notes: string read fNotes;
    property DatabaseName: string read fDBName;

    // Base MYSQL, MSSQL, ORACLE, etc
    // Version Used by SwimClubMeet database on MSSQL
    // Major.Minor.Release.Build per RAD Studio
    // Patch number - checks build number before patching...

    // OUT --------------------------------------------------------
    property BaseOUT: integer read fBaseOut;
    property VersionOUT: integer read fVersionOUT;
    property PatchOut: integer read fPatchOut;
    // RAD STUDIO VERSIONING
    property MajorOUT: integer read fMajorOUT;
    property MinorOUT: integer read fMinorOUT;
    property ReleaseOUT: integer read fReleaseOUT;
    property BuildOut: integer read fBuildOut;

  end;

implementation

{ TUDBConfig }

constructor TBMAC_Config.Create;
begin
  inherited;
  fFileName := '';
  fIsRelease := false; // the configuration update is pre-release by default;
  fIsPatch :=  false;


  // OUT --------------------------------------------------------
  fPatchOut := 0;
  fBaseOut := 0;  // internal use only - MYSQL, MSSQL, ORACLE, etc
  fVersionOut := 1;  // Version Used by SwimClubMeet database on MSSQL
  // RAD STUDIO VERSIONING
  fMajorOut := 0;
  fMinorOut := 0;
  fReleaseOut := 0;
  fBuildOut := 0;

end;

destructor TBMAC_Config.Destroy;
begin
  // code
  inherited;
end;

function TBMAC_Config.GetScriptPath: string;
var
  s: string;
begin
  result := '';
  s := ExtractFilePath(FileName);
  s := IncludeTrailingPathDelimiter(s);
  if (Length(s) > 0) then result := s;
end;

function TBMAC_Config.GetVersionStr(PickVersion: TscmBuildVersion): string;
var
  s: string;
begin
  // Used by SwimClubMeet database on MSSQL
  result := '';
  s := '';
  case PickVersion of
    bvUnknown: s := '';
    bvOUT:
      begin
        s := IntToStr(fBaseOut) + '.' + IntToStr(fVersionOut) + '.' +
          IntToStr(fMajorOut) + '.' + IntToStr(fMinorOut);
        if (fPatchOut > 0) then s := s + '.P' + IntToStr(fPatchOut);
      end;
  end;

  if (length(s) > 0) then result := s;
end;

procedure TBMAC_Config.LoadIniFile(aFileName: string);
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(aFileName);
  try
    fDBName := ini.ReadString('BUILDCONFIG', 'DatabaseName', '');
    fIsRelease := ini.ReadBool('BUILDCONFIG', 'IsRelease', False);
    fIsPatch := ini.ReadBool('BUILDCONFIG', 'IsPatch', False);
    fIsRetired := ini.ReadBool('BUILDCONFIG', 'IsRetired', False);
    fDescription := ini.ReadString('BUILDCONFIG', 'Description', '');
    fNotes := ini.ReadString('BUILDCONFIG', 'Notes', '');

    // Convert literal \r\n back into actual line breaks
    fNotes := fNotes.Replace('\r\n', sLineBreak);
    fNotes := fNotes.Replace('\t', #9);

    // OUT --------------------------------------------------------
    fBaseOut := ini.ReadInteger('BUILDOUT', 'Base', 1); // internal use only
    fPatchOut := ini.ReadInteger('BUILDOUT', 'Patch', 0);
    fVersionOut := ini.ReadInteger('BUILDOUT', 'Version', 1);
    // RAD STUDIO VERSIONING
    fMajorOut := ini.ReadInteger('BUILDOUT', 'Major', 0);
    fMinorOut := ini.ReadInteger('BUILDOUT', 'Minor', 0);
    fReleaseOut := ini.ReadInteger('BUILDOUT', 'Release', 0);
    fBuildOut := ini.ReadInteger('BUILDOUT', 'Build', 0);

  finally
    ini.Free;
  end;
end;

procedure TBMAC_Config.SaveIniFile(aFileName: string);
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(aFileName);
  try
    ini.WriteString('BUILDCONFIG', 'DatabaseName', fDBName);
    ini.WriteBool('BUILDCONFIG', 'IsRelease', fIsRelease);
    ini.WriteBool('BUILDCONFIG', 'IsPatch', fIsPatch);
    ini.WriteBool('BUILDCONFIG', 'IsRetired', fIsRetired);
    ini.WriteString('BUILDCONFIG', 'Description', fDescription);

    // Convert actual line breaks to literal \r\n
    fNotes := fNotes.Replace(sLineBreak, '\r\n');
    fNotes := fNotes.Replace(#9, '\t');

    ini.WriteString('BUILDCONFIG', 'Notes', fNotes);

    // OUT --------------------------------------------------------
    ini.WriteInteger('BUILDOUT', 'Base', fBaseOut);  // internal use only
    ini.WriteInteger('BUILDOUT', 'Patch', fPatchOut);
    ini.WriteInteger('BUILDOUT', 'Version', fVersionOut);
    // RAD STUDIO VERSIONING
    ini.WriteInteger('BUILDOUT', 'Major', fMajorOut);
    ini.WriteInteger('BUILDOUT', 'Minor', fMinorOut);
    ini.WriteInteger('BUILDOUT', 'Release', fReleaseOut);
    ini.WriteInteger('BUILDOUT', 'Build', fBuildOut);

  finally
    ini.Free;
  end;
end;

end.
