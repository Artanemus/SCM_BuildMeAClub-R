/*
 * ER/Studio Data Architect SQL Code Generation
 * Company :      Ambrosia
 * Project :      SwimClubMeet_v1.1.5.3.DM1
 * Author :       Ben Ambrose
 *
 * Date Created : Tuesday, September 26, 2023 17:47:29
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
    IsArchived          bit             DEFAULT 0 NOT NULL,
    CreatedOn           datetime        NULL,
    MemberID            int             NULL,
    ContactNumTypeID    int             NULL,
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
SET IDENTITY_INSERT  [dbo].[DisqualifyCode] ON;

-- Insert rows into tableN'DisqualifyCodeCodes'
INSERT INTO DisqualifyCode
( -- columns to insert data into
 [DisqualifyCodeID], [Caption], [ABREV], [DisqualifyTypeID]
)
VALUES
(1,N'False start', N'GA', 1),
(2,N'Delay of meet', N'GB', 1),
(3,N'Unsportsmanlike manner', N'GC', 1),
(4,N'Interference with another swimmer', N'GD', 1),
(5,N'Did not swim stroke specified', N'GE', 1),
(6,N'Did not swim distance specified', N'GF', 1),
(7,N'Did not finish in same lane', N'GG', 1),
(8,N'Standing on bottom during any stroke but freestyle', N'GH', 1),
(9,N'Swimmer swam in wrong lane', N'GI', 1),
(10,N'Swimmer made use of aids', N'GJ', 1),
(11,N'Swimmer did not finish', N'GK', 1),
(12,N'Pulled on lane ropes', N'GL', 1),
(13,N'Use of not FINA approved swim suit', N'GM', 1),
(14,N'Use of more than one swim suit', N'GN', 1),
(15,N'Use of tape on the body', N'GO', 1),

-- Freestyle
(16, N'No touch at turn or finish', N'FrA' ,2),
(17, N'Swam under water more than 15 meters after start or turn', N'FrB' ,2),
(18, N'Walked on pool bottom and/or pushed off bottom', N'FrC' ,2),

-- Backstroke
(19, N'Toes over the gutter', N'BaA' ,3),
(20, N'Head did not break surface by 15 meters after start or turn', N'BaB' ,3),
(21, N'Shoulders past vertical', N'BaC' ,3),
(22, N'No touch at turn and/or finish', N'BaD' ,3),
(23, N'Not on back off wall', N'BaE' ,3),
(24, N'Did not finish on back', N'BaF' ,3),
(25, N'Past vertical at turn: non continuous turning action', N'BaG' ,3),
(26, N'Past vertical at turn: independent kicks', N'BaH' ,3),
(27, N'Past vertical at turn: independent strokes', N'BaI' ,3),
(28, N'Sub-merged at the finish', N'BaJ' ,3),

-- Breaststroke
(29, N'Head did not break surface before hands turned inside at widest part of second stroke', N'BrA' ,4),
(30, N'Head did not break surface of water during each complete stroke cycle', N'BrB' ,4),
(31, N'Arm movements not always simultaneous and in horizontal plane', N'BrC' ,4),
(32, N'Leg Movements not always simultaneous and in horizontal plane', N'BrD' ,4),
(33, N'Hands not pushed forward on, under or over water', N'BrE' ,4),

-- BUTTERFLY 
 
(34, N'Head did not break surface 15 meters after start or turn', N'BfA' ,5),
(35 , N'More than one arm pull under water after start or turn', N'BfB' ,5), 
(36 , N'Not toward breast off the wall', N'BfC' ,5), 
(37 , N'Did not bring arms forward and/or backward simultaneously', N'BfD' ,5),
(38 , N'Did not bring arms forward over water', N'BfE' ,5), 
(39, N'Did not execute movement of both feet in same way', N'BfF' ,5), 
(40, N'Touch was not made with both hands separated and simultaneously at turn and/or finish', N'BfG' ,5), 
(41, N'No touch at turn and/or finish', N'BfH' ,5),
(42, N'Arm movements did not continue throughout race', N'BfI' ,5),
(43, N'More than one breaststroke kick per arm pull', N'BfJ' ,5),

-- Individual Medley
(44, N'Freestyle swum as backstroke, breaststroke or butterfly', N'IMA' ,6),
(45, N'Not swum in right order', N'IMB' ,6),
(46, N'Stroke infraction - use stroke codes', N'IMC' ,6),

-- Relay
(47, N'Early swimmer take-off # (RA#)', N'RA#' ,7),
(48, N'Medley not swum in right order', N'RB' ,7),
(49, N'Changed order of swimmers',N'RC',7),
(50, N'Non listed swimmer swam',N'RD',7),
(51, N'Stroke infraction - use stroke codes and swimmer',N'RE',7),
(52, N'Swimmer other than the swimmer designated to swim entered race area before finished',N'RF',7),

-- SCM Special
(53, N'Swimmer didn''t show for event. Scratched',N'ScmA',7),
(54, N'Unspecified disqualification.',N'ScmB',7)

GO

SET IDENTITY_INSERT [dbo].[DisqualifyCode]  OFF;

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
    StrokeID            int              NULL,
    CONSTRAINT PK_DisqualifyType PRIMARY KEY CLUSTERED (DisqualifyTypeID)
)
GO



IF OBJECT_ID('DisqualifyType') IS NOT NULL
    PRINT '<<< CREATED TABLE DisqualifyType >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DisqualifyType >>>'
GO
SET IDENTITY_INSERT  [dbo].[DisqualifyType] ON;
INSERT INTO DisqualifyType
(
[DisqualifyTypeID], [Caption], [StrokeID]
)
VALUES
(1, N'General',0)
,(2, N'Freestyle',1)
,(3, N'Backstroke',3)
,(4, N'Breaststroke',2)
,(5, N'Butterfly',4)
,(6, N'Individual Medley',5)
,(7, N'Relays',0)
,(8, N'SCM',0)
SET IDENTITY_INSERT  [dbo].[DisqualifyType] OFF;

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
    DistanceID     int              IDENTITY(1,1),
    Caption        nvarchar(128)    NULL,
    Meters         int              NULL,
    ABREV          nvarchar(8)      NULL,
    EventTypeID    int              NULL,
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
INSERT [dbo].[Distance] ([DistanceID], [Caption], [Meters], [ABREV], [EventTypeID]) VALUES (1, N'25m', 25, N'25', 1)
GO
INSERT [dbo].[Distance] ([DistanceID], [Caption], [Meters], [ABREV], [EventTypeID]) VALUES (2, N'50m', 50, N'50', 1)
GO
INSERT [dbo].[Distance] ([DistanceID], [Caption], [Meters], [ABREV], [EventTypeID]) VALUES (3, N'100m', 100, N'100', 1)
GO
INSERT [dbo].[Distance] ([DistanceID], [Caption], [Meters], [ABREV], [EventTypeID]) VALUES (4, N'200m', 200, N'200', 1)
GO
INSERT [dbo].[Distance] ([DistanceID], [Caption], [Meters], [ABREV], [EventTypeID]) VALUES (5, N'400m', 400, N'400', 1)
GO
INSERT [dbo].[Distance] ([DistanceID], [Caption], [Meters], [ABREV], [EventTypeID]) VALUES (6, N'800m', 800, N'800', 1)
GO
INSERT [dbo].[Distance] ([DistanceID], [Caption], [Meters], [ABREV], [EventTypeID]) VALUES (7, N'1000m', 1000, N'1000', 1)
GO
INSERT [dbo].[Distance] ([DistanceID], [Caption], [Meters], [ABREV], [EventTypeID]) VALUES (8, N'4x25m', 100, N'4x25', 2)
GO
INSERT [dbo].[Distance] ([DistanceID], [Caption], [Meters], [ABREV], [EventTypeID]) VALUES (9, N'4x50m', 200, N'4x50', 2)
GO
INSERT [dbo].[Distance] ([DistanceID], [Caption], [Meters], [ABREV], [EventTypeID]) VALUES (10, N'4x100m', 400, N'4x100', 2)
GO
INSERT [dbo].[Distance] ([DistanceID], [Caption], [Meters], [ABREV], [EventTypeID]) VALUES (11, N'4x200m', 800, N'4x200', 2)
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
    EntrantID           int        IDENTITY(1,1),
    Lane                int        NULL,
    RaceTime            time(7)    NULL,
    TimeToBeat          time(7)    NULL,
    PersonalBest        time(7)    NULL,
    IsDisqualified      bit        DEFAULT 0 NULL,
    IsScratched         bit        DEFAULT 0 NULL,
    DisqualifyCodeID    int        NULL,
    MemberID            int        DEFAULT NULL NULL,
    HeatID              int        NULL,
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
    ScheduleDT       time(7)          NULL,
    SessionID        int              NULL,
    StrokeID         int              NULL,
    DistanceID       int              NULL,
    EventStatusID    int              NULL,
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
    EventTypeID     int              IDENTITY(1,1),
    Caption         nvarchar(128)    NULL,
    CaptionShort    nvarchar(16)     NULL,
    ABREV           nvarchar(5)      NULL,
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
INSERT [dbo].[EventType] (
[EventTypeID]
, [Caption]
, [CaptionShort]
, [ABREV]
) 
VALUES 
(1, N'Individual', N'Indiv', N'INDIV')
(2, N'Team', N'Relay', N'RELAY')
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
    HeatID          int              IDENTITY(1,1),
    HeatNum         int              NULL,
    Caption         nvarchar(128)    NULL,
    ScheduleDT      time(7)          NULL,
    ClosedDT        datetime         NULL,
    EventID         int              NULL,
    HeatTypeID      int              NULL,
    HeatStatusID    int              NULL,
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
    SwimClubID    int              NULL,
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
    FirstName                   nvarchar(128)    NULL,
    MiddleInitial               nvarchar(4)      NULL,
    LastName                    nvarchar(128)    NULL,
    RegisterNum                 int              NULL,
    RegisterStr                 nvarchar(24)     NULL,
    DOB                         datetime         NULL,
    IsArchived                  bit              DEFAULT 0 NOT NULL,
    IsActive                    bit              DEFAULT 1 NOT NULL,
    IsSwimmer                   bit              DEFAULT 1 NULL,
    Email                       nvarchar(256)    NULL,
    CreatedOn                   datetime         NULL,
    ArchivedOn                  datetime         NULL,
    EnableEmailOut              bit              DEFAULT 0 NULL,
    EnableEmailNomineeForm      bit              DEFAULT 0 NULL,
    EnableEmailSessionReport    bit              DEFAULT 0 NULL,
    TAGS                        ntext            NULL,
    SwimClubID                  int              NULL,
    HouseID                     int              NULL,
    GenderID                    int              NULL,
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
 * TABLE: MemberRole 
 */

