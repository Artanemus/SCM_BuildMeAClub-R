CREATE TABLE [dbo].[ContactNumType] (
    [ContactNumTypeID] INT           IDENTITY (1, 1) NOT NULL,
    [Caption]          NVARCHAR (30) NULL,
    CONSTRAINT [PK_ContactNumType] PRIMARY KEY CLUSTERED ([ContactNumTypeID] ASC)
);


GO

GRANT SELECT
    ON OBJECT::[dbo].[ContactNumType] TO [SCM_Marshall]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[ContactNumType] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[ContactNumType] TO [SCM_Guest]
    AS [dbo];


GO

