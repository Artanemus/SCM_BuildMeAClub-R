CREATE TABLE [dbo].[Split] (
    [SplitID]   INT      IDENTITY (1, 1) NOT NULL,
    [SplitTime] TIME (7) NULL,
    [EntrantID] INT      NULL
);
GO

GRANT SELECT
    ON OBJECT::[dbo].[Split] TO [SCM_Guest]
    AS [dbo];
GO

GRANT UPDATE
    ON OBJECT::[dbo].[Split] TO [SCM_Administrator]
    AS [dbo];
GO

GRANT INSERT
    ON OBJECT::[dbo].[Split] TO [SCM_Administrator]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[dbo].[Split] TO [SCM_Marshall]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[dbo].[Split] TO [SCM_Administrator]
    AS [dbo];
GO

GRANT DELETE
    ON OBJECT::[dbo].[Split] TO [SCM_Administrator]
    AS [dbo];
GO

ALTER TABLE [dbo].[Split]
    ADD CONSTRAINT [FK_Entrant_Split] FOREIGN KEY ([EntrantID]) REFERENCES [dbo].[Entrant] ([EntrantID]) ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[Split]
    ADD CONSTRAINT [PK_Split] PRIMARY KEY NONCLUSTERED ([SplitID] ASC);
GO

