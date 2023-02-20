CREATE TABLE [dbo].[TeamSplit] (
    [TeamSplitID]   INT      IDENTITY (1, 1) NOT NULL,
    [SplitTime]     TIME (7) NULL,
    [TeamEntrantID] INT      NULL,
    CONSTRAINT [PK_TeamSplit] PRIMARY KEY NONCLUSTERED ([TeamSplitID] ASC),
    CONSTRAINT [FK_TeamEntrant_TeamSplit] FOREIGN KEY ([TeamEntrantID]) REFERENCES [dbo].[TeamEntrant] ([TeamEntrantID]) ON DELETE CASCADE
);


GO

GRANT DELETE
    ON OBJECT::[dbo].[TeamSplit] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[TeamSplit] TO [SCM_Marshall]
    AS [dbo];


GO

GRANT INSERT
    ON OBJECT::[dbo].[TeamSplit] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT UPDATE
    ON OBJECT::[dbo].[TeamSplit] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[TeamSplit] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[TeamSplit] TO [SCM_Guest]
    AS [dbo];


GO

