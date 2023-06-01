USE [SwimClubMeet]
GO
SET IDENTITY_INSERT [dbo].[ScoreDivision] ON 
GO
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (1, 1, N'Boy''s 6 years', 6, 6, 1)
GO
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (2, 1, N'Boy''s 7 years', 7, 7, 1)
GO
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (3, 1, N'Boy''s 8 years', 8, 8, 1)
GO
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (4, 1, N'Boy''s 9 years', 9, 9, 1)
GO
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (5, 1, N'Boy''s 10 years', 10, 10, 1)
GO
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (6, 1, N'Boy''s 11 years', 11, 11, 1)
GO
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (7, 1, N'Boy''s 12 years', 12, 12, 1)
GO
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (8, 1, N'Boy''s 13 years', 13, 13, 1)
GO
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (9, 1, N'Boy''s 14 years', 14, 14, 1)
GO
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (10, 1, N'Boy''s 15 years', 15, 15, 1)
GO
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (11, 1, N'Girl''s 6 years', 6, 6, 2)
GO
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (12, 1, N'Girl''s 7 years', 7, 7, 2)
GO
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (13, 1, N'Girl''s 8 years', 8, 8, 2)
GO
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (14, 1, N'Girl''s 9 years', 9, 9, 2)
GO
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (15, 1, N'Girl''s 10 years', 10, 10, 2)
GO
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (16, 1, N'Girl''s 11 years', 11, 11, 2)
GO
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (17, 1, N'Girl''s 12 years', 12, 12, 2)
GO
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (18, 1, N'Girl''s 13 years', 13, 13, 2)
GO
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (19, 1, N'Girl''s 14 years', 14, 14, 2)
GO
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (20, 1, N'Girl''s 15 years', 15, 15, 2)
GO
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (21, 1, N'Boys 5 years', 0, 5, 1)
GO
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (22, 1, N'Girls 5 years', 0, 5, 2)
GO
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (23, 1, N'Girls 12 & under', 0, 12, 2)
GO
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (24, 1, N'Boys 12 & under', 0, 12, 1)
GO
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (25, 1, N'Gilrs 13 & over', 13, 99, 2)
GO
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (26, 1, N'Boys 13 & over', 13, 99, 1)
GO
SET IDENTITY_INSERT [dbo].[ScoreDivision] OFF
GO
SET IDENTITY_INSERT [dbo].[ScorePoints] ON 
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (1, 1, 1, 10)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (2, 1, 2, 9.5)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (3, 1, 3, 9)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (4, 1, 4, 8.5)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (5, 1, 5, 8)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (6, 1, 6, 7.5)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (7, 1, 7, 7)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (8, 1, 8, 6.5)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (9, 1, 9, 6)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (10, 1, 10, 5.5)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (11, 1, 11, 5)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (12, 1, 12, 4.5)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (14, 1, 13, 4)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (15, 1, 14, 4)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (16, 1, 15, 3)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (17, 1, 16, 3)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (18, 1, 17, 2)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (19, 1, 18, 2)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (20, 1, 19, 1)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (21, 1, 20, 5)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (22, 1, 21, 4)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (23, 1, 22, 3)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (24, 1, 23, 0)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (25, 1, 24, 0)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (26, 1, 25, 0)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (27, 1, 26, 0)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (28, 1, 27, 0)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (29, 1, 28, 0)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (30, 1, 29, 0)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (31, 1, 30, 0)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (32, 1, 31, 0)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (33, 1, 32, 0)
GO
SET IDENTITY_INSERT [dbo].[ScorePoints] OFF
GO
