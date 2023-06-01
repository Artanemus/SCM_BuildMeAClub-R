/*
 * ER/Studio Data Architect SQL Code Generation
 * Company :      Ambrosia
 * Project :      SwimClubMeet_v1.1.5.3.DM1
 * Author :       Ben Ambrose
 *
 * Date Created : Thursday, June 01, 2023 12:52:31
 * Target DBMS : Microsoft SQL Server 2017
 */

USE master
GO
CREATE DATABASE SwimClubMeet
GO
USE SwimClubMeet
GO
/* 
 * ROLE: SCM_Administrator 
 */

CREATE ROLE SCM_Administrator AUTHORIZATION dbo
GO

/* 
 * ROLE: SCM_Guest 
 */

CREATE ROLE SCM_Guest AUTHORIZATION dbo
GO

/* 
 * ROLE: SCM_Marshall 
 */

CREATE ROLE SCM_Marshall AUTHORIZATION dbo
GO

/* 
 * TABLE: ContactNum 
 */

CREATE TABLE ContactNum(
    ContactNumID        int             IDENTITY(1,1),
    Number              nvarchar(30)    NULL,
    ContactNumTypeID    int             NULL,
    MemberID            int             NULL,
    IsArchived          bit             DEFAULT 0 NOT NULL,
    CreatedOn           datetime        NULL,
    CONSTRAINT PK_ContactNum PRIMARY KEY CLUSTERED (ContactNumID)
)
GO



IF OBJECT_ID('ContactNum') IS NOT NULL
    PRINT '<<< CREATED TABLE ContactNum >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE ContactNum >>>'
GO

GRANT INSERT ON ContactNum TO SCM_Administrator
GO
GRANT SELECT ON ContactNum TO SCM_Administrator
GO
GRANT UPDATE ON ContactNum TO SCM_Administrator
GO
GRANT SELECT ON ContactNum TO SCM_Marshall
GO
GRANT SELECT ON ContactNum TO SCM_Guest
GO
GRANT DELETE ON ContactNum TO SCM_Administrator
GO

/* 
 * TABLE: ContactNumType 
 */

CREATE TABLE ContactNumType(
    ContactNumTypeID    int             IDENTITY(1,1),
    Caption             nvarchar(30)    NULL,
    CONSTRAINT PK_ContactNumType PRIMARY KEY CLUSTERED (ContactNumTypeID)
)
GO



IF OBJECT_ID('ContactNumType') IS NOT NULL
    PRINT '<<< CREATED TABLE ContactNumType >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE ContactNumType >>>'
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

GRANT SELECT ON ContactNumType TO SCM_Marshall
GO
GRANT SELECT ON ContactNumType TO SCM_Guest
GO
GRANT SELECT ON ContactNumType TO SCM_Administrator
GO

/* 
 * TABLE: DisqualifyCode 
 */

CREATE TABLE DisqualifyCode(
    DisqualifyCodeID    int              IDENTITY(1,1),
    Caption             nvarchar(128)    NULL,
    ABREV               nvarchar(16)     NULL,
    DisqualifyTypeID    int              NULL,
    CONSTRAINT PK_DisqualifyCode PRIMARY KEY CLUSTERED (DisqualifyCodeID)
)
GO



IF OBJECT_ID('DisqualifyCode') IS NOT NULL
    PRINT '<<< CREATED TABLE DisqualifyCode >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DisqualifyCode >>>'
GO

GRANT SELECT ON DisqualifyCode TO SCM_Marshall
GO
GRANT SELECT ON DisqualifyCode TO SCM_Guest
GO
GRANT SELECT ON DisqualifyCode TO SCM_Administrator
GO

/* 
 * TABLE: DisqualifyType 
 */

CREATE TABLE DisqualifyType(
    DisqualifyTypeID    int              IDENTITY(1,1),
    Caption             nvarchar(128)    NULL,
    CONSTRAINT PK_DisqualifyType PRIMARY KEY CLUSTERED (DisqualifyTypeID)
)
GO



IF OBJECT_ID('DisqualifyType') IS NOT NULL
    PRINT '<<< CREATED TABLE DisqualifyType >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DisqualifyType >>>'
GO

GRANT SELECT ON DisqualifyType TO SCM_Guest
GO
GRANT SELECT ON DisqualifyType TO SCM_Marshall
GO
GRANT SELECT ON DisqualifyType TO SCM_Administrator
GO

/* 
 * TABLE: Distance 
 */

CREATE TABLE Distance(
    DistanceID    int              IDENTITY(1,1),
    Caption       nvarchar(128)    NULL,
    Meters        int              NULL,
    CONSTRAINT PK_Distance PRIMARY KEY NONCLUSTERED (DistanceID)
)
GO



IF OBJECT_ID('Distance') IS NOT NULL
    PRINT '<<< CREATED TABLE Distance >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Distance >>>'
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

GRANT SELECT ON Distance TO SCM_Marshall
GO
GRANT SELECT ON Distance TO SCM_Guest
GO
GRANT SELECT ON Distance TO SCM_Administrator
GO

/* 
 * TABLE: Entrant 
 */

CREATE TABLE Entrant(
    EntrantID         int        IDENTITY(1,1),
    MemberID          int        DEFAULT NULL NULL,
    Lane              int        NULL,
    RaceTime          time(7)    NULL,
    TimeToBeat        time(7)    NULL,
    PersonalBest      time(7)    NULL,
    IsDisqualified    bit        DEFAULT 0 NULL,
    IsScratched       bit        DEFAULT 0 NULL,
    HeatID            int        NULL,
    CONSTRAINT PK_Entrant PRIMARY KEY NONCLUSTERED (EntrantID)
)
GO



IF OBJECT_ID('Entrant') IS NOT NULL
    PRINT '<<< CREATED TABLE Entrant >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Entrant >>>'
GO

GRANT DELETE ON Entrant TO SCM_Marshall
GO
GRANT INSERT ON Entrant TO SCM_Marshall
GO
GRANT DELETE ON Entrant TO SCM_Administrator
GO
GRANT INSERT ON Entrant TO SCM_Administrator
GO
GRANT SELECT ON Entrant TO SCM_Administrator
GO
GRANT UPDATE ON Entrant TO SCM_Administrator
GO
GRANT SELECT ON Entrant TO SCM_Marshall
GO
GRANT SELECT ON Entrant TO SCM_Guest
GO
GRANT UPDATE ON Entrant TO SCM_Marshall
GO

/* 
 * TABLE: Event 
 */

CREATE TABLE Event(
    EventID          int              IDENTITY(1,1),
    EventNum         int              NULL,
    Caption          nvarchar(128)    NULL,
    ClosedDT         datetime         NULL,
    SessionID        int              NULL,
    EventTypeID      int              NULL,
    StrokeID         int              NULL,
    DistanceID       int              NULL,
    EventStatusID    int              NULL,
    ScheduleDT       time(7)          NULL,
    CONSTRAINT PK_Event PRIMARY KEY NONCLUSTERED (EventID)
)
GO



IF OBJECT_ID('Event') IS NOT NULL
    PRINT '<<< CREATED TABLE Event >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Event >>>'
GO

GRANT INSERT ON Event TO SCM_Administrator
GO
GRANT SELECT ON Event TO SCM_Administrator
GO
GRANT UPDATE ON Event TO SCM_Administrator
GO
GRANT SELECT ON Event TO SCM_Marshall
GO
GRANT SELECT ON Event TO SCM_Guest
GO
GRANT DELETE ON Event TO SCM_Administrator
GO

/* 
 * TABLE: EventStatus 
 */

CREATE TABLE EventStatus(
    EventStatusID    int             IDENTITY(1,1),
    Caption          nvarchar(32)    NULL,
    CONSTRAINT PK_EventStatus PRIMARY KEY NONCLUSTERED (EventStatusID)
)
GO



IF OBJECT_ID('EventStatus') IS NOT NULL
    PRINT '<<< CREATED TABLE EventStatus >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE EventStatus >>>'
GO
SET IDENTITY_INSERT [dbo].[EventStatus] ON 
GO
INSERT [dbo].[EventStatus] ([EventStatusID], [Caption]) VALUES (1, N'Open')
GO
INSERT [dbo].[EventStatus] ([EventStatusID], [Caption]) VALUES (2, N'Closed')
GO
SET IDENTITY_INSERT [dbo].[EventStatus] OFF
GO

GRANT SELECT ON EventStatus TO SCM_Marshall
GO
GRANT SELECT ON EventStatus TO SCM_Guest
GO
GRANT SELECT ON EventStatus TO SCM_Administrator
GO

/* 
 * TABLE: EventType 
 */

CREATE TABLE EventType(
    EventTypeID    int              IDENTITY(1,1),
    Caption        nvarchar(128)    NULL,
    CONSTRAINT PK_EventType PRIMARY KEY NONCLUSTERED (EventTypeID)
)
GO



IF OBJECT_ID('EventType') IS NOT NULL
    PRINT '<<< CREATED TABLE EventType >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE EventType >>>'
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

GRANT SELECT ON EventType TO SCM_Marshall
GO
GRANT SELECT ON EventType TO SCM_Guest
GO
GRANT SELECT ON EventType TO SCM_Administrator
GO

/* 
 * TABLE: Gender 
 */

CREATE TABLE Gender(
    GenderID    int             IDENTITY(1,1),
    Caption     nvarchar(20)    NULL,
    CONSTRAINT PK_Gender PRIMARY KEY NONCLUSTERED (GenderID)
)
GO



IF OBJECT_ID('Gender') IS NOT NULL
    PRINT '<<< CREATED TABLE Gender >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Gender >>>'
GO
SET IDENTITY_INSERT [dbo].[Gender] ON 
GO
INSERT [dbo].[Gender] ([GenderID], [Caption]) VALUES (1, N'Male')
GO
INSERT [dbo].[Gender] ([GenderID], [Caption]) VALUES (2, N'Female')
GO
SET IDENTITY_INSERT [dbo].[Gender] OFF
GO

GRANT SELECT ON Gender TO SCM_Marshall
GO
GRANT SELECT ON Gender TO SCM_Guest
GO
GRANT SELECT ON Gender TO SCM_Administrator
GO

/* 
 * TABLE: HeatIndividual 
 */

CREATE TABLE HeatIndividual(
    HeatID              int              IDENTITY(1,1),
    HeatNum             int              NULL,
    Caption             nvarchar(128)    NULL,
    ClosedDT            datetime         NULL,
    EventID             int              NULL,
    HeatTypeID          int              NULL,
    HeatStatusID        int              NULL,
    DisqualifyCodeID    int              NULL,
    CONSTRAINT PK_HeatIndividual PRIMARY KEY NONCLUSTERED (HeatID)
)
GO



IF OBJECT_ID('HeatIndividual') IS NOT NULL
    PRINT '<<< CREATED TABLE HeatIndividual >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE HeatIndividual >>>'
GO

GRANT DELETE ON HeatIndividual TO SCM_Marshall
GO
GRANT INSERT ON HeatIndividual TO SCM_Marshall
GO
GRANT DELETE ON HeatIndividual TO SCM_Administrator
GO
GRANT INSERT ON HeatIndividual TO SCM_Administrator
GO
GRANT SELECT ON HeatIndividual TO SCM_Administrator
GO
GRANT UPDATE ON HeatIndividual TO SCM_Administrator
GO
GRANT SELECT ON HeatIndividual TO SCM_Marshall
GO
GRANT UPDATE ON HeatIndividual TO SCM_Marshall
GO
GRANT SELECT ON HeatIndividual TO SCM_Guest
GO

/* 
 * TABLE: HeatStatus 
 */

CREATE TABLE HeatStatus(
    HeatStatusID    int             IDENTITY(1,1),
    Caption         nvarchar(60)    NULL,
    CONSTRAINT PK_HeatStatus PRIMARY KEY NONCLUSTERED (HeatStatusID)
)
GO



IF OBJECT_ID('HeatStatus') IS NOT NULL
    PRINT '<<< CREATED TABLE HeatStatus >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE HeatStatus >>>'
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

GRANT SELECT ON HeatStatus TO SCM_Marshall
GO
GRANT SELECT ON HeatStatus TO SCM_Guest
GO
GRANT SELECT ON HeatStatus TO SCM_Administrator
GO

/* 
 * TABLE: HeatTeam 
 */

CREATE TABLE HeatTeam(
    HeatID              int              IDENTITY(1,1),
    HeatNum             int              NULL,
    Caption             nvarchar(128)    NULL,
    ClosedDT            datetime         NULL,
    EventID             int              NULL,
    HeatTypeID          int              NULL,
    HeatStatusID        int              NULL,
    DisqualifyCodeID    int              NULL,
    CONSTRAINT PK_HeatTeam PRIMARY KEY NONCLUSTERED (HeatID)
)
GO



IF OBJECT_ID('HeatTeam') IS NOT NULL
    PRINT '<<< CREATED TABLE HeatTeam >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE HeatTeam >>>'
