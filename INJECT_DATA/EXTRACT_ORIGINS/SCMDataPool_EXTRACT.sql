USE SwimClubMeet
GO

-- ****************************************
-- A very basic test to see if a SwimClubMeet database exists.
-- ****************************************

IF NOT EXISTS (SELECT SwimClubID FROM SwimClub WHERE SwimClubID = 1)
RETURN;

/*
    METHOD:
    CREATE an empty SwimClubMeet database.
    RESTORE a previous SwimClubMeet database with has members and racetimes. 
    Name this database as SCMDataPool.

    THEN:
    1.INJECT Members into the empty SwimClubMeet database.
    2.CREATE a Session dated 2000/01/01
    3.CREATE every type of swimming Event in the new Session.
    4.NEXT 
        IF MEMBER HAS SWUM the EVENT - INJECT a Nominee record and assign Nominee.SeedDate with the member's Personal Best.

    FINALLY:
    RUN the core application. 
    IN PREFERENCES.SYSTEM enable seeding.
    SELECT Session 2000/01/01 and auto-build all event.
    DISABLE seeding.

    WRAPPING UP:
    The new SwimClubMeet has seed data. 
*/

INSERT INTO [SwimClubMeet].[dbo].[Member]
           (
       [MembershipNum]
--      ,[MembershipStr]
--      ,[MembershipDue]
           ,[FirstName]
           ,[LastName]
           ,[DOB]
           ,[IsActive]
           ,[IsArchived]
--      ,[Email]
--      ,[EnableEmailOut]
           ,[GenderID]
           ,[SwimClubID]
--      ,[MembershipTypeID]
--      ,[CreatedOn]
--      ,[ArchivedOn]
--      ,[EnableEmailNomineeForm]
--      ,[EnableEmailSessionReport]
--      ,[HouseID]
           ,[IsSwimmer])
     SELECT
        SCMDataPool.dbo.MembershipNum
           ,SCMDataPool.dbo.Member.FirstName
           ,SCMDataPool.dbo.Member.LastName
           ,SCMDataPool.dbo.Member.DOB
           , CASE WHEN (SCMDataPool.dbo.Member.IsActive = 1) THEN 1 ELSE 0 END
           , CASE WHEN (SCMDataPool.dbo.Member.IsArchived = 1) THEN 1 ELSE 0 END
           ,SCMDataPool.dbo.Member.GenderID
           ,SCMDataPool.dbo.Member.SwimClubID
           , CASE WHEN (SCMDataPool.dbo.Member.IsSwimmer = 1) THEN 1 ELSE 0 END

		FROM SCMDataPool.dbo.Member
GO

-- ****************************************
-- BUILD THE SESSION 2000/01/01
-- ****************************************

DECLARE @SessionID AS INT;
DECLARE @EventNum AS INT;

INSERT INTO [SwimClubMeet].[dbo].[Session]
(
		 [Caption]
		,[SessionStart]
		,[ClosedDT]
		,[SwimClubID]
		,[SessionStatusID]
)
VALUES
(
		 'Members Personal Best seed-data'
		,'2000-01-01 20:00'
		,'2000-01-01 20:30'
		,1
		,1
);

-- ****************************************
-- GET THE NEWLY CREATED SESSION
-- ****************************************

SET @SessionID = (IDENT_CURRENT('Session'));

-- ****************************************
-- CREATE EVERY TYPE OF SWIMMING EVENT
-- ****************************************

