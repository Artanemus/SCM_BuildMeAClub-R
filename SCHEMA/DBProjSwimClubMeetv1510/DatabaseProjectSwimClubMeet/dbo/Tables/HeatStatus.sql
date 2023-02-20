CREATE TABLE [dbo].[HeatStatus] (
    [HeatStatusID] INT           IDENTITY (1, 1) NOT NULL,
    [Caption]      NVARCHAR (60) NULL,
    CONSTRAINT [PK_HeatStatus] PRIMARY KEY NONCLUSTERED ([HeatStatusID] ASC)
);


GO

GRANT SELECT
    ON OBJECT::[dbo].[HeatStatus] TO [SCM_Marshall]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[HeatStatus] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[HeatStatus] TO [SCM_Guest]
    AS [dbo];


GO

