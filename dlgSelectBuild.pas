unit dlgSelectBuild;

interface

uses
  Winapi.Windows, Winapi.Messages,

  System.SysUtils, System.Variants, System.Generics.Collections,
  System.Classes,  System.Types,

  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.CheckLst,
  Vcl.ExtCtrls, vcl.Graphics,

  uBMAC_Config, uBMAC_Defines;

type
  TSelectBuild = class(TForm)
    btnCancel: TButton;
    btnOk: TButton;
    pnlBody: TPanel;
    pnlFooter: TPanel;
    pnlHeader: TPanel;
    ListBox1: TListBox;
    pnlNotes: TPanel;
    lblNotes: TMemo;
    pnlBorder: TPanel;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer; Rect: TRect;
        State: TOwnerDrawState);
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

  // Sync notes memopad to current selected item.
  if ListBox1.Count > 0 then
  begin
    ListBox1.ItemIndex := ListBox1.Count -1;
    lblNotes.Text := TBMAC_Config(ListBox1.Items.Objects[ListBox1.ItemIndex]).Notes;
    lblNotes.Invalidate;
  end;

end;

procedure TSelectBuild.InitCheckListBoxItems(const DIR: string;
  ConfigList: TObjectList<TBMAC_Config>);
var
  Folders: TStringDynArray;
  Files: TStringDynArray;
  aFile, fn, s1, s2: string;
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
      fn := ExtractFileName(aFile);
      if (fn = SCMCONFIGFILENAME) then
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
    s1 := BuildConfig.DatabaseName;
    s1 := s1 + ' : ' + BuildConfig.Description;

    if BuildConfig.IsRelease then
      s2 := ' Release '
    else
      s2 := ' Pre-Release';

    // 'Retired' supercedes release or pre-release
    if BuildConfig.IsRetired = true then
      s2 := ' Retired ';

    s1 := s1 + s2;

    ListBox1.Items.AddObject(s1, BuildConfig);
  end;
end;

procedure TSelectBuild.ListBox1Click(Sender: TObject);
var
aConfig: TBMAC_Config;
begin
  aConfig := TBMAC_Config(ListBox1.Items.Objects[ListBox1.ItemIndex]);
  lblNotes.Text := aConfig.Notes;
end;

procedure TSelectBuild.ListBox1DblClick(Sender: TObject);
begin
  btnOkClick(Sender);
end;

procedure TSelectBuild.ListBox1DrawItem(Control: TWinControl; Index: Integer;
    Rect: TRect; State: TOwnerDrawState);
var
 lb: TListBox;
 aConfig: TBMAC_Config;
 offsetx, offsety: integer;
begin
  OffsetX := 1;
  OffsetY := 1;
  lb := TListBox(Control);
  aConfig := TBMAC_Config(lb.Items.Objects[Index]);
  // release
  if not aconfig.IsRetired then
  begin
    LB.Canvas.Font.Color := vcl.Graphics.clWebDarkGoldenRod;
  end;
  LB.Canvas.TextOut(Rect.Left + OffsetX, Rect.Top + OffsetY, lb.Items[Index]);

end;

end.
