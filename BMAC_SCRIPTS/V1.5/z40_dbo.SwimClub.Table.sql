USE [SwimClubMeet]
GO
SET IDENTITY_INSERT [dbo].[SwimClub] ON 

INSERT [dbo].[SwimClub] ([SwimClubID], [NickName], [Caption], [Email], [ContactNum], [WebSite], [HeatAlgorithm], [EnableTeamEvents], [EnableSwimOThon], [EnableExtHeatTypes], [EnableMembershipStr], [NumOfLanes], [LenOfPool], [StartOfSwimSeason], [CreatedOn]) VALUES (1, N'Utopian Nemos', N'Utopia Swimming Club', N'utopia@myemail.com', N'', N'', 1, 0, 0, 0, 0, 8, 25, CAST(N'2019-10-16T10:04:49.403' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[SwimClub] OFF
GO