INSERT INTO [SwimClubMeet].[dbo].[Event]
(
		 [EventNum]
		,[Caption]
		,[ClosedDT]
		,[SessionID]
		,[EventTypeID]
		,[StrokeID]
		,[DistanceID]
		,[EventStatusID]
)
VALUES
    -- Freestyle 
    (1,'Seed-event for Personal Bests',NULL,@SessionID,1,1,1,1),
    (2,'Seed-event for Personal Bests',NULL,@SessionID,1,1,2,1),
    (3,'Seed-event for Personal Bests',NULL,@SessionID,1,1,3,1),
    (4,'Seed-event for Personal Bests',NULL,@SessionID,1,1,4,1),
    (5,'Seed-event for Personal Bests',NULL,@SessionID,1,1,5,1),
    (6,'Seed-event for Personal Bests',NULL,@SessionID,1,1,6,1),
    -- Breaststroke
    (7,'Seed-event for Personal Bests',NULL,@SessionID,1,2,1,1),
    (8,'Seed-event for Personal Bests',NULL,@SessionID,1,2,2,1),
    (9,'Seed-event for Personal Bests',NULL,@SessionID,1,2,3,1),
    (10,'Seed-event for Personal Bests',NULL,@SessionID,1,2,4,1),
    (11,'Seed-event for Personal Bests',NULL,@SessionID,1,2,5,1),
    (12,'Seed-event for Personal Bests',NULL,@SessionID,1,2,6,1),
    -- Backstroke
    (13,'Seed-event for Personal Bests',NULL,@SessionID,1,3,1,1),
    (14,'Seed-event for Personal Bests',NULL,@SessionID,1,3,2,1),
    (15,'Seed-event for Personal Bests',NULL,@SessionID,1,3,3,1),
    (16,'Seed-event for Personal Bests',NULL,@SessionID,1,3,4,1),
    (17,'Seed-event for Personal Bests',NULL,@SessionID,1,3,5,1),
    (18,'Seed-event for Personal Bests',NULL,@SessionID,1,3,6,1),
    -- Butterfly
    (19,'Seed-event for Personal Bests',NULL,@SessionID,1,4,1,1),
    (20,'Seed-event for Personal Bests',NULL,@SessionID,1,4,2,1),
    (21,'Seed-event for Personal Bests',NULL,@SessionID,1,4,3,1),
    (22,'Seed-event for Personal Bests',NULL,@SessionID,1,4,4,1),
    (23,'Seed-event for Personal Bests',NULL,@SessionID,1,4,5,1),
    (24,'Seed-event for Personal Bests',NULL,@SessionID,1,4,6,1),
    -- Medley
    (25,'Seed-event for Personal Bests',NULL,@SessionID,1,5,1,1), -- 25m Medley Nah!
    (26,'Seed-event for Personal Bests',NULL,@SessionID,1,5,2,1), -- 50m Medley Nah!
    (27,'Seed-event for Personal Bests',NULL,@SessionID,1,5,3,1),
    (28,'Seed-event for Personal Bests',NULL,@SessionID,1,5,4,1),
    (29,'Seed-event for Personal Bests',NULL,@SessionID,1,5,5,1),
    (30,'Seed-event for Personal Bests',NULL,@SessionID,1,5,6,1);
    
    GO

-- ****************************************
-- NOTE: After GO STATEMENT PARAMS MUST BE RE-DECLARED.
-- ****************************************

DECLARE @SessionID AS INT;

PRINT N'SessionID derived from session YEAR 2000';

SET @SessionID = (SELECT TOP 1 SessionID FROM [SwimClubMeet].[dbo].[Session] WHERE YEAR( [SessionStart] ) = 2000 );

If @SessionID IS NULL RETURN;

PRINT N'Calculate personal bests for all members in DataPool';

