USE [SwimClubMeet]
GO
SET IDENTITY_INSERT [dbo].[HeatStatus] ON 

INSERT [dbo].[HeatStatus] ([HeatStatusID], [Caption]) VALUES (1, N'Open')
INSERT [dbo].[HeatStatus] ([HeatStatusID], [Caption]) VALUES (2, N'Raced')
INSERT [dbo].[HeatStatus] ([HeatStatusID], [Caption]) VALUES (3, N'Closed')
SET IDENTITY_INSERT [dbo].[HeatStatus] OFF
GO