GO

GRANT DELETE ON HeatTeam TO SCM_Marshall
GO
GRANT INSERT ON HeatTeam TO SCM_Marshall
GO
GRANT DELETE ON HeatTeam TO SCM_Administrator
GO
GRANT INSERT ON HeatTeam TO SCM_Administrator
GO
GRANT SELECT ON HeatTeam TO SCM_Administrator
GO
GRANT UPDATE ON HeatTeam TO SCM_Administrator
GO
GRANT SELECT ON HeatTeam TO SCM_Marshall
GO
GRANT SELECT ON HeatTeam TO SCM_Guest
GO
GRANT UPDATE ON HeatTeam TO SCM_Marshall
GO

/* 
 * TABLE: HeatType 
 */

CREATE TABLE HeatType(
    HeatTypeID    int              IDENTITY(1,1),
    Caption       nvarchar(128)    NULL,
    CONSTRAINT PK_HeatType PRIMARY KEY NONCLUSTERED (HeatTypeID)
)
GO



IF OBJECT_ID('HeatType') IS NOT NULL
    PRINT '<<< CREATED TABLE HeatType >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE HeatType >>>'
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

GRANT SELECT ON HeatType TO SCM_Marshall
GO
GRANT SELECT ON HeatType TO SCM_Guest
GO
GRANT SELECT ON HeatType TO SCM_Administrator
GO

/* 
 * TABLE: House 
 */

CREATE TABLE House(
    HouseID       int              IDENTITY(1,1),
    Caption       nvarchar(128)    NULL,
    Motto         nvarchar(128)    NULL,
    Color         int              NULL,
    LogoDir       varchar(max)     NULL,
    LogoImg       image            NULL,
    LogoType      nvarchar(5)      NULL,
    IsArchived    bit              NOT NULL,
    CreatedOn     datetime         NULL,
    CONSTRAINT PK_House PRIMARY KEY CLUSTERED (HouseID)
)
GO



IF OBJECT_ID('House') IS NOT NULL
    PRINT '<<< CREATED TABLE House >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE House >>>'
GO
SET IDENTITY_INSERT [dbo].[House] ON
GO

INSERT [dbo].[House] (
	[HouseID]
	,[Caption]
	,[Motto]
	,[Color]
	)
VALUES (
	1
	,N'Arapaima'
	,N'Ad astra per aspera.'
	,255
	)
GO

INSERT [dbo].[House] (
	[HouseID]
	,[Caption]
	,[Motto]
	,[Color]
	)
VALUES (
	2
	,N'Goonch'
	,N'Acta non verba.'
	,378084
	)
GO

INSERT [dbo].[House] (
	[HouseID]
	,[Caption]
	,[Motto]
	,[Color]
	)
VALUES (
	3
	,N'Payara'
	,N'Audentes fortuna iuvat.'
	,12615680
	)
GO

INSERT [dbo].[House] (
	[HouseID]
	,[Caption]
	,[Motto]
	,[Color]
	)
VALUES (
	4
	,N'Pacu'
	,N'Ad meliora.'
	,32768
	)
GO

SET IDENTITY_INSERT [dbo].[House] OFF
GO

GRANT INSERT ON House TO SCM_Administrator
GO
GRANT SELECT ON House TO SCM_Administrator
GO
GRANT UPDATE ON House TO SCM_Administrator
GO
GRANT SELECT ON House TO SCM_Marshall
GO
GRANT SELECT ON House TO SCM_Guest
GO
GRANT DELETE ON House TO SCM_Administrator
GO

/* 
 * TABLE: Member 
 */

CREATE TABLE Member(
    MemberID                    int              IDENTITY(1,1),
    MembershipNum               int              NULL,
    MembershipStr               nvarchar(24)     NULL,
    MembershipDue               datetime         NULL,
    FirstName                   nvarchar(128)    NULL,
    LastName                    nvarchar(128)    NULL,
    DOB                         datetime         NULL,
    IsActive                    bit              DEFAULT 1 NULL,
    IsArchived                  bit              DEFAULT 0 NULL,
    Email                       nvarchar(256)    NULL,
    EnableEmailOut              bit              DEFAULT 0 NULL,
    GenderID                    int              NULL,
    SwimClubID                  int              NULL,
    MembershipTypeID            int              NULL,
    CreatedOn                   datetime         NULL,
    ArchivedOn                  datetime         NULL,
    EnableEmailNomineeForm      bit              DEFAULT 0 NULL,
    EnableEmailSessionReport    bit              DEFAULT 0 NULL,
    HouseID                     int              NULL,
    IsSwimmer                   bit              DEFAULT 1 NULL,
    CONSTRAINT PK_Member PRIMARY KEY NONCLUSTERED (MemberID)
)
GO



IF OBJECT_ID('Member') IS NOT NULL
    PRINT '<<< CREATED TABLE Member >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Member >>>'
GO

GRANT INSERT ON Member TO SCM_Administrator
GO
GRANT SELECT ON Member TO SCM_Administrator
GO
GRANT UPDATE ON Member TO SCM_Administrator
GO
GRANT SELECT ON Member TO SCM_Marshall
GO
GRANT SELECT ON Member TO SCM_Guest
GO
GRANT DELETE ON Member TO SCM_Administrator
GO

/* 
 * TABLE: MembershipType 
 */

CREATE TABLE MembershipType(
    MembershipTypeID    int              IDENTITY(1,1),
    Caption             nvarchar(64)     NULL,
    LongCaption         nvarchar(128)    NULL,
    IsSwimmer           bit              DEFAULT 1 NULL,
    Sort                int              NULL,
    AgeFrom             int              NULL,
    AgeTo               int              NULL,
    CONSTRAINT PK_MembershipType PRIMARY KEY NONCLUSTERED (MembershipTypeID)
)
GO



IF OBJECT_ID('MembershipType') IS NOT NULL
    PRINT '<<< CREATED TABLE MembershipType >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE MembershipType >>>'
GO
SET IDENTITY_INSERT [dbo].[MembershipType] ON 
GO
INSERT [dbo].[MembershipType] ([MembershipTypeID], [Caption], [LongCaption], [IsSwimmer], [Sort], [AgeFrom], [AgeTo]) VALUES (1, N'Competitive Swimmer 9 years+', N'Competitive Swimmer 9 years and over.', 1, 3, 9, NULL)
GO
INSERT [dbo].[MembershipType] ([MembershipTypeID], [Caption], [LongCaption], [IsSwimmer], [Sort], [AgeFrom], [AgeTo]) VALUES (2, N'Casual Swimmer 9 years+', N'Casual or recreational Swimmer 9 years and over, who does not compete in Metropolitan ChampionShips ', 1, 4, 9, NULL)
GO
INSERT [dbo].[MembershipType] ([MembershipTypeID], [Caption], [LongCaption], [IsSwimmer], [Sort], [AgeFrom], [AgeTo]) VALUES (3, N'Junior Dolphin 7 & Under', N'Junior Dolphin 7 and Under', 1, 1, 1, 7)
GO
INSERT [dbo].[MembershipType] ([MembershipTypeID], [Caption], [LongCaption], [IsSwimmer], [Sort], [AgeFrom], [AgeTo]) VALUES (4, N'Junior Dolphin 8 Year Old', N'Junior Dolphin 8 Year Old', 1, 2, 8, 8)
GO
SET IDENTITY_INSERT [dbo].[MembershipType] OFF
GO

GRANT INSERT ON MembershipType TO SCM_Administrator
GO
GRANT SELECT ON MembershipType TO SCM_Administrator
GO
GRANT UPDATE ON MembershipType TO SCM_Administrator
GO
GRANT SELECT ON MembershipType TO SCM_Marshall
GO
GRANT SELECT ON MembershipType TO SCM_Guest
GO
GRANT DELETE ON MembershipType TO SCM_Administrator
GO

/* 
 * TABLE: Nominee 
 */

CREATE TABLE Nominee(
    NomineeID        int        IDENTITY(1,1),
    TTB              time(7)    NULL,
    PB               time(7)    NULL,
    SeedTime         time(7)    NULL,
    AutoBuildFlag    bit        NULL,
    EventID          int        NULL,
    MemberID         int        NULL,
    CONSTRAINT PK_Nominee PRIMARY KEY CLUSTERED (NomineeID)
)
GO



IF OBJECT_ID('Nominee') IS NOT NULL
    PRINT '<<< CREATED TABLE Nominee >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Nominee >>>'
GO

GRANT DELETE ON Nominee TO SCM_Marshall
GO
GRANT INSERT ON Nominee TO SCM_Marshall
GO
GRANT UPDATE ON Nominee TO SCM_Marshall
GO
GRANT SELECT ON Nominee TO SCM_Guest
GO
GRANT SELECT ON Nominee TO SCM_Administrator
GO
GRANT SELECT ON Nominee TO SCM_Marshall
GO
GRANT DELETE ON Nominee TO SCM_Administrator
GO
GRANT INSERT ON Nominee TO SCM_Administrator
GO
GRANT UPDATE ON Nominee TO SCM_Administrator
GO

/* 
 * TABLE: Qualify 
 */

CREATE TABLE Qualify(
    QualifyID        int        IDENTITY(1,1),
    TrialDistID      int        NULL,
    QualifyDistID    int        NULL,
    StrokeID         int        NULL,
    TrialTime        time(7)    NULL,
    IsShortCourse    bit        DEFAULT 1 NULL,
    GenderID         int        NULL,
    LengthOfPool     int        NULL,
    CONSTRAINT PK_Qualify PRIMARY KEY CLUSTERED (QualifyID)
)
GO



IF OBJECT_ID('Qualify') IS NOT NULL
    PRINT '<<< CREATED TABLE Qualify >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Qualify >>>'
GO
SET IDENTITY_INSERT [dbo].[Qualify] ON 

INSERT [dbo].[Qualify] ([QualifyID], [TrialDistID], [QualifyDistID], [StrokeID], [TrialTime], [IsShortCourse], [GenderID], [LengthOfPool])
VALUES 
(1, 1, 2, 1, CAST(N'00:00:23' AS Time), 1, 1, 25)
,(2, 1, 2, 2, CAST(N'00:00:31' AS Time), 1, 1, 25)
,(3, 1, 2, 3, CAST(N'00:00:29' AS Time), 1, 1, 25)
,(4, 1, 2, 4, CAST(N'00:00:26' AS Time), 1, 1, 25)
,(5, 2, 3, 1, CAST(N'00:00:45' AS Time), 1, 1, 25)
,(6, 2, 3, 2, CAST(N'00:01:00' AS Time), 1, 1, 25)
,(7, 2, 3, 3, CAST(N'00:01:00' AS Time), 1, 1, 25)
,(8, 2, 3, 4, CAST(N'00:00:55' AS Time), 1, 1, 25)
,(9, 3, 3, 5, CAST(N'00:01:49' AS Time), 1, 1, 25)
,(10, 4, 4, 5, CAST(N'00:03:45' AS Time), 1, 1, 25)
,(11, 1, 2, 1, CAST(N'00:00:23' AS Time), 1, 2, 25)
,(12, 1, 2, 2, CAST(N'00:00:31' AS Time), 1, 2, 25)
,(13, 1, 2, 3, CAST(N'00:00:29' AS Time), 1, 2, 25)
,(14, 1, 2, 4, CAST(N'00:00:26' AS Time), 1, 2, 25)
,(15, 2, 3, 1, CAST(N'00:00:45' AS Time), 1, 2, 25)
,(16, 2, 3, 2, CAST(N'00:01:00' AS Time), 1, 2, 25)
,(17, 2, 3, 3, CAST(N'00:01:00' AS Time), 1, 2, 25)
,(18, 2, 3, 4, CAST(N'00:00:55' AS Time), 1, 2, 25)
,(19, 3, 3, 5, CAST(N'00:01:49' AS Time), 1, 2, 25)
,(20, 4, 4, 5, CAST(N'00:03:48' AS Time), 1, 2, 25)
,(21, 1, 2, 1, CAST(N'00:00:24' AS Time), 0, 1, 50)
,(22, 1, 2, 2, CAST(N'00:00:32' AS Time), 0, 1, 50)
,(23, 1, 2, 3, CAST(N'00:00:30' AS Time), 0, 1, 50)
,(24, 1, 2, 4, CAST(N'00:00:27' AS Time), 0, 1, 50)
,(25, 2, 3, 1, CAST(N'00:00:46' AS Time), 0, 1, 50)
,(26, 2, 3, 2, CAST(N'00:01:01' AS Time), 0, 1, 50)
,(27, 2, 3, 3, CAST(N'00:01:01' AS Time), 0, 1, 50)
,(28, 2, 3, 4, CAST(N'00:00:56' AS Time), 0, 1, 50)
,(29, 3, 3, 5, CAST(N'00:01:50' AS Time), 0, 1, 50)
,(30, 4, 4, 5, CAST(N'00:03:46' AS Time), 0, 1, 50)
,(31, 1, 2, 1, CAST(N'00:00:24' AS Time), 0, 2, 50)
,(32, 1, 2, 2, CAST(N'00:00:32' AS Time), 0, 2, 50)
,(33, 1, 2, 3, CAST(N'00:00:30' AS Time), 0, 2, 50)
,(34, 1, 2, 4, CAST(N'00:00:27' AS Time), 0, 2, 50)
,(35, 2, 3, 1, CAST(N'00:00:46' AS Time), 0, 2, 50)
,(36, 2, 3, 2, CAST(N'00:01:01' AS Time), 0, 2, 50)
,(37, 2, 3, 3, CAST(N'00:01:01' AS Time), 0, 2, 50)
,(38, 2, 3, 4, CAST(N'00:00:56' AS Time), 0, 2, 50)
,(39, 3, 3, 5, CAST(N'00:01:50' AS Time), 0, 2, 50)
,(40, 4, 4, 5, CAST(N'00:03:49' AS Time), 0, 2, 50)