-- Drop a temporary table called '#MemPB'
-- Drop the table if it already exists
IF OBJECT_ID('tempDB..#MemPB', 'U') IS NOT NULL
DROP TABLE #MemPB
;
-- Create the temporary table from a physical table called 'TableName' in schema 'dbo' in database 'SCMDataPool'
SELECT MemberID, 
    FirstName,
    LastName,
    -- FREESTYLE
    SCMDataPool.dbo.PersonalBest(MemberID, 1,1,GETDATE()) AS FR25,
    SCMDataPool.dbo.PersonalBest(MemberID, 2,1,GETDATE()) AS FR50,
    SCMDataPool.dbo.PersonalBest(MemberID, 3,1,GETDATE()) AS FR100,
    SCMDataPool.dbo.PersonalBest(MemberID, 4,1,GETDATE()) AS FR200,
    SCMDataPool.dbo.PersonalBest(MemberID, 5,1,GETDATE()) AS FR400,
    -- BREASTSTROKE
    SCMDataPool.dbo.PersonalBest(MemberID, 1,2,GETDATE()) AS BR25,
    SCMDataPool.dbo.PersonalBest(MemberID, 2,2,GETDATE()) AS BR50,
    SCMDataPool.dbo.PersonalBest(MemberID, 3,2,GETDATE()) AS BR100,
    SCMDataPool.dbo.PersonalBest(MemberID, 4,2,GETDATE()) AS BR200,
    SCMDataPool.dbo.PersonalBest(MemberID, 5,2,GETDATE()) AS BR400,
    -- BACKSTROKE
    SCMDataPool.dbo.PersonalBest(MemberID, 1,3,GETDATE()) AS BA25,
    SCMDataPool.dbo.PersonalBest(MemberID, 2,3,GETDATE()) AS BA50,
    SCMDataPool.dbo.PersonalBest(MemberID, 3,3,GETDATE()) AS BA100,
    SCMDataPool.dbo.PersonalBest(MemberID, 4,3,GETDATE()) AS BA200,
    SCMDataPool.dbo.PersonalBest(MemberID, 5,3,GETDATE()) AS BA400,
    -- BUTTERFLY
    SCMDataPool.dbo.PersonalBest(MemberID, 1,4,GETDATE()) AS BU25,
    SCMDataPool.dbo.PersonalBest(MemberID, 2,4,GETDATE()) AS BU50,
    SCMDataPool.dbo.PersonalBest(MemberID, 3,4,GETDATE()) AS BU100,
    SCMDataPool.dbo.PersonalBest(MemberID, 4,4,GETDATE()) AS BU200,
    SCMDataPool.dbo.PersonalBest(MemberID, 5,4,GETDATE()) AS BU400,
    --MEDLEY
    --SCMDataPool.dbo.PersonalBest(MemberID, 1,5,GETDATE()) AS ME25,
    --SCMDataPool.dbo.PersonalBest(MemberID, 2,5,GETDATE()) AS ME50,
    SCMDataPool.dbo.PersonalBest(MemberID, 3,5,GETDATE()) AS ME100,
    SCMDataPool.dbo.PersonalBest(MemberID, 4,5,GETDATE()) AS ME200,
    SCMDataPool.dbo.PersonalBest(MemberID, 5,5,GETDATE()) AS ME400

INTO #MemPB
FROM [SCMDataPool].[dbo].[Member]
WHERE IsSwimmer = 1;

/* 
-- DEBUG TEST OUTPUT
SELECT #MemPB.FR25, Member.MemberID FROM Member
INNER JOIN #MemPB ON Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName  COLLATE DATABASE_DEFAULT AND Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName 
WHERE fr25 is not null; 
*/


/*
    nominate member to event
*/
DECLARE @EventID AS INT;

-- 25m Freestyle
PRINT N'25m freestyle';

SET @EventID = (SELECT TOP 1 EventID FROM [Event] WHERE [Event].DistanceID = 1 AND [Event].StrokeID = 1 ) ;

IF @EventID IS NULL RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
    WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
    ,[EventID]
    ,[MemberID]
)
SELECT  #MemPB.FR25, @EventID, [SwimClubMeet].[dbo].Member.MemberID FROM [SwimClubMeet].[dbo].Member
INNER JOIN #MemPB ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName  COLLATE DATABASE_DEFAULT AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName 
WHERE #MemPB.FR25 is not null;

-- 50m Freestyle
PRINT N'50m freestyle';

SET @EventID = (SELECT TOP 1 EventID FROM [Event] WHERE [Event].DistanceID = 2 AND [Event].StrokeID = 1 ) ;

