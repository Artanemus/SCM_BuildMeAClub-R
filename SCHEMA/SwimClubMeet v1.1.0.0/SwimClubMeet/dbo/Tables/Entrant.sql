CREATE TABLE [dbo].[Entrant] (
    [EntrantID]      INT      IDENTITY (1, 1) NOT NULL,
    [MemberID]       INT      NULL,
    [Lane]           INT      NULL,
    [RaceTime]       TIME (7) NULL,
    [TimeToBeat]     TIME (7) NULL,
    [PersonalBest]   TIME (7) NULL,
    [IsDisqualified] BIT      DEFAULT ((0)) NULL,
    [IsScratched]    BIT      DEFAULT ((0)) NULL,
    [HeatID]         INT      NULL
);
GO

GRANT SELECT
    ON OBJECT::[dbo].[Entrant] TO [SCM_Marshall]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[dbo].[Entrant] TO [SCM_Administrator]
    AS [dbo];
GO

GRANT DELETE
    ON OBJECT::[dbo].[Entrant] TO [SCM_Administrator]
    AS [dbo];
GO

GRANT UPDATE
    ON OBJECT::[dbo].[Entrant] TO [SCM_Administrator]
    AS [dbo];
GO

GRANT UPDATE
    ON OBJECT::[dbo].[Entrant] TO [SCM_Marshall]
    AS [dbo];
GO

GRANT DELETE
    ON OBJECT::[dbo].[Entrant] TO [SCM_Marshall]
    AS [dbo];
GO

GRANT INSERT
    ON OBJECT::[dbo].[Entrant] TO [SCM_Administrator]
    AS [dbo];
GO

GRANT INSERT
    ON OBJECT::[dbo].[Entrant] TO [SCM_Marshall]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[dbo].[Entrant] TO [SCM_Guest]
    AS [dbo];
GO

ALTER TABLE [dbo].[Entrant]
    ADD CONSTRAINT [FK_HeatIndividual_Entrant] FOREIGN KEY ([HeatID]) REFERENCES [dbo].[HeatIndividual] ([HeatID]) ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[Entrant]
    ADD CONSTRAINT [FK_Member_Entrant] FOREIGN KEY ([MemberID]) REFERENCES [dbo].[Member] ([MemberID]) ON DELETE SET NULL NOT FOR REPLICATION;
GO

ALTER TABLE [dbo].[Entrant]
    ADD CONSTRAINT [PK_Entrant] PRIMARY KEY NONCLUSTERED ([EntrantID] ASC);
GO

