USE SwimClubMeet;

DECLARE @SessionID AS INT;

PRINT N'SessionID derived from session YEAR 2000';

SET @SessionID =
(
    SELECT TOP 1
           SessionID
    FROM [SwimClubMeet].[dbo].[Session]
    WHERE YEAR([SessionStart]) = 2000
);

IF @SessionID IS NULL
    RETURN;

PRINT N'Calculate personal bests for all members in DataPool';

-- Drop a temporary table called '#MemPB'
-- Drop the table if it already exists
IF OBJECT_ID('tempDB..#MemPB', 'U') IS NOT NULL
    DROP TABLE #MemPB;
-- Create the temporary table from a physical table called 'TableName' in schema 'dbo' in database 'SCMxls'
SELECT [SCMxls].[dbo].[Members].xlsMemberID
     , [SCMxls].[dbo].[Members].FirstName
     , [SCMxls].[dbo].[Members].LastName
     -- FREESTYLE
     , SCMxls.dbo.PersonalBests.FR25
     , SCMxls.dbo.PersonalBests.FR50
     , SCMxls.dbo.PersonalBests.FR100
     , SCMxls.dbo.PersonalBests.FR200
     , SCMxls.dbo.PersonalBests.FR400
     -- BREASTSTROKE
     , SCMxls.dbo.PersonalBests.BR25
     , SCMxls.dbo.PersonalBests.BR50
     , SCMxls.dbo.PersonalBests.BR100
     , SCMxls.dbo.PersonalBests.BR200
     , SCMxls.dbo.PersonalBests.BR400
     -- BACKSTROKE
     , SCMxls.dbo.PersonalBests.BA25
     , SCMxls.dbo.PersonalBests.BA50
     , SCMxls.dbo.PersonalBests.BA100
     , SCMxls.dbo.PersonalBests.BA200
     , SCMxls.dbo.PersonalBests.BA400
     -- BUTTERFLY
     , SCMxls.dbo.PersonalBests.BU25
     , SCMxls.dbo.PersonalBests.BU50
     , SCMxls.dbo.PersonalBests.BU100
     , SCMxls.dbo.PersonalBests.BU200
     , SCMxls.dbo.PersonalBests.BU400
     --MEDLEY
     --SCMxls.dbo.PersonalBests(MemberID, 1,5,GETDATE()) AS ME25,
     --SCMxls.dbo.PersonalBests(MemberID, 2,5,GETDATE()) AS ME50,
     , SCMxls.dbo.PersonalBests.ME100
     , SCMxls.dbo.PersonalBests.ME200
     , SCMxls.dbo.PersonalBests.ME400
INTO #MemPB
FROM [SCMxls].[dbo].[PersonalBests]
    INNER JOIN [SCMxls].[dbo].[Members]
        ON [SCMxls].[dbo].[PersonalBests].[xlsMemberID] = [SCMxls].[dbo].[Members].[xlsMemberID]
WHERE [SCMxls].[dbo].[Members].IsSwimmer = 1;

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

SET @EventID =
(
    SELECT TOP 1
           EventID
    FROM [Event]
    WHERE [Event].DistanceID = 1
          AND [Event].StrokeID = 1
          AND [Event].SessionID = @SessionID
);

IF @EventID IS NULL
    RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
  , [EventID]
  , [MemberID]
)
SELECT #MemPB.FR25
     , @EventID
     , [SwimClubMeet].[dbo].Member.MemberID
FROM [SwimClubMeet].[dbo].Member
    INNER JOIN #MemPB
        ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName COLLATE DATABASE_DEFAULT
           AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName
WHERE #MemPB.FR25 IS NOT NULL AND ([SwimClubMeet].[dbo].SwimTimeToMilliseconds(#MemPB.FR25) > 0);

-- 50m Freestyle
PRINT N'50m freestyle';