IF @EventID IS NULL RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
    WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
    ,[EventID]
    ,[MemberID]
)
SELECT  #MemPB.FR50, @EventID, [SwimClubMeet].[dbo].Member.MemberID FROM [SwimClubMeet].[dbo].Member
INNER JOIN #MemPB ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName  COLLATE DATABASE_DEFAULT AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName 
WHERE #MemPB.FR50 is not null;

-- 100m Freestyle
PRINT N'100m freestyle';

SET @EventID = (SELECT TOP 1 EventID FROM [Event] WHERE [Event].DistanceID = 3 AND [Event].StrokeID = 1 ) ;

IF @EventID IS NULL RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
    WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
    ,[EventID]
    ,[MemberID]
)
SELECT  #MemPB.FR100, @EventID, [SwimClubMeet].[dbo].Member.MemberID FROM [SwimClubMeet].[dbo].Member
INNER JOIN #MemPB ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName  COLLATE DATABASE_DEFAULT AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName 
WHERE #MemPB.FR100 is not null;

-- 200m Freestyle
PRINT N'200m freestyle';

SET @EventID = (SELECT TOP 1 EventID FROM [Event] WHERE [Event].DistanceID = 4 AND [Event].StrokeID = 1 ) ;

IF @EventID IS NULL RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
    WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
    ,[EventID]
    ,[MemberID]
)
SELECT  #MemPB.FR200, @EventID, [SwimClubMeet].[dbo].Member.MemberID FROM [SwimClubMeet].[dbo].Member
INNER JOIN #MemPB ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName  COLLATE DATABASE_DEFAULT AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName 
WHERE #MemPB.FR200 is not null;

-- 400m Freestyle
PRINT N'400m freestyle';

SET @EventID = (SELECT TOP 1 EventID FROM [Event] WHERE [Event].DistanceID = 5 AND [Event].StrokeID = 1 ) ;

IF @EventID IS NULL RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
    WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
    ,[EventID]
    ,[MemberID]
)
SELECT  #MemPB.FR400, @EventID, [SwimClubMeet].[dbo].Member.MemberID FROM [SwimClubMeet].[dbo].Member
INNER JOIN #MemPB ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName  COLLATE DATABASE_DEFAULT AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName 
WHERE #MemPB.FR400 is not null;

-- *************************************
-- B R E A S T S T R O K E .
-- *************************************
-- 25m Breaststroke
PRINT N'25m breatstroke';

SET @EventID = (SELECT TOP 1 EventID FROM [Event] WHERE [Event].DistanceID = 1 AND [Event].StrokeID = 2 ) ;

IF @EventID IS NULL RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
    WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
    ,[EventID]
    ,[MemberID]
)
SELECT  #MemPB.BR25, @EventID, [SwimClubMeet].[dbo].Member.MemberID FROM [SwimClubMeet].[dbo].Member
INNER JOIN #MemPB ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName  COLLATE DATABASE_DEFAULT AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName 
WHERE #MemPB.BR25 is not null;


-- 50m Breaststroke
PRINT N'50m breatstroke';

SET @EventID = (SELECT TOP 1 EventID FROM [Event] WHERE [Event].DistanceID = 2 AND [Event].StrokeID = 2 ) ;

IF @EventID IS NULL RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
    WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
    ,[EventID]
    ,[MemberID]
)
SELECT  #MemPB.BR50, @EventID, [SwimClubMeet].[dbo].Member.MemberID FROM [SwimClubMeet].[dbo].Member
INNER JOIN #MemPB ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName  COLLATE DATABASE_DEFAULT AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName 
WHERE #MemPB.BR50 is not null;


-- 100m Breaststroke
PRINT N'100m breatstroke';

SET @EventID = (SELECT TOP 1 EventID FROM [Event] WHERE [Event].DistanceID = 3 AND [Event].StrokeID = 2 ) ;

