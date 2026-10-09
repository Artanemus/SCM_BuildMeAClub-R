unit dlgMsgDBExists;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TMsgDBExists = class(TForm)
    MsgDBExists: TPanel;
    pnlFooter: TPanel;
    pnlBody: TPanel;
    btnOk: TButton;
    lblHeader: TLabel;
    memoBody: TMemo;
    procedure btnOkClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MsgDBExists: TMsgDBExists;

implementation

{$R *.dfm}

procedure TMsgDBExists.btnOkClick(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure TMsgDBExists.FormKeyDown(Sender: TObject; var Key: Word; Shift:
    TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    ModalResult := mrOK;
    Key := 0;
  end;
end;

end.