SET @EventID =
(
    SELECT TOP 1
           EventID
    FROM [Event]
    WHERE [Event].DistanceID = 2
          AND [Event].StrokeID = 1
          AND [Event].SessionID = @SessionID
);

IF @EventID IS NULL
    RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
  , [EventID]
  , [MemberID]
)
SELECT #MemPB.FR50
     , @EventID
     , [SwimClubMeet].[dbo].Member.MemberID
FROM [SwimClubMeet].[dbo].Member
    INNER JOIN #MemPB
        ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName COLLATE DATABASE_DEFAULT
           AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName
WHERE #MemPB.FR50 IS NOT NULL AND ([SwimClubMeet].[dbo].SwimTimeToMilliseconds(#MemPB.FR50) > 0);

-- 100m Freestyle
PRINT N'100m freestyle';

SET @EventID =
(
    SELECT TOP 1
           EventID
    FROM [Event]
    WHERE [Event].DistanceID = 3
          AND [Event].StrokeID = 1
          AND [Event].SessionID = @SessionID
);

IF @EventID IS NULL
    RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
  , [EventID]
  , [MemberID]
)
SELECT #MemPB.FR100
     , @EventID
     , [SwimClubMeet].[dbo].Member.MemberID
FROM [SwimClubMeet].[dbo].Member
    INNER JOIN #MemPB
        ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName COLLATE DATABASE_DEFAULT
           AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName
WHERE #MemPB.FR100 IS NOT NULL AND ([SwimClubMeet].[dbo].SwimTimeToMilliseconds(#MemPB.FR100) > 0);

-- 200m Freestyle
PRINT N'200m freestyle';

SET @EventID =
(
    SELECT TOP 1
           EventID
    FROM [Event]
    WHERE [Event].DistanceID = 4
          AND [Event].StrokeID = 1
          AND [Event].SessionID = @SessionID
);

IF @EventID IS NULL
    RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
  , [EventID]
  , [MemberID]
)
SELECT #MemPB.FR200
     , @EventID
     , [SwimClubMeet].[dbo].Member.MemberID
FROM [SwimClubMeet].[dbo].Member
    INNER JOIN #MemPB
        ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName COLLATE DATABASE_DEFAULT
           AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName
WHERE #MemPB.FR200 IS NOT NULL AND ([SwimClubMeet].[dbo].SwimTimeToMilliseconds(#MemPB.FR200) > 0);

-- 400m Freestyle
PRINT N'400m freestyle';

SET @EventID =
(
    SELECT TOP 1
           EventID
    FROM [Event]
    WHERE [Event].DistanceID = 5
          AND [Event].StrokeID = 1
          AND [Event].SessionID = @SessionID
);

IF @EventID IS NULL
    RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
  , [EventID]
  , [MemberID]
)
SELECT #MemPB.FR400
     , @EventID
     , [SwimClubMeet].[dbo].Member.MemberID
FROM [SwimClubMeet].[dbo].Member
    INNER JOIN #MemPB
        ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName COLLATE DATABASE_DEFAULT
           AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName
WHERE #MemPB.FR400 IS NOT NULL AND ([SwimClubMeet].[dbo].SwimTimeToMilliseconds(#MemPB.FR400) > 0);

-- *************************************
-- B R E A S T S T R O K E .
-- *************************************
-- 25m Breaststroke
PRINT N'25m breatstroke';

SET @EventID =
(
    SELECT TOP 1
           EventID
    FROM [Event]
    WHERE [Event].DistanceID = 1
          AND [Event].StrokeID = 2
          AND [Event].SessionID = @SessionID
);

IF @EventID IS NULL
    RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
  , [EventID]
  , [MemberID]
)
SELECT #MemPB.BR25
     , @EventID
     , [SwimClubMeet].[dbo].Member.MemberID
FROM [SwimClubMeet].[dbo].Member
    INNER JOIN #MemPB
        ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName COLLATE DATABASE_DEFAULT
           AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName
