USE [SwimClubMeet]
GO
SET IDENTITY_INSERT [dbo].[EventStatus] ON 

INSERT [dbo].[EventStatus] ([EventStatusID], [Caption]) VALUES (1, N'Open')
INSERT [dbo].[EventStatus] ([EventStatusID], [Caption]) VALUES (2, N'Closed')
SET IDENTITY_INSERT [dbo].[EventStatus] OFF
GO
