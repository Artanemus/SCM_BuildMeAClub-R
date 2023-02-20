CREATE TABLE [dbo].[HeatTeam] (
    [HeatID]       INT            IDENTITY (1, 1) NOT NULL,
    [HeatNum]      INT            NULL,
    [Caption]      NVARCHAR (128) NULL,
    [ClosedDT]     DATETIME       NULL,
    [EventID]      INT            NULL,
    [HeatTypeID]   INT            NULL,
    [HeatStatusID] INT            NULL,
    CONSTRAINT [PK_HeatTeam] PRIMARY KEY NONCLUSTERED ([HeatID] ASC),
    CONSTRAINT [FK_Event_HeatTeam] FOREIGN KEY ([EventID]) REFERENCES [dbo].[Event] ([EventID]) ON DELETE CASCADE,
    CONSTRAINT [FK_HeatStatus_HeatTeam] FOREIGN KEY ([HeatStatusID]) REFERENCES [dbo].[HeatStatus] ([HeatStatusID]) ON DELETE SET NULL,
    CONSTRAINT [FK_HeatType_HeatTeam] FOREIGN KEY ([HeatTypeID]) REFERENCES [dbo].[HeatType] ([HeatTypeID]) ON DELETE SET NULL
);


GO

GRANT SELECT
    ON OBJECT::[dbo].[HeatTeam] TO [SCM_Guest]
    AS [dbo];


GO

GRANT DELETE
    ON OBJECT::[dbo].[HeatTeam] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT UPDATE
    ON OBJECT::[dbo].[HeatTeam] TO [SCM_Marshall]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[HeatTeam] TO [SCM_Marshall]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[HeatTeam] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT INSERT
    ON OBJECT::[dbo].[HeatTeam] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT INSERT
    ON OBJECT::[dbo].[HeatTeam] TO [SCM_Marshall]
    AS [dbo];


GO

GRANT UPDATE
    ON OBJECT::[dbo].[HeatTeam] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT DELETE
    ON OBJECT::[dbo].[HeatTeam] TO [SCM_Marshall]
    AS [dbo];


GO