WHERE #MemPB.BR25 IS NOT NULL AND ([SwimClubMeet].[dbo].SwimTimeToMilliseconds(#MemPB.BR25) > 0);


-- 50m Breaststroke
PRINT N'50m breatstroke';

SET @EventID =
(
    SELECT TOP 1
           EventID
    FROM [Event]
    WHERE [Event].DistanceID = 2
          AND [Event].StrokeID = 2
          AND [Event].SessionID = @SessionID
);

IF @EventID IS NULL
    RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
  , [EventID]
  , [MemberID]
)
SELECT #MemPB.BR50
     , @EventID
     , [SwimClubMeet].[dbo].Member.MemberID
FROM [SwimClubMeet].[dbo].Member
    INNER JOIN #MemPB
        ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName COLLATE DATABASE_DEFAULT
           AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName
WHERE #MemPB.BR50 IS NOT NULL AND ([SwimClubMeet].[dbo].SwimTimeToMilliseconds(#MemPB.BR50) > 0);


-- 100m Breaststroke
PRINT N'100m breatstroke';

SET @EventID =
(
    SELECT TOP 1
           EventID
    FROM [Event]
    WHERE [Event].DistanceID = 3
          AND [Event].StrokeID = 2
          AND [Event].SessionID = @SessionID
);

IF @EventID IS NULL
    RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
  , [EventID]
  , [MemberID]
)
SELECT #MemPB.BR100
     , @EventID
     , [SwimClubMeet].[dbo].Member.MemberID
FROM [SwimClubMeet].[dbo].Member
    INNER JOIN #MemPB
        ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName COLLATE DATABASE_DEFAULT
           AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName
WHERE #MemPB.BR100 IS NOT NULL AND ([SwimClubMeet].[dbo].SwimTimeToMilliseconds(#MemPB.BR100) > 0);

-- 200m Breaststroke
PRINT N'200m breatstroke';

SET @EventID =
(
    SELECT TOP 1
           EventID
    FROM [Event]
    WHERE [Event].DistanceID = 4
          AND [Event].StrokeID = 2
          AND [Event].SessionID = @SessionID
);

IF @EventID IS NULL
    RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
  , [EventID]
  , [MemberID]
)
SELECT #MemPB.BR200
     , @EventID
     , [SwimClubMeet].[dbo].Member.MemberID
FROM [SwimClubMeet].[dbo].Member
    INNER JOIN #MemPB
        ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName COLLATE DATABASE_DEFAULT
           AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName
WHERE #MemPB.BR200 IS NOT NULL AND ([SwimClubMeet].[dbo].SwimTimeToMilliseconds(#MemPB.BR200) > 0);

-- 400m Breaststroke
PRINT N'400m breatstroke';

SET @EventID =
(
    SELECT TOP 1
           EventID
    FROM [Event]
    WHERE [Event].DistanceID = 5
          AND [Event].StrokeID = 2
          AND [Event].SessionID = @SessionID
);

IF @EventID IS NULL
    RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
  , [EventID]
  , [MemberID]
)
SELECT #MemPB.BR400
     , @EventID
     , [SwimClubMeet].[dbo].Member.MemberID
FROM [SwimClubMeet].[dbo].Member
    INNER JOIN #MemPB
        ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName COLLATE DATABASE_DEFAULT
           AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName
WHERE #MemPB.BR400 IS NOT NULL AND ([SwimClubMeet].[dbo].SwimTimeToMilliseconds(#MemPB.BR400) > 0);


-- *************************************
-- B A C K S T R O K E .
-- *************************************
-- 25m backstroke
PRINT N'25m backstroke';

SET @EventID =
(
    SELECT TOP 1
           EventID
    FROM [Event]
    WHERE [Event].DistanceID = 1
          AND [Event].StrokeID = 3
          AND [Event].SessionID = @SessionID
);

IF @EventID IS NULL
    RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
  , [EventID]
  , [MemberID]
)
SELECT #MemPB.BA25
     , @EventID
     , [SwimClubMeet].[dbo].Member.MemberID
