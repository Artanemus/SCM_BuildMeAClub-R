
-- =============================================
-- Author:		Ben Ambrose
-- Create date: 4.10.2020
-- Modified date: 6.3.2022
-- Description:	Is the club's swimming pool a ShortCourse
-- =============================================
CREATE   FUNCTION [dbo].[IsPoolShortCourse] (
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

GRANT EXECUTE
    ON OBJECT::[dbo].[IsPoolShortCourse] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT EXECUTE
    ON OBJECT::[dbo].[IsPoolShortCourse] TO [SCM_Marshall]
    AS [dbo];


GO

GRANT EXECUTE
    ON OBJECT::[dbo].[IsPoolShortCourse] TO [SCM_Guest]
    AS [dbo];


GO