SET IDENTITY_INSERT [dbo].[Qualify] OFF

GRANT INSERT ON Qualify TO SCM_Administrator
GO
GRANT SELECT ON Qualify TO SCM_Administrator
GO
GRANT UPDATE ON Qualify TO SCM_Administrator
GO
GRANT SELECT ON Qualify TO SCM_Marshall
GO
GRANT SELECT ON Qualify TO SCM_Guest
GO
GRANT DELETE ON Qualify TO SCM_Administrator
GO

/* 
 * TABLE: SCMSystem 
 */

CREATE TABLE SCMSystem(
    SCMSystemID    int    IDENTITY(1,1),
    DBVersion      int    NULL,
    Major          int    NULL,
    Minor          int    NULL,
    CONSTRAINT PK_SCMSystem PRIMARY KEY CLUSTERED (SCMSystemID)
)
GO



IF OBJECT_ID('SCMSystem') IS NOT NULL
    PRINT '<<< CREATED TABLE SCMSystem >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE SCMSystem >>>'
GO
SET IDENTITY_INSERT [dbo].[SCMSystem] ON 
GO
INSERT INTO [dbo].[SCMSystem](
[SCMSystemID] -- RECORD ID - ALWAYS 1)
,[DBVersion]  -- MSSQL:1, MYSQL:2, etc
,[Major]      -- MAJOR RELEASE NUMBER
,[Minor]      -- MINOR RELEASE NUMBER
)
VALUES
(1 ,1, 5, 3)
GO
SET IDENTITY_INSERT [dbo].[SCMSystem] OFF

GRANT SELECT ON SCMSystem TO SCM_Marshall
GO
GRANT SELECT ON SCMSystem TO SCM_Administrator
GO
GRANT SELECT ON SCMSystem TO SCM_Guest
GO

/* 
 * TABLE: ScoreDivision 
 */

CREATE TABLE ScoreDivision(
    ScoreDivisionID    int              IDENTITY(1,1),
    SwimClubID         int              NULL,
    Caption            nvarchar(128)    NULL,
    AgeFrom            int              NULL,
    AgeTo              int              NULL,
    GenderID           int              NULL,
    CONSTRAINT PK_ScoreDivision PRIMARY KEY CLUSTERED (ScoreDivisionID)
)
GO



IF OBJECT_ID('ScoreDivision') IS NOT NULL
    PRINT '<<< CREATED TABLE ScoreDivision >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE ScoreDivision >>>'
GO
SET IDENTITY_INSERT [dbo].[ScoreDivision] ON 
GO
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [AgeFrom], [AgeTo]) VALUES (1, 1, 0, 8)
GO
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [AgeFrom], [AgeTo]) VALUES (2, 1, 9, 9)
GO
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [AgeFrom], [AgeTo]) VALUES (3, 1, 10, 10)
GO
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [AgeFrom], [AgeTo]) VALUES (4, 1, 11, 11)
GO
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [AgeFrom], [AgeTo]) VALUES (5, 1, 12, 12)
GO
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [AgeFrom], [AgeTo]) VALUES (6, 1, 13, 13)
GO
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [AgeFrom], [AgeTo]) VALUES (7, 1, 14, 14)
GO
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [AgeFrom], [AgeTo]) VALUES (8, 1, 15, 15)
GO
INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [AgeFrom], [AgeTo]) VALUES (9, 1, 16, 99)
GO
SET IDENTITY_INSERT [dbo].[ScoreDivision] OFF
GO

GRANT INSERT ON ScoreDivision TO SCM_Administrator
GO
GRANT SELECT ON ScoreDivision TO SCM_Administrator
GO
GRANT UPDATE ON ScoreDivision TO SCM_Administrator
GO
GRANT SELECT ON ScoreDivision TO SCM_Marshall
GO
GRANT SELECT ON ScoreDivision TO SCM_Guest
GO
GRANT DELETE ON ScoreDivision TO SCM_Administrator
GO

/* 
 * TABLE: ScorePoints 
 */

CREATE TABLE ScorePoints(
    ScorePointsID    int      IDENTITY(1,1),
    SwimClubID       int      NULL,
    Place            int      NULL,
    Points           float    NULL,
    CONSTRAINT PK_ScorePoints PRIMARY KEY CLUSTERED (ScorePointsID)
)
GO



IF OBJECT_ID('ScorePoints') IS NOT NULL
    PRINT '<<< CREATED TABLE ScorePoints >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE ScorePoints >>>'
GO
SET IDENTITY_INSERT [dbo].[ScorePoints] ON 
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (1, 1, 1, 8.5)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (2, 1, 2, 8)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (3, 1, 3, 7.5)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (4, 1, 4, 7)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (5, 1, 5, 6.5)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (6, 1, 6, 6)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (7, 1, 7, 5.5)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (8, 1, 8, 5.2)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (9, 1, 9, 5)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (10, 1, 10, 4.6)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (11, 1, 11, 4.2)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (12, 1, 12, 4)
GO
INSERT [dbo].[ScorePoints] ([ScorePointsID], [SwimClubID], [Place], [Points]) VALUES (13, 1, 0, 1)
GO
SET IDENTITY_INSERT [dbo].[ScorePoints] OFF
GO

GRANT INSERT ON ScorePoints TO SCM_Administrator
GO
GRANT SELECT ON ScorePoints TO SCM_Administrator
GO
GRANT UPDATE ON ScorePoints TO SCM_Administrator
GO
GRANT SELECT ON ScorePoints TO SCM_Marshall
GO
GRANT SELECT ON ScorePoints TO SCM_Guest
GO
GRANT DELETE ON ScorePoints TO SCM_Administrator
GO

/* 
 * TABLE: Session 
 */

CREATE TABLE Session(
    SessionID          int              IDENTITY(1,1),
    Caption            nvarchar(128)    NULL,
    SessionStart       datetime         NULL,
    ClosedDT           datetime         NULL,
    SwimClubID         int              NULL,
    SessionStatusID    int              NULL,
    CONSTRAINT PK_Session PRIMARY KEY NONCLUSTERED (SessionID)
)
GO



IF OBJECT_ID('Session') IS NOT NULL
    PRINT '<<< CREATED TABLE Session >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Session >>>'
GO

GRANT INSERT ON Session TO SCM_Administrator
GO
GRANT SELECT ON Session TO SCM_Administrator
GO
GRANT UPDATE ON Session TO SCM_Administrator
GO
GRANT SELECT ON Session TO SCM_Marshall
GO
GRANT SELECT ON Session TO SCM_Guest
GO
GRANT DELETE ON Session TO SCM_Administrator
GO

/* 
 * TABLE: SessionStatus 
 */

CREATE TABLE SessionStatus(
    SessionStatusID    int             IDENTITY(1,1),
    Caption            nvarchar(32)    NULL,
    CONSTRAINT PK_SessionStatus PRIMARY KEY NONCLUSTERED (SessionStatusID)
)
GO



IF OBJECT_ID('SessionStatus') IS NOT NULL
    PRINT '<<< CREATED TABLE SessionStatus >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE SessionStatus >>>'
GO
SET IDENTITY_INSERT [dbo].[SessionStatus] ON 
GO
INSERT [dbo].[SessionStatus] ([SessionStatusID], [Caption]) VALUES (1, N'Open')
GO
INSERT [dbo].[SessionStatus] ([SessionStatusID], [Caption]) VALUES (2, N'Locked')
GO
SET IDENTITY_INSERT [dbo].[SessionStatus] OFF
GO

GRANT SELECT ON SessionStatus TO SCM_Marshall
GO
GRANT SELECT ON SessionStatus TO SCM_Guest
GO
GRANT SELECT ON SessionStatus TO SCM_Administrator
GO

/* 
 * TABLE: Split 
 */

CREATE TABLE Split(
    SplitID      int        IDENTITY(1,1),
    SplitTime    time(7)    NULL,
    EntrantID    int        NULL,
    CONSTRAINT PK_Split PRIMARY KEY NONCLUSTERED (SplitID)
)
GO



IF OBJECT_ID('Split') IS NOT NULL
    PRINT '<<< CREATED TABLE Split >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Split >>>'
GO

GRANT DELETE ON Split TO SCM_Administrator
GO
GRANT INSERT ON Split TO SCM_Administrator
GO
GRANT SELECT ON Split TO SCM_Administrator
GO
GRANT UPDATE ON Split TO SCM_Administrator
GO
GRANT SELECT ON Split TO SCM_Marshall
GO
GRANT SELECT ON Split TO SCM_Guest
GO

/* 
 * TABLE: Stroke 
 */

CREATE TABLE Stroke(
    StrokeID    int              IDENTITY(1,1),
    Caption     nvarchar(128)    NULL,
    CONSTRAINT PK_Stroke PRIMARY KEY NONCLUSTERED (StrokeID)
)
GO



IF OBJECT_ID('Stroke') IS NOT NULL
    PRINT '<<< CREATED TABLE Stroke >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Stroke >>>'
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
INSERT [dbo].[Stroke] ([StrokeID], [Caption]) VALUES (5, N'IndvMedley')
GO
SET IDENTITY_INSERT [dbo].[Stroke] OFF
GO

GRANT SELECT ON Stroke TO SCM_Marshall
GO
GRANT SELECT ON Stroke TO SCM_Guest
GO
GRANT SELECT ON Stroke TO SCM_Administrator
GO

/* 
 * TABLE: SwimClub 
 */

CREATE TABLE SwimClub(
    SwimClubID                      int              IDENTITY(1,1),
    NickName                        nvarchar(128)    NULL,
    Caption                         nvarchar(128)    NULL,
    Email                           nvarchar(128)    NULL,
    ContactNum                      nvarchar(30)     NULL,
    WebSite                         nvarchar(256)    NULL,
    HeatAlgorithm                   int              NULL,
    EnableTeamEvents                bit              DEFAULT 0 NULL,
    EnableSwimOThon                 bit              DEFAULT 0 NULL,
    EnableExtHeatTypes              bit              DEFAULT 0 NULL,
    EnableMembershipStr             bit              DEFAULT 0 NULL,
    EnableSimpleDisqualification    bit              DEFAULT 1 NOT NULL,
    NumOfLanes                      int              DEFAULT 8 NULL,
    LenOfPool                       int              DEFAULT 25 NULL,
    StartOfSwimSeason               datetime         NULL,
    CreatedOn                       datetime         NULL,
    LogoDir                         varchar(max)     NULL,
    LogoImg                         image            NULL,
    LogoType                        nvarchar(5)      NULL,
    CONSTRAINT PK_SwimClub PRIMARY KEY NONCLUSTERED (SwimClubID)
)
GO



IF OBJECT_ID('SwimClub') IS NOT NULL
    PRINT '<<< CREATED TABLE SwimClub >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE SwimClub >>>'
GO
SET IDENTITY_INSERT [dbo].[SwimClub] ON
GO

INSERT [dbo].[SwimClub] (
	[SwimClubID]
	,[NickName]
	,[Caption]
	,[Email]
	,[ContactNum]
	,[WebSite]
	,[HeatAlgorithm]
	,[EnableTeamEvents]
	,[EnableSwimOThon]
	,[EnableExtHeatTypes]
	,[EnableMemberShipStr]
	,[EnableSimpleDisqualification]
	,[NumOfLanes]
	,[LenOfPool]
	)
VALUES (
	1
	,N'SCM_NICKNAME'
	,N'SCM_CLUBNAME'
	,N'SCM_EMAIL'
	,N''
	,N''
	,1
	,0
	,0
	,0
	,0
	,1
	,8
	,25
	)
GO

SET IDENTITY_INSERT [dbo].[SwimClub] OFF
GO

GRANT SELECT ON SwimClub TO SCM_Administrator
GO
GRANT SELECT ON SwimClub TO SCM_Guest
GO
GRANT SELECT ON SwimClub TO SCM_Marshall
GO