FROM [SwimClubMeet].[dbo].Member
    INNER JOIN #MemPB
        ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName COLLATE DATABASE_DEFAULT
           AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName
WHERE #MemPB.BA25 IS NOT NULL AND ([SwimClubMeet].[dbo].SwimTimeToMilliseconds(#MemPB.BA25) > 0);


-- 50m backstroke
PRINT N'50m backstroke';

SET @EventID =
(
    SELECT TOP 1
           EventID
    FROM [Event]
    WHERE [Event].DistanceID = 2
          AND [Event].StrokeID = 3
          AND [Event].SessionID = @SessionID
);

IF @EventID IS NULL
    RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
  , [EventID]
  , [MemberID]
)
SELECT #MemPB.BA50
     , @EventID
     , [SwimClubMeet].[dbo].Member.MemberID
FROM [SwimClubMeet].[dbo].Member
    INNER JOIN #MemPB
        ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName COLLATE DATABASE_DEFAULT
           AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName
WHERE #MemPB.BA50 IS NOT NULL AND ([SwimClubMeet].[dbo].SwimTimeToMilliseconds(#MemPB.BA50) > 0);


-- 100m backstroke
PRINT N'100m backstroke';

SET @EventID =
(
    SELECT TOP 1
           EventID
    FROM [Event]
    WHERE [Event].DistanceID = 3
          AND [Event].StrokeID = 3
          AND [Event].SessionID = @SessionID
);

IF @EventID IS NULL
    RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
  , [EventID]
  , [MemberID]
)
SELECT #MemPB.BA100
     , @EventID
     , [SwimClubMeet].[dbo].Member.MemberID
FROM [SwimClubMeet].[dbo].Member
    INNER JOIN #MemPB
        ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName COLLATE DATABASE_DEFAULT
           AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName
WHERE #MemPB.BA100 IS NOT NULL AND ([SwimClubMeet].[dbo].SwimTimeToMilliseconds(#MemPB.BA100) > 0);

-- 200m backstroke
PRINT N'200m backstroke';

SET @EventID =
(
    SELECT TOP 1
           EventID
    FROM [Event]
    WHERE [Event].DistanceID = 4
          AND [Event].StrokeID = 3
          AND [Event].SessionID = @SessionID
);

IF @EventID IS NULL
    RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
  , [EventID]
  , [MemberID]
)
SELECT #MemPB.BA200
     , @EventID
     , [SwimClubMeet].[dbo].Member.MemberID
FROM [SwimClubMeet].[dbo].Member
    INNER JOIN #MemPB
        ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName COLLATE DATABASE_DEFAULT
           AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName
WHERE #MemPB.BA200 IS NOT NULL AND ([SwimClubMeet].[dbo].SwimTimeToMilliseconds(#MemPB.BA200) > 0);

-- 400m backstroke
PRINT N'400m backstroke';

SET @EventID =
(
    SELECT TOP 1
           EventID
    FROM [Event]
    WHERE [Event].DistanceID = 5
          AND [Event].StrokeID = 3
          AND [Event].SessionID = @SessionID
          AND [Event].SessionID = @SessionID
);

IF @EventID IS NULL
    RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
  , [EventID]
  , [MemberID]
)
SELECT #MemPB.BA400
     , @EventID
     , [SwimClubMeet].[dbo].Member.MemberID
FROM [SwimClubMeet].[dbo].Member
    INNER JOIN #MemPB
        ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName COLLATE DATABASE_DEFAULT
           AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName
WHERE #MemPB.BA400 IS NOT NULL AND ([SwimClubMeet].[dbo].SwimTimeToMilliseconds(#MemPB.BA400) > 0);



-- *************************************
-- B U T T E R F L Y
-- *************************************
-- 25m butterfly
PRINT N'25m butterfly';

