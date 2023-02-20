
-- =============================================
-- Author:		Ben Ambrose
-- Create date: 2020.11.04
-- Description:	Find the ABSOLUTE place of the member in the event.
-- =============================================
CREATE   FUNCTION [dbo].[ABSEventPlace] (
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

GRANT EXECUTE
    ON OBJECT::[dbo].[ABSEventPlace] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT EXECUTE
    ON OBJECT::[dbo].[ABSEventPlace] TO [SCM_Guest]
    AS [dbo];


GO

GRANT EXECUTE
    ON OBJECT::[dbo].[ABSEventPlace] TO [SCM_Marshall]
    AS [dbo];


GO

