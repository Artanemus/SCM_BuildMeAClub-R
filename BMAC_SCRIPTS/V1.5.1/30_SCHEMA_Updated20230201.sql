USE [SwimClubMeet]
GO
/****** Object:  Table [dbo].[ContactNum]    Script Date: 20/08/22 11:41:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactNum](
	[ContactNumID] [int] IDENTITY(1,1) NOT NULL,
	[Number] [nvarchar](30) NULL,
	[ContactNumTypeID] [int] NULL,
	[MemberID] [int] NULL,
 CONSTRAINT [PK_ContactNum] PRIMARY KEY CLUSTERED 
(
	[ContactNumID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
GRANT DELETE ON [dbo].[ContactNum] TO [SCM_Administrator] AS [dbo]
GO
GRANT INSERT ON [dbo].[ContactNum] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[ContactNum] TO [SCM_Administrator] AS [dbo]
GO
GRANT UPDATE ON [dbo].[ContactNum] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[ContactNum] TO [SCM_Guest] AS [dbo]
GO
GRANT SELECT ON [dbo].[ContactNum] TO [SCM_Marshall] AS [dbo]
GO
/****** Object:  Table [dbo].[ContactNumType]    Script Date: 20/08/22 11:41:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactNumType](
	[ContactNumTypeID] [int] IDENTITY(1,1) NOT NULL,
	[Caption] [nvarchar](30) NULL,
 CONSTRAINT [PK_ContactNumType] PRIMARY KEY CLUSTERED 
(
	[ContactNumTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
GRANT SELECT ON [dbo].[ContactNumType] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[ContactNumType] TO [SCM_Guest] AS [dbo]
GO
GRANT SELECT ON [dbo].[ContactNumType] TO [SCM_Marshall] AS [dbo]
GO
/****** Object:  Table [dbo].[Distance]    Script Date: 20/08/22 11:41:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Distance](
	[DistanceID] [int] IDENTITY(1,1) NOT NULL,
	[Caption] [nvarchar](128) NULL,
	[Meters] [int] NULL,
 CONSTRAINT [PK_Distance] PRIMARY KEY NONCLUSTERED 
(
	[DistanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
GRANT SELECT ON [dbo].[Distance] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[Distance] TO [SCM_Guest] AS [dbo]
GO
GRANT SELECT ON [dbo].[Distance] TO [SCM_Marshall] AS [dbo]
GO
/****** Object:  Table [dbo].[Entrant]    Script Date: 20/08/22 11:41:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Entrant](
	[EntrantID] [int] IDENTITY(1,1) NOT NULL,
	[MemberID] [int] NULL,
	[Lane] [int] NULL,
	[RaceTime] [time](7) NULL,
	[TimeToBeat] [time](7) NULL,
	[PersonalBest] [time](7) NULL,
	[IsDisqualified] [bit] NULL,
	[IsScratched] [bit] NULL,
	[HeatID] [int] NULL,
 CONSTRAINT [PK_Entrant] PRIMARY KEY NONCLUSTERED 
(
	[EntrantID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
GRANT DELETE ON [dbo].[Entrant] TO [SCM_Administrator] AS [dbo]
GO
GRANT INSERT ON [dbo].[Entrant] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[Entrant] TO [SCM_Administrator] AS [dbo]
GO
GRANT UPDATE ON [dbo].[Entrant] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[Entrant] TO [SCM_Guest] AS [dbo]
GO
GRANT DELETE ON [dbo].[Entrant] TO [SCM_Marshall] AS [dbo]
GO
GRANT INSERT ON [dbo].[Entrant] TO [SCM_Marshall] AS [dbo]
GO
GRANT SELECT ON [dbo].[Entrant] TO [SCM_Marshall] AS [dbo]
GO
GRANT UPDATE ON [dbo].[Entrant] TO [SCM_Marshall] AS [dbo]
GO
/****** Object:  Table [dbo].[Event]    Script Date: 20/08/22 11:41:09 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Event](
	[EventID] [int] IDENTITY(1,1) NOT NULL,
	[EventNum] [int] NULL,
	[Caption] [nvarchar](128) NULL,
	[ClosedDT] [datetime] NULL,
	[SessionID] [int] NULL,
	[EventTypeID] [int] NULL,
	[StrokeID] [int] NULL,
	[DistanceID] [int] NULL,
	[EventStatusID] [int] NULL,
 CONSTRAINT [PK_Event] PRIMARY KEY NONCLUSTERED 
(
	[EventID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
GRANT DELETE ON [dbo].[Event] TO [SCM_Administrator] AS [dbo]
GO
GRANT INSERT ON [dbo].[Event] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[Event] TO [SCM_Administrator] AS [dbo]
GO
GRANT UPDATE ON [dbo].[Event] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[Event] TO [SCM_Guest] AS [dbo]
GO
GRANT SELECT ON [dbo].[Event] TO [SCM_Marshall] AS [dbo]
GO
/****** Object:  Table [dbo].[EventStatus]    Script Date: 20/08/22 11:41:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventStatus](
	[EventStatusID] [int] IDENTITY(1,1) NOT NULL,
	[Caption] [nvarchar](32) NULL,
 CONSTRAINT [PK_EventStatus] PRIMARY KEY NONCLUSTERED 
(
	[EventStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
GRANT SELECT ON [dbo].[EventStatus] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[EventStatus] TO [SCM_Guest] AS [dbo]
GO
GRANT SELECT ON [dbo].[EventStatus] TO [SCM_Marshall] AS [dbo]
GO
/****** Object:  Table [dbo].[EventType]    Script Date: 20/08/22 11:41:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventType](
	[EventTypeID] [int] IDENTITY(1,1) NOT NULL,
	[Caption] [nvarchar](128) NULL,
 CONSTRAINT [PK_EventType] PRIMARY KEY NONCLUSTERED 
(
	[EventTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
GRANT SELECT ON [dbo].[EventType] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[EventType] TO [SCM_Guest] AS [dbo]
GO
GRANT SELECT ON [dbo].[EventType] TO [SCM_Marshall] AS [dbo]
GO
/****** Object:  Table [dbo].[Gender]    Script Date: 20/08/22 11:41:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Gender](
	[GenderID] [int] IDENTITY(1,1) NOT NULL,
	[Caption] [nvarchar](20) NULL,
 CONSTRAINT [PK_Gender] PRIMARY KEY NONCLUSTERED 
(
	[GenderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
GRANT SELECT ON [dbo].[Gender] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[Gender] TO [SCM_Guest] AS [dbo]
GO
GRANT SELECT ON [dbo].[Gender] TO [SCM_Marshall] AS [dbo]
GO
/****** Object:  Table [dbo].[HeatIndividual]    Script Date: 20/08/22 11:41:09 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HeatIndividual](
	[HeatID] [int] IDENTITY(1,1) NOT NULL,
	[HeatNum] [int] NULL,
	[Caption] [nvarchar](128) NULL,
	[ClosedDT] [datetime] NULL,
	[EventID] [int] NULL,
	[HeatTypeID] [int] NULL,
	[HeatStatusID] [int] NULL,
 CONSTRAINT [PK_HeatIndividual] PRIMARY KEY NONCLUSTERED 
(
	[HeatID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
GRANT DELETE ON [dbo].[HeatIndividual] TO [SCM_Administrator] AS [dbo]
GO
GRANT INSERT ON [dbo].[HeatIndividual] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[HeatIndividual] TO [SCM_Administrator] AS [dbo]
GO
GRANT UPDATE ON [dbo].[HeatIndividual] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[HeatIndividual] TO [SCM_Guest] AS [dbo]
GO
GRANT DELETE ON [dbo].[HeatIndividual] TO [SCM_Marshall] AS [dbo]
GO
GRANT INSERT ON [dbo].[HeatIndividual] TO [SCM_Marshall] AS [dbo]
GO
GRANT SELECT ON [dbo].[HeatIndividual] TO [SCM_Marshall] AS [dbo]
GO
GRANT UPDATE ON [dbo].[HeatIndividual] TO [SCM_Marshall] AS [dbo]
GO
/****** Object:  Table [dbo].[HeatStatus]    Script Date: 20/08/22 11:41:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HeatStatus](
	[HeatStatusID] [int] IDENTITY(1,1) NOT NULL,
	[Caption] [nvarchar](60) NULL,
 CONSTRAINT [PK_HeatStatus] PRIMARY KEY NONCLUSTERED 
(
	[HeatStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
GRANT SELECT ON [dbo].[HeatStatus] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[HeatStatus] TO [SCM_Guest] AS [dbo]
GO
GRANT SELECT ON [dbo].[HeatStatus] TO [SCM_Marshall] AS [dbo]
GO
/****** Object:  Table [dbo].[HeatTeam]    Script Date: 20/08/22 11:41:09 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HeatTeam](
	[HeatID] [int] IDENTITY(1,1) NOT NULL,
	[HeatNum] [int] NULL,
	[Caption] [nvarchar](128) NULL,
	[ClosedDT] [datetime] NULL,
	[EventID] [int] NULL,
	[HeatTypeID] [int] NULL,
	[HeatStatusID] [int] NULL,
 CONSTRAINT [PK_HeatTeam] PRIMARY KEY NONCLUSTERED 
(
	[HeatID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
GRANT DELETE ON [dbo].[HeatTeam] TO [SCM_Administrator] AS [dbo]
GO
GRANT INSERT ON [dbo].[HeatTeam] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[HeatTeam] TO [SCM_Administrator] AS [dbo]
GO
GRANT UPDATE ON [dbo].[HeatTeam] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[HeatTeam] TO [SCM_Guest] AS [dbo]
GO
GRANT DELETE ON [dbo].[HeatTeam] TO [SCM_Marshall] AS [dbo]
GO
GRANT INSERT ON [dbo].[HeatTeam] TO [SCM_Marshall] AS [dbo]
GO
GRANT SELECT ON [dbo].[HeatTeam] TO [SCM_Marshall] AS [dbo]
GO
GRANT UPDATE ON [dbo].[HeatTeam] TO [SCM_Marshall] AS [dbo]
GO
/****** Object:  Table [dbo].[HeatType]    Script Date: 20/08/22 11:41:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HeatType](
	[HeatTypeID] [int] IDENTITY(1,1) NOT NULL,
	[Caption] [nvarchar](128) NULL,
 CONSTRAINT [PK_HeatType] PRIMARY KEY NONCLUSTERED 
(
	[HeatTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
GRANT SELECT ON [dbo].[HeatType] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[HeatType] TO [SCM_Guest] AS [dbo]
GO
GRANT SELECT ON [dbo].[HeatType] TO [SCM_Marshall] AS [dbo]
GO
/****** Object:  Table [dbo].[House]    Script Date: 20/08/22 11:41:09 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[House](
	[HouseID] [int] IDENTITY(1,1) NOT NULL,
	[Caption] [nvarchar](128) NULL,
	[Motto] [nvarchar](128) NULL,
	[Color] [int] NULL,
	[LogoDir] [varchar](max) NULL,
	[LogoImg] [image] NULL,
 CONSTRAINT [PK_House] PRIMARY KEY CLUSTERED 
(
	[HouseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
GRANT DELETE ON [dbo].[House] TO [SCM_Administrator] AS [dbo]
GO
GRANT INSERT ON [dbo].[House] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[House] TO [SCM_Administrator] AS [dbo]
GO
GRANT UPDATE ON [dbo].[House] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[House] TO [SCM_Guest] AS [dbo]
GO
GRANT SELECT ON [dbo].[House] TO [SCM_Marshall] AS [dbo]
GO
/****** Object:  Table [dbo].[Member]    Script Date: 20/08/22 11:41:09 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member](
	[MemberID] [int] IDENTITY(1,1) NOT NULL,
	[MembershipNum] [int] NULL,
	[MembershipStr] [nvarchar](24) NULL,
	[MembershipDue] [datetime] NULL,
	[FirstName] [nvarchar](128) NULL,
	[LastName] [nvarchar](128) NULL,
	[DOB] [datetime] NULL,
	[IsArchived] [bit] DEFAULT 0,
	[IsActive] [bit] DEFAULT 1,
	[IsSwimmer] [bit] DEFAULT 1,
	[Email] [nvarchar](256) NULL,
	[EnableEmailOut] [bit] NULL,
	[GenderID] [int] NULL,
	[SwimClubID] [int] NULL,
	[MembershipTypeID] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[ArchivedOn] [datetime] NULL,
	[EnableEmailNomineeForm] [bit] NULL,
	[EnableEmailSessionReport] [bit] NULL,
	[HouseID] [int] NULL,
 CONSTRAINT [PK_Member] PRIMARY KEY NONCLUSTERED 
(
	[MemberID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
GRANT DELETE ON [dbo].[Member] TO [SCM_Administrator] AS [dbo]
GO
GRANT INSERT ON [dbo].[Member] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[Member] TO [SCM_Administrator] AS [dbo]
GO
GRANT UPDATE ON [dbo].[Member] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[Member] TO [SCM_Guest] AS [dbo]
GO
GRANT SELECT ON [dbo].[Member] TO [SCM_Marshall] AS [dbo]
GO
/****** Object:  Table [dbo].[MembershipType]    Script Date: 20/08/22 11:41:09 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MembershipType](
	[MembershipTypeID] [int] IDENTITY(1,1) NOT NULL,
	[Caption] [nvarchar](64) NULL,
	[LongCaption] [nvarchar](128) NULL,
	[IsSwimmer] [bit] NULL,
	[Sort] [int] NULL,
	[AgeFrom] [int] NULL,
	[AgeTo] [int] NULL,
 CONSTRAINT [PK_MembershipType] PRIMARY KEY NONCLUSTERED 
(
	[MembershipTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
GRANT DELETE ON [dbo].[MembershipType] TO [SCM_Administrator] AS [dbo]
GO
GRANT INSERT ON [dbo].[MembershipType] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[MembershipType] TO [SCM_Administrator] AS [dbo]
GO
GRANT UPDATE ON [dbo].[MembershipType] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[MembershipType] TO [SCM_Guest] AS [dbo]
GO
GRANT SELECT ON [dbo].[MembershipType] TO [SCM_Marshall] AS [dbo]
GO
/****** Object:  Table [dbo].[Nominee]    Script Date: 20/08/22 11:41:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Nominee](
	[NomineeID] [int] IDENTITY(1,1) NOT NULL,
	[TTB] [time](7) NULL,
	[PB] [time](7) NULL,
	[SeedTime] [time](7) NULL,
	[AutoBuildFlag] [bit] NULL,
	[EventID] [int] NULL,
	[MemberID] [int] NULL,
 CONSTRAINT [PK_Nominee] PRIMARY KEY CLUSTERED 
(
	[NomineeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
GRANT DELETE ON [dbo].[Nominee] TO [SCM_Administrator] AS [dbo]
GO
GRANT INSERT ON [dbo].[Nominee] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[Nominee] TO [SCM_Administrator] AS [dbo]
GO
GRANT UPDATE ON [dbo].[Nominee] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[Nominee] TO [SCM_Guest] AS [dbo]
GO
GRANT DELETE ON [dbo].[Nominee] TO [SCM_Marshall] AS [dbo]
GO
GRANT INSERT ON [dbo].[Nominee] TO [SCM_Marshall] AS [dbo]
GO
GRANT SELECT ON [dbo].[Nominee] TO [SCM_Marshall] AS [dbo]
GO
GRANT UPDATE ON [dbo].[Nominee] TO [SCM_Marshall] AS [dbo]
GO
/****** Object:  Table [dbo].[Qualify]    Script Date: 20/08/22 11:41:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Qualify](
	[QualifyID] [int] IDENTITY(1,1) NOT NULL,
	[TrialDistID] [int] NULL,
	[QualifyDistID] [int] NULL,
	[StrokeID] [int] NULL,
	[TrialTime] [time](7) NULL,
	[IsShortCourse] [bit] NULL,
	[GenderID] [int] NULL,
	[LengthOfPool] [int] NULL,
 CONSTRAINT [PK_Qualify] PRIMARY KEY CLUSTERED 
(
	[QualifyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
GRANT DELETE ON [dbo].[Qualify] TO [SCM_Administrator] AS [dbo]
GO
GRANT INSERT ON [dbo].[Qualify] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[Qualify] TO [SCM_Administrator] AS [dbo]
GO
GRANT UPDATE ON [dbo].[Qualify] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[Qualify] TO [SCM_Guest] AS [dbo]
GO
GRANT SELECT ON [dbo].[Qualify] TO [SCM_Marshall] AS [dbo]
GO
/****** Object:  Table [dbo].[SCMSystem]    Script Date: 20/08/22 11:41:09 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SCMSystem](
	[SCMSystemID] [int] IDENTITY(1,1) NOT NULL,
	[DBVersion] [int] NULL,
	[Major] [int] NULL,
	[Minor] [int] NULL,
 CONSTRAINT [PK_SCMSystem] PRIMARY KEY CLUSTERED 
(
	[SCMSystemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
GRANT SELECT ON [dbo].[SCMSystem] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[SCMSystem] TO [SCM_Guest] AS [dbo]
GO
GRANT SELECT ON [dbo].[SCMSystem] TO [SCM_Marshall] AS [dbo]
GO
/****** Object:  Table [dbo].[ScoreDivision]    Script Date: 20/08/22 11:41:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ScoreDivision](
	[ScoreDivisionID] [int] IDENTITY(1,1) NOT NULL,
	[SwimClubID] [int] NULL,
	[Caption] [nvarchar](128) NULL,
	[AgeFrom] [int] NULL,
	[AgeTo] [int] NULL,
	[GenderID] [int] NULL,
 CONSTRAINT [PK_ScoreDivision] PRIMARY KEY CLUSTERED 
(
	[ScoreDivisionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
GRANT DELETE ON [dbo].[ScoreDivision] TO [SCM_Administrator] AS [dbo]
GO
GRANT INSERT ON [dbo].[ScoreDivision] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[ScoreDivision] TO [SCM_Administrator] AS [dbo]
GO
GRANT UPDATE ON [dbo].[ScoreDivision] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[ScoreDivision] TO [SCM_Guest] AS [dbo]
GO
GRANT SELECT ON [dbo].[ScoreDivision] TO [SCM_Marshall] AS [dbo]
GO
/****** Object:  Table [dbo].[ScorePoints]    Script Date: 20/08/22 11:41:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ScorePoints](
	[ScorePointsID] [int] IDENTITY(1,1) NOT NULL,
	[SwimClubID] [int] NULL,
	[Place] [int] NULL,
	[Points] [float] NULL,
 CONSTRAINT [PK_ScorePoints] PRIMARY KEY CLUSTERED 
(
	[ScorePointsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
GRANT DELETE ON [dbo].[ScorePoints] TO [SCM_Administrator] AS [dbo]
GO
GRANT INSERT ON [dbo].[ScorePoints] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[ScorePoints] TO [SCM_Administrator] AS [dbo]
GO
GRANT UPDATE ON [dbo].[ScorePoints] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[ScorePoints] TO [SCM_Guest] AS [dbo]
GO
GRANT SELECT ON [dbo].[ScorePoints] TO [SCM_Marshall] AS [dbo]
GO
/****** Object:  Table [dbo].[Session]    Script Date: 20/08/22 11:41:09 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Session](
	[SessionID] [int] IDENTITY(1,1) NOT NULL,
	[Caption] [nvarchar](128) NULL,
	[SessionStart] [datetime] NULL,
	[ClosedDT] [datetime] NULL,
	[SwimClubID] [int] NULL,
	[SessionStatusID] [int] NULL,
 CONSTRAINT [PK_Session] PRIMARY KEY NONCLUSTERED 
(
	[SessionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
GRANT DELETE ON [dbo].[Session] TO [SCM_Administrator] AS [dbo]
GO
GRANT INSERT ON [dbo].[Session] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[Session] TO [SCM_Administrator] AS [dbo]
GO
GRANT UPDATE ON [dbo].[Session] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[Session] TO [SCM_Guest] AS [dbo]
GO
GRANT SELECT ON [dbo].[Session] TO [SCM_Marshall] AS [dbo]
GO
/****** Object:  Table [dbo].[SessionStatus]    Script Date: 20/08/22 11:41:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SessionStatus](
	[SessionStatusID] [int] IDENTITY(1,1) NOT NULL,
	[Caption] [nvarchar](32) NULL,
 CONSTRAINT [PK_SessionStatus] PRIMARY KEY NONCLUSTERED 
(
	[SessionStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
GRANT SELECT ON [dbo].[SessionStatus] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[SessionStatus] TO [SCM_Guest] AS [dbo]
GO
GRANT SELECT ON [dbo].[SessionStatus] TO [SCM_Marshall] AS [dbo]
GO
/****** Object:  Table [dbo].[Split]    Script Date: 20/08/22 11:41:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Split](
	[SplitID] [int] IDENTITY(1,1) NOT NULL,
	[SplitTime] [time](7) NULL,
	[EntrantID] [int] NULL,
 CONSTRAINT [PK_Split] PRIMARY KEY NONCLUSTERED 
(
	[SplitID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
GRANT DELETE ON [dbo].[Split] TO [SCM_Administrator] AS [dbo]
GO
GRANT INSERT ON [dbo].[Split] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[Split] TO [SCM_Administrator] AS [dbo]
GO
GRANT UPDATE ON [dbo].[Split] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[Split] TO [SCM_Guest] AS [dbo]
GO
GRANT SELECT ON [dbo].[Split] TO [SCM_Marshall] AS [dbo]
GO
/****** Object:  Table [dbo].[Stroke]    Script Date: 20/08/22 11:41:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stroke](
	[StrokeID] [int] IDENTITY(1,1) NOT NULL,
	[Caption] [nvarchar](128) NULL,
 CONSTRAINT [PK_Stroke] PRIMARY KEY NONCLUSTERED 
(
	[StrokeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
GRANT SELECT ON [dbo].[Stroke] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[Stroke] TO [SCM_Guest] AS [dbo]
GO
GRANT SELECT ON [dbo].[Stroke] TO [SCM_Marshall] AS [dbo]
GO
/****** Object:  Table [dbo].[SwimClub]    Script Date: 20/08/22 11:41:09 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SwimClub](
	[SwimClubID] [int] IDENTITY(1,1) NOT NULL,
	[NickName] [nvarchar](128) NULL,
	[Caption] [nvarchar](128) NULL,
	[Email] [nvarchar](128) NULL,
	[ContactNum] [nvarchar](30) NULL,
	[WebSite] [nvarchar](256) NULL,
	[HeatAlgorithm] [int] NULL,
	[EnableTeamEvents] [bit] NULL,
	[EnableSwimOThon] [bit] NULL,
	[EnableExtHeatTypes] [bit] NULL,
	[EnableMembershipStr] [bit] NULL,
	[NumOfLanes] [int] NULL,
	[LenOfPool] [int] NULL,
	[StartOfSwimSeason] [datetime] NULL,
	[CreatedOn] [datetime] NULL,
 CONSTRAINT [PK_SwimClub] PRIMARY KEY NONCLUSTERED 
(
	[SwimClubID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
GRANT SELECT ON [dbo].[SwimClub] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[SwimClub] TO [SCM_Guest] AS [dbo]
GO
GRANT SELECT ON [dbo].[SwimClub] TO [SCM_Marshall] AS [dbo]
GO
/****** Object:  Table [dbo].[Team]    Script Date: 20/08/22 11:41:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Team](
	[TeamID] [int] IDENTITY(1,1) NOT NULL,
	[Lane] [int] NULL,
	[TeamTime] [time](7) NULL,
	[IsDisqualified] [bit] NULL,
	[IsScratched] [bit] NULL,
	[HeatID] [int] NULL,
 CONSTRAINT [PK_Team] PRIMARY KEY NONCLUSTERED 
(
	[TeamID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
GRANT DELETE ON [dbo].[Team] TO [SCM_Administrator] AS [dbo]
GO
GRANT INSERT ON [dbo].[Team] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[Team] TO [SCM_Administrator] AS [dbo]
GO
GRANT UPDATE ON [dbo].[Team] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[Team] TO [SCM_Guest] AS [dbo]
GO
GRANT SELECT ON [dbo].[Team] TO [SCM_Marshall] AS [dbo]
GO
/****** Object:  Table [dbo].[TeamEntrant]    Script Date: 20/08/22 11:41:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TeamEntrant](
	[TeamEntrantID] [int] IDENTITY(1,1) NOT NULL,
	[MemberID] [int] NULL,
	[RaceTime] [time](7) NULL,
	[StrokeID] [int] NULL,
	[TeamID] [int] NULL,
 CONSTRAINT [PK_TeamEntrant] PRIMARY KEY NONCLUSTERED 
(
	[TeamEntrantID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
GRANT DELETE ON [dbo].[TeamEntrant] TO [SCM_Administrator] AS [dbo]
GO
GRANT INSERT ON [dbo].[TeamEntrant] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[TeamEntrant] TO [SCM_Administrator] AS [dbo]
GO
GRANT UPDATE ON [dbo].[TeamEntrant] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[TeamEntrant] TO [SCM_Guest] AS [dbo]
GO
GRANT DELETE ON [dbo].[TeamEntrant] TO [SCM_Marshall] AS [dbo]
GO
GRANT INSERT ON [dbo].[TeamEntrant] TO [SCM_Marshall] AS [dbo]
GO
GRANT SELECT ON [dbo].[TeamEntrant] TO [SCM_Marshall] AS [dbo]
GO
GRANT UPDATE ON [dbo].[TeamEntrant] TO [SCM_Marshall] AS [dbo]
GO
/****** Object:  Table [dbo].[TeamSplit]    Script Date: 20/08/22 11:41:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TeamSplit](
	[TeamSplitID] [int] IDENTITY(1,1) NOT NULL,
	[SplitTime] [time](7) NULL,
	[TeamEntrantID] [int] NULL,
 CONSTRAINT [PK_TeamSplit] PRIMARY KEY NONCLUSTERED 
(
	[TeamSplitID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
GRANT DELETE ON [dbo].[TeamSplit] TO [SCM_Administrator] AS [dbo]
GO
GRANT INSERT ON [dbo].[TeamSplit] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[TeamSplit] TO [SCM_Administrator] AS [dbo]
GO
GRANT UPDATE ON [dbo].[TeamSplit] TO [SCM_Administrator] AS [dbo]
GO
GRANT SELECT ON [dbo].[TeamSplit] TO [SCM_Guest] AS [dbo]
GO
GRANT SELECT ON [dbo].[TeamSplit] TO [SCM_Marshall] AS [dbo]
GO
ALTER TABLE [dbo].[Entrant] ADD  DEFAULT ((0)) FOR [IsDisqualified]
GO
ALTER TABLE [dbo].[Entrant] ADD  DEFAULT ((0)) FOR [IsScratched]
GO
ALTER TABLE [dbo].[Member] ADD  CONSTRAINT [DF__Member__IsActive__2A4B4B5E]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Member] ADD  CONSTRAINT [DF__Member__EnableEm__2B3F6F97]  DEFAULT ((0)) FOR [EnableEmailOut]
GO
ALTER TABLE [dbo].[MembershipType] ADD  CONSTRAINT [DF__Membershi__IsSwi__2E1BDC42]  DEFAULT ((1)) FOR [IsSwimmer]
GO
ALTER TABLE [dbo].[Qualify] ADD  DEFAULT ((1)) FOR [IsShortCourse]
GO
ALTER TABLE [dbo].[SCMSystem] ADD  CONSTRAINT [DF__SCMSystem__DBVer__35BCFE0A]  DEFAULT ((0)) FOR [DBVersion]
GO
ALTER TABLE [dbo].[SwimClub] ADD  CONSTRAINT [DF__SwimClub__Enable__403A8C7D]  DEFAULT ((0)) FOR [EnableTeamEvents]
GO
ALTER TABLE [dbo].[SwimClub] ADD  CONSTRAINT [DF__SwimClub__Enable__412EB0B6]  DEFAULT ((0)) FOR [EnableSwimOThon]
GO
ALTER TABLE [dbo].[SwimClub] ADD  CONSTRAINT [DF__SwimClub__Enable__4222D4EF]  DEFAULT ((0)) FOR [EnableExtHeatTypes]
GO
ALTER TABLE [dbo].[SwimClub] ADD  CONSTRAINT [DF__SwimClub__Enable__4316F928]  DEFAULT ((0)) FOR [EnableMembershipStr]
GO
ALTER TABLE [dbo].[SwimClub] ADD  CONSTRAINT [DF__SwimClub__NumOfL__440B1D61]  DEFAULT ((8)) FOR [NumOfLanes]
GO
ALTER TABLE [dbo].[SwimClub] ADD  CONSTRAINT [DF__SwimClub__LenOfP__44FF419A]  DEFAULT ((25)) FOR [LenOfPool]
GO
ALTER TABLE [dbo].[Team] ADD  DEFAULT ((0)) FOR [IsDisqualified]
GO
ALTER TABLE [dbo].[Team] ADD  DEFAULT ((0)) FOR [IsScratched]
GO
ALTER TABLE [dbo].[ContactNum]  WITH CHECK ADD  CONSTRAINT [FK_ContactNumType_ContactNum] FOREIGN KEY([ContactNumTypeID])
REFERENCES [dbo].[ContactNumType] ([ContactNumTypeID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[ContactNum] CHECK CONSTRAINT [FK_ContactNumType_ContactNum]
GO
ALTER TABLE [dbo].[ContactNum]  WITH CHECK ADD  CONSTRAINT [FK_Member_ContactNum] FOREIGN KEY([MemberID])
REFERENCES [dbo].[Member] ([MemberID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ContactNum] CHECK CONSTRAINT [FK_Member_ContactNum]
GO
ALTER TABLE [dbo].[Entrant]  WITH CHECK ADD  CONSTRAINT [FK_HeatIndividual_Entrant] FOREIGN KEY([HeatID])
REFERENCES [dbo].[HeatIndividual] ([HeatID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Entrant] CHECK CONSTRAINT [FK_HeatIndividual_Entrant]
GO
ALTER TABLE [dbo].[Entrant]  WITH NOCHECK ADD  CONSTRAINT [FK_Member_Entrant] FOREIGN KEY([MemberID])
REFERENCES [dbo].[Member] ([MemberID])
ON DELETE SET NULL
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[Entrant] CHECK CONSTRAINT [FK_Member_Entrant]
GO
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [FK_Distance_Event] FOREIGN KEY([DistanceID])
REFERENCES [dbo].[Distance] ([DistanceID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [FK_Distance_Event]
GO
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [FK_EventStatus_Event] FOREIGN KEY([EventStatusID])
REFERENCES [dbo].[EventStatus] ([EventStatusID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [FK_EventStatus_Event]
GO
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [FK_EventType_Event] FOREIGN KEY([EventTypeID])
REFERENCES [dbo].[EventType] ([EventTypeID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [FK_EventType_Event]
GO
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [FK_Session_Event] FOREIGN KEY([SessionID])
REFERENCES [dbo].[Session] ([SessionID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [FK_Session_Event]
GO
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [FK_Stroke_Event] FOREIGN KEY([StrokeID])
REFERENCES [dbo].[Stroke] ([StrokeID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [FK_Stroke_Event]
GO
ALTER TABLE [dbo].[HeatIndividual]  WITH CHECK ADD  CONSTRAINT [FK_Event_HeatIndividual] FOREIGN KEY([EventID])
REFERENCES [dbo].[Event] ([EventID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[HeatIndividual] CHECK CONSTRAINT [FK_Event_HeatIndividual]
GO
ALTER TABLE [dbo].[HeatIndividual]  WITH CHECK ADD  CONSTRAINT [FK_HeatStatus_HeatIndividual] FOREIGN KEY([HeatStatusID])
REFERENCES [dbo].[HeatStatus] ([HeatStatusID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[HeatIndividual] CHECK CONSTRAINT [FK_HeatStatus_HeatIndividual]
GO
ALTER TABLE [dbo].[HeatIndividual]  WITH CHECK ADD  CONSTRAINT [FK_HeatType_HeatIndividual] FOREIGN KEY([HeatTypeID])
REFERENCES [dbo].[HeatType] ([HeatTypeID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[HeatIndividual] CHECK CONSTRAINT [FK_HeatType_HeatIndividual]
GO
ALTER TABLE [dbo].[HeatTeam]  WITH CHECK ADD  CONSTRAINT [FK_Event_HeatTeam] FOREIGN KEY([EventID])
REFERENCES [dbo].[Event] ([EventID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[HeatTeam] CHECK CONSTRAINT [FK_Event_HeatTeam]
GO
ALTER TABLE [dbo].[HeatTeam]  WITH CHECK ADD  CONSTRAINT [FK_HeatStatus_HeatTeam] FOREIGN KEY([HeatStatusID])
REFERENCES [dbo].[HeatStatus] ([HeatStatusID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[HeatTeam] CHECK CONSTRAINT [FK_HeatStatus_HeatTeam]
GO
ALTER TABLE [dbo].[HeatTeam]  WITH CHECK ADD  CONSTRAINT [FK_HeatType_HeatTeam] FOREIGN KEY([HeatTypeID])
REFERENCES [dbo].[HeatType] ([HeatTypeID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[HeatTeam] CHECK CONSTRAINT [FK_HeatType_HeatTeam]
GO
ALTER TABLE [dbo].[Member]  WITH CHECK ADD  CONSTRAINT [FK_Gender_Member] FOREIGN KEY([GenderID])
REFERENCES [dbo].[Gender] ([GenderID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Member] CHECK CONSTRAINT [FK_Gender_Member]
GO
ALTER TABLE [dbo].[Member]  WITH CHECK ADD  CONSTRAINT [FK_House_Member] FOREIGN KEY([HouseID])
REFERENCES [dbo].[House] ([HouseID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Member] CHECK CONSTRAINT [FK_House_Member]
GO
ALTER TABLE [dbo].[Member]  WITH CHECK ADD  CONSTRAINT [FK_MembershipType_Member] FOREIGN KEY([MembershipTypeID])
REFERENCES [dbo].[MembershipType] ([MembershipTypeID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Member] CHECK CONSTRAINT [FK_MembershipType_Member]
GO
ALTER TABLE [dbo].[Member]  WITH CHECK ADD  CONSTRAINT [FK_SwimClub_Member] FOREIGN KEY([SwimClubID])
REFERENCES [dbo].[SwimClub] ([SwimClubID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Member] CHECK CONSTRAINT [FK_SwimClub_Member]
GO
ALTER TABLE [dbo].[Nominee]  WITH CHECK ADD  CONSTRAINT [FK_Event_Nominee] FOREIGN KEY([EventID])
REFERENCES [dbo].[Event] ([EventID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Nominee] CHECK CONSTRAINT [FK_Event_Nominee]
GO
ALTER TABLE [dbo].[Nominee]  WITH CHECK ADD  CONSTRAINT [FK_Member_Nominee] FOREIGN KEY([MemberID])
REFERENCES [dbo].[Member] ([MemberID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Nominee] CHECK CONSTRAINT [FK_Member_Nominee]
GO
ALTER TABLE [dbo].[Qualify]  WITH CHECK ADD  CONSTRAINT [FK_Distance_Quali4] FOREIGN KEY([QualifyDistID])
REFERENCES [dbo].[Distance] ([DistanceID])
GO
ALTER TABLE [dbo].[Qualify] CHECK CONSTRAINT [FK_Distance_Quali4]
GO
ALTER TABLE [dbo].[Qualify]  WITH CHECK ADD  CONSTRAINT [FK_Distance_Qualify] FOREIGN KEY([TrialDistID])
REFERENCES [dbo].[Distance] ([DistanceID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Qualify] CHECK CONSTRAINT [FK_Distance_Qualify]
GO
ALTER TABLE [dbo].[Qualify]  WITH CHECK ADD  CONSTRAINT [FK_Gender_Qualify] FOREIGN KEY([GenderID])
REFERENCES [dbo].[Gender] ([GenderID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Qualify] CHECK CONSTRAINT [FK_Gender_Qualify]
GO
ALTER TABLE [dbo].[Qualify]  WITH CHECK ADD  CONSTRAINT [FK_Stroke_Qualify] FOREIGN KEY([StrokeID])
REFERENCES [dbo].[Stroke] ([StrokeID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Qualify] CHECK CONSTRAINT [FK_Stroke_Qualify]
GO
ALTER TABLE [dbo].[ScoreDivision]  WITH CHECK ADD  CONSTRAINT [FK_Gender_ScoreDivision] FOREIGN KEY([GenderID])
REFERENCES [dbo].[Gender] ([GenderID])
GO
ALTER TABLE [dbo].[ScoreDivision] CHECK CONSTRAINT [FK_Gender_ScoreDivision]
GO
ALTER TABLE [dbo].[ScoreDivision]  WITH CHECK ADD  CONSTRAINT [FK_SwimClub_ScoreDivision] FOREIGN KEY([SwimClubID])
REFERENCES [dbo].[SwimClub] ([SwimClubID])
GO
ALTER TABLE [dbo].[ScoreDivision] CHECK CONSTRAINT [FK_SwimClub_ScoreDivision]
GO
ALTER TABLE [dbo].[ScorePoints]  WITH CHECK ADD  CONSTRAINT [FK_SwimClub_ScorePoints] FOREIGN KEY([SwimClubID])
REFERENCES [dbo].[SwimClub] ([SwimClubID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ScorePoints] CHECK CONSTRAINT [FK_SwimClub_ScorePoints]
GO
ALTER TABLE [dbo].[Session]  WITH CHECK ADD  CONSTRAINT [FK_SessionStatus_Session] FOREIGN KEY([SessionStatusID])
REFERENCES [dbo].[SessionStatus] ([SessionStatusID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Session] CHECK CONSTRAINT [FK_SessionStatus_Session]
GO
ALTER TABLE [dbo].[Session]  WITH CHECK ADD  CONSTRAINT [FK_SwimClub_Session] FOREIGN KEY([SwimClubID])
REFERENCES [dbo].[SwimClub] ([SwimClubID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Session] CHECK CONSTRAINT [FK_SwimClub_Session]
GO
ALTER TABLE [dbo].[Split]  WITH CHECK ADD  CONSTRAINT [FK_Entrant_Split] FOREIGN KEY([EntrantID])
REFERENCES [dbo].[Entrant] ([EntrantID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Split] CHECK CONSTRAINT [FK_Entrant_Split]
GO
ALTER TABLE [dbo].[Team]  WITH CHECK ADD  CONSTRAINT [FK_HeatTeam_Team] FOREIGN KEY([HeatID])
REFERENCES [dbo].[HeatTeam] ([HeatID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Team] CHECK CONSTRAINT [FK_HeatTeam_Team]
GO
ALTER TABLE [dbo].[TeamEntrant]  WITH CHECK ADD  CONSTRAINT [FK_Member_TeamEntrant] FOREIGN KEY([MemberID])
REFERENCES [dbo].[Member] ([MemberID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[TeamEntrant] CHECK CONSTRAINT [FK_Member_TeamEntrant]
GO
ALTER TABLE [dbo].[TeamEntrant]  WITH CHECK ADD  CONSTRAINT [FK_Stroke_TeamEntrant] FOREIGN KEY([StrokeID])
REFERENCES [dbo].[Stroke] ([StrokeID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[TeamEntrant] CHECK CONSTRAINT [FK_Stroke_TeamEntrant]
GO
ALTER TABLE [dbo].[TeamEntrant]  WITH CHECK ADD  CONSTRAINT [FK_Team_TeamEntrant] FOREIGN KEY([TeamID])
REFERENCES [dbo].[Team] ([TeamID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TeamEntrant] CHECK CONSTRAINT [FK_Team_TeamEntrant]
GO
ALTER TABLE [dbo].[TeamSplit]  WITH CHECK ADD  CONSTRAINT [FK_TeamEntrant_TeamSplit] FOREIGN KEY([TeamEntrantID])
REFERENCES [dbo].[TeamEntrant] ([TeamEntrantID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TeamSplit] CHECK CONSTRAINT [FK_TeamEntrant_TeamSplit]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'While IsShortCourse will determine the generic pool standard - ie the course length. Short Course (SC),  Long Course (LC)
LengthOfPool allows for more options in filtering of the qualify table.
An example.
If the tblSwimClub->LengthOfPool value is 33m and Qualify->LengthOfPool is 33m then it can pull these records under the guise of the generic pool standard.
If these values don''t exist then the pool length that matches the generic pool standard is used. towit Short Course (SC) 25m,  Long Course (LC) 50m' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Qualify', @level2type=N'COLUMN',@level2name=N'LengthOfPool'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Qualifying Times:
For a swimmer to compete in an event of said distance and stroke they must have swum the stoke in a (shorter) distance within a given time.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Qualify'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Allows for AlphaNumerical membership number. Once enabled Member.MembershipNum is ignored.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SwimClub', @level2type=N'COLUMN',@level2name=N'EnableMembershipStr'
GO
