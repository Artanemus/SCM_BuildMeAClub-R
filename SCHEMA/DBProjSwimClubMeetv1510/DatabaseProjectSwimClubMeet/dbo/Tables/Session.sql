CREATE TABLE [dbo].[Session] (
    [SessionID]       INT            IDENTITY (1, 1) NOT NULL,
    [Caption]         NVARCHAR (128) NULL,
    [SessionStart]    DATETIME       NULL,
    [ClosedDT]        DATETIME       NULL,
    [SwimClubID]      INT            NULL,
    [SessionStatusID] INT            NULL,
    CONSTRAINT [PK_Session] PRIMARY KEY NONCLUSTERED ([SessionID] ASC),
    CONSTRAINT [FK_SessionStatus_Session] FOREIGN KEY ([SessionStatusID]) REFERENCES [dbo].[SessionStatus] ([SessionStatusID]) ON DELETE SET NULL,
    CONSTRAINT [FK_SwimClub_Session] FOREIGN KEY ([SwimClubID]) REFERENCES [dbo].[SwimClub] ([SwimClubID]) ON DELETE CASCADE
);


GO

GRANT SELECT
    ON OBJECT::[dbo].[Session] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT UPDATE
    ON OBJECT::[dbo].[Session] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[Session] TO [SCM_Guest]
    AS [dbo];


GO

GRANT DELETE
    ON OBJECT::[dbo].[Session] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT INSERT
    ON OBJECT::[dbo].[Session] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[Session] TO [SCM_Marshall]
    AS [dbo];


GO