/* 
 * TABLE: Team 
 */

CREATE TABLE Team(
    TeamID            int        IDENTITY(1,1),
    Lane              int        NULL,
    TeamTime          time(7)    NULL,
    IsDisqualified    bit        DEFAULT 0 NULL,
    IsScratched       bit        DEFAULT 0 NULL,
    HeatID            int        NULL,
    CONSTRAINT PK_Team PRIMARY KEY NONCLUSTERED (TeamID)
)
GO



IF OBJECT_ID('Team') IS NOT NULL
    PRINT '<<< CREATED TABLE Team >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Team >>>'
GO

GRANT INSERT ON Team TO SCM_Administrator
GO
GRANT SELECT ON Team TO SCM_Administrator
GO
GRANT UPDATE ON Team TO SCM_Administrator
GO
GRANT SELECT ON Team TO SCM_Marshall
GO
GRANT SELECT ON Team TO SCM_Guest
GO
GRANT DELETE ON Team TO SCM_Administrator
GO

/* 
 * TABLE: TeamEntrant 
 */

CREATE TABLE TeamEntrant(
    TeamEntrantID    int        IDENTITY(1,1),
    MemberID         int        NULL,
    RaceTime         time(7)    NULL,
    StrokeID         int        NULL,
    TeamID           int        NULL,
    CONSTRAINT PK_TeamEntrant PRIMARY KEY NONCLUSTERED (TeamEntrantID)
)
GO



IF OBJECT_ID('TeamEntrant') IS NOT NULL
    PRINT '<<< CREATED TABLE TeamEntrant >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE TeamEntrant >>>'
GO

GRANT DELETE ON TeamEntrant TO SCM_Marshall
GO
GRANT INSERT ON TeamEntrant TO SCM_Marshall
GO
GRANT DELETE ON TeamEntrant TO SCM_Administrator
GO
GRANT INSERT ON TeamEntrant TO SCM_Administrator
GO
GRANT SELECT ON TeamEntrant TO SCM_Administrator
GO
GRANT UPDATE ON TeamEntrant TO SCM_Administrator
GO
GRANT SELECT ON TeamEntrant TO SCM_Marshall
GO
GRANT SELECT ON TeamEntrant TO SCM_Guest
GO
GRANT UPDATE ON TeamEntrant TO SCM_Marshall
GO

/* 
 * TABLE: TeamSplit 
 */

CREATE TABLE TeamSplit(
    TeamSplitID      int        IDENTITY(1,1),
    SplitTime        time(7)    NULL,
    TeamEntrantID    int        NULL,
    CONSTRAINT PK_TeamSplit PRIMARY KEY NONCLUSTERED (TeamSplitID)
)
GO



IF OBJECT_ID('TeamSplit') IS NOT NULL
    PRINT '<<< CREATED TABLE TeamSplit >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE TeamSplit >>>'
GO

GRANT DELETE ON TeamSplit TO SCM_Administrator
GO
GRANT INSERT ON TeamSplit TO SCM_Administrator
GO
GRANT SELECT ON TeamSplit TO SCM_Administrator
GO
GRANT UPDATE ON TeamSplit TO SCM_Administrator
GO
GRANT SELECT ON TeamSplit TO SCM_Marshall
GO
GRANT SELECT ON TeamSplit TO SCM_Guest
GO

/* 
 * TABLE: ContactNum 
 */

ALTER TABLE ContactNum ADD CONSTRAINT ContactNumTypeContactNum 
    FOREIGN KEY (ContactNumTypeID)
    REFERENCES ContactNumType(ContactNumTypeID) ON DELETE SET NULL
GO

ALTER TABLE ContactNum ADD CONSTRAINT MemberContactNum 
    FOREIGN KEY (MemberID)
    REFERENCES Member(MemberID) ON DELETE CASCADE
GO


/* 
 * TABLE: DisqualifyCode 
 */

ALTER TABLE DisqualifyCode ADD CONSTRAINT DisqualifyTypeDisqualifyCode 
    FOREIGN KEY (DisqualifyTypeID)
    REFERENCES DisqualifyType(DisqualifyTypeID)
GO


/* 
 * TABLE: Entrant 
 */

ALTER TABLE Entrant ADD CONSTRAINT HeatIndividualEntrant 
    FOREIGN KEY (HeatID)
    REFERENCES HeatIndividual(HeatID) ON DELETE CASCADE
GO

ALTER TABLE Entrant ADD CONSTRAINT MemberEntrant 
    FOREIGN KEY (MemberID)
    REFERENCES Member(MemberID) ON DELETE SET NULL  NOT FOR REPLICATION
GO


/* 
 * TABLE: Event 
 */

ALTER TABLE Event ADD CONSTRAINT DistanceEvent 
    FOREIGN KEY (DistanceID)
    REFERENCES Distance(DistanceID) ON DELETE SET NULL
GO

ALTER TABLE Event ADD CONSTRAINT EventStatusEvent 
    FOREIGN KEY (EventStatusID)
    REFERENCES EventStatus(EventStatusID) ON DELETE SET NULL
GO

ALTER TABLE Event ADD CONSTRAINT EventTypeEvent 
    FOREIGN KEY (EventTypeID)
    REFERENCES EventType(EventTypeID) ON DELETE SET NULL
GO

ALTER TABLE Event ADD CONSTRAINT SessionEvent 
    FOREIGN KEY (SessionID)
    REFERENCES Session(SessionID) ON DELETE CASCADE
GO

ALTER TABLE Event ADD CONSTRAINT StrokeEvent 
    FOREIGN KEY (StrokeID)
    REFERENCES Stroke(StrokeID) ON DELETE SET NULL
GO


/* 
 * TABLE: HeatIndividual 
 */

ALTER TABLE HeatIndividual ADD CONSTRAINT DisqualifyCodeHeatIndividual 
    FOREIGN KEY (DisqualifyCodeID)
    REFERENCES DisqualifyCode(DisqualifyCodeID)
GO

ALTER TABLE HeatIndividual ADD CONSTRAINT EventHeatIndividual 
    FOREIGN KEY (EventID)
    REFERENCES Event(EventID) ON DELETE CASCADE
GO

ALTER TABLE HeatIndividual ADD CONSTRAINT HeatStatusHeatIndividual 
    FOREIGN KEY (HeatStatusID)
    REFERENCES HeatStatus(HeatStatusID) ON DELETE SET NULL
GO

ALTER TABLE HeatIndividual ADD CONSTRAINT HeatTypeHeatIndividual 
    FOREIGN KEY (HeatTypeID)
    REFERENCES HeatType(HeatTypeID) ON DELETE SET NULL
GO


/* 
 * TABLE: HeatTeam 
 */

ALTER TABLE HeatTeam ADD CONSTRAINT DisqualifyCodeHeatTeam 
    FOREIGN KEY (DisqualifyCodeID)
    REFERENCES DisqualifyCode(DisqualifyCodeID)
GO

ALTER TABLE HeatTeam ADD CONSTRAINT EventHeatTeam 
    FOREIGN KEY (EventID)
    REFERENCES Event(EventID) ON DELETE CASCADE
GO

ALTER TABLE HeatTeam ADD CONSTRAINT HeatStatusHeatTeam 
    FOREIGN KEY (HeatStatusID)
    REFERENCES HeatStatus(HeatStatusID) ON DELETE SET NULL
GO

ALTER TABLE HeatTeam ADD CONSTRAINT HeatTypeHeatTeam 
    FOREIGN KEY (HeatTypeID)
    REFERENCES HeatType(HeatTypeID) ON DELETE SET NULL
GO


/* 
 * TABLE: Member 
 */

ALTER TABLE Member ADD CONSTRAINT GenderMember 
    FOREIGN KEY (GenderID)
    REFERENCES Gender(GenderID) ON DELETE SET NULL
GO

ALTER TABLE Member ADD CONSTRAINT HouseMember 
    FOREIGN KEY (HouseID)
    REFERENCES House(HouseID) ON DELETE SET NULL
GO

ALTER TABLE Member ADD CONSTRAINT MembershipTypeMember 
    FOREIGN KEY (MembershipTypeID)
    REFERENCES MembershipType(MembershipTypeID) ON DELETE SET NULL
GO

ALTER TABLE Member ADD CONSTRAINT SwimClubMember 
    FOREIGN KEY (SwimClubID)
    REFERENCES SwimClub(SwimClubID) ON DELETE SET NULL
GO


/* 
 * TABLE: Nominee 
 */

ALTER TABLE Nominee ADD CONSTRAINT EventNominee 
    FOREIGN KEY (EventID)
    REFERENCES Event(EventID) ON DELETE CASCADE
GO

ALTER TABLE Nominee ADD CONSTRAINT MemberNominee 
    FOREIGN KEY (MemberID)
    REFERENCES Member(MemberID) ON DELETE SET NULL
GO


/* 
 * TABLE: Qualify 
 */

ALTER TABLE Qualify ADD CONSTRAINT DistanceQuali4 
    FOREIGN KEY (QualifyDistID)
    REFERENCES Distance(DistanceID)
GO

ALTER TABLE Qualify ADD CONSTRAINT DistanceQualify 
    FOREIGN KEY (TrialDistID)
    REFERENCES Distance(DistanceID) ON DELETE SET NULL
GO

ALTER TABLE Qualify ADD CONSTRAINT GenderQualify 
    FOREIGN KEY (GenderID)
    REFERENCES Gender(GenderID) ON DELETE SET NULL
GO

ALTER TABLE Qualify ADD CONSTRAINT StrokeQualify 
    FOREIGN KEY (StrokeID)
    REFERENCES Stroke(StrokeID) ON DELETE SET NULL
GO


/* 
 * TABLE: ScoreDivision 
 */

ALTER TABLE ScoreDivision ADD CONSTRAINT GenderScoreDivision 
    FOREIGN KEY (GenderID)
    REFERENCES Gender(GenderID)
GO

ALTER TABLE ScoreDivision ADD CONSTRAINT SwimClubScoreDivision 
    FOREIGN KEY (SwimClubID)
    REFERENCES SwimClub(SwimClubID)
GO


/* 
 * TABLE: ScorePoints 
 */

ALTER TABLE ScorePoints ADD CONSTRAINT SwimClubScorePoints 
    FOREIGN KEY (SwimClubID)
    REFERENCES SwimClub(SwimClubID) ON DELETE CASCADE
GO


/* 
 * TABLE: Session 
 */

ALTER TABLE Session ADD CONSTRAINT SessionStatusSession 
    FOREIGN KEY (SessionStatusID)
    REFERENCES SessionStatus(SessionStatusID) ON DELETE SET NULL
GO

ALTER TABLE Session ADD CONSTRAINT SwimClubSession 
    FOREIGN KEY (SwimClubID)
    REFERENCES SwimClub(SwimClubID) ON DELETE CASCADE
GO


/* 
 * TABLE: Split 
 */

ALTER TABLE Split ADD CONSTRAINT EntrantSplit 
    FOREIGN KEY (EntrantID)
    REFERENCES Entrant(EntrantID) ON DELETE CASCADE
GO


/* 
 * TABLE: Team 
 */

ALTER TABLE Team ADD CONSTRAINT HeatTeamTeam 
    FOREIGN KEY (HeatID)
    REFERENCES HeatTeam(HeatID) ON DELETE CASCADE
GO


/* 
 * TABLE: TeamEntrant 
 */

ALTER TABLE TeamEntrant ADD CONSTRAINT MemberTeamEntrant 
    FOREIGN KEY (MemberID)
    REFERENCES Member(MemberID) ON DELETE SET NULL
GO

ALTER TABLE TeamEntrant ADD CONSTRAINT StrokeTeamEntrant 
    FOREIGN KEY (StrokeID)
    REFERENCES Stroke(StrokeID) ON DELETE SET NULL
GO

ALTER TABLE TeamEntrant ADD CONSTRAINT TeamTeamEntrant 
    FOREIGN KEY (TeamID)
    REFERENCES Team(TeamID) ON DELETE CASCADE
GO


/* 
 * TABLE: TeamSplit 
 */

ALTER TABLE TeamSplit ADD CONSTRAINT TeamEntrantTeamSplit 
    FOREIGN KEY (TeamEntrantID)
    REFERENCES TeamEntrant(TeamEntrantID) ON DELETE CASCADE
GO


/* 
 * FUNCTION: ABSEventPlace 
 */

USE [SwimClubMeet]
GO

