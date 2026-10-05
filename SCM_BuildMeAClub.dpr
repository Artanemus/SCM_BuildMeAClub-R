program SCM_BuildMeAClub;

uses
  Vcl.Forms,
  frmSCMBuildMeADataBase in 'frmSCMBuildMeADataBase.pas' {SCMBuildMeADataBase},
  Vcl.Themes,
  Vcl.Styles,
  dlgBMACMsgBox in 'dlgBMACMsgBox.pas' {BMACMsgBox},
  utilVersion in '..\SCM_SHARED\utilVersion.pas',
  dlgSelectBuild in 'dlgSelectBuild.pas' {SelectBuild},
  uBMAC_Config in 'uBMAC_Config.pas',
  uBMAC_Defines in 'uBMAC_Defines.pas';

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
