CREATE TABLE [dbo].[EventStatus] (
    [EventStatusID] INT           IDENTITY (1, 1) NOT NULL,
    [Caption]       NVARCHAR (32) NULL
);
GO

GRANT SELECT
    ON OBJECT::[dbo].[EventStatus] TO [SCM_Administrator]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[dbo].[EventStatus] TO [SCM_Guest]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[dbo].[EventStatus] TO [SCM_Marshall]
    AS [dbo];
GO

ALTER TABLE [dbo].[EventStatus]
    ADD CONSTRAINT [PK_EventStatus] PRIMARY KEY NONCLUSTERED ([EventStatusID] ASC);
GO