CREATE TABLE MemberRole(
    MemberRoleID    int              IDENTITY(1,1),
    Caption         nvarchar(128)    NULL,
    IsArchived      bit              DEFAULT 0 NOT NULL,
    IsActive        bit              DEFAULT 1 NOT NULL,
    CreatedOn       datetime         NULL,
    CONSTRAINT PK_MemberRole PRIMARY KEY CLUSTERED (MemberRoleID)
)
GO



IF OBJECT_ID('MemberRole') IS NOT NULL
    PRINT '<<< CREATED TABLE MemberRole >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE MemberRole >>>'
GO
SET IDENTITY_INSERT [dbo].[MemberRole] ON
GO

INSERT INTO [dbo].[MemberRole]
(
    MemberRoleID
  , [Caption]
  , [IsActive]
  , [IsArchived]
)
VALUES
(1, 'President', 1, 0)
, (2, 'Vice President', 1, 0)
, (3, 'Secretary', 1, 0)
, (4, 'Registrar', 1, 0)
, (5, 'Treasurer', 1, 0)
, (6, 'Race Secretary', 1, 0)
, (7, 'Committee Member', 1, 0)
, (8, 'Volunteer Coordinator', 1, 0)
, (9, 'Public Officer', 1, 0)
, (10, 'Club Coach', 1, 0)
, (11, 'Life Member', 1, 0)
GO

SET IDENTITY_INSERT [dbo].[MemberRole] OFF
GO

GRANT SELECT ON MemberRole TO SCM_Marshall
GO
GRANT SELECT ON MemberRole TO SCM_Guest
GO
GRANT SELECT ON MemberRole TO SCM_Administrator
GO

/* 
 * TABLE: MemberRoleLink 
 */

CREATE TABLE MemberRoleLink(
    MemberRoleID    int         NOT NULL,
    MemberID        int         NOT NULL,
    CreatedOn       datetime    NULL,
    IsActive        bit         DEFAULT 1 NOT NULL,
    IsArchived      bit         DEFAULT 0 NOT NULL,
    StartOn         datetime    NULL,
    EndOn           datetime    NULL,
    CONSTRAINT PK_MemberRoleLink PRIMARY KEY CLUSTERED (MemberRoleID, MemberID)
)
GO



