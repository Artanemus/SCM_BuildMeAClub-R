USE [SwimClubMeet]
GO
SET IDENTITY_INSERT [dbo].[MembershipType] ON 

INSERT [dbo].[MembershipType] ([MembershipTypeID], [Caption], [LongCaption], [IsSwimmer], [Sort], [AgeFrom], [AgeTo]) VALUES (1, N'Competitive Swimmer 9 years+', N'Competitive Swimmer 9 years and over', 1, 3, 9, NULL)
INSERT [dbo].[MembershipType] ([MembershipTypeID], [Caption], [LongCaption], [IsSwimmer], [Sort], [AgeFrom], [AgeTo]) VALUES (2, N'Recreational Swimmer 9 years+', N'Casual or recreational Swimmer 9 years and over, who does not compete in Metropolitan ChampionShips ', 1, 4, 9, NULL)
INSERT [dbo].[MembershipType] ([MembershipTypeID], [Caption], [LongCaption], [IsSwimmer], [Sort], [AgeFrom], [AgeTo]) VALUES (4, N'Swimmer 8 years and under', N'Swimmer 8 years and under', 1, 2, 8, 8)
INSERT [dbo].[MembershipType] ([MembershipTypeID], [Caption], [LongCaption], [IsSwimmer], [Sort], [AgeFrom], [AgeTo]) VALUES (5, N'Parent', N'For anyone involved in the club who is not competing, such as parents, volunteers, coaches and teachers. ', 0, 5, NULL, NULL)
SET IDENTITY_INSERT [dbo].[MembershipType] OFF
GO
