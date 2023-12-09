program SCM_BuildMeAClub;

uses
  Vcl.Forms,
  frmSCMBuildMeADataBase in 'frmSCMBuildMeADataBase.pas' {SCMBuildMeADataBase},
  utilVersion in 'utilVersion.pas',
  Vcl.Themes,
  Vcl.Styles,
  dlgBMACMsgBox in 'dlgBMACMsgBox.pas' {BMACMsgBox},
  dlgSelectDataBaseToBuild in 'dlgSelectDataBaseToBuild.pas' {SelectDataBaseToBuild};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'SCM_UpdateDataBase';
  TStyleManager.TrySetStyle('Windows10 SlateGray');
  Application.CreateForm(TSCMBuildMeADataBase, SCMBuildMeADataBase);
  Application.CreateForm(TBMACMsgBox, BMACMsgBox);
  Application.Run;
end.
