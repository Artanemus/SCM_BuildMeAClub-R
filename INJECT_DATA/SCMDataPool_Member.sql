USE SwimClubMeet
GO

INSERT INTO [SwimClubMeet].[dbo].[Member]
           ([MembershipNum]
--      ,[MembershipStr]
--      ,[MembershipDue]
           ,[FirstName]
           ,[LastName]
           ,[DOB]
           ,[IsActive]
           ,[IsArchived]
           ,[Email]
--      ,[EnableEmailOut]
           ,[EnableEmailOut]
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
           
		   SCMDataPool.dbo.Member.MembershipNum
           ,SCMDataPool.dbo.Member.FirstName
           ,SCMDataPool.dbo.Member.LastName
           ,SCMDataPool.dbo.Member.DOB
           ,SCMDataPool.dbo.Member.IsActive
           ,SCMDataPool.dbo.Member.IsArchived
           ,SCMDataPool.dbo.Member.Email
           ,SCMDataPool.dbo.Member.EnableEmailOut
           ,SCMDataPool.dbo.Member.GenderID
           ,SCMDataPool.dbo.Member.SwimClubID
           ,SCMDataPool.dbo.Member.IsSwimmer 

		FROM SCMDataPool.dbo.Member
GO


