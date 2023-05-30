USE [master]
GO
/****** Object:  Database [SwimClubMeet]    Script Date: 29/05/23 11:28:59 AM ******/
CREATE DATABASE [SwimClubMeet]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SwimClubMeet', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\SwimClubMeet.mdf' , SIZE = 12480KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'SwimClubMeet_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\SwimClubMeet_log.ldf' , SIZE = 4736KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [SwimClubMeet] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SwimClubMeet].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SwimClubMeet] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SwimClubMeet] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SwimClubMeet] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SwimClubMeet] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SwimClubMeet] SET ARITHABORT OFF 
GO
ALTER DATABASE [SwimClubMeet] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [SwimClubMeet] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SwimClubMeet] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SwimClubMeet] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SwimClubMeet] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SwimClubMeet] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SwimClubMeet] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SwimClubMeet] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SwimClubMeet] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SwimClubMeet] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SwimClubMeet] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SwimClubMeet] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SwimClubMeet] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SwimClubMeet] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SwimClubMeet] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SwimClubMeet] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SwimClubMeet] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SwimClubMeet] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SwimClubMeet] SET  MULTI_USER 
GO
ALTER DATABASE [SwimClubMeet] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SwimClubMeet] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SwimClubMeet] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SwimClubMeet] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [SwimClubMeet] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SwimClubMeet] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [SwimClubMeet] SET QUERY_STORE = OFF
GO
USE [SwimClubMeet]
GO
/****** Object:  User [scmAdmin]    Script Date: 29/05/23 11:28:59 AM ******/
CREATE USER [scmAdmin] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[scmAdmin]
GO
/****** Object:  DatabaseRole [SCM_Marshall]    Script Date: 29/05/23 11:28:59 AM ******/
CREATE ROLE [SCM_Marshall]
GO
/****** Object:  DatabaseRole [SCM_Guest]    Script Date: 29/05/23 11:28:59 AM ******/
CREATE ROLE [SCM_Guest]
GO
/****** Object:  DatabaseRole [SCM_Administrator]    Script Date: 29/05/23 11:28:59 AM ******/
CREATE ROLE [SCM_Administrator]
GO
ALTER ROLE [SCM_Administrator] ADD MEMBER [scmAdmin]
GO
/****** Object:  Schema [scmAdmin]    Script Date: 29/05/23 11:28:59 AM ******/
CREATE SCHEMA [scmAdmin]
GO
/****** Object:  Default [BIT_0]    Script Date: 29/05/23 11:28:59 AM ******/
CREATE DEFAULT [dbo].[BIT_0] 
AS
0
GO
/****** Object:  Default [BIT_1]    Script Date: 29/05/23 11:28:59 AM ******/
CREATE DEFAULT [dbo].[BIT_1] 
AS
1
GO
/****** Object:  Default [Def_INT]    Script Date: 29/05/23 11:28:59 AM ******/
CREATE DEFAULT [dbo].[Def_INT] 
AS
NULL
GO
/****** Object:  Default [Def_NVARCHAR]    Script Date: 29/05/23 11:28:59 AM ******/
CREATE DEFAULT [dbo].[Def_NVARCHAR] 
AS
NULL
GO
/****** Object:  UserDefinedFunction [dbo].[ABSEventPlace]    Script Date: 29/05/23 11:28:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ben Ambrose
-- Create date: 2020.11.04
-- Description:	Find the ABSOLUTE place of the member in the event.
-- =============================================
CREATE    FUNCTION [dbo].[ABSEventPlace] (
    -- Add the parameters for the function here
    @EventID INT
    , @MemberID INT
    )
RETURNS INT
AS
BEGIN
    -- Declare the return variable here
    DECLARE @Result INT;

    WITH CTE_Event (
        Place
        , RaceTime
        , EventID
        , MemberID
        )
    AS (
        SELECT ROW_NUMBER() OVER (
                ORDER BY CASE 
                        WHEN RaceTime IS NULL
                            THEN 1
                        ELSE 0
                        END ASC
                    , CASE 
                        WHEN (CAST(CAST(RaceTime AS DATETIME) AS FLOAT) = 0)
                            THEN 1
                        ELSE 0
                        END ASC
                    , RaceTime ASC
                ) AS Place
            , Entrant.RaceTime
            , Event.EventID
            , Entrant.MemberID
        FROM Event
        INNER JOIN HeatIndividual
            ON Event.EventID = HeatIndividual.EventID
        INNER JOIN Entrant
            ON HeatIndividual.HeatID = Entrant.HeatID
        WHERE Event.EventID = @EventID
            AND MemberID IS NOT NULL
            AND Entrant.IsDisqualified = 0
            AND Entrant.IsScratched = 0
        )
    -- Add the T-SQL statements to compute the return value here
    SELECT @Result = (
            SELECT Place
            FROM CTE_Event
            WHERE CTE_Event.MemberID = @MemberID
            )

    -- Return the result of the function
    RETURN @Result
END
GO
/****** Object:  UserDefinedFunction [dbo].[ABSHeatPlace]    Script Date: 29/05/23 11:28:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ben Ambrose
-- Create date: 2020.11.04
-- Description:	Find the ABSOLUTE place of the member in the heat.
-- =============================================
CREATE  
    

   FUNCTION [dbo].[ABSHeatPlace] (
    -- Add the parameters for the function here
    @HeatID INT
    , @MemberID INT
    )
RETURNS INT
AS
BEGIN
    -- Declare the return variable here
    DECLARE @Result INT;

    WITH CTE_Heat (
        Place
        , RaceTime
        , HeatID
        , MemberID
        )
    AS (
        SELECT ROW_NUMBER() OVER (
                ORDER BY CASE 
                        WHEN RaceTime IS NULL
                            THEN 1
                        ELSE 0
                        END ASC
                    , CASE 
                        WHEN (CAST(CAST(RaceTime AS DATETIME) AS FLOAT) = 0)
                            THEN 1
                        ELSE 0
                        END ASC
                    , RaceTime ASC
                ) AS Place
            , Entrant.RaceTime
            , HeatIndividual.HeatID
            , Entrant.MemberID
        FROM HeatIndividual
        INNER JOIN Entrant
            ON HeatIndividual.HeatID = Entrant.HeatID
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
/****** Object:  UserDefinedFunction [dbo].[EntrantCount]    Script Date: 29/05/23 11:28:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ben Ambrose
-- Create date: 13/8/2019
-- Description:	Count the number of entrants for an event
-- =============================================
CREATE    FUNCTION [dbo].[EntrantCount] (
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
/****** Object:  UserDefinedFunction [dbo].[EntrantScore]    Script Date: 29/05/23 11:28:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ben Ambrose
-- Create date: 28/08/2022
-- Description:	Get the entrants score for a given place.
-- =============================================
CREATE   FUNCTION [dbo].[EntrantScore] 
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
/****** Object:  UserDefinedFunction [dbo].[HeatCount]    Script Date: 29/05/23 11:28:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ben Ambrose
-- Create date: 14/8/2019
-- Description:	Count the number of heats in an event
-- =============================================
CREATE    FUNCTION [dbo].[HeatCount] (
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
/****** Object:  UserDefinedFunction [dbo].[IsMemberNominated]    Script Date: 29/05/23 11:28:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ben Ambrose
-- Create date: 25/05/2022
-- Description:	Is the member nominated for the event
-- =============================================
CREATE FUNCTION [dbo].[IsMemberNominated] 
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
/****** Object:  UserDefinedFunction [dbo].[IsMemberQualified]    Script Date: 29/05/23 11:28:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ben Ambrose
-- Create date: 04/05/22
-- Description:	Is the member qualified to swim the event
-- =============================================
CREATE    FUNCTION [dbo].[IsMemberQualified] 
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

	SET @Result =(SELECT IIF(@TrialTimePB <=TrialTime, 1, 0) FROM @Trail); 

	-- Return the result of the function
	RETURN @Result

END
GO
/****** Object:  UserDefinedFunction [dbo].[IsPoolShortCourse]    Script Date: 29/05/23 11:28:59 AM ******/
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
CREATE    FUNCTION [dbo].[IsPoolShortCourse] (
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
    -- @Result = 0
    -- Return the result of the function
    RETURN @Result
END
GO
/****** Object:  UserDefinedFunction [dbo].[NomineeCount]    Script Date: 29/05/23 11:28:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ben Ambrose
-- Create date: 13/8/2019
-- Description:	Count the number of nominees wishing to enter the event
-- =============================================
CREATE    FUNCTION [dbo].[NomineeCount] (
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
/****** Object:  UserDefinedFunction [dbo].[PersonalBest]    Script Date: 29/05/23 11:28:59 AM ******/
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
CREATE  
    

   FUNCTION [dbo].[PersonalBest] (
    -- Add the parameters for the function here
    @MemberID INT
    , @DistanceID INT
    , @StrokeID INT
    , @SessionDate DATETIME = NULL
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
    INNER JOIN HeatIndividual
        ON Entrant.HeatID = HeatIndividual.HeatID
    INNER JOIN Event
        ON HeatIndividual.EventID = Event.EventID
    INNER JOIN Session
        ON Event.SessionID = Session.SessionID
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
/****** Object:  UserDefinedFunction [dbo].[RaceTimeDIFF]    Script Date: 29/05/23 11:28:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ben
-- Create date: 21/02/2019
-- Description:	Performance difference in race time vs personal best given in seconds (float)
-- =============================================
CREATE    FUNCTION [dbo].[RaceTimeDIFF] (
    -- Add the parameters for the function here
    @RaceTime TIME(7)
    , @PersonalBest TIME(7)
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
/****** Object:  UserDefinedFunction [dbo].[RELEventPlace]    Script Date: 29/05/23 11:28:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ben Ambrose
-- Create date: 2020.11.04
-- Description:	Find the place of the member in the event relative to a given division.
-- =============================================
CREATE  
    

   FUNCTION [dbo].[RELEventPlace] (
    -- Add the parameters for the function here
    @EventID INT
    , @MemberID INT
    , @DivisionID INT
    , @SessionStart DATETIME
    )
RETURNS INT
AS
BEGIN
    -- Declare the return variable here
    DECLARE @Result INT;
    DECLARE @TempTBL TABLE (
        MemberID INT
        , ScoreDivisionID INT
        );

    INSERT INTO @TempTBL
    SELECT Member.MemberID
        , ScoreDivisionID
    FROM ScoreDivision
    JOIN Member
        ON ScoreDivision.GenderID = Member.GenderID
    WHERE dbo.SwimmerAge(@SessionStart, Member.DOB) <= AgeTo
        AND dbo.SwimmerAge(@SessionStart, Member.DOB) >= AgeFrom;

    WITH CTE_Event (
        Place
        , MemberID
        )
    AS (
        SELECT ROW_NUMBER() OVER (
                ORDER BY CASE 
                        WHEN RaceTime IS NULL
                            THEN 1
                        ELSE 0
                        END ASC
                    , CASE 
                        WHEN (CAST(CAST(RaceTime AS DATETIME) AS FLOAT) = 0)
                            THEN 1
                        ELSE 0
                        END ASC
                    , RaceTime ASC
                ) AS Place
            , Entrant.MemberID
        FROM Event
        INNER JOIN HeatIndividual
            ON Event.EventID = HeatIndividual.EventID
        INNER JOIN Entrant
            ON HeatIndividual.HeatID = Entrant.HeatID
        LEFT JOIN @TempTBL
            ON Entrant.MemberID = [@TempTBL].[MemberID]
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
/****** Object:  UserDefinedFunction [dbo].[RELHeatPlace]    Script Date: 29/05/23 11:28:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ben Ambrose
-- Create date: 2020.11.04
-- Description:	Find the place of the member in the heat relative to a given division.
-- =============================================
CREATE  
    

   FUNCTION [dbo].[RELHeatPlace] (
    -- Add the parameters for the function here
    @HeatID INT
    , @MemberID INT
    , @DivisionID INT
    , @SessionStart DATETIME
    )
RETURNS INT
AS
BEGIN
    -- Declare the return variable here
    DECLARE @Result INT
    DECLARE @TempTBL TABLE (
        MemberID INT
        , ScoreDivisionID INT
        );

    INSERT INTO @TempTBL
    SELECT Member.MemberID
        , ScoreDivisionID
    FROM ScoreDivision
    JOIN Member
        ON ScoreDivision.GenderID = Member.GenderID
    WHERE dbo.SwimmerAge(@SessionStart, Member.DOB) <= AgeTo
        AND dbo.SwimmerAge(@SessionStart, Member.DOB) >= AgeFrom;

    WITH CTE_Event (
        Place
        , MemberID
        )
    AS (
        SELECT ROW_NUMBER() OVER (
                ORDER BY CASE 
                        WHEN RaceTime IS NULL
                            THEN 1
                        ELSE 0
                        END ASC
                    , CASE 
                        WHEN (CAST(CAST(RaceTime AS DATETIME) AS FLOAT) = 0)
                            THEN 1
                        ELSE 0
                        END ASC
                    , RaceTime ASC
                ) AS Place
            , Entrant.MemberID
        FROM HeatIndividual
        INNER JOIN Entrant
            ON HeatIndividual.HeatID = Entrant.HeatID
        LEFT JOIN @TempTBL
            ON Entrant.MemberID = [@TempTBL].[MemberID]
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
/****** Object:  UserDefinedFunction [dbo].[SessionEntrantCount]    Script Date: 29/05/23 11:28:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ben Ambrose
-- Create date: 15/11/2019
-- Description:	Count the number of entrants in a given session
-- =============================================
CREATE    FUNCTION [dbo].[SessionEntrantCount] (
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
    INNER JOIN HeatIndividual
        ON Entrant.HeatID = HeatIndividual.HeatID
    INNER JOIN Event
        ON HeatIndividual.EventID = Event.EventID
    WHERE (Event.SessionID = @SessionID)
        AND (Entrant.MemberID > 0)

    -- Return the result of the function
    RETURN @Result
END
GO
/****** Object:  UserDefinedFunction [dbo].[SessionNomineeCount]    Script Date: 29/05/23 11:28:59 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- =============================================
-- Author:		Ben Ambrose
-- Create date: 15/11/2019
-- Description:	Count the number of Nominees for a give session
-- =============================================
CREATE    FUNCTION [dbo].[SessionNomineeCount] (
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
    INNER JOIN Event
        ON Nominee.EventID = Event.EventID
    WHERE (Event.SessionID = @SessionID);

    -- Return the result of the function
    RETURN @Result
END
GO
/****** Object:  UserDefinedFunction [dbo].[SwimmerAge]    Script Date: 29/05/23 11:28:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ben Ambrpse
-- Create date: 
-- Description:	Swimmer's age at swim club night.
-- =============================================
CREATE    FUNCTION [dbo].[SwimmerAge] (
    -- Add the parameters for the function here
    @SessionStart DATETIME
    , @DOB DATETIME
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
/****** Object:  UserDefinedFunction [dbo].[SwimmerGenderToString]    Script Date: 29/05/23 11:28:59 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- =============================================
-- Author:		Ben
-- Create date: 21/02/2019
-- Description:	Return the gender of the meber as a short string
-- =============================================
CREATE    FUNCTION [dbo].[SwimmerGenderToString] (
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
/****** Object:  UserDefinedFunction [dbo].[SwimTimeToMilliseconds]    Script Date: 29/05/23 11:28:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ben Ambrose
-- Create date: 9/8/2019
-- Description:	SwimTime to Milliseconds
-- =============================================
CREATE    FUNCTION [dbo].[SwimTimeToMilliseconds] (
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
/****** Object:  UserDefinedFunction [dbo].[SwimTimeToString]    Script Date: 29/05/23 11:28:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ben
-- Create date: 21/02/2019
-- Description:	Convert DateTime to Swimming Time
-- =============================================
CREATE    FUNCTION [dbo].[SwimTimeToString] (
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
/****** Object:  UserDefinedFunction [dbo].[TimeToBeat]    Script Date: 29/05/23 11:28:59 AM ******/
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
CREATE  
    

   FUNCTION [dbo].[TimeToBeat] (
    -- Add the parameters for the function here
    @algorithm INT
    , @CalcDefault INT = 1
    , @Percent FLOAT = 50.0
    , @MemberID INT
    , @DistanceID INT
    , @StrokeID INT
    , @SessionDate DATETIME = NULL
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
/****** Object:  UserDefinedFunction [dbo].[TimeToBeat_1]    Script Date: 29/05/23 11:28:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE    FUNCTION [dbo].[TimeToBeat_1] (
    -- Add the parameters for the function here
    @MemberID INT
    , @DistanceID INT
    , @StrokeID INT
    , @SessionDate DATETIME = NULL
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
    INNER JOIN HeatIndividual
        ON Entrant.HeatID = HeatIndividual.HeatID
    INNER JOIN Event
        ON HeatIndividual.EventID = Event.EventID
    INNER JOIN Session
        ON Event.SessionID = Session.SessionID
    WHERE (Entrant.RaceTime IS NOT NULL)
        AND (Entrant.IsDisqualified <> 1) -- added 16/5/2020
        AND (Entrant.IsScratched <> 1) -- added 16/5/2020
        AND (Entrant.MemberID = @MEMBERID)
        AND (Session.SessionStart < @SESSIONDATE)
        AND Event.DistanceID = @DISTANCEID
        AND Event.StrokeID = @STROKEID
    ORDER BY Session.SessionStart DESC
        , Entrant.RaceTime ASC

    -- Return the result of the function
    RETURN @Result
END
GO
/****** Object:  UserDefinedFunction [dbo].[TimeToBeat_2]    Script Date: 29/05/23 11:28:59 AM ******/
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
CREATE    FUNCTION [dbo].[TimeToBeat_2] (
    -- Add the parameters for the function here
    @MemberID INT
    , @DistanceID INT
    , @StrokeID INT
    , @SessionDate DATETIME
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
        SELECT TOP (3) [Event].DistanceID
            , [Event].StrokeID
            , Entrant.RaceTime
            , Entrant.MemberID
        FROM Entrant
        INNER JOIN HeatIndividual
            ON Entrant.HeatID = HeatIndividual.HeatID
        INNER JOIN [Event]
            ON HeatIndividual.EventID = [Event].EventID
        INNER JOIN [Session]
            ON [Event].SessionID = [Session].SessionID
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
/****** Object:  UserDefinedFunction [dbo].[TimeToBeat_DEFAULT]    Script Date: 29/05/23 11:28:59 AM ******/
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
CREATE    FUNCTION [dbo].[TimeToBeat_DEFAULT] (
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
    INSERT INTO @Temp (RT)
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

    SET @BottomNum = (
            SELECT COUNT(*)
            FROM @Temp
            );

    -- Sample set is too small! 
    -- Look for members who are of a different gender
    -- and add them to the list.
    IF (@BottomNum < @MinSampleSize)
        INSERT INTO @Temp (RT)
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
        INSERT INTO @Temp (RT)
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
    INSERT INTO @Temp2 (RT)
    -- NOTE: ErStudio unable to validate use of PARAM - throws error
    SELECT TOP (CONVERT(INT, @BottomNum)) RT
    FROM @Temp
    ORDER BY RT DESC;

    -- Get the average time for the bottom (50) percent
    -- Final assignment - converted to TIME value
    SET @Result = CAST(CAST((
                    SELECT AVG(RT) AS RTfloat
                    FROM @Temp2
                    ) AS DATETIME) AS TIME);

    RETURN @Result;
END
GO
/****** Object:  Table [dbo].[ContactNum]    Script Date: 29/05/23 11:28:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactNum](
	[ContactNumID] [int] IDENTITY(1,1) NOT NULL,
	[Number] [nvarchar](30) NULL,
	[ContactNumTypeID] [int] NULL,
	[MemberID] [int] NULL,
	[IsArchived] [bit] NOT NULL,
	[CreatedOn] [datetime] NULL,
 CONSTRAINT [PK_ContactNum] PRIMARY KEY CLUSTERED 
(
	[ContactNumID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContactNumType]    Script Date: 29/05/23 11:28:59 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Distance]    Script Date: 29/05/23 11:28:59 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Entrant]    Script Date: 29/05/23 11:28:59 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Event]    Script Date: 29/05/23 11:28:59 AM ******/
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
	[ScheduleDT] [time](7) NULL,
 CONSTRAINT [PK_Event] PRIMARY KEY NONCLUSTERED 
(
	[EventID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EventStatus]    Script Date: 29/05/23 11:28:59 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EventType]    Script Date: 29/05/23 11:28:59 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Gender]    Script Date: 29/05/23 11:28:59 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HeatIndividual]    Script Date: 29/05/23 11:28:59 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HeatStatus]    Script Date: 29/05/23 11:28:59 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HeatTeam]    Script Date: 29/05/23 11:28:59 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HeatType]    Script Date: 29/05/23 11:28:59 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[House]    Script Date: 29/05/23 11:28:59 AM ******/
