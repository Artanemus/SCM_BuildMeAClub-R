USE SCMDataPool
GO

-- Create a new table called '[xlsMember]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[SCMDataPool].[dbo].[xlsMember]', 'U') IS NOT NULL
    DROP TABLE [SCMDataPool].[dbo].[xlsMember]
GO
-- Create the table in the specified schema
CREATE TABLE [SCMDataPool].[dbo].[xlsMember]
(
    [xlsMemberID] [int] IDENTITY(1, 1) NOT NULL
  , [MembershipNum] [int] NULL
  , [FirstName] [nvarchar](128) NULL
  , [LastName] [nvarchar](128) NULL
  , [DOB] [datetime] NULL
  , [IsActive] [bit] NULL
  , [IsArchived] [bit] NULL
  , [Email] [nvarchar](256) NULL
  , [GenderID] [int] NULL
  , [SwimClubID] [int] NULL
  , [CreatedOn] [datetime] NULL
  , [HouseID] [int] NULL
  , [IsSwimmer] [bit] NULL,
);
GO

INSERT INTO [SCMDataPool].[dbo].[xlsMember]
(
    [MembershipNum]
  , [FirstName]
  , [LastName]
  , [DOB]
  , [IsActive]
  , [IsArchived]
  , [Email]
  , [GenderID]
  , [SwimClubID]
  , [CreatedOn]
  , [HouseID]
  , [IsSwimmer]
)
SELECT SCMDataPool.dbo.Member.MembershipNum
     , SCMDataPool.dbo.Member.FirstName
     , SCMDataPool.dbo.Member.LastName
     , SCMDataPool.dbo.Member.DOB
     , CASE
           WHEN (SCMDataPool.dbo.Member.IsActive = 1) THEN
               1
           ELSE
               0
       END
     , CASE
           WHEN (SCMDataPool.dbo.Member.IsArchived = 1) THEN
               1
           ELSE
               0
       END
     , SCMDataPool.dbo.Member.Email
     , SCMDataPool.dbo.Member.GenderID
     , 1 -- Swimming Club ID 
     , SCMDataPool.dbo.Member.CreatedOn
     , [HouseID]
     , CASE
           WHEN (SCMDataPool.dbo.Member.IsSwimmer = 1) THEN
               1
           ELSE
               0
       END
FROM SCMDataPool.dbo.Member
GO


