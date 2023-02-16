CREATE TABLE [dbo].[SCMSystem] (
    [SCMSystemID] INT IDENTITY (1, 1) NOT NULL,
    [DBVersion]   INT NULL,
    [Major]       INT NULL,
    [Minor]       INT NULL
);
GO

ALTER TABLE [dbo].[SCMSystem]
    ADD CONSTRAINT [PK_SCMSystem] PRIMARY KEY CLUSTERED ([SCMSystemID] ASC);
GO

GRANT SELECT
    ON OBJECT::[dbo].[SCMSystem] TO [SCM_Guest]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[dbo].[SCMSystem] TO [SCM_Marshall]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[dbo].[SCMSystem] TO [SCM_Administrator]
    AS [dbo];
GO

ALTER TABLE [dbo].[SCMSystem]
    ADD CONSTRAINT [DF__SCMSystem__DBVer__35BCFE0A] DEFAULT ((0)) FOR [DBVersion];
GO

