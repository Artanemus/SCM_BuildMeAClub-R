unit dlgBMACMsgBox;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TBMACMsgBox = class(TForm)
    Panel1: TPanel;
    btnCancel: TButton;
    btnOK: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    Shape1: TShape;
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FFolderPath: String;
  public
    { Public declarations }
    property FolderPath: string read FFolderPath write FFolderPath;
  end;

var
  BMACMsgBox: TBMACMsgBox;

implementation

{$R *.dfm}

procedure TBMACMsgBox.btnCancelClick(Sender: TObject);
begin
  ModalResult := btnCancel.ModalResult;
  Close;
end;

procedure TBMACMsgBox.FormCreate(Sender: TObject);
begin
  FFolderPath := '';
end;

end.