IF @EventID IS NULL RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
    WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
    ,[EventID]
    ,[MemberID]
)
SELECT  #MemPB.BR100, @EventID, [SwimClubMeet].[dbo].Member.MemberID FROM [SwimClubMeet].[dbo].Member
INNER JOIN #MemPB ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName  COLLATE DATABASE_DEFAULT AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName 
WHERE #MemPB.BR100 is not null;

-- 200m Breaststroke
PRINT N'200m breatstroke';

SET @EventID = (SELECT TOP 1 EventID FROM [Event] WHERE [Event].DistanceID = 4 AND [Event].StrokeID = 2 ) ;

IF @EventID IS NULL RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
    WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
    ,[EventID]
    ,[MemberID]
)
SELECT  #MemPB.BR200, @EventID, [SwimClubMeet].[dbo].Member.MemberID FROM [SwimClubMeet].[dbo].Member
INNER JOIN #MemPB ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName  COLLATE DATABASE_DEFAULT AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName 
WHERE #MemPB.BR200 is not null;

-- 400m Breaststroke
PRINT N'400m breatstroke';

SET @EventID = (SELECT TOP 1 EventID FROM [Event] WHERE [Event].DistanceID = 5 AND [Event].StrokeID = 2 ) ;

IF @EventID IS NULL RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
    WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
    ,[EventID]
    ,[MemberID]
)
SELECT  #MemPB.BR400, @EventID, [SwimClubMeet].[dbo].Member.MemberID FROM [SwimClubMeet].[dbo].Member
INNER JOIN #MemPB ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName  COLLATE DATABASE_DEFAULT AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName 
WHERE #MemPB.BR400 is not null;


-- *************************************
-- B A C K S T R O K E .
-- *************************************
-- 25m backstroke
PRINT N'25m backstroke';

SET @EventID = (SELECT TOP 1 EventID FROM [Event] WHERE [Event].DistanceID = 1 AND [Event].StrokeID = 3 ) ;

IF @EventID IS NULL RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
    WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
    ,[EventID]
    ,[MemberID]
)
SELECT  #MemPB.BA25, @EventID, [SwimClubMeet].[dbo].Member.MemberID FROM [SwimClubMeet].[dbo].Member
INNER JOIN #MemPB ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName  COLLATE DATABASE_DEFAULT AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName 
WHERE #MemPB.BA25 is not null;


-- 50m backstroke
PRINT N'50m backstroke';

SET @EventID = (SELECT TOP 1 EventID FROM [Event] WHERE [Event].DistanceID = 2 AND [Event].StrokeID = 3 ) ;

IF @EventID IS NULL RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
    WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
    ,[EventID]
    ,[MemberID]
)
SELECT  #MemPB.BA50, @EventID, [SwimClubMeet].[dbo].Member.MemberID FROM [SwimClubMeet].[dbo].Member
INNER JOIN #MemPB ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName  COLLATE DATABASE_DEFAULT AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName 
WHERE #MemPB.BA50 is not null;


-- 100m backstroke
PRINT N'100m backstroke';

SET @EventID = (SELECT TOP 1 EventID FROM [Event] WHERE [Event].DistanceID = 3 AND [Event].StrokeID = 3 ) ;

IF @EventID IS NULL RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
    WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
    ,[EventID]
    ,[MemberID]
)
SELECT  #MemPB.BA100, @EventID, [SwimClubMeet].[dbo].Member.MemberID FROM [SwimClubMeet].[dbo].Member
INNER JOIN #MemPB ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName  COLLATE DATABASE_DEFAULT AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName 
WHERE #MemPB.BA100 is not null;

-- 200m backstroke
PRINT N'200m backstroke';

SET @EventID = (SELECT TOP 1 EventID FROM [Event] WHERE [Event].DistanceID = 4 AND [Event].StrokeID = 3 ) ;

