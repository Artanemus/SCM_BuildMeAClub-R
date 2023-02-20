CREATE TABLE [dbo].[Qualify] (
    [QualifyID]     INT      IDENTITY (1, 1) NOT NULL,
    [TrialDistID]   INT      NULL,
    [QualifyDistID] INT      NULL,
    [StrokeID]      INT      NULL,
    [TrialTime]     TIME (7) NULL,
    [IsShortCourse] BIT      DEFAULT ((1)) NULL,
    [GenderID]      INT      NULL,
    [LengthOfPool]  INT      NULL,
    CONSTRAINT [PK_Qualify] PRIMARY KEY CLUSTERED ([QualifyID] ASC),
    CONSTRAINT [FK_Distance_Quali4] FOREIGN KEY ([QualifyDistID]) REFERENCES [dbo].[Distance] ([DistanceID]),
    CONSTRAINT [FK_Distance_Qualify] FOREIGN KEY ([TrialDistID]) REFERENCES [dbo].[Distance] ([DistanceID]) ON DELETE SET NULL,
    CONSTRAINT [FK_Gender_Qualify] FOREIGN KEY ([GenderID]) REFERENCES [dbo].[Gender] ([GenderID]) ON DELETE SET NULL,
    CONSTRAINT [FK_Stroke_Qualify] FOREIGN KEY ([StrokeID]) REFERENCES [dbo].[Stroke] ([StrokeID]) ON DELETE SET NULL
);


GO

GRANT DELETE
    ON OBJECT::[dbo].[Qualify] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[Qualify] TO [SCM_Guest]
    AS [dbo];


GO

GRANT INSERT
    ON OBJECT::[dbo].[Qualify] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[Qualify] TO [SCM_Marshall]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[Qualify] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT UPDATE
    ON OBJECT::[dbo].[Qualify] TO [SCM_Administrator]
    AS [dbo];


GO

