CREATE TABLE [dbo].[TeamEntrant] (
    [TeamEntrantID] INT      IDENTITY (1, 1) NOT NULL,
    [MemberID]      INT      NULL,
    [RaceTime]      TIME (7) NULL,
    [StrokeID]      INT      NULL,
    [TeamID]        INT      NULL
);
GO

GRANT SELECT
    ON OBJECT::[dbo].[TeamEntrant] TO [SCM_Marshall]
    AS [dbo];
GO

GRANT DELETE
    ON OBJECT::[dbo].[TeamEntrant] TO [SCM_Administrator]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[dbo].[TeamEntrant] TO [SCM_Administrator]
    AS [dbo];
GO

GRANT UPDATE
    ON OBJECT::[dbo].[TeamEntrant] TO [SCM_Administrator]
    AS [dbo];
GO

GRANT INSERT
    ON OBJECT::[dbo].[TeamEntrant] TO [SCM_Marshall]
    AS [dbo];
GO

GRANT INSERT
    ON OBJECT::[dbo].[TeamEntrant] TO [SCM_Administrator]
    AS [dbo];
GO

GRANT UPDATE
    ON OBJECT::[dbo].[TeamEntrant] TO [SCM_Marshall]
    AS [dbo];
GO

GRANT DELETE
    ON OBJECT::[dbo].[TeamEntrant] TO [SCM_Marshall]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[dbo].[TeamEntrant] TO [SCM_Guest]
    AS [dbo];
GO

ALTER TABLE [dbo].[TeamEntrant]
    ADD CONSTRAINT [FK_Team_TeamEntrant] FOREIGN KEY ([TeamID]) REFERENCES [dbo].[Team] ([TeamID]) ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[TeamEntrant]
    ADD CONSTRAINT [FK_Member_TeamEntrant] FOREIGN KEY ([MemberID]) REFERENCES [dbo].[Member] ([MemberID]) ON DELETE SET NULL;
GO

ALTER TABLE [dbo].[TeamEntrant]
    ADD CONSTRAINT [FK_Stroke_TeamEntrant] FOREIGN KEY ([StrokeID]) REFERENCES [dbo].[Stroke] ([StrokeID]) ON DELETE SET NULL;
GO

ALTER TABLE [dbo].[TeamEntrant]
    ADD CONSTRAINT [PK_TeamEntrant] PRIMARY KEY NONCLUSTERED ([TeamEntrantID] ASC);
GO