IF OBJECT_ID('MemberRoleLink') IS NOT NULL
    PRINT '<<< CREATED TABLE MemberRoleLink >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE MemberRoleLink >>>'
GO

/* 
 * TABLE: MetaData 
 */

CREATE TABLE MetaData(
    MetaDataID    int              IDENTITY(1,1),
    TAG           nvarchar(128)    NULL,
    TAGID         int              NULL,
    IsActive      bit              DEFAULT 1 NOT NULL,
    IsArchived    bit              DEFAULT 0 NOT NULL,
    CONSTRAINT PK_MetaData PRIMARY KEY CLUSTERED (MetaDataID)
)
GO



IF OBJECT_ID('MetaData') IS NOT NULL
    PRINT '<<< CREATED TABLE MetaData >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE MetaData >>>'
GO
SET IDENTITY_INSERT [dbo].[MetaData] ON
GO

INSERT INTO [dbo].[MetaData]
(
    MetaDataID
  , [TAG]	-- METADATA STRING
  , [TAGID] -- NON SPECIFIC RELATIONSHIP - [dbo].[ClubType] - NULL PERMITTED.
  , [IsActive] -- NULL VALUE NOT PERMITTED
  , [IsArchived] -- NULL VALUE NOT PERMITTED
)
VALUES
(1, 'COMPETITIVE', 1, 1, 0)

GO

SET IDENTITY_INSERT [dbo].[MetaData] OFF
GO

GRANT INSERT ON MetaData TO SCM_Administrator
GO
GRANT SELECT ON MetaData TO SCM_Administrator
GO
GRANT UPDATE ON MetaData TO SCM_Administrator
GO
GRANT SELECT ON MetaData TO SCM_Marshall
GO
GRANT SELECT ON MetaData TO SCM_Guest
GO
GRANT DELETE ON MetaData TO SCM_Administrator
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
GRANT DELETE ON Nominee TO SCM_Marshall
GO
GRANT INSERT ON Nominee TO SCM_Marshall
GO
GRANT UPDATE ON Nominee TO SCM_Marshall
GO

/* 
 * TABLE: ParaDetail 
 */

CREATE TABLE ParaDetail(
    ParaDetailID    int              IDENTITY(1,1),
    Code            nvarchar(16)     NULL,
    Details         nvarchar(max)    NULL,
    ParaMasterID    int              NULL,
    CONSTRAINT PK_ParaDetail PRIMARY KEY CLUSTERED (ParaDetailID)
)
GO



IF OBJECT_ID('ParaDetail') IS NOT NULL
    PRINT '<<< CREATED TABLE ParaDetail >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE ParaDetail >>>'
GO
/*
Para-Swimming Sport Classes
The prefix for each class identifies the stroke;
S denotes the class for freestyle, backstroke and butterfly 
SB denotes the class for breaststroke 
SM denotes the class for individual medley
*/


SET IDENTITY_INSERT [dbo].[ParaDetail] ON 
GO

INSERT [dbo].[ParaDetail] (
ParaDetailID
, Code
, Details
, ParaMasterID
)
 
