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

GRANT SELECT
    ON OBJECT::[dbo].[Qualify] TO [SCM_Guest]
    AS [dbo];


GO

GRANT DELETE
    ON OBJECT::[dbo].[Qualify] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT INSERT
    ON OBJECT::[dbo].[Qualify] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT UPDATE
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

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Qualifying Times:
For a swimmer to compete in an event of said distance and stroke they must have swum the stoke in a (shorter) distance within a given time.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Qualify';


GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'While IsShortCourse will determine the generic pool standard - ie the course length. Short Course (SC),  Long Course (LC)
LengthOfPool allows for more options in filtering of the qualify table.
An example.
If the tblSwimClub->LengthOfPool value is 33m and Qualify->LengthOfPool is 33m then it can pull these records under the guise of the generic pool standard.
If these values don''t exist then the pool length that matches the generic pool standard is used. towit Short Course (SC) 25m,  Long Course (LC) 50m', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Qualify', @level2type = N'COLUMN', @level2name = N'LengthOfPool';


GO

