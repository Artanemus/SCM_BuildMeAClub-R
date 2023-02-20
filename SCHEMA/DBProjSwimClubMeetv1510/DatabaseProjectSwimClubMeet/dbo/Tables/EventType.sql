CREATE TABLE [dbo].[EventType] (
    [EventTypeID] INT            IDENTITY (1, 1) NOT NULL,
    [Caption]     NVARCHAR (128) NULL,
    CONSTRAINT [PK_EventType] PRIMARY KEY NONCLUSTERED ([EventTypeID] ASC)
);


GO

GRANT SELECT
    ON OBJECT::[dbo].[EventType] TO [SCM_Guest]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[EventType] TO [SCM_Marshall]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[EventType] TO [SCM_Administrator]
    AS [dbo];


GO