VALUES 
(1, 'S1', 'Swimmers with a Physical Impairment: Swimmers who have significant movement difficulties in arms, legs and trunk. Swimmers use a wheelchair for everyday mobility. Swimmers start in the water for all strokes, use assistance for water exit and entry and complete all strokes on their back.', 1),
(2,'SB1', 'Swimmers with a Physical Impairment: Swimmers who have significant movement difficulties in arms, legs and trunk. Swimmers use a wheelchair for everyday mobility. Swimmers start in the water for all strokes, use assistance for water exit and entry and complete all strokes on their back.', 1),
(3,'SM1', 'Swimmers with a Physical Impairment: Swimmers who have significant movement difficulties in arms, legs and trunk. Swimmers use a wheelchair for everyday mobility. Swimmers start in the water for all strokes, use assistance for water exit and entry and complete all strokes on their back.', 1),
(4,'S2', 'Swimmers with a Physical Impairment: Swimmers have significant movement difficulties in arms, legs and trunk, but with more propulsive ability in arms or legs than S1 swimmers. Swimmers use water starts and assistance with water entry.', 1),
(5,'SB1', 'Swimmers with a Physical Impairment: Swimmers have significant movement difficulties in arms, legs and trunk, but with more propulsive ability in arms or legs than S1 swimmers. Swimmers use water starts and assistance with water entry.', 1),
(6,'SM2', 'Swimmers with a Physical Impairment: Swimmers have significant movement difficulties in arms, legs and trunk, but with more propulsive ability in arms or legs than S1 swimmers. Swimmers use water starts and assistance with water entry.', 1),
(7,'S3', 'Swimmers with a Physical Impairment: Swimmers with some arm movement but with no use of their legs or torso; or swimmers with significant restrictions in all four limbs. Swimmers use water starts and assistance in the water.', 1),
(8,'SB2', 'Swimmers with a Physical Impairment: Swimmers with some arm movement but with no use of their legs or torso; or swimmers with significant restrictions in all four limbs. Swimmers use water starts and assistance in the water.', 1),
(9,'SM3', 'Swimmers with a Physical Impairment: Swimmers with some arm movement but with no use of their legs or torso; or swimmers with significant restrictions in all four limbs. Swimmers use water starts and assistance in the water.', 1),
(10,'S4', 'Swimmers with a Physical Impairment: Swimmers with good use of arms and some hand weakness with no use of their torso or legs; swimmers with significant limb loss to three or four limbs. Swimmers usually start in the water.', 1),
(11,'SB3', 'Swimmers with a Physical Impairment: Swimmers with good use of arms and some hand weakness with no use of their torso or legs; swimmers with significant limb loss to three or four limbs. Swimmers usually start in the water.', 1),
(12,'SM4', 'Swimmers with a Physical Impairment: Swimmers with good use of arms and some hand weakness with no use of their torso or legs; swimmers with significant limb loss to three or four limbs. Swimmers usually start in the water.', 1),
(13,'S5', 'Swimmers with a Physical Impairment: Swimmers with good use of arms, but no torso and leg movement; swimmers with some limb loss in three or four limbs. Some swimmers may start in the water and may have difficulty holding good body position in the water.', 1),
(14,'SB4', 'Swimmers with a Physical Impairment: Swimmers with good use of arms, but no torso and leg movement; swimmers with some limb loss in three or four limbs. Some swimmers may start in the water and may have difficulty holding good body position in the water.', 1),
(15,'SM5', 'Swimmers with a Physical Impairment: Swimmers with good use of arms, but no torso and leg movement; swimmers with some limb loss in three or four limbs. Some swimmers may start in the water and may have difficulty holding good body position in the water.', 1),
(16,'S6', 'Swimmers with a Physical Impairment: Swimmers with short stature; swimmers with good arms, some torso and no leg movement; swimmers with significant impairment down one side of their body (limb loss or co-ordination difficulties).', 1),
(17,'SB5', 'Swimmers with a Physical Impairment: Swimmers with short stature; swimmers with good arms, some torso and no leg movement; swimmers with significant impairment down one side of their body (limb loss or co-ordination difficulties).', 1),
(18,'SM6', 'Swimmers with a Physical Impairment: Swimmers with short stature; swimmers with good arms, some torso and no leg movement; swimmers with significant impairment down one side of their body (limb loss or co-ordination difficulties).', 1),
(19,'S7', 'Swimmers with a Physical Impairment: Swimmers with short stature; good arms and torso control and some leg movement; or swimmers with co-ordination difficulties or limb loss down one side of the body.', 1),
(20,'SB6', 'Swimmers with a Physical Impairment: Swimmers with short stature; good arms and torso control and some leg movement; or swimmers with co-ordination difficulties or limb loss down one side of the body.', 1),
(21,'SM7', 'Swimmers with a Physical Impairment: Swimmers with short stature; good arms and torso control and some leg movement; or swimmers with co-ordination difficulties or limb loss down one side of the body.', 1),
(22,'S8', 'Swimmers with a Physical Impairment: Swimmers with full use of their arms and torso with good hip and some leg movement; or swimmers with limb loss of two limbs; swimmers without the use of one arm. Swimmers use regular starts, strokes and turns and may have some difficulties with timing of their strokes.', 1),
(23,'SB7', 'Swimmers with a Physical Impairment: Swimmers with full use of their arms and torso with good hip and some leg movement; or swimmers with limb loss of two limbs; swimmers without the use of one arm. Swimmers use regular starts, strokes and turns and may have some difficulties with timing of their strokes.', 1),
(24,'SM8', 'Swimmers with a Physical Impairment: Swimmers with full use of their arms and torso with good hip and some leg movement; or swimmers with limb loss of two limbs; swimmers without the use of one arm. Swimmers use regular starts, strokes and turns and may have some difficulties with timing of their strokes.', 1),
(25,'S9', 'Swimmers with a Physical Impairment: Swimmers with weakness, limb loss or co-ordination difficulties in one arm or leg only. Swimmers use regular starts, strokes and turns, but have some difficulties in applying even power to the water.', 1),
(26,'SB8', 'Swimmers with a Physical Impairment: Swimmers with weakness, limb loss or co-ordination difficulties in one arm or leg only. Swimmers use regular starts, strokes and turns, but have some difficulties in applying even power to the water.', 1),
(27,'SM9', 'Swimmers with a Physical Impairment: Swimmers with weakness, limb loss or co-ordination difficulties in one arm or leg only. Swimmers use regular starts, strokes and turns, but have some difficulties in applying even power to the water.', 1),
(28,'S10', 'Swimmers with a Physical Impairment: Swimmers with minimal impairment that affects one joint, usually their foot or hand. Starts, turns and strokes are smooth and fluid.', 1),
(29,'SB9', 'Swimmers with a Physical Impairment: Swimmers with minimal impairment that affects one joint, usually their foot or hand. Starts, turns and strokes are smooth and fluid.', 1),
(30,'SM10', 'Swimmers with a Physical Impairment: Swimmers with minimal impairment that affects one joint, usually their foot or hand. Starts, turns and strokes are smooth and fluid.', 1),
(31,'S11', 'Swimmers with a Vision Impairment: Swimmers who are blind. Swimmers must wear blacked out goggles for competition and use a tapper as they approach the end of the pool. Swimmers often count strokes to know the length of the lane and anticipate turns.', 2),
(32,'SB11', 'Swimmers with a Vision Impairment: Swimmers who are blind. Swimmers must wear blacked out goggles for competition and use a tapper as they approach the end of the pool. Swimmers often count strokes to know the length of the lane and anticipate turns.', 2),
(33,'SM11', 'Swimmers with a Vision Impairment: Swimmers who are blind. Swimmers must wear blacked out goggles for competition and use a tapper as they approach the end of the pool. Swimmers often count strokes to know the length of the lane and anticipate turns.', 2),
(34,'S12', 'Swimmers with a Vision Impairment: Swimmers who have very low vision in both eyes either in how far they can see (visual acuity <2/60; LogMAR 1.5-2.6 inclusive) or how wide they can see (visual field <10 degrees diameter). Swimmers have the option to use a tapper.', 2),
(35,'SB12', 'Swimmers with a Vision Impairment: Swimmers who have very low vision in both eyes either in how far they can see (visual acuity <2/60; LogMAR 1.5-2.6 inclusive) or how wide they can see (visual field <10 degrees diameter). Swimmers have the option to use a tapper.', 2),
(36,'SM12', 'Swimmers with a Vision Impairment: Swimmers who have very low vision in both eyes either in how far they can see (visual acuity <2/60; LogMAR 1.5-2.6 inclusive) or how wide they can see (visual field <10 degrees diameter). Swimmers have the option to use a tapper.', 2),
(37,'S13', 'Swimmer who have low vision in both eyes, but more vision than S12 swimmers. Vision is affected either in how far they can see (visual acuity <6/60; LogMAR 1-1.4 inclusive) or how wide they can see (visual field < 40 degrees diameter). Swimmers may elect to use a tapper.', 2),
(38,'SB13', 'Swimmer who have low vision in both eyes, but more vision than S12 swimmers. Vision is affected either in how far they can see (visual acuity <6/60; LogMAR 1-1.4 inclusive) or how wide they can see (visual field < 40 degrees diameter). Swimmers may elect to use a tapper.', 2),
(39,'SM13', 'Swimmer who have low vision in both eyes, but more vision than S12 swimmers. Vision is affected either in how far they can see (visual acuity <6/60; LogMAR 1-1.4 inclusive) or how wide they can see (visual field < 40 degrees diameter). Swimmers may elect to use a tapper.', 2),
(40,'S14', 'Swimmers with an Intellectual Impairment: Swimmers with an intellectual impairment. Swimmers may find it more difficult to pace consistently and plan event tactics.', 3),
(41,'SB14', 'Swimmers with an Intellectual Impairment: Swimmers with an intellectual impairment. Swimmers may find it more difficult to pace consistently and plan event tactics.', 3),
(42,'SM14', 'Swimmers with an Intellectual Impairment: Swimmers with an intellectual impairment. Swimmers may find it more difficult to pace consistently and plan event tactics.', 3),
(43,'NE', 'Not Eligible: Swimmers do not meet the minimum criteria for the Para-sport classes, but may still be able to compete. Contact Swimming Australia for more information.', 4);

