CREATE TABLE [dbo].[Members] (
    [xlsMemberID]   INT           NOT NULL,
    [MembershipNum] INT           NULL,
    [FirstName]     NVARCHAR (50) NOT NULL,
    [LastName]      NVARCHAR (50) NOT NULL,
    [DOB]           DATETIME2 (7) NOT NULL,
    [IsActive]      BIT           NOT NULL,
    [IsArchived]    BIT           NOT NULL,
    [Email]         NVARCHAR (50) NULL,
    [GenderID]      INT           NOT NULL,
    [SwimClubID]    INT           NOT NULL,
    [CreatedOn]     DATETIME2 (7) NULL,
    [HouseID]       INT           NULL,
    [IsSwimmer]     BIT           NOT NULL,
    CONSTRAINT [PK_SCMMembers] PRIMARY KEY CLUSTERED ([xlsMemberID] ASC)
);


GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'SCM Members imported from flat file', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Members';


GO

