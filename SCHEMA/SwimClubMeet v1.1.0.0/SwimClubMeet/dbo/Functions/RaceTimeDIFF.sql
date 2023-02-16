
-- =============================================
-- Author:		Ben
-- Create date: 21/02/2019
-- Description:	Performance difference in race time vs personal best given in seconds (float)
-- =============================================
CREATE   FUNCTION [dbo].[RaceTimeDIFF] (
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

GRANT EXECUTE
    ON OBJECT::[dbo].[RaceTimeDIFF] TO [SCM_Marshall]
    AS [dbo];
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[RaceTimeDIFF] TO [SCM_Guest]
    AS [dbo];
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[RaceTimeDIFF] TO [SCM_Administrator]
    AS [dbo];
GO

