CREATE TABLE [dbo].[Distance] (
    [DistanceID] INT            IDENTITY (1, 1) NOT NULL,
    [Caption]    NVARCHAR (128) NULL,
    [Meters]     INT            NULL
);
GO

GRANT SELECT
    ON OBJECT::[dbo].[Distance] TO [SCM_Administrator]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[dbo].[Distance] TO [SCM_Marshall]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[dbo].[Distance] TO [SCM_Guest]
    AS [dbo];
GO

ALTER TABLE [dbo].[Distance]
    ADD CONSTRAINT [PK_Distance] PRIMARY KEY NONCLUSTERED ([DistanceID] ASC);
GO

