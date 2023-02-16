
-- =============================================
-- Author:		Ben Ambrpse
-- Create date: 
-- Description:	Swimmer's age at swim club night.
-- =============================================
CREATE   FUNCTION [dbo].[SwimmerAge] (
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

GRANT EXECUTE
    ON OBJECT::[dbo].[SwimmerAge] TO [SCM_Guest]
    AS [dbo];
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[SwimmerAge] TO [SCM_Administrator]
    AS [dbo];
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[SwimmerAge] TO [SCM_Marshall]
    AS [dbo];
GO

