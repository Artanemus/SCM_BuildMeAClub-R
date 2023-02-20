CREATE TABLE [dbo].[ScoreDivision] (
    [ScoreDivisionID] INT            IDENTITY (1, 1) NOT NULL,
    [SwimClubID]      INT            NULL,
    [Caption]         NVARCHAR (128) NULL,
    [AgeFrom]         INT            NULL,
    [AgeTo]           INT            NULL,
    [GenderID]        INT            NULL,
    CONSTRAINT [PK_ScoreDivision] PRIMARY KEY CLUSTERED ([ScoreDivisionID] ASC),
    CONSTRAINT [FK_Gender_ScoreDivision] FOREIGN KEY ([GenderID]) REFERENCES [dbo].[Gender] ([GenderID]),
    CONSTRAINT [FK_SwimClub_ScoreDivision] FOREIGN KEY ([SwimClubID]) REFERENCES [dbo].[SwimClub] ([SwimClubID])
);


GO

GRANT UPDATE
    ON OBJECT::[dbo].[ScoreDivision] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT INSERT
    ON OBJECT::[dbo].[ScoreDivision] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[ScoreDivision] TO [SCM_Guest]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[ScoreDivision] TO [SCM_Marshall]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[ScoreDivision] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT DELETE
    ON OBJECT::[dbo].[ScoreDivision] TO [SCM_Administrator]
    AS [dbo];


GO

