CREATE TABLE [dbo].[Entrant] (
    [EntrantID]      INT      IDENTITY (1, 1) NOT NULL,
    [MemberID]       INT      NULL,
    [Lane]           INT      NULL,
    [RaceTime]       TIME (7) NULL,
    [TimeToBeat]     TIME (7) NULL,
    [PersonalBest]   TIME (7) NULL,
    [IsDisqualified] BIT      DEFAULT ((0)) NULL,
    [IsScratched]    BIT      DEFAULT ((0)) NULL,
    [HeatID]         INT      NULL,
    CONSTRAINT [PK_Entrant] PRIMARY KEY NONCLUSTERED ([EntrantID] ASC),
    CONSTRAINT [FK_HeatIndividual_Entrant] FOREIGN KEY ([HeatID]) REFERENCES [dbo].[HeatIndividual] ([HeatID]) ON DELETE CASCADE,
    CONSTRAINT [FK_Member_Entrant] FOREIGN KEY ([MemberID]) REFERENCES [dbo].[Member] ([MemberID]) ON DELETE SET NULL NOT FOR REPLICATION
);


GO

GRANT DELETE
    ON OBJECT::[dbo].[Entrant] TO [SCM_Marshall]
    AS [dbo];


GO

GRANT INSERT
    ON OBJECT::[dbo].[Entrant] TO [SCM_Marshall]
    AS [dbo];


GO

GRANT UPDATE
    ON OBJECT::[dbo].[Entrant] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[Entrant] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT INSERT
    ON OBJECT::[dbo].[Entrant] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[Entrant] TO [SCM_Guest]
    AS [dbo];


GO

GRANT UPDATE
    ON OBJECT::[dbo].[Entrant] TO [SCM_Marshall]
    AS [dbo];


GO

GRANT DELETE
    ON OBJECT::[dbo].[Entrant] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[Entrant] TO [SCM_Marshall]
    AS [dbo];


GO

