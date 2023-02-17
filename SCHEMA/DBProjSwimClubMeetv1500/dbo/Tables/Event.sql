CREATE TABLE [dbo].[Event] (
    [EventID]       INT            IDENTITY (1, 1) NOT NULL,
    [EventNum]      INT            NULL,
    [Caption]       NVARCHAR (128) NULL,
    [ClosedDT]      DATETIME       NULL,
    [SessionID]     INT            NULL,
    [EventTypeID]   INT            NULL,
    [StrokeID]      INT            NULL,
    [DistanceID]    INT            NULL,
    [EventStatusID] INT            NULL,
    CONSTRAINT [PK_Event] PRIMARY KEY NONCLUSTERED ([EventID] ASC),
    CONSTRAINT [FK_Distance_Event] FOREIGN KEY ([DistanceID]) REFERENCES [dbo].[Distance] ([DistanceID]) ON DELETE SET NULL,
    CONSTRAINT [FK_EventStatus_Event] FOREIGN KEY ([EventStatusID]) REFERENCES [dbo].[EventStatus] ([EventStatusID]) ON DELETE SET NULL,
    CONSTRAINT [FK_EventType_Event] FOREIGN KEY ([EventTypeID]) REFERENCES [dbo].[EventType] ([EventTypeID]) ON DELETE SET NULL,
    CONSTRAINT [FK_Session_Event] FOREIGN KEY ([SessionID]) REFERENCES [dbo].[Session] ([SessionID]) ON DELETE CASCADE,
    CONSTRAINT [FK_Stroke_Event] FOREIGN KEY ([StrokeID]) REFERENCES [dbo].[Stroke] ([StrokeID]) ON DELETE SET NULL
);


GO

GRANT SELECT
    ON OBJECT::[dbo].[Event] TO [SCM_Guest]
    AS [dbo];


GO

GRANT INSERT
    ON OBJECT::[dbo].[Event] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT DELETE
    ON OBJECT::[dbo].[Event] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[Event] TO [SCM_Marshall]
    AS [dbo];


GO

GRANT UPDATE
    ON OBJECT::[dbo].[Event] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[Event] TO [SCM_Administrator]
    AS [dbo];


GO

