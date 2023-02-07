USE SwimClubMeet;

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
    nominate memer to event
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





