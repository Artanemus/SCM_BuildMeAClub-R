USE [SwimClubMeet]
GO
SET IDENTITY_INSERT [dbo].[EventType] ON 

INSERT [dbo].[EventType] ([EventTypeID], [Caption]) VALUES (1, N'Individual')
INSERT [dbo].[EventType] ([EventTypeID], [Caption]) VALUES (2, N'Team')
INSERT [dbo].[EventType] ([EventTypeID], [Caption]) VALUES (3, N'Swim-O-Thon')
SET IDENTITY_INSERT [dbo].[EventType] OFF
GO
