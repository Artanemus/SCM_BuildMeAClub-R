USE SwimClubMeet
GO

INSERT INTO [SwimClubMeet].[dbo].[Member]
           (
--       [MembershipNum]
--      ,[MembershipStr]
--      ,[MembershipDue]
           [FirstName]
           ,[LastName]
           ,[DOB]
           ,[IsActive]
           ,[IsArchived]
--      ,[Email]
--      ,[EnableEmailOut]
           ,[GenderID]
           ,[SwimClubID]
--      ,[MembershipTypeID]
--      ,[CreatedOn]
--      ,[ArchivedOn]
--      ,[EnableEmailNomineeForm]
--      ,[EnableEmailSessionReport]
--      ,[HouseID]
           ,[IsSwimmer])
     SELECT
           SCMDataPool.dbo.Member.FirstName
           ,SCMDataPool.dbo.Member.LastName
           ,SCMDataPool.dbo.Member.DOB
           , CASE WHEN (SCMDataPool.dbo.Member.IsActive = 1) THEN 1 ELSE 0 END
           , CASE WHEN (SCMDataPool.dbo.Member.IsArchived = 1) THEN 1 ELSE 0 END
           ,SCMDataPool.dbo.Member.GenderID
           ,SCMDataPool.dbo.Member.SwimClubID
           , CASE WHEN (SCMDataPool.dbo.Member.IsSwimmer = 1) THEN 1 ELSE 0 END

		FROM SCMDataPool.dbo.Member
GO