IF @EventID IS NULL RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
    WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
    ,[EventID]
    ,[MemberID]
)
SELECT  #MemPB.BA200, @EventID, [SwimClubMeet].[dbo].Member.MemberID FROM [SwimClubMeet].[dbo].Member
INNER JOIN #MemPB ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName  COLLATE DATABASE_DEFAULT AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName 
WHERE #MemPB.BA200 is not null;

-- 400m backstroke
PRINT N'400m backstroke';

SET @EventID = (SELECT TOP 1 EventID FROM [Event] WHERE [Event].DistanceID = 5 AND [Event].StrokeID = 3 ) ;

IF @EventID IS NULL RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
    WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
    ,[EventID]
    ,[MemberID]
)
SELECT  #MemPB.BA400, @EventID, [SwimClubMeet].[dbo].Member.MemberID FROM [SwimClubMeet].[dbo].Member
INNER JOIN #MemPB ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName  COLLATE DATABASE_DEFAULT AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName 
WHERE #MemPB.BA400 is not null;



-- *************************************
-- B U T T E R F L Y
-- *************************************
-- 25m butterfly
PRINT N'25m butterfly';

SET @EventID = (SELECT TOP 1 EventID FROM [Event] WHERE [Event].DistanceID = 1 AND [Event].StrokeID = 4 ) ;

IF @EventID IS NULL RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
    WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
    ,[EventID]
    ,[MemberID]
)
SELECT  #MemPB.BU25, @EventID, [SwimClubMeet].[dbo].Member.MemberID FROM [SwimClubMeet].[dbo].Member
INNER JOIN #MemPB ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName  COLLATE DATABASE_DEFAULT AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName 
WHERE #MemPB.BU25 is not null;


-- 50m butterfly
PRINT N'50m butterfly';

SET @EventID = (SELECT TOP 1 EventID FROM [Event] WHERE [Event].DistanceID = 2 AND [Event].StrokeID = 4 ) ;

IF @EventID IS NULL RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
    WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
    ,[EventID]
    ,[MemberID]
)
SELECT  #MemPB.BU50, @EventID, [SwimClubMeet].[dbo].Member.MemberID FROM [SwimClubMeet].[dbo].Member
INNER JOIN #MemPB ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName  COLLATE DATABASE_DEFAULT AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName 
WHERE #MemPB.BU50 is not null;


-- 100m butterfly
PRINT N'100m butterfly';

SET @EventID = (SELECT TOP 1 EventID FROM [Event] WHERE [Event].DistanceID = 3 AND [Event].StrokeID = 4 ) ;

IF @EventID IS NULL RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
    WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
    ,[EventID]
    ,[MemberID]
)
SELECT  #MemPB.BU100, @EventID, [SwimClubMeet].[dbo].Member.MemberID FROM [SwimClubMeet].[dbo].Member
INNER JOIN #MemPB ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName  COLLATE DATABASE_DEFAULT AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName 
WHERE #MemPB.BU100 is not null;

-- 200m butterfly
PRINT N'200m butterfly';

SET @EventID = (SELECT TOP 1 EventID FROM [Event] WHERE [Event].DistanceID = 4 AND [Event].StrokeID = 4 ) ;

IF @EventID IS NULL RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
    WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
    ,[EventID]
    ,[MemberID]
)
SELECT  #MemPB.BU200, @EventID, [SwimClubMeet].[dbo].Member.MemberID FROM [SwimClubMeet].[dbo].Member
INNER JOIN #MemPB ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName  COLLATE DATABASE_DEFAULT AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName 
WHERE #MemPB.BU200 is not null;

-- 400m butterfly
PRINT N'400m butterfly';

SET @EventID = (SELECT TOP 1 EventID FROM [Event] WHERE [Event].DistanceID = 5 AND [Event].StrokeID = 4 ) ;

IF @EventID IS NULL RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
    WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
    ,[EventID]
    ,[MemberID]
)
SELECT  #MemPB.BU400, @EventID, [SwimClubMeet].[dbo].Member.MemberID FROM [SwimClubMeet].[dbo].Member
INNER JOIN #MemPB ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName  COLLATE DATABASE_DEFAULT AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName 
WHERE #MemPB.BU400 is not null;




