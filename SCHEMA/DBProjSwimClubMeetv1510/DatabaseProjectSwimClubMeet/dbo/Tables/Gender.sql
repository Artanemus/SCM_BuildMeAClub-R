CREATE TABLE [dbo].[Gender] (
    [GenderID] INT           IDENTITY (1, 1) NOT NULL,
    [Caption]  NVARCHAR (20) NULL,
    CONSTRAINT [PK_Gender] PRIMARY KEY NONCLUSTERED ([GenderID] ASC)
);


GO

GRANT SELECT
    ON OBJECT::[dbo].[Gender] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[Gender] TO [SCM_Marshall]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[Gender] TO [SCM_Guest]
    AS [dbo];


GO

