USE [SwimClubMeet]
GO
SET IDENTITY_INSERT [dbo].[SwimClub] ON
--z40
INSERT [dbo].[SwimClub]
(
    [SwimClubID]
  , [NickName]
  , [Caption]
  , [Email]
  , [ContactNum]
  , [WebSite]
  , [HeatAlgorithm]
  , [EnableTeamEvents]
  , [EnableSwimOThon]
  , [EnableExtHeatTypes]
  , [EnableMembershipStr]
  , [NumOfLanes]
  , [LenOfPool]
  , [StartOfSwimSeason]
  , [CreatedOn]
)
VALUES
(1, N'Utopian Nemos', N'Utopia Swimming Club', N'utopia@myemail.com', N'', N'', 1, 0, 0, 0, 0, 8, 25
, CAST(N'2019-10-16T10:04:49.403' AS DATETIME), NULL)
SET IDENTITY_INSERT [dbo].[SwimClub] OFF
GO
--z41
SET IDENTITY_INSERT [dbo].[ContactNumType] ON 
INSERT [dbo].[ContactNumType] ([ContactNumTypeID], [Caption]) VALUES (1, N'Mobile')
INSERT [dbo].[ContactNumType] ([ContactNumTypeID], [Caption]) VALUES (2, N'Home')
INSERT [dbo].[ContactNumType] ([ContactNumTypeID], [Caption]) VALUES (3, N'Business')
SET IDENTITY_INSERT [dbo].[ContactNumType] OFF
GO
--z42
SET IDENTITY_INSERT [dbo].[Distance] ON 
INSERT [dbo].[Distance] ([DistanceID], [Caption], [Meters]) VALUES (1, N'25m', 25)
INSERT [dbo].[Distance] ([DistanceID], [Caption], [Meters]) VALUES (2, N'50m', 50)
INSERT [dbo].[Distance] ([DistanceID], [Caption], [Meters]) VALUES (3, N'100m', 100)
INSERT [dbo].[Distance] ([DistanceID], [Caption], [Meters]) VALUES (4, N'200m', 200)
INSERT [dbo].[Distance] ([DistanceID], [Caption], [Meters]) VALUES (5, N'400m', 400)
INSERT [dbo].[Distance] ([DistanceID], [Caption], [Meters]) VALUES (6, N'1000m', 1000)
SET IDENTITY_INSERT [dbo].[Distance] OFF
GO
--z43
SET IDENTITY_INSERT [dbo].[EventStatus] ON 
INSERT [dbo].[EventStatus] ([EventStatusID], [Caption]) VALUES (1, N'Open')
INSERT [dbo].[EventStatus] ([EventStatusID], [Caption]) VALUES (2, N'Closed')
SET IDENTITY_INSERT [dbo].[EventStatus] OFF
GO
--z44
SET IDENTITY_INSERT [dbo].[EventType] ON 
INSERT [dbo].[EventType] ([EventTypeID], [Caption]) VALUES (1, N'Individual')
INSERT [dbo].[EventType] ([EventTypeID], [Caption]) VALUES (2, N'Team')
INSERT [dbo].[EventType] ([EventTypeID], [Caption]) VALUES (3, N'Swim-O-Thon')
SET IDENTITY_INSERT [dbo].[EventType] OFF
GO
--z45
SET IDENTITY_INSERT [dbo].[Gender] ON 
INSERT [dbo].[Gender] ([GenderID], [Caption]) VALUES (1, N'Male')
INSERT [dbo].[Gender] ([GenderID], [Caption]) VALUES (2, N'Female')
SET IDENTITY_INSERT [dbo].[Gender] OFF
GO
--z46
SET IDENTITY_INSERT [dbo].[HeatStatus] ON 
INSERT [dbo].[HeatStatus] ([HeatStatusID], [Caption]) VALUES (1, N'Open')
INSERT [dbo].[HeatStatus] ([HeatStatusID], [Caption]) VALUES (2, N'Raced')
INSERT [dbo].[HeatStatus] ([HeatStatusID], [Caption]) VALUES (3, N'Closed')
SET IDENTITY_INSERT [dbo].[HeatStatus] OFF
GO
--z47
SET IDENTITY_INSERT [dbo].[HeatType] ON 
INSERT [dbo].[HeatType] ([HeatTypeID], [Caption]) VALUES (1, N'Heat')
INSERT [dbo].[HeatType] ([HeatTypeID], [Caption]) VALUES (2, N'Quarter')
INSERT [dbo].[HeatType] ([HeatTypeID], [Caption]) VALUES (3, N'Semi')
INSERT [dbo].[HeatType] ([HeatTypeID], [Caption]) VALUES (4, N'Final')
SET IDENTITY_INSERT [dbo].[HeatType] OFF
GO
--z48
-- HOUSE DATA --
--z49
SET IDENTITY_INSERT [dbo].[MembershipType] ON 
INSERT [dbo].[MembershipType] ([MembershipTypeID], [Caption], [LongCaption], [IsSwimmer], [Sort], [AgeFrom], [AgeTo]) VALUES (1, N'Competitive Swimmer 9 years+', N'Competitive Swimmer 9 years and over', 1, 3, 9, NULL)
INSERT [dbo].[MembershipType] ([MembershipTypeID], [Caption], [LongCaption], [IsSwimmer], [Sort], [AgeFrom], [AgeTo]) VALUES (2, N'Recreational Swimmer 9 years+', N'Casual or recreational Swimmer 9 years and over, who does not compete in Metropolitan ChampionShips ', 1, 4, 9, NULL)
INSERT [dbo].[MembershipType] ([MembershipTypeID], [Caption], [LongCaption], [IsSwimmer], [Sort], [AgeFrom], [AgeTo]) VALUES (4, N'Swimmer 8 years and under', N'Swimmer 8 years and under', 1, 2, 8, 8)
INSERT [dbo].[MembershipType] ([MembershipTypeID], [Caption], [LongCaption], [IsSwimmer], [Sort], [AgeFrom], [AgeTo]) VALUES (5, N'Parent', N'For anyone involved in the club who is not competing, such as parents, volunteers, coaches and teachers. ', 0, 5, NULL, NULL)
SET IDENTITY_INSERT [dbo].[MembershipType] OFF
GO
--z50
--VERSION 1.6.0.0
--z51
SET IDENTITY_INSERT [dbo].[SessionStatus] ON 
INSERT [dbo].[SessionStatus] ([SessionStatusID], [Caption]) VALUES (1, N'Open')
INSERT [dbo].[SessionStatus] ([SessionStatusID], [Caption]) VALUES (2, N'Closed')
SET IDENTITY_INSERT [dbo].[SessionStatus] OFF
GO
--z52
SET IDENTITY_INSERT [dbo].[Stroke] ON 
INSERT [dbo].[Stroke] ([StrokeID], [Caption]) VALUES (1, N'FreeStyle')
INSERT [dbo].[Stroke] ([StrokeID], [Caption]) VALUES (2, N'BreastStroke')
INSERT [dbo].[Stroke] ([StrokeID], [Caption]) VALUES (3, N'BackStroke')
INSERT [dbo].[Stroke] ([StrokeID], [Caption]) VALUES (4, N'ButterFly')
INSERT [dbo].[Stroke] ([StrokeID], [Caption]) VALUES (5, N'Medley')
SET IDENTITY_INSERT [dbo].[Stroke] OFF
GO
--z53
SET IDENTITY_INSERT [dbo].[Qualify] ON 
INSERT [dbo].[Qualify] ([QualifyID], [TrialDistID], [QualifyDistID], [StrokeID], [TrialTime], [IsShortCourse], [GenderID], [LengthOfPool]) VALUES (1, 1, 2, 1, CAST(N'00:00:23' AS Time), 1, 1, 25)
INSERT [dbo].[Qualify] ([QualifyID], [TrialDistID], [QualifyDistID], [StrokeID], [TrialTime], [IsShortCourse], [GenderID], [LengthOfPool]) VALUES (2, 1, 2, 2, CAST(N'00:00:31' AS Time), 1, 1, 25)
INSERT [dbo].[Qualify] ([QualifyID], [TrialDistID], [QualifyDistID], [StrokeID], [TrialTime], [IsShortCourse], [GenderID], [LengthOfPool]) VALUES (3, 1, 2, 3, CAST(N'00:00:29' AS Time), 1, 1, 25)
INSERT [dbo].[Qualify] ([QualifyID], [TrialDistID], [QualifyDistID], [StrokeID], [TrialTime], [IsShortCourse], [GenderID], [LengthOfPool]) VALUES (4, 1, 2, 4, CAST(N'00:00:26' AS Time), 1, 1, 25)
INSERT [dbo].[Qualify] ([QualifyID], [TrialDistID], [QualifyDistID], [StrokeID], [TrialTime], [IsShortCourse], [GenderID], [LengthOfPool]) VALUES (5, 2, 3, 1, CAST(N'00:00:45' AS Time), 1, 1, 25)
INSERT [dbo].[Qualify] ([QualifyID], [TrialDistID], [QualifyDistID], [StrokeID], [TrialTime], [IsShortCourse], [GenderID], [LengthOfPool]) VALUES (6, 2, 3, 2, CAST(N'00:01:00' AS Time), 1, 1, 25)
INSERT [dbo].[Qualify] ([QualifyID], [TrialDistID], [QualifyDistID], [StrokeID], [TrialTime], [IsShortCourse], [GenderID], [LengthOfPool]) VALUES (7, 2, 3, 3, CAST(N'00:01:00' AS Time), 1, 1, 25)
INSERT [dbo].[Qualify] ([QualifyID], [TrialDistID], [QualifyDistID], [StrokeID], [TrialTime], [IsShortCourse], [GenderID], [LengthOfPool]) VALUES (8, 2, 3, 4, CAST(N'00:00:55' AS Time), 1, 1, 25)
INSERT [dbo].[Qualify] ([QualifyID], [TrialDistID], [QualifyDistID], [StrokeID], [TrialTime], [IsShortCourse], [GenderID], [LengthOfPool]) VALUES (9, 3, 3, 5, CAST(N'00:01:49' AS Time), 1, 1, 25)
INSERT [dbo].[Qualify] ([QualifyID], [TrialDistID], [QualifyDistID], [StrokeID], [TrialTime], [IsShortCourse], [GenderID], [LengthOfPool]) VALUES (10, 4, 4, 5, CAST(N'00:03:45' AS Time), 1, 1, 25)
INSERT [dbo].[Qualify] ([QualifyID], [TrialDistID], [QualifyDistID], [StrokeID], [TrialTime], [IsShortCourse], [GenderID], [LengthOfPool]) VALUES (11, 1, 2, 1, CAST(N'00:00:23' AS Time), 1, 2, 25)
INSERT [dbo].[Qualify] ([QualifyID], [TrialDistID], [QualifyDistID], [StrokeID], [TrialTime], [IsShortCourse], [GenderID], [LengthOfPool]) VALUES (12, 1, 2, 2, CAST(N'00:00:31' AS Time), 1, 2, 25)
INSERT [dbo].[Qualify] ([QualifyID], [TrialDistID], [QualifyDistID], [StrokeID], [TrialTime], [IsShortCourse], [GenderID], [LengthOfPool]) VALUES (13, 1, 2, 3, CAST(N'00:00:29' AS Time), 1, 2, 25)
INSERT [dbo].[Qualify] ([QualifyID], [TrialDistID], [QualifyDistID], [StrokeID], [TrialTime], [IsShortCourse], [GenderID], [LengthOfPool]) VALUES (14, 1, 2, 4, CAST(N'00:00:26' AS Time), 1, 2, 25)
INSERT [dbo].[Qualify] ([QualifyID], [TrialDistID], [QualifyDistID], [StrokeID], [TrialTime], [IsShortCourse], [GenderID], [LengthOfPool]) VALUES (15, 2, 3, 1, CAST(N'00:00:45' AS Time), 1, 2, 25)
INSERT [dbo].[Qualify] ([QualifyID], [TrialDistID], [QualifyDistID], [StrokeID], [TrialTime], [IsShortCourse], [GenderID], [LengthOfPool]) VALUES (16, 2, 3, 2, CAST(N'00:01:00' AS Time), 1, 2, 25)
INSERT [dbo].[Qualify] ([QualifyID], [TrialDistID], [QualifyDistID], [StrokeID], [TrialTime], [IsShortCourse], [GenderID], [LengthOfPool]) VALUES (17, 2, 3, 3, CAST(N'00:01:00' AS Time), 1, 2, 25)
INSERT [dbo].[Qualify] ([QualifyID], [TrialDistID], [QualifyDistID], [StrokeID], [TrialTime], [IsShortCourse], [GenderID], [LengthOfPool]) VALUES (18, 2, 3, 4, CAST(N'00:00:55' AS Time), 1, 2, 25)
INSERT [dbo].[Qualify] ([QualifyID], [TrialDistID], [QualifyDistID], [StrokeID], [TrialTime], [IsShortCourse], [GenderID], [LengthOfPool]) VALUES (19, 3, 3, 5, CAST(N'00:01:49' AS Time), 1, 2, 25)
INSERT [dbo].[Qualify] ([QualifyID], [TrialDistID], [QualifyDistID], [StrokeID], [TrialTime], [IsShortCourse], [GenderID], [LengthOfPool]) VALUES (20, 4, 4, 5, CAST(N'00:03:48' AS Time), 1, 2, 25)
INSERT [dbo].[Qualify] ([QualifyID], [TrialDistID], [QualifyDistID], [StrokeID], [TrialTime], [IsShortCourse], [GenderID], [LengthOfPool]) VALUES (21, 1, 2, 1, CAST(N'00:00:24' AS Time), 0, 1, 50)
INSERT [dbo].[Qualify] ([QualifyID], [TrialDistID], [QualifyDistID], [StrokeID], [TrialTime], [IsShortCourse], [GenderID], [LengthOfPool]) VALUES (22, 1, 2, 2, CAST(N'00:00:32' AS Time), 0, 1, 50)
INSERT [dbo].[Qualify] ([QualifyID], [TrialDistID], [QualifyDistID], [StrokeID], [TrialTime], [IsShortCourse], [GenderID], [LengthOfPool]) VALUES (23, 1, 2, 3, CAST(N'00:00:30' AS Time), 0, 1, 50)
INSERT [dbo].[Qualify] ([QualifyID], [TrialDistID], [QualifyDistID], [StrokeID], [TrialTime], [IsShortCourse], [GenderID], [LengthOfPool]) VALUES (24, 1, 2, 4, CAST(N'00:00:27' AS Time), 0, 1, 50)
INSERT [dbo].[Qualify] ([QualifyID], [TrialDistID], [QualifyDistID], [StrokeID], [TrialTime], [IsShortCourse], [GenderID], [LengthOfPool]) VALUES (25, 2, 3, 1, CAST(N'00:00:46' AS Time), 0, 1, 50)
INSERT [dbo].[Qualify] ([QualifyID], [TrialDistID], [QualifyDistID], [StrokeID], [TrialTime], [IsShortCourse], [GenderID], [LengthOfPool]) VALUES (26, 2, 3, 2, CAST(N'00:01:01' AS Time), 0, 1, 50)
INSERT [dbo].[Qualify] ([QualifyID], [TrialDistID], [QualifyDistID], [StrokeID], [TrialTime], [IsShortCourse], [GenderID], [LengthOfPool]) VALUES (27, 2, 3, 3, CAST(N'00:01:01' AS Time), 0, 1, 50)
INSERT [dbo].[Qualify] ([QualifyID], [TrialDistID], [QualifyDistID], [StrokeID], [TrialTime], [IsShortCourse], [GenderID], [LengthOfPool]) VALUES (28, 2, 3, 4, CAST(N'00:00:56' AS Time), 0, 1, 50)
INSERT [dbo].[Qualify] ([QualifyID], [TrialDistID], [QualifyDistID], [StrokeID], [TrialTime], [IsShortCourse], [GenderID], [LengthOfPool]) VALUES (29, 3, 3, 5, CAST(N'00:01:50' AS Time), 0, 1, 50)
INSERT [dbo].[Qualify] ([QualifyID], [TrialDistID], [QualifyDistID], [StrokeID], [TrialTime], [IsShortCourse], [GenderID], [LengthOfPool]) VALUES (30, 4, 4, 5, CAST(N'00:03:46' AS Time), 0, 1, 50)
INSERT [dbo].[Qualify] ([QualifyID], [TrialDistID], [QualifyDistID], [StrokeID], [TrialTime], [IsShortCourse], [GenderID], [LengthOfPool]) VALUES (31, 1, 2, 1, CAST(N'00:00:24' AS Time), 0, 2, 50)
INSERT [dbo].[Qualify] ([QualifyID], [TrialDistID], [QualifyDistID], [StrokeID], [TrialTime], [IsShortCourse], [GenderID], [LengthOfPool]) VALUES (32, 1, 2, 2, CAST(N'00:00:32' AS Time), 0, 2, 50)
INSERT [dbo].[Qualify] ([QualifyID], [TrialDistID], [QualifyDistID], [StrokeID], [TrialTime], [IsShortCourse], [GenderID], [LengthOfPool]) VALUES (33, 1, 2, 3, CAST(N'00:00:30' AS Time), 0, 2, 50)
INSERT [dbo].[Qualify] ([QualifyID], [TrialDistID], [QualifyDistID], [StrokeID], [TrialTime], [IsShortCourse], [GenderID], [LengthOfPool]) VALUES (34, 1, 2, 4, CAST(N'00:00:27' AS Time), 0, 2, 50)
INSERT [dbo].[Qualify] ([QualifyID], [TrialDistID], [QualifyDistID], [StrokeID], [TrialTime], [IsShortCourse], [GenderID], [LengthOfPool]) VALUES (35, 2, 3, 1, CAST(N'00:00:46' AS Time), 0, 2, 50)
INSERT [dbo].[Qualify] ([QualifyID], [TrialDistID], [QualifyDistID], [StrokeID], [TrialTime], [IsShortCourse], [GenderID], [LengthOfPool]) VALUES (36, 2, 3, 2, CAST(N'00:01:01' AS Time), 0, 2, 50)
INSERT [dbo].[Qualify] ([QualifyID], [TrialDistID], [QualifyDistID], [StrokeID], [TrialTime], [IsShortCourse], [GenderID], [LengthOfPool]) VALUES (37, 2, 3, 3, CAST(N'00:01:01' AS Time), 0, 2, 50)
INSERT [dbo].[Qualify] ([QualifyID], [TrialDistID], [QualifyDistID], [StrokeID], [TrialTime], [IsShortCourse], [GenderID], [LengthOfPool]) VALUES (38, 2, 3, 4, CAST(N'00:00:56' AS Time), 0, 2, 50)
INSERT [dbo].[Qualify] ([QualifyID], [TrialDistID], [QualifyDistID], [StrokeID], [TrialTime], [IsShortCourse], [GenderID], [LengthOfPool]) VALUES (39, 3, 3, 5, CAST(N'00:01:50' AS Time), 0, 2, 50)
INSERT [dbo].[Qualify] ([QualifyID], [TrialDistID], [QualifyDistID], [StrokeID], [TrialTime], [IsShortCourse], [GenderID], [LengthOfPool]) VALUES (40, 4, 4, 5, CAST(N'00:03:49' AS Time), 0, 2, 50)
SET IDENTITY_INSERT [dbo].[Qualify] OFF
GO
--zz54
SET IDENTITY_INSERT [dbo].[ScorePoints] ON 
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (1, 1, 1, 10)
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (2, 1, 2, 7)
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (3, 1, 3, 5)
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (4, 1, 4, 1)
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (5, 1, 5, 1)
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (6, 1, 6, 1)
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (7, 1, 7, 1)
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (8, 1, 8, 1)
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (9, 1, 9, 1)
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (10, 1, 10, 1)
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (11, 1, 11, 1)
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (12, 1, 12, 1)
SET IDENTITY_INSERT [dbo].[ScorePoints] OFF
GO
--z55
SET IDENTITY_INSERT [dbo].[ScoreDivision] ON 
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (1, 1, N'Boy''s 6 years', 6, 6, 1)
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (2, 1, N'Boy''s 7 years', 7, 7, 1)
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (3, 1, N'Boy''s 8 years', 8, 8, 1)
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (4, 1, N'Boy''s 9 years', 9, 9, 1)
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (5, 1, N'Boy''s 10 years', 10, 10, 1)
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (6, 1, N'Boy''s 11 years', 11, 11, 1)
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (7, 1, N'Boy''s 12 years', 12, 12, 1)
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (8, 1, N'Boy''s 13 years', 13, 13, 1)
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (9, 1, N'Boy''s 14 years', 14, 14, 1)
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (10, 1, N'Boy''s 15 years', 15, 15, 1)
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (11, 1, N'Girl''s 6 years', 6, 6, 2)
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (12, 1, N'Girl''s 7 years', 7, 7, 2)
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (13, 1, N'Girl''s 8 years', 8, 8, 2)
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (14, 1, N'Girl''s 9 years', 9, 9, 2)
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (15, 1, N'Girl''s 10 years', 10, 10, 2)
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (16, 1, N'Girl''s 11 years', 11, 11, 2)
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (17, 1, N'Girl''s 12 years', 12, 12, 2)
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (18, 1, N'Girl''s 13 years', 13, 13, 2)
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (19, 1, N'Girl''s 14 years', 14, 14, 2)
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (20, 1, N'Girl''s 15 years', 15, 15, 2)
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (21, 1, N'Boys 5 years', 0, 5, 1)
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (22, 1, N'Girls 5 years', 0, 5, 2)
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (23, 1, N'Girls 12 & under', 0, 12, 2)
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (24, 1, N'Boys 12 & under', 0, 12, 1)
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (25, 1, N'Gilrs 13 & over', 13, 99, 2)
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [Caption], [AgeFrom], [AgeTo], [GenderID]) VALUES (26, 1, N'Boys 13 & over', 13, 99, 1)
SET IDENTITY_INSERT [dbo].[ScoreDivision] OFF
GO
--z56
--CLUB LOGO

