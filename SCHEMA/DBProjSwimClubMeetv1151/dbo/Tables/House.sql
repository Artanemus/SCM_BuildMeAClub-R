CREATE TABLE [dbo].[House] (
    [HouseID] INT            IDENTITY (1, 1) NOT NULL,
    [Caption] NVARCHAR (128) NULL,
    [Motto]   NVARCHAR (128) NULL,
    [Color]   INT            NULL,
    [LogoDir] VARCHAR (MAX)  NULL,
    [LogoImg] IMAGE          NULL,
    CONSTRAINT [PK_House] PRIMARY KEY CLUSTERED ([HouseID] ASC)
);


GO

GRANT SELECT
    ON OBJECT::[dbo].[House] TO [SCM_Guest]
    AS [dbo];


GO

GRANT DELETE
    ON OBJECT::[dbo].[House] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[House] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[House] TO [SCM_Marshall]
    AS [dbo];


GO

GRANT UPDATE
    ON OBJECT::[dbo].[House] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT INSERT
    ON OBJECT::[dbo].[House] TO [SCM_Administrator]
    AS [dbo];


GO

