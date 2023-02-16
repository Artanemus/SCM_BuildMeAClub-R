CREATE ROLE [SCM_Administrator]
    AUTHORIZATION [dbo];
GO

ALTER ROLE [SCM_Administrator] ADD MEMBER [scmAdmin];
GO

