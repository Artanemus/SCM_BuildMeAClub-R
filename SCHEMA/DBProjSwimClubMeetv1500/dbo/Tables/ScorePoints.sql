CREATE TABLE [dbo].[ScorePoints] (
    [ScorePointsID] INT        IDENTITY (1, 1) NOT NULL,
    [SwimClubID]    INT        NULL,
    [Place]         INT        NULL,
    [Points]        FLOAT (53) NULL,
    CONSTRAINT [PK_ScorePoints] PRIMARY KEY CLUSTERED ([ScorePointsID] ASC),
    CONSTRAINT [FK_SwimClub_ScorePoints] FOREIGN KEY ([SwimClubID]) REFERENCES [dbo].[SwimClub] ([SwimClubID]) ON DELETE CASCADE
);


GO

GRANT SELECT
    ON OBJECT::[dbo].[ScorePoints] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT UPDATE
    ON OBJECT::[dbo].[ScorePoints] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT INSERT
    ON OBJECT::[dbo].[ScorePoints] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT DELETE
    ON OBJECT::[dbo].[ScorePoints] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[ScorePoints] TO [SCM_Marshall]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[ScorePoints] TO [SCM_Guest]
    AS [dbo];


GO

