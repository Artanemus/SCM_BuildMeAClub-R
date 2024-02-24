unit dlgSelectBuild;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,  System.Types,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.CheckLst,
  Vcl.ExtCtrls,
  scmBuildConfig, System.Generics.Collections;

type
  TSelectBuild = class(TForm)
    btnCancel: TButton;
    btnOk: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    ListBox1: TListBox;
    pnlNotes: TPanel;
    lblNotes: TLabel;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
  private
    { Private declarations }
    fRootPath: string;
    fConfigList: TObjectList<TscmBuildConfig>;
    fSelectedConfig: TscmBuildConfig;
    function FindFiles(const Path, Masks: string): TStringDynArray;
    procedure InitCheckListBoxItems(const DIR: string;
      ConfigList: TObjectList<TscmBuildConfig>);
  public
    { Public declarations }
    property ConfigList: TObjectList<TscmBuildConfig> write fConfigList;
    property SelectedConfig: TscmBuildConfig read fSelectedConfig;
    property RootPath: string write fRootPath;
  end;

var
  SelectBuild: TSelectBuild;

implementation

{$R *.dfm}

uses
  StrUtils, System.IOUtils, System.Masks;

procedure TSelectBuild.btnCancelClick(Sender: TObject);
begin
  fSelectedConfig := nil;
  ModalResult := mrCancel;
end;

procedure TSelectBuild.btnOkClick(Sender: TObject);
begin
  if (ListBox1.ItemIndex <> -1) then
  begin
    fSelectedConfig := TscmBuildConfig(ListBox1.Items.Objects
      [ListBox1.ItemIndex]);
    ModalResult := mrOK;
  end;
end;

function TSelectBuild.FindFiles(const Path, Masks: string): TStringDynArray;
var
  MaskArray: TStringDynArray;
  Predicate: TDirectory.TFilterPredicate;
begin
  MaskArray := SplitString(Masks, ';');
  Predicate :=
      function(const Path: string; const SearchRec: TSearchRec): Boolean
    var
      Mask: string;
    begin
      for Mask in MaskArray do
        if MatchesMask(SearchRec.Name, Mask) then exit(True);
      exit(false);
    end;
  result := TDirectory.GetFiles(Path, Predicate);
end;

procedure TSelectBuild.FormCreate(Sender: TObject);
begin
  fConfigList := nil;
  fSelectedConfig := nil;
end;

procedure TSelectBuild.FormKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    key := 0;
    btnCancel.Click;
  end;
end;

procedure TSelectBuild.FormShow(Sender: TObject);
begin
  if fRootPath.IsEmpty or not Assigned(fConfigList) then
  begin
    ModalResult := mrCancel;
    Close;
  end;
  InitCheckListBoxItems(fRootPath, fConfigList);
end;

procedure TSelectBuild.InitCheckListBoxItems(const DIR: string;
  ConfigList: TObjectList<TscmBuildConfig>);
var
  Folders: TStringDynArray;
  Files: TStringDynArray;
  aFile, s: string;
  Folder: string;
  Masks: String;
  BuildConfig: TscmBuildConfig;
begin
  Folders := TDirectory.GetDirectories(DIR);
  ListBox1.Items.Clear;
  ConfigList.Clear;
  for Folder in Folders do
  begin
    // get the files in the folder
    Masks := '*.ini';
    Files := FindFiles(Folder, Masks);
    for aFile in Files do
    begin
      // should only be one ini file in the each directory
      s := ExtractFileName(aFile);
      if (s = 'BMACConfig.ini') then
      begin
        BuildConfig := TscmBuildConfig.Create;
        BuildConfig.LoadIniFile(aFile);
        BuildConfig.FileName := aFile;
        ConfigList.Add(BuildConfig); // owns object
      end;
    end;
  end;
  for BuildConfig in ConfigList do
  begin
    // create checkbox caption
    s := BuildConfig.Description;
    if BuildConfig.IsRelease = false then
      s := s + ' Pre-Release'
    else
      s := s + ' Release';
    if BuildConfig.IsPatch = true then
      s := s + ' Patch ';
    ListBox1.Items.AddObject(s, BuildConfig);
  end;
end;

procedure TSelectBuild.ListBox1Click(Sender: TObject);
var
aConfig: TscmBuildConfig;
begin
    aConfig := TscmBuildConfig(ListBox1.Items.Objects
      [ListBox1.ItemIndex]);
  lblNotes.Caption := aConfig.Notes;
end;

procedure TSelectBuild.ListBox1DblClick(Sender: TObject);
begin
  btnOkClick(Sender);
end;

end.