/****** Object:  UserDefinedFunction [dbo].[ABSEventPlace]    Script Date: 20/11/2020 12:40:49 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ben Ambrose
-- Create date: 2020.11.04
-- Description:	Find the ABSOLUTE place of the member in the event.
-- =============================================
CREATE FUNCTION [ABSEventPlace] 
(
	-- Add the parameters for the function here
	@EventID int
	,@MemberID int
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result int;

WITH CTE_Event (
	Place
	,RaceTime
	,EventID
	,MemberID
	)
AS (
	SELECT ROW_NUMBER() OVER (
			ORDER BY CASE 
					WHEN RaceTime IS NULL
						THEN 1
					ELSE 0
					END ASC
				,CASE 
					WHEN (CAST(CAST(RaceTime AS DATETIME) AS FLOAT) = 0)
						THEN 1
					ELSE 0
					END ASC
				,RaceTime ASC
			) AS Place
		,Entrant.RaceTime
		,Event.EventID
		,Entrant.MemberID
	FROM Event
	INNER JOIN HeatIndividual ON Event.EventID = HeatIndividual.EventID
	INNER JOIN Entrant ON HeatIndividual.HeatID = Entrant.HeatID
	WHERE Event.EventID = @EventID
		AND MemberID IS NOT NULL
		AND Entrant.IsDisqualified = 0
		AND Entrant.IsScratched = 0
	)

	-- Add the T-SQL statements to compute the return value here
	SELECT @Result = (SELECT Place FROM CTE_Event WHERE CTE_Event.MemberID = @MemberID )

	-- Return the result of the function
	RETURN @Result

END
GO





GO
IF OBJECT_ID('ABSEventPlace') IS NOT NULL
    PRINT '<<< CREATED FUNCTION ABSEventPlace >>>'
ELSE
    PRINT '<<< FAILED CREATING FUNCTION ABSEventPlace >>>'
GO

GRANT EXECUTE ON ABSEventPlace TO SCM_Marshall
GO
GRANT EXECUTE ON ABSEventPlace TO SCM_Guest
GO
GRANT EXECUTE ON ABSEventPlace TO SCM_Administrator
GO


/* 
 * FUNCTION: ABSHeatPlace 
 */

USE [SwimClubMeet]
GO

/****** Object:  UserDefinedFunction [dbo].[ABSHeatPlace]    Script Date: 20/11/2020 12:41:05 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Ben Ambrose
-- Create date: 2020.11.04
-- Description:	Find the ABSOLUTE place of the member in the heat.
-- =============================================
CREATE FUNCTION [ABSHeatPlace] (
	-- Add the parameters for the function here
	@HeatID INT
	,@MemberID INT
	)
RETURNS INT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result INT;

	WITH CTE_Heat (
		Place
		,RaceTime
		,HeatID
		,MemberID
		)
	AS (
		SELECT ROW_NUMBER() OVER (
				ORDER BY CASE 
						WHEN RaceTime IS NULL
							THEN 1
						ELSE 0
						END ASC
					,CASE 
						WHEN (CAST(CAST(RaceTime AS DATETIME) AS FLOAT) = 0)
							THEN 1
						ELSE 0
						END ASC
					,RaceTime ASC
				) AS Place
			,Entrant.RaceTime
			,HeatIndividual.HeatID
			,Entrant.MemberID
		FROM HeatIndividual
		INNER JOIN Entrant ON HeatIndividual.HeatID = Entrant.HeatID
		WHERE HeatIndividual.HeatID = @HeatID
			AND MemberID IS NOT NULL
			AND Entrant.IsDisqualified = 0
			AND Entrant.IsScratched = 0
		)
	-- Add the T-SQL statements to compute the return value here
	SELECT @Result = (
			SELECT CTE_Heat.Place
			FROM CTE_Heat
			WHERE CTE_Heat.MemberID = @MemberID
			)

	-- Return the result of the function
	RETURN @Result
END
GO





GO
IF OBJECT_ID('ABSHeatPlace') IS NOT NULL
    PRINT '<<< CREATED FUNCTION ABSHeatPlace >>>'
ELSE
    PRINT '<<< FAILED CREATING FUNCTION ABSHeatPlace >>>'
GO

GRANT EXECUTE ON ABSHeatPlace TO SCM_Marshall
GO
GRANT EXECUTE ON ABSHeatPlace TO SCM_Guest
GO
GRANT EXECUTE ON ABSHeatPlace TO SCM_Administrator
GO


/* 
 * FUNCTION: EntrantCount 
 */

USE [SwimClubMeet]
GO

/****** Object:  UserDefinedFunction [dbo].[EntrantCount]    Script Date: 4/03/2022 4:04:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ben Ambrose
-- Create date: 13/8/2019
-- Description:	Count the number of entrants for an event
-- =============================================
CREATE FUNCTION [EntrantCount] (
    -- Add the parameters for the function here
    @EventID INT
    )
RETURNS INT
AS
BEGIN
    -- Declare the return variable here
    DECLARE @Result INT

    -- Add the T-SQL statements to compute the return value here
    SELECT @Result = Count(Entrant.EntrantID)
    FROM Entrant
    INNER JOIN HeatIndividual
        ON Entrant.HeatID = HeatIndividual.HeatID
    WHERE (Entrant.MemberID IS NOT NULL)
    GROUP BY HeatIndividual.EventID
    HAVING HeatIndividual.EventID = @EventID

    -- Return the result of the function
    RETURN @Result
END
GO




GO
IF OBJECT_ID('EntrantCount') IS NOT NULL
    PRINT '<<< CREATED FUNCTION EntrantCount >>>'
ELSE
    PRINT '<<< FAILED CREATING FUNCTION EntrantCount >>>'
GO

GRANT EXECUTE ON EntrantCount TO SCM_Marshall
GO
GRANT EXECUTE ON EntrantCount TO SCM_Guest
GO
GRANT EXECUTE ON EntrantCount TO SCM_Administrator
GO


/* 
 * FUNCTION: EntrantScore 
 */

USE [SwimClubMeet]
GO

/****** Object:  UserDefinedFunction [dbo].[EntrantScore]    Script Date: 28/08/22 4:13:31 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ben Ambrose
-- Create date: 28/08/2022
-- Description:	Get the entrants score for a given place.
-- =============================================
CREATE FUNCTION [EntrantScore] 
(
	-- Add the parameters for the function here
	@EntrantID int, 
	@Place int
)
RETURNS float
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result float;

	WITH CTE_POINTS (EntrantID, Points) 
	AS (

	SELECT EntrantID,
		   CASE
			   WHEN (RaceTime IS NULL) OR (IsDisqualified = 1) OR (IsScratched = 1) THEN 0
			   ELSE
				   ScorePoints.Points
		   END AS Points
	FROM Entrant
		INNER JOIN ScorePoints
			ON ScorePoints.Place = @Place
	WHERE EntrantID = @EntrantID)

	-- Add the T-SQL statements to compute the return value here
	SELECT @Result = (SELECT Points FROM CTE_POINTS);

	-- Return the result of the function
	RETURN @Result

END
GO

IF OBJECT_ID('EntrantScore') IS NOT NULL
    PRINT '<<< CREATED FUNCTION EntrantScore >>>'
ELSE
    PRINT '<<< FAILED CREATING FUNCTION EntrantScore >>>'
GO

GRANT EXECUTE ON EntrantScore TO SCM_Administrator
GO
GRANT EXECUTE ON EntrantScore TO SCM_Guest
GO
GRANT EXECUTE ON EntrantScore TO SCM_Marshall
GO


/* 
 * FUNCTION: HeatCount 
 */

USE [SwimClubMeet]
GO

/****** Object:  UserDefinedFunction [dbo].[HeatCount]    Script Date: 4/03/2022 4:04:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ben Ambrose
-- Create date: 14/8/2019
-- Description:	Count the number of heats in an event
-- =============================================
CREATE FUNCTION [HeatCount] (
	-- Add the parameters for the function here
	@EventID INT
	)
RETURNS INT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result INT

	-- Add the T-SQL statements to compute the return value here
	SELECT @Result = @EventID

	-- Add the T-SQL statements to compute the return value here
	SELECT @Result = Count(HeatIndividual.EventID)
	FROM HeatIndividual
	WHERE HeatIndividual.EventID = @EventID
	GROUP BY HeatIndividual.EventID

	-- Return the result of the function
	RETURN @Result
END
GO






GO
IF OBJECT_ID('HeatCount') IS NOT NULL
    PRINT '<<< CREATED FUNCTION HeatCount >>>'
ELSE
    PRINT '<<< FAILED CREATING FUNCTION HeatCount >>>'
GO

GRANT EXECUTE ON HeatCount TO SCM_Marshall
GO
GRANT EXECUTE ON HeatCount TO SCM_Guest
GO
GRANT EXECUTE ON HeatCount TO SCM_Administrator
GO


/* 
 * FUNCTION: IsMemberNominated 
 */

USE [SwimClubMeet]
GO

/****** Object:  UserDefinedFunction [dbo].[IsMemberNominated]    Script Date: 26/05/22 11:28:58 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ben Ambrose
-- Create date: 25/05/2022
-- Description:	Is the member nominated for the event
-- =============================================
CREATE FUNCTION [IsMemberNominated] 
(
	-- Add the parameters for the function here
	@MemberID int
	,@EventID int
)
RETURNS Bit
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result Bit

	-- Add the T-SQL statements to compute the return value here
    SELECT @Result = (
            SELECT CASE 
                    WHEN [NomineeID] IS NOT NULL
                        THEN 0
                    ELSE 1
                    END
            FROM Nominee
            WHERE MemberID = @MemberID AND EventID = @EventID
            )

	-- Return the result of the function
	RETURN @Result

END
GO

IF OBJECT_ID('IsMemberNominated') IS NOT NULL
    PRINT '<<< CREATED FUNCTION IsMemberNominated >>>'
ELSE
    PRINT '<<< FAILED CREATING FUNCTION IsMemberNominated >>>'
GO

GRANT EXECUTE ON IsMemberNominated TO SCM_Marshall
GO
GRANT EXECUTE ON IsMemberNominated TO SCM_Guest
GO
GRANT EXECUTE ON IsMemberNominated TO SCM_Administrator
GO


/* 
 * FUNCTION: IsMemberQualified 
 */

USE [SwimClubMeet]
GO

/****** Object:  UserDefinedFunction [dbo].[IsMemberQualified]    Script Date: 26/05/22 11:29:28 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ben Ambrose
-- Create date: 04/05/22
-- Description:	Is the member qualified to swim the event
-- =============================================
CREATE   FUNCTION [dbo].[IsMemberQualified] 
(
	-- Add the parameters for the function here
	@MemberID int
	,@SeedDate DateTime
	,@DistanceID int
	,@StrokeID int
	
)
RETURNS BIT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result bit;

	DECLARE @IsShortCourse AS BIT;-- calculated (important - uses SwimClubID)
	DECLARE @GenderID AS INT;-- calculated (important - qualification table splits MALE and FEMALE)
	DECLARE @SwimClubID AS INT;-- required (NULL returns no records)
	DECLARE @TrialTimePB AS time(7);

	SET @Result = 0;

	SET @GenderID = (SELECT GenderID FROM dbo.Member WHERE dbo.Member.MemberID = @MemberID) ;

	SET @SwimCLubID = 1;

	-- use todays date
    IF @SeedDate IS NULL
        SET @SeedDate = GETDATE();

	-- any thing under 50 meters is a shortcourse
	SET @IsShortCourse = (
		SELECT CASE 
				WHEN [SwimClub].[LenOfPool] >= 50
					THEN 0
				ELSE 1
				END
		FROM SwimClub
		WHERE SwimClubID = @SwimClubID
		);

	DECLARE @Trail TABLE (
		ID INT identity(1, 1)
		, TrialDistID INT
		, TrialTime time(7)
		);

	INSERT INTO @Trail(TrialDistID, TrialTime)
	SELECT TrialDistID, TrialTime
			FROM Qualify
			WHERE (Qualify.StrokeID = @StrokeID)
				AND (Qualify.QualifyDistID = @DistanceID)
				AND (Qualify.IsShortCourse = @IsShortCourse)
				AND (Qualify.GenderID = @GenderID);


	if EXISTS (SELECT * FROM @Trail) 
		SET @TrialTimePB = (SELECT dbo.PersonalBest(@MemberID, TrialDistID, @StrokeID, @SeedDate) FROM @Trail);
	ELSE 
		RETURN @Result;
	-- ErStudio can't validate IIF statement
	SET @Result =(SELECT IIF(@TrialTimePB <=TrialTime, 1, 0) FROM @Trail); 

	-- Return the result of the function
	RETURN @Result

END
GO





GO
IF OBJECT_ID('IsMemberQualified') IS NOT NULL
    PRINT '<<< CREATED FUNCTION IsMemberQualified >>>'
ELSE
    PRINT '<<< FAILED CREATING FUNCTION IsMemberQualified >>>'
GO

GRANT EXECUTE ON IsMemberQualified TO SCM_Marshall
GO
GRANT EXECUTE ON IsMemberQualified TO SCM_Guest
GO
GRANT EXECUTE ON IsMemberQualified TO SCM_Administrator
GO


/* 
 * FUNCTION: IsPoolShortCourse 
 */

