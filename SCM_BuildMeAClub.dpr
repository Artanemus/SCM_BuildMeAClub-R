program SCM_BuildMeAClub;

uses
  Vcl.Forms,
  frmSCMBuildMeADataBase in 'frmSCMBuildMeADataBase.pas' {SCMBuildMeADataBase},
  Vcl.Themes,
  Vcl.Styles,
  dlgBMACMsgBox in 'dlgBMACMsgBox.pas' {BMACMsgBox},
  dlgSelectBuild in '..\SCM_SHARED\dlgSelectBuild.pas' {SelectBuild},
  scmBuildConfig in '..\SCM_SHARED\scmBuildConfig.pas',
  utilVersion in '..\SCM_SHARED\utilVersion.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'SCM_UpdateDataBase';
  TStyleManager.TrySetStyle('Windows10 SlateGray');
  Application.CreateForm(TSCMBuildMeADataBase, SCMBuildMeADataBase);
  Application.CreateForm(TBMACMsgBox, BMACMsgBox);
  Application.CreateForm(TSelectBuild, SelectBuild);
  Application.Run;
end.
