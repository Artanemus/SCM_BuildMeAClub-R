-- =============================================
-- Author:		Ben Ambrose
-- Create date: 28/08/2022
-- Description:	Get the entrants score for a given place.
-- =============================================
CREATE FUNCTION EntrantScore 
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

