
-- =============================================
-- Author:		Ben Ambrose
-- Create date: 14/8/2019
-- Description:	Count the number of heats in an event
-- =============================================
CREATE   FUNCTION [dbo].[HeatCount] (
    -- Add the parameters for the function here
    @EventID INT
    )
RETURNS INT
AS
BEGIN
    -- Declare the return variable here
    DECLARE @Result INT

    -- Add the T-SQL statements to compute the return value here
    SELECT @Result = @EventID

    -- Add the T-SQL statements to compute the return value here
    SELECT @Result = Count(HeatIndividual.EventID)
    FROM HeatIndividual
    WHERE HeatIndividual.EventID = @EventID
    GROUP BY HeatIndividual.EventID

    -- Return the result of the function
    RETURN @Result
END

GO

GRANT EXECUTE
    ON OBJECT::[dbo].[HeatCount] TO [SCM_Guest]
    AS [dbo];


GO

GRANT EXECUTE
    ON OBJECT::[dbo].[HeatCount] TO [SCM_Marshall]
    AS [dbo];


GO

GRANT EXECUTE
    ON OBJECT::[dbo].[HeatCount] TO [SCM_Administrator]
    AS [dbo];


GO