USE [SwimClubMeet]
GO

/****** Object:  UserDefinedFunction [dbo].[IsPoolShortCourse]    Script Date: 4/10/2020 9:25:38 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ben Ambrose
-- Create date: 4.10.2020
-- Modified date: 6.3.2022
-- Description:	Is the club's swimming pool a ShortCourse
-- =============================================
CREATE FUNCTION [IsPoolShortCourse] (
    -- Add the parameters for the function here
    @SwimClubID INT
    )
RETURNS BIT
AS
BEGIN
    -- Declare the return variable here
    DECLARE @Result BIT

    -- T-SQL statement to compute the return value here
    -- NOTE: May produce NULL if the SwimClubID is invalid.
    SELECT @Result = (
            SELECT CASE 
                    WHEN [SwimClub].[LenOfPool] >= 50
                        THEN 0
                    ELSE 1
                    END
            -- ER Studio validation error - doesn't understand IIF
            -- IIF(LenOfPool >= 50, 0, 1) 
            FROM SwimClub
            WHERE SwimClubID = @SwimClubID
            )

    -- NOTE: Set an arbetory DEFAULT?
    -- IF @Result IS NULL 
    -- SET @Result = 0

    -- Return the result of the function
    RETURN @Result
END



GO
IF OBJECT_ID('IsPoolShortCourse') IS NOT NULL
    PRINT '<<< CREATED FUNCTION IsPoolShortCourse >>>'
ELSE
    PRINT '<<< FAILED CREATING FUNCTION IsPoolShortCourse >>>'
GO

GRANT EXECUTE ON IsPoolShortCourse TO SCM_Marshall
GO
GRANT EXECUTE ON IsPoolShortCourse TO SCM_Guest
GO
GRANT EXECUTE ON IsPoolShortCourse TO SCM_Administrator
GO


/* 
 * FUNCTION: NomineeCount 
 */

USE [SwimClubMeet]
GO

/****** Object:  UserDefinedFunction [dbo].[NomineeCount]    Script Date: 4/03/2022 4:04:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ben Ambrose
-- Create date: 13/8/2019
-- Description:	Count the number of nominees wishing to enter the event
-- =============================================
CREATE FUNCTION [NomineeCount] (
	-- Add the parameters for the function here
	@EventID INT
	)
RETURNS INT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result INT

	-- Add the T-SQL statements to compute the return value here
	SELECT @Result = Count(Nominee.EventID)
	FROM Nominee
	GROUP BY Nominee.EventID
	HAVING Nominee.EventID = @EventID

	-- Return the result of the function
	RETURN @Result
END
GO









GO
IF OBJECT_ID('NomineeCount') IS NOT NULL
    PRINT '<<< CREATED FUNCTION NomineeCount >>>'
ELSE
    PRINT '<<< FAILED CREATING FUNCTION NomineeCount >>>'
GO

GRANT EXECUTE ON NomineeCount TO SCM_Marshall
GO
GRANT EXECUTE ON NomineeCount TO SCM_Guest
GO
GRANT EXECUTE ON NomineeCount TO SCM_Administrator
GO


/* 
 * FUNCTION: PersonalBest 
 */

USE [SwimClubMeet]
GO

/****** Object:  UserDefinedFunction [dbo].[PersonalBest]    Script Date: 4/03/2022 4:04:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ben Ambrose
-- Create date: 3/8/2019
-- Updated 16/5/2020
-- Description:	Find the 'Personal Best' 
--				race time for a given Member
-- =============================================
CREATE FUNCTION [PersonalBest] (
	-- Add the parameters for the function here
	@MemberID INT,
	@DistanceID INT,
	@StrokeID INT,
	@SessionDate DATETIME = NULL
	)
RETURNS TIME
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result TIME

	-- use a default sessiontime
	IF @SessionDate IS NULL
		SET @SessionDate = GETDATE();

	-- Add the T-SQL statements to compute the return value here
	SELECT @Result = MIN(Entrant.RaceTime)
	-- CAST(CAST(MIN(Entrant.RaceTime) AS DATETIME) AS FLOAT) AS PersonalBest
	FROM Entrant
	INNER JOIN HeatIndividual ON Entrant.HeatID = HeatIndividual.HeatID
	INNER JOIN Event ON HeatIndividual.EventID = Event.EventID
	INNER JOIN Session ON Event.SessionID = Session.SessionID
	WHERE (Event.StrokeID = @StrokeID)
		AND (Event.DistanceID = @DistanceID)
		AND (Entrant.RaceTime IS NOT NULL)
		AND (Entrant.IsDisqualified <> 1) -- added 16/5/2020
		AND (Entrant.IsScratched <> 1) -- added 16/5/2020
		AND (Session.SessionStart < @SessionDate)
	GROUP BY Entrant.MemberID
	HAVING (Entrant.MemberID = @MemberID)

	-- Return the result of the function
	RETURN @Result
END
GO





GO
IF OBJECT_ID('PersonalBest') IS NOT NULL
    PRINT '<<< CREATED FUNCTION PersonalBest >>>'
ELSE
    PRINT '<<< FAILED CREATING FUNCTION PersonalBest >>>'
GO

GRANT EXECUTE ON PersonalBest TO SCM_Marshall
GO
GRANT EXECUTE ON PersonalBest TO SCM_Guest
GO
GRANT EXECUTE ON PersonalBest TO SCM_Administrator
GO


/* 
 * FUNCTION: RaceTimeDIFF 
 */

USE [SwimClubMeet]
GO

/****** Object:  UserDefinedFunction [dbo].[RaceTimeDIFF]    Script Date: 4/03/2022 4:04:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ben
-- Create date: 21/02/2019
-- Description:	Performance difference in race time vs personal best given in seconds (float)
-- =============================================
CREATE FUNCTION [RaceTimeDIFF] (
	-- Add the parameters for the function here
	@RaceTime TIME(7),
	@PersonalBest TIME(7)
	)
RETURNS FLOAT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result FLOAT

	IF (@RaceTime IS NULL)
		OR (@PersonalBest IS NULL)
		OR (CAST(CAST(@RaceTime AS DATETIME) AS FLOAT) = 0)
		OR (CAST(CAST(@PersonalBest AS DATETIME) AS FLOAT) = 0)
		SET @Result = 0;
	ELSE
		-- Add the T-SQL statements to compute the return value here
		SELECT @Result = DATEDIFF(millisecond, @RaceTime, @PersonalBest) / 1000.0

	-- Return the result of the function
	RETURN @Result
END
GO





GO
IF OBJECT_ID('RaceTimeDIFF') IS NOT NULL
    PRINT '<<< CREATED FUNCTION RaceTimeDIFF >>>'
ELSE
    PRINT '<<< FAILED CREATING FUNCTION RaceTimeDIFF >>>'
GO

GRANT EXECUTE ON RaceTimeDIFF TO SCM_Marshall
GO
GRANT EXECUTE ON RaceTimeDIFF TO SCM_Guest
GO
GRANT EXECUTE ON RaceTimeDIFF TO SCM_Administrator
GO


/* 
 * FUNCTION: RELEventPlace 
 */

USE [SwimClubMeet]
GO

/****** Object:  UserDefinedFunction [dbo].[RELEventPlace]    Script Date: 20/11/2020 12:41:46 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Ben Ambrose
-- Create date: 2020.11.04
-- Description:	Find the place of the member in the event relative to a given division.
-- =============================================
CREATE FUNCTION [RELEventPlace] (
	-- Add the parameters for the function here
	@EventID INT
	,@MemberID INT
	,@DivisionID INT
	,@SessionStart DATETIME
	)
RETURNS INT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result INT;


	DECLARE @TempTBL TABLE (
		MemberID INT
		,ScoreDivisionID INT
		);

	INSERT INTO @TempTBL
	SELECT Member.MemberID
		,ScoreDivisionID
	FROM ScoreDivision
	JOIN Member ON ScoreDivision.GenderID = Member.GenderID
	WHERE dbo.SwimmerAge(@SessionStart, Member.DOB) <= AgeTo
		AND dbo.SwimmerAge(@SessionStart, Member.DOB) >= AgeFrom;

	WITH CTE_Event (
		Place 
		,MemberID
		)
	AS (
		SELECT ROW_NUMBER() OVER (
				ORDER BY CASE 
						WHEN RaceTime IS NULL
							THEN 1
						ELSE 0
						END ASC
					,CASE 
						WHEN (CAST(CAST(RaceTime AS DATETIME) AS FLOAT) = 0)
							THEN 1
						ELSE 0
						END ASC
					,RaceTime ASC
				) AS Place
			,Entrant.MemberID
		FROM Event
		INNER JOIN HeatIndividual ON Event.EventID = HeatIndividual.EventID
		INNER JOIN Entrant ON HeatIndividual.HeatID = Entrant.HeatID
		LEFT JOIN @TempTBL ON Entrant.MemberID = [@TempTBL].[MemberID]
		WHERE Event.EventID = @EventID
			AND Entrant.MemberID IS NOT NULL
			AND Entrant.IsDisqualified = 0
			AND Entrant.IsScratched = 0
			AND [@TempTBL].[ScoreDivisionID] = @DivisionID
		)
	-- Add the T-SQL statements to compute the return value here
	SELECT @Result = (
			SELECT CTE_Event.Place
			FROM CTE_Event
			WHERE CTE_Event.MemberID = @MemberID
			)

	-- Return the result of the function
	RETURN @Result
END
GO





GO
IF OBJECT_ID('RELEventPlace') IS NOT NULL
    PRINT '<<< CREATED FUNCTION RELEventPlace >>>'
ELSE
    PRINT '<<< FAILED CREATING FUNCTION RELEventPlace >>>'
GO

GRANT EXECUTE ON RELEventPlace TO SCM_Marshall
GO
GRANT EXECUTE ON RELEventPlace TO SCM_Guest
GO
GRANT EXECUTE ON RELEventPlace TO SCM_Administrator
GO


/* 
 * FUNCTION: RELHeatPlace 
 */

USE [SwimClubMeet]
GO

/****** Object:  UserDefinedFunction [dbo].[RELHeatPlace]    Script Date: 20/11/2020 12:41:52 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ben Ambrose
-- Create date: 2020.11.04
-- Description:	Find the place of the member in the heat relative to a given division.
-- =============================================
CREATE FUNCTION [RELHeatPlace] 
(
	-- Add the parameters for the function here
	@HeatID int
	,@MemberID INT
	,@DivisionID INT
	,@SessionStart DATETIME
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result int

	DECLARE @TempTBL TABLE (
		MemberID INT
		,ScoreDivisionID INT
		);

	INSERT INTO @TempTBL
	SELECT Member.MemberID
		,ScoreDivisionID
	FROM ScoreDivision
	JOIN Member ON ScoreDivision.GenderID = Member.GenderID
	WHERE dbo.SwimmerAge(@SessionStart, Member.DOB) <= AgeTo
		AND dbo.SwimmerAge(@SessionStart, Member.DOB) >= AgeFrom;

	WITH CTE_Event (
		Place 
		,MemberID
		)
	AS (
		SELECT ROW_NUMBER() OVER (
				ORDER BY CASE 
						WHEN RaceTime IS NULL
							THEN 1
						ELSE 0
						END ASC
					,CASE 
						WHEN (CAST(CAST(RaceTime AS DATETIME) AS FLOAT) = 0)
							THEN 1
						ELSE 0
						END ASC
					,RaceTime ASC
				) AS Place
			,Entrant.MemberID
		FROM HeatIndividual 
		INNER JOIN Entrant ON HeatIndividual.HeatID = Entrant.HeatID
		LEFT JOIN @TempTBL ON Entrant.MemberID = [@TempTBL].[MemberID]
		WHERE HeatIndividual.HeatID = @HeatID
			AND Entrant.MemberID IS NOT NULL
			AND Entrant.IsDisqualified = 0
			AND Entrant.IsScratched = 0
			AND [@TempTBL].[ScoreDivisionID] = @DivisionID
		)
	-- Add the T-SQL statements to compute the return value here
	SELECT @Result = (
			SELECT CTE_Event.Place
			FROM CTE_Event
			WHERE CTE_Event.MemberID = @MemberID
			)

	-- Return the result of the function
	RETURN @Result

END
GO





GO
IF OBJECT_ID('RELHeatPlace') IS NOT NULL
    PRINT '<<< CREATED FUNCTION RELHeatPlace >>>'
ELSE
    PRINT '<<< FAILED CREATING FUNCTION RELHeatPlace >>>'
GO

GRANT EXECUTE ON RELHeatPlace TO SCM_Marshall
GO
GRANT EXECUTE ON RELHeatPlace TO SCM_Guest
GO
GRANT EXECUTE ON RELHeatPlace TO SCM_Administrator
GO


/* 
 * FUNCTION: SessionEntrantCount 
 */

USE [SwimClubMeet]
GO

