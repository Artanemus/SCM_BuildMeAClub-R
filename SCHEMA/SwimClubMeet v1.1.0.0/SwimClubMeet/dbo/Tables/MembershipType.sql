CREATE TABLE [dbo].[MembershipType] (
    [MembershipTypeID] INT            IDENTITY (1, 1) NOT NULL,
    [Caption]          NVARCHAR (64)  NULL,
    [LongCaption]      NVARCHAR (128) NULL,
    [IsSwimmer]        BIT            NULL,
    [Sort]             INT            NULL,
    [AgeFrom]          INT            NULL,
    [AgeTo]            INT            NULL
);
GO

GRANT DELETE
    ON OBJECT::[dbo].[MembershipType] TO [SCM_Administrator]
    AS [dbo];
GO

GRANT INSERT
    ON OBJECT::[dbo].[MembershipType] TO [SCM_Administrator]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[dbo].[MembershipType] TO [SCM_Administrator]
    AS [dbo];
GO

GRANT UPDATE
    ON OBJECT::[dbo].[MembershipType] TO [SCM_Administrator]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[dbo].[MembershipType] TO [SCM_Marshall]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[dbo].[MembershipType] TO [SCM_Guest]
    AS [dbo];
GO

ALTER TABLE [dbo].[MembershipType]
    ADD CONSTRAINT [PK_MembershipType] PRIMARY KEY NONCLUSTERED ([MembershipTypeID] ASC);
GO

ALTER TABLE [dbo].[MembershipType]
    ADD CONSTRAINT [DF__Membershi__IsSwi__2E1BDC42] DEFAULT ((1)) FOR [IsSwimmer];
GO

