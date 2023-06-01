USE [SwimClubMeet]
GO
SET IDENTITY_INSERT [dbo].[ContactNumType] ON 
GO
INSERT [dbo].[ContactNumType] ([ContactNumTypeID], [Caption]) VALUES (1, N'Mobile')
GO
INSERT [dbo].[ContactNumType] ([ContactNumTypeID], [Caption]) VALUES (2, N'Home')
GO
INSERT [dbo].[ContactNumType] ([ContactNumTypeID], [Caption]) VALUES (3, N'Business')
GO
SET IDENTITY_INSERT [dbo].[ContactNumType] OFF
GO
SET IDENTITY_INSERT [dbo].[Distance] ON 
GO
INSERT [dbo].[Distance] ([DistanceID], [Caption], [Meters]) VALUES (1, N'25m', 25)
GO
INSERT [dbo].[Distance] ([DistanceID], [Caption], [Meters]) VALUES (2, N'50m', 50)
GO
INSERT [dbo].[Distance] ([DistanceID], [Caption], [Meters]) VALUES (3, N'100m', 100)
GO
INSERT [dbo].[Distance] ([DistanceID], [Caption], [Meters]) VALUES (4, N'200m', 200)
GO
INSERT [dbo].[Distance] ([DistanceID], [Caption], [Meters]) VALUES (5, N'400m', 400)
GO
INSERT [dbo].[Distance] ([DistanceID], [Caption], [Meters]) VALUES (6, N'1000m', 1000)
GO
SET IDENTITY_INSERT [dbo].[Distance] OFF
GO
SET IDENTITY_INSERT [dbo].[EventStatus] ON 
GO
INSERT [dbo].[EventStatus] ([EventStatusID], [Caption]) VALUES (1, N'Open')
GO
INSERT [dbo].[EventStatus] ([EventStatusID], [Caption]) VALUES (2, N'Closed')
GO
SET IDENTITY_INSERT [dbo].[EventStatus] OFF
GO
SET IDENTITY_INSERT [dbo].[EventType] ON 
GO
INSERT [dbo].[EventType] ([EventTypeID], [Caption]) VALUES (1, N'Individual')
GO
INSERT [dbo].[EventType] ([EventTypeID], [Caption]) VALUES (2, N'Team')
GO
INSERT [dbo].[EventType] ([EventTypeID], [Caption]) VALUES (3, N'Swim-O-Thon')
GO
SET IDENTITY_INSERT [dbo].[EventType] OFF
GO
SET IDENTITY_INSERT [dbo].[Gender] ON 
GO
INSERT [dbo].[Gender] ([GenderID], [Caption]) VALUES (1, N'Male')
GO
INSERT [dbo].[Gender] ([GenderID], [Caption]) VALUES (2, N'Female')
GO
SET IDENTITY_INSERT [dbo].[Gender] OFF
GO
SET IDENTITY_INSERT [dbo].[HeatStatus] ON 
GO
INSERT [dbo].[HeatStatus] ([HeatStatusID], [Caption]) VALUES (1, N'Open')
GO
INSERT [dbo].[HeatStatus] ([HeatStatusID], [Caption]) VALUES (2, N'Raced')
GO
INSERT [dbo].[HeatStatus] ([HeatStatusID], [Caption]) VALUES (3, N'Closed')
GO
SET IDENTITY_INSERT [dbo].[HeatStatus] OFF
GO
SET IDENTITY_INSERT [dbo].[HeatType] ON 
GO
INSERT [dbo].[HeatType] ([HeatTypeID], [Caption]) VALUES (1, N'Heat')
GO
INSERT [dbo].[HeatType] ([HeatTypeID], [Caption]) VALUES (2, N'Quarter')
GO
INSERT [dbo].[HeatType] ([HeatTypeID], [Caption]) VALUES (3, N'Semi')
GO
INSERT [dbo].[HeatType] ([HeatTypeID], [Caption]) VALUES (4, N'Final')
GO
SET IDENTITY_INSERT [dbo].[HeatType] OFF
GO
SET IDENTITY_INSERT [dbo].[MembershipType] ON 
GO
INSERT [dbo].[MembershipType] ([MembershipTypeID], [Caption], [LongCaption], [IsSwimmer], [Sort], [AgeFrom], [AgeTo]) VALUES (1, N'Competitive 9 years+', N'Competitive Swimmer 9 years and over', 1, 3, 9, NULL)
GO
INSERT [dbo].[MembershipType] ([MembershipTypeID], [Caption], [LongCaption], [IsSwimmer], [Sort], [AgeFrom], [AgeTo]) VALUES (2, N'Recreational 9 years+', N'Casual or recreational Swimmer 9 years and over, who does not compete in Metropolitan ChampionShips ', 1, 4, 9, NULL)
GO
INSERT [dbo].[MembershipType] ([MembershipTypeID], [Caption], [LongCaption], [IsSwimmer], [Sort], [AgeFrom], [AgeTo]) VALUES (4, N'8 years and under', N'Swimmer 8 years and under', 1, 2, 8, 8)
GO
INSERT [dbo].[MembershipType] ([MembershipTypeID], [Caption], [LongCaption], [IsSwimmer], [Sort], [AgeFrom], [AgeTo]) VALUES (5, N'Parent', N'For anyone involved in the club who is not competing, such as parents, volunteers, coaches and teachers. ', 0, 5, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[MembershipType] OFF
GO
SET IDENTITY_INSERT [dbo].[SCMSystem] ON 
GO
INSERT [dbo].[SCMSystem] ([SCMSystemID], [DBVersion], [Major], [Minor]) VALUES (1, 1, 5, 3)
GO
SET IDENTITY_INSERT [dbo].[SCMSystem] OFF
GO
SET IDENTITY_INSERT [dbo].[SessionStatus] ON 
GO
INSERT [dbo].[SessionStatus] ([SessionStatusID], [Caption]) VALUES (1, N'Open')
GO
INSERT [dbo].[SessionStatus] ([SessionStatusID], [Caption]) VALUES (2, N'Closed')
GO
SET IDENTITY_INSERT [dbo].[SessionStatus] OFF
GO
SET IDENTITY_INSERT [dbo].[Stroke] ON 
GO
INSERT [dbo].[Stroke] ([StrokeID], [Caption]) VALUES (1, N'FreeStyle')
GO
INSERT [dbo].[Stroke] ([StrokeID], [Caption]) VALUES (2, N'BreastStroke')
GO
INSERT [dbo].[Stroke] ([StrokeID], [Caption]) VALUES (3, N'BackStroke')
GO
INSERT [dbo].[Stroke] ([StrokeID], [Caption]) VALUES (4, N'ButterFly')
GO
INSERT [dbo].[Stroke] ([StrokeID], [Caption]) VALUES (5, N'Medley')
GO
SET IDENTITY_INSERT [dbo].[Stroke] OFF
GO
SET IDENTITY_INSERT [dbo].[SwimClub] ON 
GO
INSERT [dbo].[SwimClub] ([SwimClubID], [NickName], [Caption], [Email], [ContactNum], [WebSite], [HeatAlgorithm], [EnableTeamEvents], [EnableSwimOThon], [EnableExtHeatTypes], [EnableMembershipStr], [NumOfLanes], [LenOfPool], [StartOfSwimSeason], [CreatedOn], [LogoDir], [LogoImg], [LogoType]) VALUES (1, N'Utopian Nemos', N'Utopia Swimming Club', N'utopia@myemail.com', N'', N'', 1, 0, 0, 0, 0, 8, 25, CAST(N'2021-09-01T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[SwimClub] OFF
GO
