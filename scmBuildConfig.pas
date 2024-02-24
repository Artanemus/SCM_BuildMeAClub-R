unit scmBuildConfig;

interface

uses system.IniFiles, system.SysUtils;

type

  TscmBuildVersion = (bvUnknown, bvIN, bvOUT);

  TscmBuildConfig = class(TObject)
  private
    { private declarations }
    fDBName: string; // =SwimClubMeet
    fIsRelease: boolean; // =false
    fIsPatch: boolean;
    fDescription: string; // ="v1.1.5.1 to v1.1.5.2"
    fNotes: string; // ="FINA disqualification codes."

    fBaseIn: integer;
    fVersionIn: integer;
    fMajorIn: integer;
    fMinorIn: integer;
    fPatchIn: integer;

    fBaseOut: integer;
    fVersionOut: integer;
    fMajorOut: integer;
    fMinorOut: integer;
    fPatchOut: integer;

    fFileName: string; // full path and filename to UDBConfig.ini

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
    property PatchIn: integer read fPatchIn;
    property PatchOut: integer read fPatchOut;
    property FileName: string read fFileName write fFileName;
    property BaseIN: integer read fBaseIn;
    property VersionIN: integer read fVersionIn;
    property MajorIN: integer read fMajorIn;
    property MinorIN: integer read fMinorIn;
    property Description: string read fDescription;
    property Notes: string read fNotes;
  end;

implementation

{ TUDBConfig }

constructor TscmBuildConfig.Create;
begin
  inherited;
  fIsRelease := false; // the configuration update is pre-release by default;
  fIsPatch :=  false;
  fPatchIn := 0;
  fPatchOut := 0;
  fBaseOut := 0;
  fVersionOut := 1;
  fMajorOut := 0;
  fMinorOut := 0;
  fFileName := '';
end;

destructor TscmBuildConfig.Destroy;
begin
  // code
  inherited;
end;

function TscmBuildConfig.GetScriptPath: string;
var
  s: string;
begin
  result := '';
  s := ExtractFilePath(FileName);
  s := IncludeTrailingPathDelimiter(s);
  if (Length(s) > 0) then result := s;
end;

function TscmBuildConfig.GetVersionStr(PickVersion: TscmBuildVersion): string;
var
  s: string;
begin
  result := '';
  s := '';
  case PickVersion of
    bvUnknown: s := '';
    bvIN:
      begin
        s := IntToStr(fBaseIn) + '.' + IntToStr(fVersionIn) + '.' +
          IntToStr(fMajorIn) + '.' + IntToStr(fMinorIn);
        if (fPatchIn > 0) then s := s + '.P' + IntToStr(fPatchIn);
      end;
    bvOUT:
      begin
        s := IntToStr(fBaseOut) + '.' + IntToStr(fVersionOut) + '.' +
          IntToStr(fMajorOut) + '.' + IntToStr(fMinorOut);
        if (fPatchOut > 0) then s := s + '.P' + IntToStr(fPatchOut);
      end;
  end;

  if (length(s) > 0) then result := s;
end;

procedure TscmBuildConfig.LoadIniFile(aFileName: string);
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(aFileName);
  try
    fDBName := ini.ReadString('BMAC', 'DatabaseName', '');
    fIsRelease := ini.ReadBool('BMAC', 'IsRelease', False);
    fIsPatch := ini.ReadBool('BMAC', 'IsPatch', False);
    fDescription := ini.ReadString('BMAC', 'Description', '');
    fNotes := ini.ReadString('BMAC', 'Notes', '');
    fBaseIn := ini.ReadInteger('BMACIN', 'Base', 1);
    fVersionIn := ini.ReadInteger('BMACIN', 'Version', 1);
    fMajorIn := ini.ReadInteger('BMACIN', 'Major', 0);
    fMinorIn := ini.ReadInteger('BMACIN', 'Minor', 0);
    fPatchIn := ini.ReadInteger('BMACIN', 'PatchIn', 0);
    fBaseOut := ini.ReadInteger('BMACOUT', 'Base', 1);
    fVersionOut := ini.ReadInteger('BMACOUT', 'Version', 1);
    fMajorOut := ini.ReadInteger('BMACOUT', 'Major', 0);
    fMinorOut := ini.ReadInteger('BMACOUT', 'Minor', 0);
    fPatchOut := ini.ReadInteger('BMACOUT', 'PatchOut', 0);
  finally
    ini.Free;
  end;
end;

procedure TscmBuildConfig.SaveIniFile(aFileName: string);
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(aFileName);
  try
    ini.WriteString('BMAC', 'DatabaseName', fDBName);
    ini.WriteBool('BMAC', 'IsRelease', fIsRelease);
    ini.WriteBool('BMAC', 'IsPatch', fIsPatch);
    ini.WriteString('BMAC', 'Description', fDescription);
    ini.WriteString('BMAC', 'Notes', fNotes);
    ini.WriteInteger('BMACIN', 'Base', fBaseIn);
    ini.WriteInteger('BMACIN', 'Version', fVersionIn);
    ini.WriteInteger('BMACIN', 'Major', fMajorIn);
    ini.WriteInteger('BMACIN', 'Minor', fMinorIn);
    ini.WriteInteger('BMACIN', 'Base', fPatchIn);
    ini.WriteInteger('BMACOUT', 'Base', fBaseOut);
    ini.WriteInteger('BMACOUT', 'Version', fVersionOut);
    ini.WriteInteger('BMACOUT', 'Major', fMajorOut);
    ini.WriteInteger('BMACOUT', 'Minor', fMinorOut);
    ini.WriteInteger('BMACOUT', 'Base', fPatchOut);
  finally
    ini.Free;
  end;
end;

end.
