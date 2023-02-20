USE SCMDataPool
GO

-- Create a new table called '[xlsPB]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[SCMDataPool].[dbo].[xlsPB]', 'U') IS NOT NULL
    DROP TABLE [SCMDataPool].[dbo].[xlsPB]
GO
-- Create the table in the specified schema
CREATE TABLE [SCMDataPool].[dbo].[xlsPB]
(
    [xlsPBID] [int] IDENTITY(1, 1) NOT NULL
    ,xlsMemberID int -- LINK TO xlsMember.ID
  , [FR25] TIME(7) NULL
  , [FR50] TIME(7) NULL
  , [FR100] TIME(7) NULL
  , [FR200] TIME(7) NULL
  , [FR400] TIME(7) NULL

  , [BR25] TIME(7) NULL
  , [BR50] TIME(7) NULL
  , [BR100] TIME(7) NULL
  , [BR200] TIME(7) NULL
  , [BR400] TIME(7) NULL

  , [BA25] TIME(7) NULL
  , [BA50] TIME(7) NULL
  , [BA100] TIME(7) NULL
  , [BA200] TIME(7) NULL
  , [BA400] TIME(7) NULL

  , [BU25] TIME(7) NULL
  , [BU50] TIME(7) NULL
  , [BU100] TIME(7) NULL
  , [BU200] TIME(7) NULL
  , [BU400] TIME(7) NULL

  , [ME25] TIME(7) NULL
  , [ME50] TIME(7) NULL
  , [ME100] TIME(7) NULL
  , [ME200] TIME(7) NULL
  , [ME400] TIME(7) NULL

);

GO

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
    SCMDataPool.dbo.PersonalBest(MemberID, 1,5,GETDATE()) AS ME25,
    SCMDataPool.dbo.PersonalBest(MemberID, 2,5,GETDATE()) AS ME50,
    SCMDataPool.dbo.PersonalBest(MemberID, 3,5,GETDATE()) AS ME100,
    SCMDataPool.dbo.PersonalBest(MemberID, 4,5,GETDATE()) AS ME200,
    SCMDataPool.dbo.PersonalBest(MemberID, 5,5,GETDATE()) AS ME400

INTO #MemPB
FROM [SCMDataPool].[dbo].[Member]
WHERE IsSwimmer = 1;

INSERT INTO [SCMDataPool].[dbo].[xlsPB]
(
    xlsMemberID
    , FR25
    , FR50
    , FR100
    , FR200
    , FR400

    , BR25
    , BR50
    , BR100
    , BR200
    , BR400

    , BA25
    , BA50
    , BA100
    , BA200
    , BA400


    , BU25
    , BU50
    , BU100
    , BU200
    , BU400

    , ME25
    , ME50
    , ME100
    , ME200
    , ME400
)
SELECT 
     [xlsMember].[xlsMemberID]
     ,#MemPB.FR25
     ,#MemPB.FR50
     ,#MemPB.FR100
     ,#MemPB.FR200
     ,#MemPB.FR400
     
     ,#MemPB.BR25
     ,#MemPB.BR50
     ,#MemPB.BR100
     ,#MemPB.BR200
     ,#MemPB.BR400
     
     ,#MemPB.BA25
     ,#MemPB.BA50
     ,#MemPB.BA100
     ,#MemPB.BA200
     ,#MemPB.BA400
     
     ,#MemPB.BU25
     ,#MemPB.BU50
     ,#MemPB.BU100
     ,#MemPB.BU200
     ,#MemPB.BU400

     ,#MemPB.ME25
     ,#MemPB.ME50
     ,#MemPB.ME100
     ,#MemPB.ME200
     ,#MemPB.ME400

FROM [xlsMember]
    INNER JOIN Member ON Member.Firstname COLLATE DATABASE_DEFAULT = xlsMember.FirstName COLLATE DATABASE_DEFAULT
           AND Member.Lastname COLLATE DATABASE_DEFAULT = xlsMember.LastName
    INNER JOIN #MemPB
        ON Member.MemberID = #MemPB.MemberID
;



