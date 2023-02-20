
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
CREATE   FUNCTION [dbo].[TimeToBeat_DEFAULT] (
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

GRANT EXECUTE
    ON OBJECT::[dbo].[TimeToBeat_DEFAULT] TO [SCM_Administrator]
    AS [dbo];


GO

