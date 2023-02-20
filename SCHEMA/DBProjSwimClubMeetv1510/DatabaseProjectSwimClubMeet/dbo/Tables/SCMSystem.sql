CREATE TABLE [dbo].[SCMSystem] (
    [SCMSystemID] INT IDENTITY (1, 1) NOT NULL,
    [DBVersion]   INT CONSTRAINT [DF__SCMSystem__DBVer__35BCFE0A] DEFAULT ((0)) NULL,
    [Major]       INT NULL,
    [Minor]       INT NULL,
    CONSTRAINT [PK_SCMSystem] PRIMARY KEY CLUSTERED ([SCMSystemID] ASC)
);


GO

GRANT SELECT
    ON OBJECT::[dbo].[SCMSystem] TO [SCM_Guest]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[SCMSystem] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[SCMSystem] TO [SCM_Marshall]
    AS [dbo];


GO

