USE SwimClubMeet;

INSERT INTO [SwimClubMeet].[dbo].[Member]
(
    [MembershipNum]
  --      ,[MembershipStr]
  --      ,[MembershipDue]
  , [FirstName]
  , [LastName]
  , [DOB]
  , [IsActive]
  , [IsArchived]
  --      ,[Email]
  --      ,[EnableEmailOut]
  , [GenderID]
  , [SwimClubID]
  --      ,[MembershipTypeID]
  --      ,[CreatedOn]
  --      ,[ArchivedOn]
  --      ,[EnableEmailNomineeForm]
  --      ,[EnableEmailSessionReport]
  --      ,[HouseID]
  , [IsSwimmer]
)
SELECT SCMxls.dbo.Members.MembershipNum
     , SCMxls.dbo.Members.FirstName
     , SCMxls.dbo.Members.LastName
     , SCMxls.dbo.Members.DOB
     , CASE
           WHEN (SCMxls.dbo.Members.IsActive = 1) THEN
               1
           ELSE
               0
       END
     , CASE
           WHEN (SCMxls.dbo.Members.IsArchived = 1) THEN
               1
           ELSE
               0
       END
     , SCMxls.dbo.Members.GenderID
     , SCMxls.dbo.Members.SwimClubID
     , CASE
           WHEN (SCMxls.dbo.Members.IsSwimmer = 1) THEN
               1
           ELSE
               0
       END
FROM SCMxls.dbo.Members;
GO


