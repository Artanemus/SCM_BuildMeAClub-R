
-- =============================================
-- Author:		Ben Ambrose
-- Create date: 
-- Description:	returns the member's ABSOLUTE place within an event
-- =============================================
CREATE   PROCEDURE [dbo].[procABSEventPlace]
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