/****** Object:  UserDefinedFunction [dbo].[SessionEntrantCount]    Script Date: 4/03/2022 4:04:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ben Ambrose
-- Create date: 15/11/2019
-- Description:	Count the number of entrants in a given session
-- =============================================
CREATE FUNCTION [SessionEntrantCount] (
	-- Add the parameters for the function here
	@SessionID INT
	)
RETURNS INT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result INT

	-- Add the T-SQL statements to compute the return value here
	SELECT @Result = Count(Entrant.MemberID)
	FROM Entrant
	INNER JOIN HeatIndividual ON Entrant.HeatID = HeatIndividual.HeatID
	INNER JOIN Event ON HeatIndividual.EventID = Event.EventID
	WHERE (Event.SessionID = @SessionID)
		AND (Entrant.MemberID > 0)

	-- Return the result of the function
	RETURN @Result
END
GO





GO
IF OBJECT_ID('SessionEntrantCount') IS NOT NULL
    PRINT '<<< CREATED FUNCTION SessionEntrantCount >>>'
ELSE
    PRINT '<<< FAILED CREATING FUNCTION SessionEntrantCount >>>'
GO

GRANT EXECUTE ON SessionEntrantCount TO SCM_Marshall
GO
GRANT EXECUTE ON SessionEntrantCount TO SCM_Guest
GO
GRANT EXECUTE ON SessionEntrantCount TO SCM_Administrator
GO


/* 
 * FUNCTION: SessionNomineeCount 
 */

USE [SwimClubMeet]
GO

/****** Object:  UserDefinedFunction [dbo].[SessionNomineeCount]    Script Date: 4/03/2022 4:04:00 PM ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

-- =============================================
-- Author:		Ben Ambrose
-- Create date: 15/11/2019
-- Description:	Count the number of Nominees for a give session
-- =============================================
CREATE FUNCTION [SessionNomineeCount] (
	-- Add the parameters for the function here
	@SessionID INT
	)
RETURNS INT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result INT

	-- Add the T-SQL statements to compute the return value here
	SELECT @Result = COUNT(Nominee.NomineeID)
	FROM Nominee
	INNER JOIN Event ON Nominee.EventID = Event.EventID
	WHERE (Event.SessionID = @SessionID);

	-- Return the result of the function
	RETURN @Result
END
GO





GO
IF OBJECT_ID('SessionNomineeCount') IS NOT NULL
    PRINT '<<< CREATED FUNCTION SessionNomineeCount >>>'
ELSE
    PRINT '<<< FAILED CREATING FUNCTION SessionNomineeCount >>>'
GO

GRANT EXECUTE ON SessionNomineeCount TO SCM_Marshall
GO
GRANT EXECUTE ON SessionNomineeCount TO SCM_Guest
GO
GRANT EXECUTE ON SessionNomineeCount TO SCM_Administrator
GO


/* 
 * FUNCTION: SwimmerAge 
 */

USE [SwimClubMeet]
GO

/****** Object:  UserDefinedFunction [dbo].[SwimmerAge]    Script Date: 4/03/2022 4:04:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ben Ambrpse
-- Create date: 
-- Description:	Swimmer's age at swim club night.
-- =============================================
CREATE FUNCTION [SwimmerAge] (
	-- Add the parameters for the function here
	@SessionStart DATETIME,
	@DOB DATETIME
	)
RETURNS INT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result INT

	-- Add the T-SQL statements to compute the return value here
	SET @Result = FLOOR(DATEDIFF(day, @DOB, @SessionStart) / 365.0)

	-- Return the result of the function
	RETURN @Result
END
GO





GO
IF OBJECT_ID('SwimmerAge') IS NOT NULL
    PRINT '<<< CREATED FUNCTION SwimmerAge >>>'
ELSE
    PRINT '<<< FAILED CREATING FUNCTION SwimmerAge >>>'
GO

GRANT EXECUTE ON SwimmerAge TO SCM_Marshall
GO
GRANT EXECUTE ON SwimmerAge TO SCM_Guest
GO
GRANT EXECUTE ON SwimmerAge TO SCM_Administrator
GO


/* 
 * FUNCTION: SwimmerGenderToString 
 */

USE [SwimClubMeet]
GO

/****** Object:  UserDefinedFunction [dbo].[SwimmerGenderToString]    Script Date: 4/03/2022 4:04:00 PM ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

-- =============================================
-- Author:		Ben
-- Create date: 21/02/2019
-- Description:	Return the gender of the meber as a short string
-- =============================================
CREATE FUNCTION [SwimmerGenderToString] (
	-- Add the parameters for the function here
	@MemberID INT
	)
RETURNS NVARCHAR(2)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result NVARCHAR(2)

	-- Add the T-SQL statements to compute the return value here
	SELECT @Result = CASE GenderID
			WHEN 1
				THEN 'M'
			WHEN 2
				THEN 'F'
			END
	FROM Member
	WHERE MemberID = @MemberID;

	-- Return the result of the function
	RETURN @Result
END
GO





GO
IF OBJECT_ID('SwimmerGenderToString') IS NOT NULL
    PRINT '<<< CREATED FUNCTION SwimmerGenderToString >>>'
ELSE
    PRINT '<<< FAILED CREATING FUNCTION SwimmerGenderToString >>>'
GO

GRANT EXECUTE ON SwimmerGenderToString TO SCM_Marshall
GO
GRANT EXECUTE ON SwimmerGenderToString TO SCM_Guest
GO
GRANT EXECUTE ON SwimmerGenderToString TO SCM_Administrator
GO


/* 
 * FUNCTION: SwimTimeToMilliseconds 
 */

USE [SwimClubMeet]
GO

/****** Object:  UserDefinedFunction [dbo].[SwimTimeToMilliseconds]    Script Date: 4/03/2022 4:04:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ben Ambrose
-- Create date: 9/8/2019
-- Description:	SwimTime to Milliseconds
-- =============================================
CREATE FUNCTION [SwimTimeToMilliseconds] (
	-- Add the parameters for the function here
	@SwimTime TIME
	)
RETURNS INT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result INT

	-- THIS IS ALSO LEGAL
	-- SELECT @Result = DATEDIFF(MILLISECOND, 0, @SwimTime)
	-- Add the T-SQL statements to compute the return value here
	SELECT @Result = DATEPART(MILLISECOND, @SwimTime) + (DATEPART(second, @SwimTime) * 1000) + (DATEPART(minute, @SwimTime) * 1000 * 60)

	-- Return the result of the function
	RETURN @Result
END
GO





GO
IF OBJECT_ID('SwimTimeToMilliseconds') IS NOT NULL
    PRINT '<<< CREATED FUNCTION SwimTimeToMilliseconds >>>'
ELSE
    PRINT '<<< FAILED CREATING FUNCTION SwimTimeToMilliseconds >>>'
GO

GRANT EXECUTE ON SwimTimeToMilliseconds TO SCM_Marshall
GO
GRANT EXECUTE ON SwimTimeToMilliseconds TO SCM_Guest
GO
GRANT EXECUTE ON SwimTimeToMilliseconds TO SCM_Administrator
GO


/* 
 * FUNCTION: SwimTimeToString 
 */

USE [SwimClubMeet]
GO

/****** Object:  UserDefinedFunction [dbo].[SwimTimeToString]    Script Date: 4/03/2022 4:04:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ben
-- Create date: 21/02/2019
-- Description:	Convert DateTime to Swimming Time
-- =============================================
CREATE FUNCTION [SwimTimeToString] (
	-- Add the parameters for the function here
	@SwimTime TIME(7)
	)
RETURNS NVARCHAR(12)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result NVARCHAR(12)

	IF (@SwimTime IS NULL)
		OR (CAST(CAST(@SwimTime AS DATETIME) AS FLOAT) = 0)
		SET @Result = '';
	ELSE
		-- Add the T-SQL statements to compute the return value here
		SELECT @Result = SUBSTRING(convert(VARCHAR(25), @SwimTime, 121), 4, 9);

	/*
	NOTE:
	Originally written as ...
	-- SELECT @Result = SUBSTRING(Format(CAST(@SwimTime AS DATETIME), 'mm:ss.fff'),0, 12);
	... Proved to round out the precision 
	*/
	-- Return the result of the function
	RETURN @Result
END
GO





GO
IF OBJECT_ID('SwimTimeToString') IS NOT NULL
    PRINT '<<< CREATED FUNCTION SwimTimeToString >>>'
ELSE
    PRINT '<<< FAILED CREATING FUNCTION SwimTimeToString >>>'
GO

GRANT EXECUTE ON SwimTimeToString TO SCM_Marshall
GO
GRANT EXECUTE ON SwimTimeToString TO SCM_Guest
GO
GRANT EXECUTE ON SwimTimeToString TO SCM_Administrator
GO


/* 
 * FUNCTION: TimeToBeat 
 */

USE [SwimClubMeet]
GO

/****** Object:  UserDefinedFunction [dbo].[TimeToBeat]    Script Date: 4/03/2022 4:04:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ben Ambrose
-- Create date: 3/8/2019
-- Description:	TimeToBeat
-- Update 16/5/2020
-- algorithm 0 ... last known racetime
-- algorithm 1 ... average of the 3 fastest racetimes
-- algorithm 2 ... participants personal best
-- else (entrants without racetimes) calculate timetobeat
-- =============================================
CREATE FUNCTION [TimeToBeat] (
	-- Add the parameters for the function here
	@algorithm INT,
	@CalcDefault INT = 1,
	@Percent FLOAT = 50.0,
	@MemberID INT,
	@DistanceID INT,
	@StrokeID INT,
	@SessionDate DATETIME = NULL
	)
RETURNS TIME
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result TIME

	-- use a default sessiontime
	IF @SessionDate IS NULL
		SET @SessionDate = GETDATE();

	-- Add the T-SQL statements to compute the return value here
	SELECT @Result = CASE @algorithm
			WHEN 0
				THEN dbo.TimeToBeat_1(@MemberID, @DistanceID, @StrokeID, @SessionDate)
			WHEN 1
				THEN dbo.TimeToBeat_2(@MemberID, @DistanceID, @StrokeID, @SessionDate)
			WHEN 2
				THEN dbo.PersonalBest(@MemberID, @DistanceID, @StrokeID, @SessionDate)
			ELSE NULL
			END

	IF @Result IS NULL
		AND (@CalcDefault = 1) (
			SELECT @Result = dbo.TimeToBeat_DEFAULT(@MemberID, @DistanceID, @StrokeID, @SessionDate, @Percent)
			);
		-- Return the result of the function
		RETURN @Result
END
GO





GO
IF OBJECT_ID('TimeToBeat') IS NOT NULL
    PRINT '<<< CREATED FUNCTION TimeToBeat >>>'
ELSE
    PRINT '<<< FAILED CREATING FUNCTION TimeToBeat >>>'
GO

GRANT EXECUTE ON TimeToBeat TO SCM_Marshall
GO
GRANT EXECUTE ON TimeToBeat TO SCM_Guest
GO
GRANT EXECUTE ON TimeToBeat TO SCM_Administrator
GO


/* 
 * FUNCTION: TimeToBeat_1 
 */

USE [SwimClubMeet]
GO

/****** Object:  UserDefinedFunction [dbo].[TimeToBeat_1]    Script Date: 4/03/2022 4:04:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ben Ambrose
-- Create date: 3/8/2019
-- Updated 16/5/2020
-- Description:	Get TimeToBeat 
-- algorithm 1 ... last known racetime
-- =============================================
CREATE FUNCTION [TimeToBeat_1] (
	-- Add the parameters for the function here
	@MemberID INT,
	@DistanceID INT,
	@StrokeID INT,
	@SessionDate DATETIME = NULL
	)
RETURNS TIME
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result TIME

	-- use a default sessiontime
	IF @SessionDate IS NULL
		SET @SessionDate = GETDATE();

	-- Add the T-SQL statements to compute the return value here
	SELECT TOP (1) @Result = Entrant.RaceTime
	FROM Entrant
	INNER JOIN HeatIndividual ON Entrant.HeatID = HeatIndividual.HeatID
	INNER JOIN Event ON HeatIndividual.EventID = Event.EventID
	INNER JOIN Session ON Event.SessionID = Session.SessionID
	WHERE (Entrant.RaceTime IS NOT NULL)
		AND (Entrant.IsDisqualified <> 1) -- added 16/5/2020
		AND (Entrant.IsScratched <> 1) -- added 16/5/2020
		AND (Entrant.MemberID = @MEMBERID)
		AND (Session.SessionStart < @SESSIONDATE)
		AND Event.DistanceID = @DISTANCEID
		AND Event.StrokeID = @STROKEID
	ORDER BY Session.SessionStart DESC,
		Entrant.RaceTime ASC

	-- Return the result of the function
	RETURN @Result
END
GO





GO
IF OBJECT_ID('TimeToBeat_1') IS NOT NULL
    PRINT '<<< CREATED FUNCTION TimeToBeat_1 >>>'
ELSE
    PRINT '<<< FAILED CREATING FUNCTION TimeToBeat_1 >>>'
GO

GRANT EXECUTE ON TimeToBeat_1 TO SCM_Marshall
GO
GRANT EXECUTE ON TimeToBeat_1 TO SCM_Guest
GO
GRANT EXECUTE ON TimeToBeat_1 TO SCM_Administrator
GO


/* 
 * FUNCTION: TimeToBeat_2 
 */