GO

SET IDENTITY_INSERT [dbo].[ParaDetail] OFF
GO

/* 
 * TABLE: ParaMaster 
 */

CREATE TABLE ParaMaster(
    ParaMasterID    int              IDENTITY(1,1),
    Caption         nvarchar(128)    NULL,
    CONSTRAINT PK_ParaMaster PRIMARY KEY CLUSTERED (ParaMasterID)
)
GO



IF OBJECT_ID('ParaMaster') IS NOT NULL
    PRINT '<<< CREATED TABLE ParaMaster >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE ParaMaster >>>'
GO
SET IDENTITY_INSERT [dbo].[ParaMaster] ON 
GO

INSERT [dbo].[ParaMaster] (
ParaMasterID
, Caption
)
VALUES 
(1,'Physical')
, (2,'Vision Impaired')
, (3,'Intellectual')
, (4,'Not Eligible')
GO

SET IDENTITY_INSERT [dbo].[ParaMaster] OFF
GO

/* 
 * TABLE: PoolType 
 */

CREATE TABLE PoolType(
    PoolTypeID      int              IDENTITY(1,1),
    Caption         nvarchar(128)    NULL,
    ShortCaption    nvarchar(16)     NULL,
    ABREV           nvarchar(12)     NULL,
    IsArchived      bit              DEFAULT 0 NULL,
    IsActive        bit              DEFAULT 1 NULL,
    LenOfPool       float            NULL,
    CONSTRAINT PK_PoolType PRIMARY KEY CLUSTERED (PoolTypeID)
)
GO



IF OBJECT_ID('PoolType') IS NOT NULL
    PRINT '<<< CREATED TABLE PoolType >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE PoolType >>>'
GO

GRANT INSERT ON PoolType TO SCM_Administrator
GO
GRANT SELECT ON PoolType TO SCM_Administrator
GO
GRANT UPDATE ON PoolType TO SCM_Administrator
GO
GRANT SELECT ON PoolType TO SCM_Marshall
GO
GRANT SELECT ON PoolType TO SCM_Guest
GO
GRANT DELETE ON PoolType TO SCM_Administrator
GO

/* 
 * TABLE: Qualify 
 */

