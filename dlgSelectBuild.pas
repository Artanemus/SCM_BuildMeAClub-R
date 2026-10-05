unit dlgSelectBuild;

interface

uses
  Winapi.Windows, Winapi.Messages,

  System.SysUtils, System.Variants, System.Generics.Collections,
  System.Classes, Vcl.Graphics,  System.Types,

  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.CheckLst,
  Vcl.ExtCtrls,

  uBMAC_Config, uBMAC_Defines;

type
  TSelectBuild = class(TForm)
    btnCancel: TButton;
    btnOk: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    ListBox1: TListBox;
    pnlNotes: TPanel;
    lblNotes: TMemo;
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
    fConfigList: TObjectList<TBMAC_Config>;
    fSelectedConfig: TBMAC_Config;
    function FindFiles(const Path, Masks: string): TStringDynArray;
    procedure InitCheckListBoxItems(const DIR: string;
      ConfigList: TObjectList<TBMAC_Config>);
  public
    { Public declarations }
    property ConfigList: TObjectList<TBMAC_Config> write fConfigList;
    property SelectedConfig: TBMAC_Config read fSelectedConfig;
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
    fSelectedConfig := TBMAC_Config(ListBox1.Items.Objects
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

  SendMessage(
    lblNotes.Handle,
    EM_SETTABSTOPS,
    1,
    LPARAM(@MemoTabWidth)
  );

  lblNotes.Invalidate;
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
  ConfigList: TObjectList<TBMAC_Config>);
var
  Folders: TStringDynArray;
  Files: TStringDynArray;
  aFile, s: string;
  Folder: string;
  Masks: String;
  BuildConfig: TBMAC_Config;
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
      if (s = SCMCONFIGFILENAME) then
      begin
        BuildConfig := TBMAC_Config.Create;
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
    if BuildConfig.IsRelease then
      s := s + ' Release '
    else
      s := s + ' Pre-Release';

    // depreciated supercedes release or pre-release
    if BuildConfig.IsDepreciated = true then
      s := BuildConfig.Description + ' Depreciated ';

    ListBox1.Items.AddObject(s, BuildConfig);
  end;
end;

procedure TSelectBuild.ListBox1Click(Sender: TObject);
var
aConfig: TBMAC_Config;
begin
    aConfig := TBMAC_Config(ListBox1.Items.Objects
      [ListBox1.ItemIndex]);
  lblNotes.Caption := aConfig.Notes;
end;

procedure TSelectBuild.ListBox1DblClick(Sender: TObject);
begin
  btnOkClick(Sender);
end;

end.
