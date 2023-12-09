unit dlgSelectDataBaseToBuild;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.CheckLst;

type
  TSelectDataBaseToBuild = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    btnCancel: TButton;
    btnOk: TButton;
    CheckListBox1: TCheckListBox;
    Panel3: TPanel;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    fBMACScriptsPath: string;
    fRtnSubFolder: string;
    procedure InitCheckListBoxItems(const DIR: string);
    function GetCheckedItems(ListBox: TCheckListBox): string;

  public
    { Public declarations }
    property RtnSubFolder: string read fRtnSubFolder;
    property BMACScriptsPath: string write fBMACScriptsPath;
  end;

var
  SelectDataBaseToBuild: TSelectDataBaseToBuild;

implementation

{$R *.dfm}
{ TSelectDataBaseToBuild }

uses
  System.IOUtils, System.Types;

procedure TSelectDataBaseToBuild.btnCancelClick(Sender: TObject);
begin
  fRtnSubFolder := '';
  ModalResult := mrCancel;
end;

procedure TSelectDataBaseToBuild.btnOkClick(Sender: TObject);
begin
  // get the selected CheckListBox item
  fRtnSubFolder := GetCheckedItems(CheckListBox1);
  ModalResult := mrOK;
end;

procedure TSelectDataBaseToBuild.FormCreate(Sender: TObject);
begin
  fRtnSubFolder := '';
end;

procedure TSelectDataBaseToBuild.FormShow(Sender: TObject);
begin
  if fBMACScriptsPath.IsEmpty then
  begin
    ModalResult := mrCancel;
    Close;
  end;
  InitCheckListBoxItems(fBMACScriptsPath);
end;

function TSelectDataBaseToBuild.GetCheckedItems(ListBox: TCheckListBox): string;
var
  i: Integer;
begin
  result := '';
  for i := 0 to ListBox.Count - 1 do
  begin
    if ListBox.Checked[i] then
    begin
      result := ListBox.Items[i];
      break;
    end;
  end;

end;

procedure TSelectDataBaseToBuild.InitCheckListBoxItems(const DIR: string);
var
  Folders: TStringDynArray;
  Folder: string;
  LastFolder: string;
begin
  Folders := TDirectory.GetDirectories(DIR);
  CheckListBox1.Items.Clear;
  for Folder in Folders do
  begin
    LastFolder := ExtractFileName(ExcludeTrailingPathDelimiter(Folder));
    CheckListBox1.Items.Add(LowerCase(LastFolder));
  end;
end;

end.
