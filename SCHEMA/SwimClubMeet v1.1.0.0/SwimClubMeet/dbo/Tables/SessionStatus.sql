CREATE TABLE [dbo].[SessionStatus] (
    [SessionStatusID] INT           IDENTITY (1, 1) NOT NULL,
    [Caption]         NVARCHAR (32) NULL
);
GO

GRANT SELECT
    ON OBJECT::[dbo].[SessionStatus] TO [SCM_Guest]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[dbo].[SessionStatus] TO [SCM_Marshall]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[dbo].[SessionStatus] TO [SCM_Administrator]
    AS [dbo];
GO

ALTER TABLE [dbo].[SessionStatus]
    ADD CONSTRAINT [PK_SessionStatus] PRIMARY KEY NONCLUSTERED ([SessionStatusID] ASC);
GO