USE [SwimClubMeet]
GO

/****** Object:  UserDefinedFunction [dbo].[TimeToBeat_2]    Script Date: 4/03/2022 4:04:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ben Ambrose
-- Create date: 3/8/2019
-- Updated 16/5/2020
-- 
-- Description:	Get the timeToBeat for a given member
-- Use the average of the 3 fastest race times.
-- =============================================
CREATE FUNCTION [dbo].[TimeToBeat_2] (
	-- Add the parameters for the function here
	@MemberID INT,
	@DistanceID INT,
	@StrokeID INT,
	@SessionDate DATETIME
	)
RETURNS TIME
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result TIME;
	DECLARE @tmpFloat FLOAT;

	-- very specific criteria 
	-- only pull a short list of racetime 
	-- not ordered
	WITH tmpTable
	AS (
		SELECT TOP (3) [Event].DistanceID,
			[Event].StrokeID,
			Entrant.RaceTime,
			Entrant.MemberID
		FROM Entrant
		INNER JOIN HeatIndividual ON Entrant.HeatID = HeatIndividual.HeatID
		INNER JOIN [Event] ON HeatIndividual.EventID = [Event].EventID
		INNER JOIN [Session] ON [Event].SessionID = [Session].SessionID
		WHERE (Entrant.RaceTime IS NOT NULL)
			AND (Entrant.IsDisqualified <> 1) -- added 16/5/2020
			AND (Entrant.IsScratched <> 1) -- added 16/5/2020
			AND (Entrant.MemberID = @MEMBERID)
			AND ([Session].SessionStart < @SESSIONDATE)
			AND [Event].DistanceID = @DISTANCEID
			AND [Event].StrokeID = @STROKEID
		-- ErStudio VALIDATION ERROR - doesn't understand TOP + ORDER BY
		-- ACCEPTED BY MS SQL - TOP is permitted in CTE table when ORDER BY is included
		ORDER BY Entrant.RaceTime ASC
		)
	-- Add the T-SQL statements to compute the return value here
	-- combination of TOP (3) and ORDER BY means AVG works only on the three best racetimes
	SELECT @tmpFloat = avg(CAST(CAST(tmpTable.RaceTime AS DATETIME) AS FLOAT))
	FROM tmpTable

	SET @Result = CAST(CAST(@tmpFloat AS DATETIME) AS TIME)

	-- Return the result of the function
	RETURN @Result
END
GO





GO
IF OBJECT_ID('TimeToBeat_2') IS NOT NULL
    PRINT '<<< CREATED FUNCTION TimeToBeat_2 >>>'
ELSE
    PRINT '<<< FAILED CREATING FUNCTION TimeToBeat_2 >>>'
GO

GRANT EXECUTE ON TimeToBeat_2 TO SCM_Marshall
GO
GRANT EXECUTE ON TimeToBeat_2 TO SCM_Guest
GO
GRANT EXECUTE ON TimeToBeat_2 TO SCM_Administrator
GO


/* 
 * FUNCTION: TimeToBeat_DEFAULT 
 */

USE [SwimClubMeet]
GO
/****** Object:  UserDefinedFunction [dbo].[TimeToBeat_DEFAULT]    Script Date: 5/03/2022 2:04:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ben Ambrose
-- Create date: 5/8/2019
-- Updated 06/03/2022
-- Description:	
-- After CALLING either MODES 1-3 and a TTB hasn't
-- successfully been found for the entrant then this 
-- function is called.
-- (Slowly) Calculate a TimeToBeat by brute force.
-- =============================================

CREATE FUNCTION [dbo].[TimeToBeat_DEFAULT] (
    -- Add the parameters for the function here
    @MemberID INT
    , @DistanceID INT
    , @StrokeID INT
    , @SessionDate DATETIME = NULL
    , @Percent FLOAT = 50.0
    )
RETURNS TIME
AS
BEGIN
    -- Declare the return variable here
    DECLARE @Result TIME;
    DECLARE @BottomNum FLOAT;
    DECLARE @tmpFloat FLOAT;
    DECLARE @Age INT;
    DECLARE @DOB DATETIME;
    DECLARE @GenderID INT;
	DECLARE @MinSampleSize AS INT;

	-- All the time for the given distance stroke are stored here
	-- Note: Entrant RaceTimes are converted to float.
    DECLARE @Temp TABLE (
        ID INT identity(1, 1)
        , RT FLOAT
        );
	-- Only a selected draw of times from above table go here
	-- in preparation to work out the average bottom (50) percent
    DECLARE @Temp2 TABLE (
        ID INT identity(1, 1)
        , RT FLOAT
        );

    -- ASSERT DEFAULT VALUE 
	-- Assigning NULL may result in an exceptin error
	-- A zero TIME value indicates no valid TTB found.
    -- SET @Result = CAST(CONVERT(DATETIME,0.0) AS TIME);
	SET @Result = NULL;
	SET @MinSampleSize = 4;

    -- use a default sessiontime
    IF @SessionDate IS NULL
        SET @SessionDate = GETDATE();
    SET @DOB = (
            SELECT Member.DOB
            FROM Member
            WHERE Member.MemberID = @MemberID
            );
    SET @GenderID = (
            SELECT Member.GenderID
            FROM Member
            WHERE Member.MemberID = @MemberID
            );
    SET @Age = FLOOR(DATEDIFF(day, @DOB, @SessionDate) / 365.0);

    -- find any members (matching age and gender) who have raced this event 
    INSERT INTO @Temp (
        RT
        )
	-- MSSQL doesn't allow you to convert TIME (the matissa of DATETIME) to FLOAT. 
	-- NOTE: we need to be using FLOAT values - if we want to perform an average.
    SELECT CONVERT(FLOAT, CAST(Entrant.RaceTime AS DATETIME))
    FROM Entrant
    INNER JOIN HeatIndividual
        ON Entrant.HeatID = HeatIndividual.HeatID
    INNER JOIN Event
        ON HeatIndividual.EventID = Event.EventID
    INNER JOIN Member
        ON Entrant.MemberID = Member.MemberID
    WHERE (Event.StrokeID = @StrokeID)
        AND (Event.DistanceID = @DistanceID)
        AND (Entrant.RaceTime IS NOT NULL)
        AND (Entrant.IsDisqualified <> 1) -- added 16/5/2020
        AND (Entrant.IsScratched <> 1) -- added 16/5/2020
        AND (Member.GenderID = @GenderID)
        AND (FLOOR(DATEDIFF(day, Member.DOB, @SessionDate) / 365.0) = @Age);

    SET @BottomNum =(
            SELECT COUNT(*)
            FROM @Temp
            );

    -- Sample set is too small! 
	-- Look for members who are of a different gender
	-- and add them to the list.
    IF (@BottomNum < @MinSampleSize)
        INSERT INTO @Temp (
            RT
            )
        SELECT CONVERT(FLOAT, CAST(Entrant.RaceTime AS DATETIME))
        FROM Entrant
        INNER JOIN HeatIndividual
            ON Entrant.HeatID = HeatIndividual.HeatID
        INNER JOIN Event
            ON HeatIndividual.EventID = Event.EventID
        INNER JOIN Member
            ON Entrant.MemberID = Member.MemberID
        WHERE (Event.StrokeID = @StrokeID)
            AND (Event.DistanceID = @DistanceID)
            AND (Entrant.RaceTime IS NOT NULL)
            AND (Entrant.IsDisqualified <> 1) -- added 16/5/2020
            AND (Entrant.IsScratched <> 1) -- added 16/5/2020
            AND (Member.GenderID <> @GenderID)
            AND (FLOOR(DATEDIFF(day, Member.DOB, @SessionDate) / 365.0) = @Age);

	-- Count the number of racetimes in the table
    SET @BottomNum = (
            SELECT COUNT(*)
            FROM @Temp
            );

    -- ONCE MORE - the sample set is too small!
	-- Look for members +1,+2 age bracket above (of any gender).
	-- Add them to the list.
    IF (@BottomNum < @MinSampleSize)
        INSERT INTO @Temp (
             RT
            )
        SELECT CONVERT(FLOAT, CAST(Entrant.RaceTime AS DATETIME))
        FROM Entrant
        INNER JOIN HeatIndividual
            ON Entrant.HeatID = HeatIndividual.HeatID
        INNER JOIN Event
            ON HeatIndividual.EventID = Event.EventID
        INNER JOIN Member
            ON Entrant.MemberID = Member.MemberID
        WHERE (Event.StrokeID = @StrokeID)
            AND (Event.DistanceID = @DistanceID)
            AND (Entrant.RaceTime IS NOT NULL)
            AND (Entrant.IsDisqualified <> 1) -- added 16/5/2020
            AND (Entrant.IsScratched <> 1) -- added 16/5/2020
            AND (
             (FLOOR(DATEDIFF(day, Member.DOB, @SessionDate) / 365.0) = (@Age + 2))
            OR (FLOOR(DATEDIFF(day, Member.DOB, @SessionDate) / 365.0) = (@Age + 1))
			);

	-- Count the number of racetimes in the table
    SET @BottomNum = (
            SELECT COUNT(*)
            FROM @Temp
            );

    -- Sample set is still to small.
	-- FAILED to produce a result. Return NULL
	IF (@BottomNum = 0)
		-- TODO: Find the slowest RaceTime for any swimmer in this event.
		RETURN @Result;
		
    -- IF (@BottomNum < 4)
        -- RETURN @Result;

    -- Select bottom percent (default is 50%)
    SET @BottomNum = @BottomNum * @Percent / 100.0;

    -- Under minium - raise the sample count
    IF (CAST(@BottomNum AS INT) < @MinSampleSize)
        SET @BottomNum = @MinSampleSize;

	-- push a selection of sample RTs into the second table
	-- NOTE: the slowest RaceTimes (largest floats) will fill this list
	INSERT INTO @Temp2
		(RT)
	-- NOTE: ErStudio unable to validate use of PARAM - throws error
	SELECT TOP (CONVERT(INT,@BottomNum)) 
		RT
        FROM @Temp
		ORDER BY RT DESC;

	-- Get the average time for the bottom (50) percent
	-- Final assignment - converted to TIME value
    SET @Result = 
    	CAST(
    		CAST(
    			(SELECT AVG(RT) AS RTfloat FROM @Temp2)
     			AS DATETIME
     		) 
     		AS TIME
     	);


    RETURN @Result;
END
GO



GO
IF OBJECT_ID('TimeToBeat_DEFAULT') IS NOT NULL
    PRINT '<<< CREATED FUNCTION TimeToBeat_DEFAULT >>>'
ELSE
    PRINT '<<< FAILED CREATING FUNCTION TimeToBeat_DEFAULT >>>'
GO

GRANT EXECUTE ON TimeToBeat_DEFAULT TO SCM_Administrator
GO
GRANT EXECUTE ON TimeToBeat_DEFAULT TO SCM_Marshall
GO
GRANT EXECUTE ON TimeToBeat_DEFAULT TO SCM_Guest
GO



USE [SwimClubMeet]
GO
-- REQUIRED AS GENERATE DATABASE unsuccessful at creating this user
-- (Syntax used by ER/Studio too simple.)  
/****** Object:  User [scmAdmin]    Script Date: 25/12/2020 1:42:57 PM ******/
CREATE USER [scmAdmin] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[scmAdmin]
GO
-- Roles can be successfully created with GENERATE DATABASE ROLES param
/****** Object:  DatabaseRole [SCM_Administrator]    Script Date: 25/12/2020 1:42:57 PM ******/
--CREATE ROLE [SCM_Administrator]
--GO
/****** Object:  DatabaseRole [SCM_Guest]    Script Date: 25/12/2020 1:42:57 PM ******/
--CREATE ROLE [SCM_Guest]
--GO
/****** Object:  DatabaseRole [SCM_Marshall]    Script Date: 25/12/2020 1:42:57 PM ******/
--CREATE ROLE [SCM_Marshall]
--GO
ALTER ROLE [SCM_Administrator] ADD MEMBER [scmAdmin]
GO
ALTER ROLE [db_datareader] ADD MEMBER [scmAdmin]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [scmAdmin]
GO

-- REQUIRED AS GENERATE DATABASE unsuccessful at creating schema without scmAdmin user name
/****** Object:  Schema [scmAdmin]    Script Date: 25/12/2020 1:42:58 PM ******/
CREATE SCHEMA [scmAdmin]
GO