CREATE TABLE Qualify(
    QualifyID        int        IDENTITY(1,1),
    TrialTime        time(7)    NULL,
    IsShortCourse    bit        DEFAULT 1 NULL,
    LengthOfPool     int        NULL,
    TrialDistID      int        NULL,
    QualifyDistID    int        NULL,
    StrokeID         int        NULL,
    GenderID         int        NULL,
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
    Build          int    NULL,
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
    Caption            nvarchar(128)    NULL,
    AgeFrom            int              NULL,
    AgeTo              int              NULL,
    SwimClubID         int              NULL,
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

INSERT [dbo].[ScoreDivision] ([ScoreDivisionID], [SwimClubID], [AgeFrom], [AgeTo], [Caption], [GenderID]) 
VALUES
-- GIRLS 
(1, 1, 0, 8, N'Junior swimmers 8 years and under.', 2),
(2, 1, 9, 9, N'Junior swimmers 9 years.', 2),
(3, 1, 10, 11, N'10-11. Girls Multi-Class.', 2),
(4, 1, 12, 13, N'12-13. Girls Multi-Class.', 2),
(5, 1, 14, 15, N'14-15. Girls Multi-Class.', 2),
(6, 1, 16, 18, N'16-18. Girls Multi-Class.', 2),
-- Example of Set Inclusion
(7, 1, 14, 18, N'14-18. Girls Senior Championship.', 2),

-- BOYS
(8, 1, 0, 8, N'Junior swimmers 8 years and under.', 1),
(9, 1, 9, 9, N'Junior swimmers 9 years.', 1),
(10, 1, 10, 11, N'10-11. Boys Multi-Class.', 1),
(11, 1, 12, 13, N'12-13. Boys Multi-Class.', 1),
(12, 1, 14, 15, N'14-15. Boys Multi-Class.', 1),
(13, 1, 16, 18, N'16-18. Boys Multi-Class.', 1),
-- Example of Set Inclusion
(14, 1, 14, 18, N'14-18. Boys Senior Championship.', 1)

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
    Place            int      NULL,
    Points           float    NULL,
    SwimClubID       int      NULL,
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
    PoolTypeID                      int              NULL,
    SwimClubTypeID                  int              NULL,
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
	,N'https://artanemus.github.io/index.html'
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
 * TABLE: SwimClubMetaDataLink 
 */

CREATE TABLE SwimClubMetaDataLink(
    SwimClubID    int    NOT NULL,
    MetaDataID    int    NOT NULL,
    CONSTRAINT PK_SwimClubMetaDataLink PRIMARY KEY CLUSTERED (SwimClubID, MetaDataID)
)
GO



IF OBJECT_ID('SwimClubMetaDataLink') IS NOT NULL
    PRINT '<<< CREATED TABLE SwimClubMetaDataLink >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE SwimClubMetaDataLink >>>'
GO
SET IDENTITY_INSERT [dbo].[SwimClubMetaDataLink] ON
GO

INSERT INTO [dbo].[SwimClubMetaDataLink]
(
    SwimClubID
  , MetaDataID
)
VALUES
(1, 1)

GO

SET IDENTITY_INSERT [dbo].[SwimClubMetaDataLink] OFF
GO

GRANT INSERT ON SwimClubMetaDataLink TO SCM_Administrator
GO
GRANT SELECT ON SwimClubMetaDataLink TO SCM_Administrator
GO
GRANT UPDATE ON SwimClubMetaDataLink TO SCM_Administrator
GO
GRANT SELECT ON SwimClubMetaDataLink TO SCM_Marshall
GO
GRANT SELECT ON SwimClubMetaDataLink TO SCM_Guest
GO
GRANT DELETE ON SwimClubMetaDataLink TO SCM_Administrator
GO

/* 
 * TABLE: SwimClubType 
 */

CREATE TABLE SwimClubType(
    SwimClubTypeID    int              IDENTITY(1,1),
    Caption           nvarchar(128)    NULL,
    ShortCaption      nvarchar(32)     NULL,
    ABREV             nvarchar(12)     NULL,
    IsArchived        bit              DEFAULT 0 NOT NULL,
    IsActive          bit              DEFAULT 1 NOT NULL,
    CONSTRAINT PK_SwimClubType PRIMARY KEY CLUSTERED (SwimClubTypeID)
)
GO



IF OBJECT_ID('SwimClubType') IS NOT NULL
    PRINT '<<< CREATED TABLE SwimClubType >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE SwimClubType >>>'
GO
SET IDENTITY_INSERT [dbo].[SwimClubType] ON
GO

INSERT [dbo].[SwimClubType]
(
    [SwimClubTypeID]
  , [Caption]
  , [ShortCaption]
  , [ABREV]
  , [IsActive] -- NULL NOT ALLOWED
  , [IsArchived] -- NULL NOT ALLOWED
)
VALUES
(1, N'Amateur Swimming Club', 'SCM SwimClub', N'SCMCLUB', 1, 0)
, (2, N'SCM Carnival Club vs Clubs', 'SCM Carnival', N'SCMCARNIVAL', 1, 0)
, (3, N'Club Championship', 'Championship', N'CLUBCHAMP', 1, 0)
, (4, N'Regional Championship', 'Regional Competitive', N'REGCOMP', 1, 0)
, (5, N'State Championship', 'State Competitive', N'STATECOMP', 1, 0)
, (6, N'National Championship', 'National Competitive', N'NATCOMP', 1, 0)
, (7, N'Masters Swimming', 'Masters', N'MASTER', 1, 0)
, (8, N'Paralympic Swimming', 'Paralympic', N'PARA', 1, 0)
, (9, N'Primary School Carnival', 'Primary School', N'PRIMARY', 1, 0)
, (10, N'Secondary School Carnival', 'Secondary School', N'SECONDARY', 1, 0)
, (11, N'Multi-Class Carnival', 'Multi-Class', N'MULTICLASS', 1, 0)
GO

/* 
 * TABLE: SwimmerCategory 
 */

CREATE TABLE SwimmerCategory(
    SwimmerCategoryID    int              IDENTITY(1,1),
    Caption              nvarchar(64)     NULL,
    LongCaption          nvarchar(128)    NULL,
    TAG                  nvarchar(128)    NULL,
    TAGID                int              NULL,
    ABREV                nvarchar(9)      NULL,
    AgeFrom              int              NULL,
    AgeTo                int              NULL,
    IsArchived           bit              DEFAULT 0 NOT NULL,
    IsActive             bit              DEFAULT 1 NOT NULL,
    SwimClubID           int              NULL,
    CONSTRAINT PK_SwimmerCategory PRIMARY KEY CLUSTERED (SwimmerCategoryID)
)
GO



IF OBJECT_ID('SwimmerCategory') IS NOT NULL
    PRINT '<<< CREATED TABLE SwimmerCategory >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE SwimmerCategory >>>'
GO
SET IDENTITY_INSERT [dbo].[SwimmerCategory] ON 
GO
INSERT [dbo].[SwimmerCategory] ([SwimmerCategoryID], [Caption], [LongCaption], [TAG], [TAGID], [ABREV], [AgeFrom], [AgeTo], [IsArchived], [IsActive], [SwimClubID]) 
VALUES 
/* 
NOTE: Gender not a consideration in swimming categories. METADATA TAG used to resolve duplicity.
HINT: Use by Auto-Build 'seperate by Swimming Category' option.'
*/
(1, N'Competitive 9 years+', N'Competitive Swimmer 9 years and over.',N'COMPETITIVE',1,N'COMPET9+', 9, 99, 0,1,1)
,(2, N'Casual 9 years+', N'Casual or recreational Swimmer 9 years and over, who does not compete in Metropolitan ChampionShips ',NULL,0,N'CASUAL9+', 9, 99, 0,1,1)
,(3, N'Junior Dolphin 7 & under', N'Junior Dolphin 7 and under.', NULL,0,N'JrDOLP7U', 1, 7, 0,1,1)
,(4, N'Junior Dolphin 8 years', N'Junior Dolphin 8 year old.', NULL,0,N'JrDOLPH8Y', 8, 8, 0,1,1)
GO
SET IDENTITY_INSERT [dbo].[SwimmerCategory] OFF
GO

GRANT UPDATE ON SwimmerCategory TO SCM_Administrator
GO
GRANT SELECT ON SwimmerCategory TO SCM_Marshall
GO
GRANT SELECT ON SwimmerCategory TO SCM_Guest
GO
GRANT DELETE ON SwimmerCategory TO SCM_Administrator
GO
GRANT INSERT ON SwimmerCategory TO SCM_Administrator
GO
GRANT SELECT ON SwimmerCategory TO SCM_Administrator
GO

/* 
 * TABLE: Team 
 */

CREATE TABLE Team(
    TeamID              int        IDENTITY(1,1),
    Lane                int        NULL,
    RaceTime            time(7)    NULL,
    TimeToBeat          time(7)    NULL,
    IsDisqualified      bit        DEFAULT 0 NULL,
    IsScratched         bit        DEFAULT 0 NULL,
    DisqualifyCodeID    int        NULL,
    HeatID              int        NULL,
    TeamNameID          int        NULL,
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
GRANT DELETE ON Team TO SCM_Marshall
GO
GRANT INSERT ON Team TO SCM_Marshall
GO
GRANT UPDATE ON Team TO SCM_Marshall
GO

/* 
 * TABLE: TeamEntrant 
 */

CREATE TABLE TeamEntrant(
    TeamEntrantID       int        IDENTITY(1,1),
    Lane                int        NULL,
    RaceTime            time(7)    NULL,
    TimeToBeat          time(7)    NULL,
    PersonalBest        time(7)    NULL,
    IsDisqualified      bit        DEFAULT 0 NULL,
    IsScratched         bit        DEFAULT 0 NULL,
    DisqualifyCodeID    int        NULL,
    MemberID            int        NULL,
    StrokeID            int        NULL,
    TeamID              int        NULL,
    CONSTRAINT PK_TeamEntrant PRIMARY KEY NONCLUSTERED (TeamEntrantID)
)
GO



IF OBJECT_ID('TeamEntrant') IS NOT NULL
    PRINT '<<< CREATED TABLE TeamEntrant >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE TeamEntrant >>>'
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
GRANT DELETE ON TeamEntrant TO SCM_Marshall
GO
GRANT INSERT ON TeamEntrant TO SCM_Marshall
GO

/* 
 * TABLE: TeamName 
 */

CREATE TABLE TeamName(
    TeamNameID      int             IDENTITY(1,1),
    Caption         nvarchar(64)    NULL,
    CaptionShort    nvarchar(64)    NULL,
    ABREV           nvarchar(5)     NULL,
    CONSTRAINT PK_TeamName PRIMARY KEY CLUSTERED (TeamNameID)
)
GO



IF OBJECT_ID('TeamName') IS NOT NULL
    PRINT '<<< CREATED TABLE TeamName >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE TeamName >>>'
GO

GRANT INSERT ON TeamName TO SCM_Administrator
GO
GRANT SELECT ON TeamName TO SCM_Administrator
GO
GRANT UPDATE ON TeamName TO SCM_Administrator
GO
GRANT SELECT ON TeamName TO SCM_Marshall
GO
GRANT SELECT ON TeamName TO SCM_Guest
GO
GRANT DELETE ON TeamName TO SCM_Administrator
GO

/* 
 * TABLE: TeamSplit 
 */

CREATE TABLE TeamSplit(
    TeamSplitID    int        IDENTITY(1,1),
    SplitTime      time(7)    NULL,
    TeamID         int        NULL,
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
 * TABLE: DisqualifyType 
 */

ALTER TABLE DisqualifyType ADD CONSTRAINT StrokeDisqualifyType 
    FOREIGN KEY (StrokeID)
    REFERENCES Stroke(StrokeID)
GO


/* 
 * TABLE: Distance 
 */

ALTER TABLE Distance ADD CONSTRAINT EventTypeDistance 
    FOREIGN KEY (EventTypeID)
    REFERENCES EventType(EventTypeID)
GO


/* 
 * TABLE: Entrant 
 */

ALTER TABLE Entrant ADD CONSTRAINT DisqualifyCodeEntrant 
    FOREIGN KEY (DisqualifyCodeID)
    REFERENCES DisqualifyCode(DisqualifyCodeID)
GO

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
 * TABLE: House 
 */

ALTER TABLE House ADD CONSTRAINT SwimClubHouse 
    FOREIGN KEY (SwimClubID)
    REFERENCES SwimClub(SwimClubID)
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

ALTER TABLE Member ADD CONSTRAINT SwimClubMember 
    FOREIGN KEY (SwimClubID)
    REFERENCES SwimClub(SwimClubID) ON DELETE SET NULL
GO


/* 
 * TABLE: MemberRoleLink 
 */

ALTER TABLE MemberRoleLink ADD CONSTRAINT MemberMemberRoleLink 
    FOREIGN KEY (MemberID)
    REFERENCES Member(MemberID)
GO

ALTER TABLE MemberRoleLink ADD CONSTRAINT MemberRoleMemberRoleLink 
    FOREIGN KEY (MemberRoleID)
    REFERENCES MemberRole(MemberRoleID)
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
 * TABLE: ParaDetail 
 */

ALTER TABLE ParaDetail ADD CONSTRAINT ParaMasterParaDetail 
    FOREIGN KEY (ParaMasterID)
    REFERENCES ParaMaster(ParaMasterID)
GO


/* 
 * TABLE: Qualify 
 */

ALTER TABLE Qualify ADD CONSTRAINT DistanceQual16 
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
 * TABLE: SwimClub 
 */

ALTER TABLE SwimClub ADD CONSTRAINT PoolTypeSwimClub 
    FOREIGN KEY (PoolTypeID)
    REFERENCES PoolType(PoolTypeID)
GO

ALTER TABLE SwimClub ADD CONSTRAINT SwimClubTypeSwimClub 
    FOREIGN KEY (SwimClubTypeID)
    REFERENCES SwimClubType(SwimClubTypeID)
GO


/* 
 * TABLE: SwimClubMetaDataLink 
 */

ALTER TABLE SwimClubMetaDataLink ADD CONSTRAINT MetaDataSwimClubMetaDataLink 
    FOREIGN KEY (MetaDataID)
    REFERENCES MetaData(MetaDataID)
GO

ALTER TABLE SwimClubMetaDataLink ADD CONSTRAINT SwimClubSwimClubMetaDataLink 
    FOREIGN KEY (SwimClubID)
    REFERENCES SwimClub(SwimClubID)
GO


/* 
 * TABLE: SwimmerCategory 
 */

ALTER TABLE SwimmerCategory ADD CONSTRAINT SwimClubSwimmerCategory 
    FOREIGN KEY (SwimClubID)
    REFERENCES SwimClub(SwimClubID)
GO


/* 
 * TABLE: Team 
 */

ALTER TABLE Team ADD CONSTRAINT DisqualifyCodeTeam 
    FOREIGN KEY (DisqualifyCodeID)
    REFERENCES DisqualifyCode(DisqualifyCodeID)
GO

ALTER TABLE Team ADD CONSTRAINT HeatIndividualTeam 
    FOREIGN KEY (HeatID)
    REFERENCES HeatIndividual(HeatID)
GO

ALTER TABLE Team ADD CONSTRAINT TeamNameTeam 
    FOREIGN KEY (TeamNameID)
    REFERENCES TeamName(TeamNameID)
GO


/* 
 * TABLE: TeamEntrant 
 */

ALTER TABLE TeamEntrant ADD CONSTRAINT DisqualifyCodeTeamEntrant 
    FOREIGN KEY (DisqualifyCodeID)
    REFERENCES DisqualifyCode(DisqualifyCodeID)
GO

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

ALTER TABLE TeamSplit ADD CONSTRAINT TeamTeamSplit 
    FOREIGN KEY (TeamID)
    REFERENCES Team(TeamID)
GO


/* 
 * FUNCTION: ABSEventPlace 
 */

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

/****** Object:  UserDefinedFunction [dbo].[EntrantCount]    Script Date: 05/09/23 1:45:52 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ben Ambrose
-- Create date: 13/8/2019
-- Modified on: 05/09/2023 
-- 
-- Description:	Count the number of swimmers for an event.
-- Determines if event is INDV or TEAM.
-- =============================================
CREATE FUNCTION [EntrantCount] (
    -- Add the parameters for the function here
    @EventID INT
    )
RETURNS INT
AS
BEGIN
    -- Declare the return variable here
    DECLARE @Result INT;
	DECLARE @EventTypeID  INT;

	SET @EventTypeID = (SELECT EventTypeID FROM dbo.[Event] INNER JOIN [Distance] ON [Event].DistanceID = Distance.DistanceID WHERE [Event].EventID = @EventID);
	SET @Result = 0;

	IF @EventTypeID IS NULL RETURN @Result; 

	IF @EventTypeID IS NULL RETURN @Result; 

	IF @EventTypeID = 1
	BEGIN
		SELECT @Result = Count(Entrant.EntrantID)
		FROM Entrant
		INNER JOIN HeatIndividual
			ON Entrant.HeatID = HeatIndividual.HeatID
		WHERE (Entrant.MemberID IS NOT NULL) AND (Entrant.MemberID > 0)
		GROUP BY HeatIndividual.EventID
		HAVING HeatIndividual.EventID = @EventID
	END;

	ELSE IF @EventTypeID = 2
	BEGIN
		SELECT @Result = Count(TeamEntrant.TeamEntrantID)
		FROM TeamEntrant
		INNER JOIN Team
			ON TeamEntrant.TeamID = Team.TeamID
		INNER JOIN HeatIndividual
			ON Team.HeatID = HeatIndividual.HeatID
		WHERE (TeamEntrant.MemberID IS NOT NULL) AND (TeamEntrant.MemberID > 0)
		GROUP BY HeatIndividual.EventID
		HAVING HeatIndividual.EventID = @EventID
	END;

    -- Return the result of the function
    RETURN @Result;

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

/****** Object:  UserDefinedFunction [dbo].[IsMemberNominated]    Script Date: 04/02/23 9:29:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ben Ambrose
-- Create date: 04/02/2023
-- Description:	Is the member nominated for the event
-- =============================================
CREATE FUNCTION [IsMemberNominated]
(
    -- Add the parameters for the function here
    @MemberID INT
  , @EventID INT
)
RETURNS BIT
AS
BEGIN
    -- Declare the return variable here
    DECLARE @Result BIT;
    DECLARE @Count AS INTEGER;

    SELECT @Count =
    (
        SELECT COUNT(dbo.nominee.NomineeID) AS NOM
        FROM Nominee
        WHERE memberid = @MemberID
              AND EventID = @EventID
    );

    IF @Count = 0
        SELECT @Result = 0;
    ELSE
        SELECT @Result = 1;

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
 * FUNCTION: MembersSwimmerCategory 
 */

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ben Ambrose
-- Create date: 13/07/2023
-- Description:	Get the Swimming CATEGORY of the MEMBER
-- =============================================
CREATE FUNCTION [MembersSwimmerCategory] 
(
	-- Add the parameters for the function here
	@MemberID int
	,@SwimClubID int
	,@SeedDate DateTime
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result int;

	IF @SwimClubID IS NULL SET @SwimClubID = 1;

	IF @SeedDate IS NULL SET @SeedDate = GETDATE();

	SET @Result = 0;

	IF @MemberID IS NULL RETURN @Result;

    DECLARE @SwimClubTypeID AS INTEGER;
    SET @SwimClubTypeID = (SELECT @SwimClubTypeID FROM dbo.SwimClub WHERE SwimClubID = @SwimClubID);
    IF @SwimClubTypeID IS NULL SET @SwimClubTypeID = 1;    

	    -- Declare the table variable
    DECLARE @A TABLE (MemberID INT, AGE INT, TAGS nvarchar(max));
	DECLARE @B TABLE (ID INT, aMATCH INT);

    -- Insert data into the table variable
    INSERT INTO @A (MemberID, AGE, TAGS) 
    SELECT 
		[MemberID]
		, dbo.SwimmerAge(@SeedDate, member.DOB) AS AGE
		, [TAGS]

	FROM [SwimClubMeet].[dbo].[Member]
	WHERE MemberID = @MemberID AND SwimClubID = @SwimClubID	;


	INSERT INTO @B (ID, aMATCH)
	SELECT 
		[dbo].[SwimmerCategory].[SwimmerCategoryID] AS ID
		, CASE
            -- IF BOTH ARE NULL - MATCH
			WHEN (SwimmerCategory.TAG IS NULL)
				AND (TAGS IS NULL) THEN
				1 
            -- TAG FOUND IN META-DATA                
			-- If either the expressionToFind or expressionToSearch expression has a NULL value, CHARINDEX returns NULL.
			-- If CHARINDEX does not find expressionToFind within expressionToSearch, CHARINDEX returns 0.
			WHEN (CHARINDEX(SwimmerCategory.TAG, TAGS) > 0) THEN
				1 
			ELSE
				0 -- NO MATCH
		END AS aMATCH 

		FROM [dbo].[SwimmerCategory]
            
			INNER JOIN @A
				ON (AGE >= AgeFrom)
				   AND (AGE <= AgeTo)
        WHERE [dbo].[SwimmerCategory].[SwimClubID] = @SwimClubID
		-- Ordering here fails !!! ???


	SELECT TOP (1)  @Result = ID FROM @B  WHERE aMATCH = 1 ORDER BY aMATCH DESC; 


	-- Return the result of the function
	RETURN @Result

END
GO



GO
IF OBJECT_ID('MembersSwimmerCategory') IS NOT NULL
    PRINT '<<< CREATED FUNCTION MembersSwimmerCategory >>>'
ELSE
    PRINT '<<< FAILED CREATING FUNCTION MembersSwimmerCategory >>>'
GO


/* 
 * FUNCTION: NomineeCount 
 */

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

GRANT EXECUTE ON RaceTimeDIFF TO SCM_Administrator
GO
GRANT EXECUTE ON RaceTimeDIFF TO SCM_Marshall
GO
GRANT EXECUTE ON RaceTimeDIFF TO SCM_Guest
GO


/* 
 * FUNCTION: RELEventPlace 
 */

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


/****** Object:  UserDefinedFunction [dbo].[SessionEntrantCount]    Script Date: 14/09/23 4:15:03 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Ben Ambrose
-- Create date: 15/11/2019
-- Modified on: 05/09/2023
--
-- Description:	Count the number of swimmers for the session.
-- Determines if the event is INDV or TEAM.
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
	DECLARE @Ent  INT;
	DECLARE @TeamEnt INT;

	SET @Ent = (SELECT Count(Entrant.MemberID)
	FROM Entrant
	INNER JOIN HeatIndividual ON Entrant.HeatID = HeatIndividual.HeatID
	INNER JOIN Event ON HeatIndividual.EventID = Event.EventID
	WHERE (Event.SessionID = @SessionID) AND
		(Entrant.MemberID IS NOT NULL) AND (Entrant.MemberID > 0));

	SET @TeamEnt = (SELECT Count(TeamEntrant.MemberID)
	FROM TeamEntrant
	INNER JOIN Team ON TeamEntrant.TeamID = Team.TeamID
	INNER JOIN HeatIndividual ON Team.HeatID = HeatIndividual.HeatID
	INNER JOIN Event ON HeatIndividual.EventID = Event.EventID
	WHERE (Event.SessionID = @SessionID) AND
		(TeamEntrant.MemberID IS NOT NULL) AND (TeamEntrant.MemberID > 0));

	SET @Result = @Ent + @TeamEnt;

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

