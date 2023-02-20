CREATE TABLE [dbo].[Stroke] (
    [StrokeID] INT            IDENTITY (1, 1) NOT NULL,
    [Caption]  NVARCHAR (128) NULL,
    CONSTRAINT [PK_Stroke] PRIMARY KEY NONCLUSTERED ([StrokeID] ASC)
);


GO

GRANT SELECT
    ON OBJECT::[dbo].[Stroke] TO [SCM_Guest]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[Stroke] TO [SCM_Marshall]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[Stroke] TO [SCM_Administrator]
    AS [dbo];


GO

