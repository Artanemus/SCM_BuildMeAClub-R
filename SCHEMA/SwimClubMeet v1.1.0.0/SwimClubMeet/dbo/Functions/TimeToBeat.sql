
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

GRANT EXECUTE
    ON OBJECT::[dbo].[TimeToBeat] TO [SCM_Marshall]
    AS [dbo];
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[TimeToBeat] TO [SCM_Guest]
    AS [dbo];
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[TimeToBeat] TO [SCM_Administrator]
    AS [dbo];
GO