-- *************************************
-- M E D L E Y
-- *************************************
/* 
-- 25m medley
PRINT N'25m medley';

SET @EventID = (SELECT TOP 1 EventID FROM [Event] WHERE [Event].DistanceID = 1 AND [Event].StrokeID = 5 ) ;

IF @EventID IS NULL RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
    WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
    ,[EventID]
    ,[MemberID]
)
SELECT  #MemPB.ME25, @EventID, [SwimClubMeet].[dbo].Member.MemberID FROM [SwimClubMeet].[dbo].Member
INNER JOIN #MemPB ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName  COLLATE DATABASE_DEFAULT AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName 
WHERE #MemPB.ME25 is not null;


-- 50m medley
PRINT N'50m medley';

SET @EventID = (SELECT TOP 1 EventID FROM [Event] WHERE [Event].DistanceID = 2 AND [Event].StrokeID = 5 ) ;

IF @EventID IS NULL RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
    WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
    ,[EventID]
    ,[MemberID]
)
SELECT  #MemPB.ME50, @EventID, [SwimClubMeet].[dbo].Member.MemberID FROM [SwimClubMeet].[dbo].Member
INNER JOIN #MemPB ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName  COLLATE DATABASE_DEFAULT AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName 
WHERE #MemPB.ME50 is not null;
 */

-- 100m medley
PRINT N'100m medley';

SET @EventID = (SELECT TOP 1 EventID FROM [Event] WHERE [Event].DistanceID = 3 AND [Event].StrokeID = 5 ) ;

IF @EventID IS NULL RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
    WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
    ,[EventID]
    ,[MemberID]
)
SELECT  #MemPB.ME100, @EventID, [SwimClubMeet].[dbo].Member.MemberID FROM [SwimClubMeet].[dbo].Member
INNER JOIN #MemPB ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName  COLLATE DATABASE_DEFAULT AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName 
WHERE #MemPB.ME100 is not null;

-- 200m medley
PRINT N'200m medley';

SET @EventID = (SELECT TOP 1 EventID FROM [Event] WHERE [Event].DistanceID = 4 AND [Event].StrokeID = 5 ) ;

IF @EventID IS NULL RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
    WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
    ,[EventID]
    ,[MemberID]
)
SELECT  #MemPB.ME200, @EventID, [SwimClubMeet].[dbo].Member.MemberID FROM [SwimClubMeet].[dbo].Member
INNER JOIN #MemPB ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName  COLLATE DATABASE_DEFAULT AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName 
WHERE #MemPB.ME200 is not null;

-- 400m medley
PRINT N'400m medley';

SET @EventID = (SELECT TOP 1 EventID FROM [Event] WHERE [Event].DistanceID = 5 AND [Event].StrokeID = 5 ) ;

IF @EventID IS NULL RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
    WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
    ,[EventID]
    ,[MemberID]
)
SELECT  #MemPB.ME400, @EventID, [SwimClubMeet].[dbo].Member.MemberID FROM [SwimClubMeet].[dbo].Member
INNER JOIN #MemPB ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName  COLLATE DATABASE_DEFAULT AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName 
WHERE #MemPB.ME400 is not null;

-- Update rows in table '[Nominee]' in schema '[dbo]'
-- INITIALIZE PREDICTIVE DATA

/* 
DECLARE @myTime TIME(7) = '00:00:00';

UPDATE [dbo].[Nominee]
SET
    [TTB] = @myTime,
    [PB] = @myTime,
    AutoBuildFlag = 0
    -- Add more columns and values here
FROM [dbo].[Nominee]
INNER JOIN [Event] ON [dbo].[Nominee].EventID = [Event].EventID 
INNER JOIN [Session] ON [Event].SessionID = [Session].SessionID   
WHERE [Session].SessionID = @SessionID; 

*/

GO










