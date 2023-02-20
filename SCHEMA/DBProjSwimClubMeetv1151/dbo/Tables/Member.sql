CREATE TABLE [dbo].[Member] (
    [MemberID]                 INT            IDENTITY (1, 1) NOT NULL,
    [MembershipNum]            INT            NULL,
    [MembershipStr]            NVARCHAR (24)  NULL,
    [MembershipDue]            DATETIME       NULL,
    [FirstName]                NVARCHAR (128) NULL,
    [LastName]                 NVARCHAR (128) NULL,
    [DOB]                      DATETIME       NULL,
    [IsArchived]               BIT            CONSTRAINT [DF_Member_IsArchived] DEFAULT ((0)) NULL,
    [IsActive]                 BIT            CONSTRAINT [DF__Member__IsActive] DEFAULT ((1)) NULL,
    [IsSwimmer]                BIT            CONSTRAINT [DF_Member_IsSwimmer] DEFAULT ((1)) NULL,
    [Email]                    NVARCHAR (256) NULL,
    [EnableEmailOut]           BIT            CONSTRAINT [DF__Member__EnableEm__2B3F6F97] DEFAULT ((0)) NULL,
    [GenderID]                 INT            NULL,
    [SwimClubID]               INT            NULL,
    [MembershipTypeID]         INT            NULL,
    [CreatedOn]                DATETIME       NULL,
    [ArchivedOn]               DATETIME       NULL,
    [EnableEmailNomineeForm]   BIT            CONSTRAINT [DF_Member_EM_NomineeForm] DEFAULT ((0)) NULL,
    [EnableEmailSessionReport] BIT            CONSTRAINT [DF_Member_EM_SessionReport] DEFAULT ((0)) NULL,
    [HouseID]                  INT            NULL,
    CONSTRAINT [PK_Member] PRIMARY KEY NONCLUSTERED ([MemberID] ASC),
    CONSTRAINT [FK_Gender_Member] FOREIGN KEY ([GenderID]) REFERENCES [dbo].[Gender] ([GenderID]) ON DELETE SET NULL,
    CONSTRAINT [FK_House_Member] FOREIGN KEY ([HouseID]) REFERENCES [dbo].[House] ([HouseID]) ON DELETE SET NULL,
    CONSTRAINT [FK_MembershipType_Member] FOREIGN KEY ([MembershipTypeID]) REFERENCES [dbo].[MembershipType] ([MembershipTypeID]) ON DELETE SET NULL,
    CONSTRAINT [FK_SwimClub_Member] FOREIGN KEY ([SwimClubID]) REFERENCES [dbo].[SwimClub] ([SwimClubID]) ON DELETE SET NULL
);


GO

GRANT SELECT
    ON OBJECT::[dbo].[Member] TO [SCM_Guest]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[Member] TO [SCM_Marshall]
    AS [dbo];


GO

GRANT INSERT
    ON OBJECT::[dbo].[Member] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT UPDATE
    ON OBJECT::[dbo].[Member] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT DELETE
    ON OBJECT::[dbo].[Member] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[Member] TO [SCM_Administrator]
    AS [dbo];


GO