SET ANSI_NULLS ON
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
	[LogoType] [nvarchar](5) NULL,
	[IsArchived] [bit] NOT NULL,
	[CreatedOn] [datetime] NULL,
 CONSTRAINT [PK_House] PRIMARY KEY CLUSTERED 
(
	[HouseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member]    Script Date: 29/05/23 11:28:59 AM ******/
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
	[IsActive] [bit] NULL,
	[IsArchived] [bit] NULL,
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
	[IsSwimmer] [bit] NULL,
 CONSTRAINT [PK_Member] PRIMARY KEY NONCLUSTERED 
(
	[MemberID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MembershipType]    Script Date: 29/05/23 11:28:59 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Nominee]    Script Date: 29/05/23 11:28:59 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Qualify]    Script Date: 29/05/23 11:28:59 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SCMSystem]    Script Date: 29/05/23 11:28:59 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ScoreDivision]    Script Date: 29/05/23 11:28:59 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ScorePoints]    Script Date: 29/05/23 11:28:59 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Session]    Script Date: 29/05/23 11:28:59 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SessionStatus]    Script Date: 29/05/23 11:28:59 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Split]    Script Date: 29/05/23 11:28:59 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Stroke]    Script Date: 29/05/23 11:28:59 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SwimClub]    Script Date: 29/05/23 11:28:59 AM ******/
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
	[LogoDir] [varchar](max) NULL,
	[LogoImg] [image] NULL,
	[LogoType] [nvarchar](5) NULL,
 CONSTRAINT [PK_SwimClub] PRIMARY KEY NONCLUSTERED 
