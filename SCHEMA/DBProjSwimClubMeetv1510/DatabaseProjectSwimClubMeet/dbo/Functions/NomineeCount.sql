
-- =============================================
-- Author:		Ben Ambrose
-- Create date: 13/8/2019
-- Description:	Count the number of nominees wishing to enter the event
-- =============================================
CREATE   FUNCTION [dbo].[NomineeCount] (
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

GRANT EXECUTE
    ON OBJECT::[dbo].[NomineeCount] TO [SCM_Guest]
    AS [dbo];


GO

GRANT EXECUTE
    ON OBJECT::[dbo].[NomineeCount] TO [SCM_Marshall]
    AS [dbo];


GO

GRANT EXECUTE
    ON OBJECT::[dbo].[NomineeCount] TO [SCM_Administrator]
    AS [dbo];


GO

