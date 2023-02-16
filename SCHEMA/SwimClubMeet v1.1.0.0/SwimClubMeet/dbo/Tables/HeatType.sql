CREATE TABLE [dbo].[HeatType] (
    [HeatTypeID] INT            IDENTITY (1, 1) NOT NULL,
    [Caption]    NVARCHAR (128) NULL
);
GO

ALTER TABLE [dbo].[HeatType]
    ADD CONSTRAINT [PK_HeatType] PRIMARY KEY NONCLUSTERED ([HeatTypeID] ASC);
GO

GRANT SELECT
    ON OBJECT::[dbo].[HeatType] TO [SCM_Guest]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[dbo].[HeatType] TO [SCM_Administrator]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[dbo].[HeatType] TO [SCM_Marshall]
    AS [dbo];
GO

