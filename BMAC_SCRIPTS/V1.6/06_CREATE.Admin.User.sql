USE [SwimClubMeet]
GO
/****** Object:  User [scmAdmin]    Script Date: 16/04/22 11:52:21 AM ******/
CREATE USER [scmAdmin] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[scmAdmin]
GO
ALTER ROLE [SCM_Administrator] ADD MEMBER [scmAdmin]
GO
