CREATE TABLE [dbo].[Team] (
    [TeamID]         INT      IDENTITY (1, 1) NOT NULL,
    [Lane]           INT      NULL,
    [TeamTime]       TIME (7) NULL,
    [IsDisqualified] BIT      DEFAULT ((0)) NULL,
    [IsScratched]    BIT      DEFAULT ((0)) NULL,
    [HeatID]         INT      NULL,
    CONSTRAINT [PK_Team] PRIMARY KEY NONCLUSTERED ([TeamID] ASC),
    CONSTRAINT [FK_HeatTeam_Team] FOREIGN KEY ([HeatID]) REFERENCES [dbo].[HeatTeam] ([HeatID]) ON DELETE CASCADE
);


GO

GRANT SELECT
    ON OBJECT::[dbo].[Team] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT UPDATE
    ON OBJECT::[dbo].[Team] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT INSERT
    ON OBJECT::[dbo].[Team] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT DELETE
    ON OBJECT::[dbo].[Team] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[Team] TO [SCM_Marshall]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[Team] TO [SCM_Guest]
    AS [dbo];


GO

