USE [SwimClubMeet]
GO
SET IDENTITY_INSERT [dbo].[SessionStatus] ON 

INSERT [dbo].[SessionStatus] ([SessionStatusID], [Caption]) VALUES (1, N'Open')
INSERT [dbo].[SessionStatus] ([SessionStatusID], [Caption]) VALUES (2, N'Closed')
SET IDENTITY_INSERT [dbo].[SessionStatus] OFF
GO
