
-- =============================================
-- Author:		Ben
-- Create date: 21/02/2019
-- Description:	Convert DateTime to Swimming Time
-- =============================================
CREATE   FUNCTION [dbo].[SwimTimeToString] (
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

GRANT EXECUTE
    ON OBJECT::[dbo].[SwimTimeToString] TO [SCM_Guest]
    AS [dbo];


GO

GRANT EXECUTE
    ON OBJECT::[dbo].[SwimTimeToString] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT EXECUTE
    ON OBJECT::[dbo].[SwimTimeToString] TO [SCM_Marshall]
    AS [dbo];


GO