(
	[SwimClubID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Team]    Script Date: 29/05/23 11:28:59 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TeamEntrant]    Script Date: 29/05/23 11:28:59 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TeamSplit]    Script Date: 29/05/23 11:28:59 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
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
ALTER TABLE [dbo].[ContactNum]  WITH CHECK ADD  CONSTRAINT [ContactNumTypeContactNum] FOREIGN KEY([ContactNumTypeID])
REFERENCES [dbo].[ContactNumType] ([ContactNumTypeID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[ContactNum] CHECK CONSTRAINT [ContactNumTypeContactNum]
GO
ALTER TABLE [dbo].[ContactNum]  WITH CHECK ADD  CONSTRAINT [MemberContactNum] FOREIGN KEY([MemberID])
REFERENCES [dbo].[Member] ([MemberID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ContactNum] CHECK CONSTRAINT [MemberContactNum]
GO
ALTER TABLE [dbo].[Entrant]  WITH CHECK ADD  CONSTRAINT [HeatIndividualEntrant] FOREIGN KEY([HeatID])
REFERENCES [dbo].[HeatIndividual] ([HeatID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Entrant] CHECK CONSTRAINT [HeatIndividualEntrant]
GO
ALTER TABLE [dbo].[Entrant]  WITH NOCHECK ADD  CONSTRAINT [MemberEntrant] FOREIGN KEY([MemberID])
REFERENCES [dbo].[Member] ([MemberID])
ON DELETE SET NULL
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[Entrant] CHECK CONSTRAINT [MemberEntrant]
GO
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [DistanceEvent] FOREIGN KEY([DistanceID])
REFERENCES [dbo].[Distance] ([DistanceID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [DistanceEvent]
GO
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [EventStatusEvent] FOREIGN KEY([EventStatusID])
REFERENCES [dbo].[EventStatus] ([EventStatusID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [EventStatusEvent]
GO
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [EventTypeEvent] FOREIGN KEY([EventTypeID])
REFERENCES [dbo].[EventType] ([EventTypeID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [EventTypeEvent]
GO
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [SessionEvent] FOREIGN KEY([SessionID])
REFERENCES [dbo].[Session] ([SessionID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [SessionEvent]
GO
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [StrokeEvent] FOREIGN KEY([StrokeID])
REFERENCES [dbo].[Stroke] ([StrokeID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [StrokeEvent]
GO
ALTER TABLE [dbo].[HeatIndividual]  WITH CHECK ADD  CONSTRAINT [EventHeatIndividual] FOREIGN KEY([EventID])
REFERENCES [dbo].[Event] ([EventID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[HeatIndividual] CHECK CONSTRAINT [EventHeatIndividual]
GO
ALTER TABLE [dbo].[HeatIndividual]  WITH CHECK ADD  CONSTRAINT [HeatStatusHeatIndividual] FOREIGN KEY([HeatStatusID])
REFERENCES [dbo].[HeatStatus] ([HeatStatusID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[HeatIndividual] CHECK CONSTRAINT [HeatStatusHeatIndividual]
GO
ALTER TABLE [dbo].[HeatIndividual]  WITH CHECK ADD  CONSTRAINT [HeatTypeHeatIndividual] FOREIGN KEY([HeatTypeID])
REFERENCES [dbo].[HeatType] ([HeatTypeID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[HeatIndividual] CHECK CONSTRAINT [HeatTypeHeatIndividual]
GO
ALTER TABLE [dbo].[HeatTeam]  WITH CHECK ADD  CONSTRAINT [EventHeatTeam] FOREIGN KEY([EventID])
REFERENCES [dbo].[Event] ([EventID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[HeatTeam] CHECK CONSTRAINT [EventHeatTeam]
GO
ALTER TABLE [dbo].[HeatTeam]  WITH CHECK ADD  CONSTRAINT [HeatStatusHeatTeam] FOREIGN KEY([HeatStatusID])
REFERENCES [dbo].[HeatStatus] ([HeatStatusID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[HeatTeam] CHECK CONSTRAINT [HeatStatusHeatTeam]
GO
ALTER TABLE [dbo].[HeatTeam]  WITH CHECK ADD  CONSTRAINT [HeatTypeHeatTeam] FOREIGN KEY([HeatTypeID])
REFERENCES [dbo].[HeatType] ([HeatTypeID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[HeatTeam] CHECK CONSTRAINT [HeatTypeHeatTeam]
GO
ALTER TABLE [dbo].[Member]  WITH CHECK ADD  CONSTRAINT [GenderMember] FOREIGN KEY([GenderID])
REFERENCES [dbo].[Gender] ([GenderID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Member] CHECK CONSTRAINT [GenderMember]
GO
ALTER TABLE [dbo].[Member]  WITH CHECK ADD  CONSTRAINT [HouseMember] FOREIGN KEY([HouseID])
REFERENCES [dbo].[House] ([HouseID])
GO
ALTER TABLE [dbo].[Member] CHECK CONSTRAINT [HouseMember]
GO
ALTER TABLE [dbo].[Member]  WITH CHECK ADD  CONSTRAINT [MembershipTypeMember] FOREIGN KEY([MembershipTypeID])
REFERENCES [dbo].[MembershipType] ([MembershipTypeID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Member] CHECK CONSTRAINT [MembershipTypeMember]
GO
ALTER TABLE [dbo].[Member]  WITH CHECK ADD  CONSTRAINT [SwimClubMember] FOREIGN KEY([SwimClubID])
REFERENCES [dbo].[SwimClub] ([SwimClubID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Member] CHECK CONSTRAINT [SwimClubMember]
GO
ALTER TABLE [dbo].[Nominee]  WITH CHECK ADD  CONSTRAINT [EventNominee] FOREIGN KEY([EventID])
REFERENCES [dbo].[Event] ([EventID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Nominee] CHECK CONSTRAINT [EventNominee]
GO
ALTER TABLE [dbo].[Nominee]  WITH CHECK ADD  CONSTRAINT [MemberNominee] FOREIGN KEY([MemberID])
REFERENCES [dbo].[Member] ([MemberID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Nominee] CHECK CONSTRAINT [MemberNominee]
GO
ALTER TABLE [dbo].[Qualify]  WITH CHECK ADD  CONSTRAINT [DistanceQual31] FOREIGN KEY([QualifyDistID])
REFERENCES [dbo].[Distance] ([DistanceID])
GO
ALTER TABLE [dbo].[Qualify] CHECK CONSTRAINT [DistanceQual31]
GO
ALTER TABLE [dbo].[Qualify]  WITH CHECK ADD  CONSTRAINT [DistanceQualify] FOREIGN KEY([TrialDistID])
REFERENCES [dbo].[Distance] ([DistanceID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Qualify] CHECK CONSTRAINT [DistanceQualify]
GO
ALTER TABLE [dbo].[Qualify]  WITH CHECK ADD  CONSTRAINT [GenderQualify] FOREIGN KEY([GenderID])
REFERENCES [dbo].[Gender] ([GenderID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Qualify] CHECK CONSTRAINT [GenderQualify]
GO
ALTER TABLE [dbo].[Qualify]  WITH CHECK ADD  CONSTRAINT [StrokeQualify] FOREIGN KEY([StrokeID])
REFERENCES [dbo].[Stroke] ([StrokeID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Qualify] CHECK CONSTRAINT [StrokeQualify]
GO
ALTER TABLE [dbo].[ScoreDivision]  WITH CHECK ADD  CONSTRAINT [GenderScoreDivision] FOREIGN KEY([GenderID])
REFERENCES [dbo].[Gender] ([GenderID])
GO
ALTER TABLE [dbo].[ScoreDivision] CHECK CONSTRAINT [GenderScoreDivision]
GO
ALTER TABLE [dbo].[ScoreDivision]  WITH CHECK ADD  CONSTRAINT [SwimClubScoreDivision] FOREIGN KEY([SwimClubID])
REFERENCES [dbo].[SwimClub] ([SwimClubID])
GO
ALTER TABLE [dbo].[ScoreDivision] CHECK CONSTRAINT [SwimClubScoreDivision]
GO
ALTER TABLE [dbo].[ScorePoints]  WITH CHECK ADD  CONSTRAINT [SwimClubScorePoints] FOREIGN KEY([SwimClubID])
REFERENCES [dbo].[SwimClub] ([SwimClubID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ScorePoints] CHECK CONSTRAINT [SwimClubScorePoints]
GO
ALTER TABLE [dbo].[Session]  WITH CHECK ADD  CONSTRAINT [SessionStatusSession] FOREIGN KEY([SessionStatusID])
REFERENCES [dbo].[SessionStatus] ([SessionStatusID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Session] CHECK CONSTRAINT [SessionStatusSession]
GO
ALTER TABLE [dbo].[Session]  WITH CHECK ADD  CONSTRAINT [SwimClubSession] FOREIGN KEY([SwimClubID])
REFERENCES [dbo].[SwimClub] ([SwimClubID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Session] CHECK CONSTRAINT [SwimClubSession]
GO
ALTER TABLE [dbo].[Split]  WITH CHECK ADD  CONSTRAINT [EntrantSplit] FOREIGN KEY([EntrantID])
REFERENCES [dbo].[Entrant] ([EntrantID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Split] CHECK CONSTRAINT [EntrantSplit]
GO
ALTER TABLE [dbo].[Team]  WITH CHECK ADD  CONSTRAINT [HeatTeamTeam] FOREIGN KEY([HeatID])
REFERENCES [dbo].[HeatTeam] ([HeatID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Team] CHECK CONSTRAINT [HeatTeamTeam]
GO
ALTER TABLE [dbo].[TeamEntrant]  WITH CHECK ADD  CONSTRAINT [MemberTeamEntrant] FOREIGN KEY([MemberID])
REFERENCES [dbo].[Member] ([MemberID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[TeamEntrant] CHECK CONSTRAINT [MemberTeamEntrant]
GO
ALTER TABLE [dbo].[TeamEntrant]  WITH CHECK ADD  CONSTRAINT [StrokeTeamEntrant] FOREIGN KEY([StrokeID])
REFERENCES [dbo].[Stroke] ([StrokeID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[TeamEntrant] CHECK CONSTRAINT [StrokeTeamEntrant]
GO
ALTER TABLE [dbo].[TeamEntrant]  WITH CHECK ADD  CONSTRAINT [TeamTeamEntrant] FOREIGN KEY([TeamID])
REFERENCES [dbo].[Team] ([TeamID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TeamEntrant] CHECK CONSTRAINT [TeamTeamEntrant]
GO
ALTER TABLE [dbo].[TeamSplit]  WITH CHECK ADD  CONSTRAINT [TeamEntrantTeamSplit] FOREIGN KEY([TeamEntrantID])
REFERENCES [dbo].[TeamEntrant] ([TeamEntrantID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TeamSplit] CHECK CONSTRAINT [TeamEntrantTeamSplit]
GO
/****** Object:  StoredProcedure [dbo].[procABSEventPlace]    Script Date: 29/05/23 11:28:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ben Ambrose
-- Create date: 
-- Description:	returns the member's ABSOLUTE place within an event
-- =============================================
CREATE    PROCEDURE [dbo].[procABSEventPlace]
    -- Add the parameters for the stored procedure here
    @MemberID INT = 0
    , @EventID INT = 0
    -- RAD PARAM Input/Output
    , @Place INT = 0 OUTPUT -- (omit line or OUTPUT for RESULT SET)
    , @Points FLOAT = 0 OUTPUT -- (omit line or OUTPUT for RESULT SET)
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    IF OBJECT_ID('tempdb..#tmpWk', 'U') IS NOT NULL
        DROP TABLE #tmpWk;

    -- build an ordered list of entrants with placings
    SELECT Event.EventID
        , Entrant.MemberID
        , Entrant.RaceTime
        --,ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) as  Place
        , ROW_NUMBER() OVER (
            ORDER BY Entrant.RaceTime ASC
            ) AS Place
    INTO #tmpWk
    FROM Event
    INNER JOIN HeatIndividual
        ON Event.EventID = HeatIndividual.EventID
    INNER JOIN Entrant
        ON HeatIndividual.HeatID = Entrant.HeatID
    WHERE (Event.EventID = @EventID)
        AND (NOT (Entrant.RaceTime IS NULL))
        AND (Entrant.IsDisqualified <> 1)
        AND (Entrant.IsScratched <> 1)
        AND (Event.EventStatusID = 2)
        -- ORDER BY Entrant.RaceTime DESC
        ;

    -- syntax for ... RESULT SET
    -- SELECT #tmpWk.Place, ScorePoints.Points
    -- syntax for ... RAD ParamFieldName("") or SQL DECLARED param   
    -- Insert statements for procedure here
    SELECT @Place = #tmpWk.Place
        , @Points = ScorePoints.Points
    FROM #tmpWk
    INNER JOIN ScorePoints
        ON #tmpWk.Place = ScorePoints.Place
    WHERE #tmpWk.MemberID = @MemberID;

    DROP TABLE #tmpWk;

    RETURN
END
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
USE [master]
GO
ALTER DATABASE [SwimClubMeet] SET  READ_WRITE 
GO
