CREATE TABLE [dbo].[ContactNum] (
    [ContactNumID]     INT           IDENTITY (1, 1) NOT NULL,
    [Number]           NVARCHAR (30) NULL,
    [ContactNumTypeID] INT           NULL,
    [MemberID]         INT           NULL,
    CONSTRAINT [PK_ContactNum] PRIMARY KEY CLUSTERED ([ContactNumID] ASC),
    CONSTRAINT [FK_ContactNumType_ContactNum] FOREIGN KEY ([ContactNumTypeID]) REFERENCES [dbo].[ContactNumType] ([ContactNumTypeID]) ON DELETE SET NULL,
    CONSTRAINT [FK_Member_ContactNum] FOREIGN KEY ([MemberID]) REFERENCES [dbo].[Member] ([MemberID]) ON DELETE CASCADE
);


GO

GRANT DELETE
    ON OBJECT::[dbo].[ContactNum] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[ContactNum] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT INSERT
    ON OBJECT::[dbo].[ContactNum] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[ContactNum] TO [SCM_Guest]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[ContactNum] TO [SCM_Marshall]
    AS [dbo];


GO

GRANT UPDATE
    ON OBJECT::[dbo].[ContactNum] TO [SCM_Administrator]
    AS [dbo];


GO