SET @EventID =
(
    SELECT TOP 1
           EventID
    FROM [Event]
    WHERE [Event].DistanceID = 1
          AND [Event].StrokeID = 4
          AND [Event].SessionID = @SessionID
);

IF @EventID IS NULL
    RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
  , [EventID]
  , [MemberID]
)
SELECT #MemPB.BU25
     , @EventID
     , [SwimClubMeet].[dbo].Member.MemberID
FROM [SwimClubMeet].[dbo].Member
    INNER JOIN #MemPB
        ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName COLLATE DATABASE_DEFAULT
           AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName
WHERE #MemPB.BU25 IS NOT NULL AND ([SwimClubMeet].[dbo].SwimTimeToMilliseconds(#MemPB.BU25) > 0);


-- 50m butterfly
PRINT N'50m butterfly';

SET @EventID =
(
    SELECT TOP 1
           EventID
    FROM [Event]
    WHERE [Event].DistanceID = 2
          AND [Event].StrokeID = 4
          AND [Event].SessionID = @SessionID
);

IF @EventID IS NULL
    RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
  , [EventID]
  , [MemberID]
)
SELECT #MemPB.BU50
     , @EventID
     , [SwimClubMeet].[dbo].Member.MemberID
FROM [SwimClubMeet].[dbo].Member
    INNER JOIN #MemPB
        ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName COLLATE DATABASE_DEFAULT
           AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName
WHERE #MemPB.BU50 IS NOT NULL AND ([SwimClubMeet].[dbo].SwimTimeToMilliseconds(#MemPB.BU50) > 0);


-- 100m butterfly
PRINT N'100m butterfly';

SET @EventID =
(
    SELECT TOP 1
           EventID
    FROM [Event]
    WHERE [Event].DistanceID = 3
          AND [Event].StrokeID = 4
          AND [Event].SessionID = @SessionID
);

IF @EventID IS NULL
    RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
  , [EventID]
  , [MemberID]
)
SELECT #MemPB.BU100
     , @EventID
     , [SwimClubMeet].[dbo].Member.MemberID
FROM [SwimClubMeet].[dbo].Member
    INNER JOIN #MemPB
        ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName COLLATE DATABASE_DEFAULT
           AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName
WHERE #MemPB.BU100 IS NOT NULL AND ([SwimClubMeet].[dbo].SwimTimeToMilliseconds(#MemPB.BU100) > 0);

-- 200m butterfly
PRINT N'200m butterfly';

SET @EventID =
(
    SELECT TOP 1
           EventID
    FROM [Event]
    WHERE [Event].DistanceID = 4
          AND [Event].StrokeID = 4
          AND [Event].SessionID = @SessionID
);

IF @EventID IS NULL
    RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
  , [EventID]
  , [MemberID]
)
SELECT #MemPB.BU200
     , @EventID
     , [SwimClubMeet].[dbo].Member.MemberID
FROM [SwimClubMeet].[dbo].Member
    INNER JOIN #MemPB
        ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName COLLATE DATABASE_DEFAULT
           AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName
WHERE #MemPB.BU200 IS NOT NULL AND ([SwimClubMeet].[dbo].SwimTimeToMilliseconds(#MemPB.BU200) > 0);

-- 400m butterfly
PRINT N'400m butterfly';

SET @EventID =
(
    SELECT TOP 1
           EventID
    FROM [Event]
    WHERE [Event].DistanceID = 5
          AND [Event].StrokeID = 4
          AND [Event].SessionID = @SessionID
);

IF @EventID IS NULL
    RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
  , [EventID]
  , [MemberID]
)
SELECT #MemPB.BU400
     , @EventID
     , [SwimClubMeet].[dbo].Member.MemberID
FROM [SwimClubMeet].[dbo].Member
    INNER JOIN #MemPB
        ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName COLLATE DATABASE_DEFAULT
           AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName
