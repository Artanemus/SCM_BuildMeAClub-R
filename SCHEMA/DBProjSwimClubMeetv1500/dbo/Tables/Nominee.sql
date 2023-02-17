CREATE TABLE [dbo].[Nominee] (
    [NomineeID]     INT      IDENTITY (1, 1) NOT NULL,
    [TTB]           TIME (7) NULL,
    [PB]            TIME (7) NULL,
    [SeedTime]      TIME (7) NULL,
    [AutoBuildFlag] BIT      NULL,
    [EventID]       INT      NULL,
    [MemberID]      INT      NULL,
    CONSTRAINT [PK_Nominee] PRIMARY KEY CLUSTERED ([NomineeID] ASC),
    CONSTRAINT [FK_Event_Nominee] FOREIGN KEY ([EventID]) REFERENCES [dbo].[Event] ([EventID]) ON DELETE CASCADE,
    CONSTRAINT [FK_Member_Nominee] FOREIGN KEY ([MemberID]) REFERENCES [dbo].[Member] ([MemberID]) ON DELETE SET NULL
);


GO

GRANT DELETE
    ON OBJECT::[dbo].[Nominee] TO [SCM_Marshall]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[Nominee] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[Nominee] TO [SCM_Marshall]
    AS [dbo];


GO

GRANT UPDATE
    ON OBJECT::[dbo].[Nominee] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT INSERT
    ON OBJECT::[dbo].[Nominee] TO [SCM_Marshall]
    AS [dbo];


GO

GRANT DELETE
    ON OBJECT::[dbo].[Nominee] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[Nominee] TO [SCM_Guest]
    AS [dbo];


GO

GRANT UPDATE
    ON OBJECT::[dbo].[Nominee] TO [SCM_Marshall]
    AS [dbo];


GO

GRANT INSERT
    ON OBJECT::[dbo].[Nominee] TO [SCM_Administrator]
    AS [dbo];


GO