WHERE #MemPB.BU400 IS NOT NULL AND ([SwimClubMeet].[dbo].SwimTimeToMilliseconds(#MemPB.BU400) > 0);




-- *************************************
-- M E D L E Y
-- *************************************
/* 
-- 25m medley
PRINT N'25m medley';

SET @EventID = (SELECT TOP 1 EventID FROM [Event] WHERE [Event].DistanceID = 1 AND [Event].StrokeID = 5 AND [Event].SessionID = @SessionID ) ;

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
WHERE #MemPB.ME25 is not null AND ([SwimClubMeet].[dbo].SwimTimeToMilliseconds(#MemPB.ME25) > 0);


-- 50m medley
PRINT N'50m medley';

SET @EventID = (SELECT TOP 1 EventID FROM [Event] WHERE [Event].DistanceID = 2 AND [Event].StrokeID = 5 AND [Event].SessionID = @SessionID ) ;

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
WHERE #MemPB.ME50 is not null AND ([SwimClubMeet].[dbo].SwimTimeToMilliseconds(#MemPB.ME50) > 0);
 */

-- 100m medley
PRINT N'100m medley';

SET @EventID =
(
    SELECT TOP 1
           EventID
    FROM [Event]
    WHERE [Event].DistanceID = 3
          AND [Event].StrokeID = 5
          AND [Event].SessionID = @SessionID
);

IF @EventID IS NULL
    RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
  , [EventID]
  , [MemberID]
)
SELECT #MemPB.ME100
     , @EventID
     , [SwimClubMeet].[dbo].Member.MemberID
FROM [SwimClubMeet].[dbo].Member
    INNER JOIN #MemPB
        ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName COLLATE DATABASE_DEFAULT
           AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName
WHERE #MemPB.ME100 IS NOT NULL AND ([SwimClubMeet].[dbo].SwimTimeToMilliseconds(#MemPB.ME100) > 0);

-- 200m medley
PRINT N'200m medley';

SET @EventID =
(
    SELECT TOP 1
           EventID
    FROM [Event]
    WHERE [Event].DistanceID = 4
          AND [Event].StrokeID = 5
          AND [Event].SessionID = @SessionID
);

IF @EventID IS NULL
    RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
  , [EventID]
  , [MemberID]
)
SELECT #MemPB.ME200
     , @EventID
     , [SwimClubMeet].[dbo].Member.MemberID
FROM [SwimClubMeet].[dbo].Member
    INNER JOIN #MemPB
        ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName COLLATE DATABASE_DEFAULT
           AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName
WHERE #MemPB.ME200 IS NOT NULL AND ([SwimClubMeet].[dbo].SwimTimeToMilliseconds(#MemPB.ME200) > 0);

-- 400m medley
PRINT N'400m medley';

SET @EventID =
(
    SELECT TOP 1
           EventID
    FROM [Event]
    WHERE [Event].DistanceID = 5
          AND [Event].StrokeID = 5
          AND [Event].SessionID = @SessionID
);

IF @EventID IS NULL
    RETURN;

DELETE FROM [SwimClubMeet].[dbo].[Nominee]
WHERE EventID = @EventID;

INSERT INTO [SwimClubMeet].[dbo].[Nominee]
(
    [SeedTime]
  , [EventID]
  , [MemberID]
)
SELECT #MemPB.ME400
     , @EventID
     , [SwimClubMeet].[dbo].Member.MemberID
FROM [SwimClubMeet].[dbo].Member
    INNER JOIN #MemPB
        ON [SwimClubMeet].[dbo].Member.Firstname COLLATE DATABASE_DEFAULT = #MemPB.FirstName COLLATE DATABASE_DEFAULT
           AND [SwimClubMeet].[dbo].Member.Lastname COLLATE DATABASE_DEFAULT = #MemPB.LastName
WHERE #MemPB.ME400 IS NOT NULL AND ([SwimClubMeet].[dbo].SwimTimeToMilliseconds(#MemPB.ME400) > 0);

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





