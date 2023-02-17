-- =============================================
-- Author:		Ben Ambrose
-- Create date: 25/05/2022
-- Description:	Is the member nominated for the event
-- =============================================
CREATE FUNCTION [dbo].[IsMemberNominated] 
(
	-- Add the parameters for the function here
	@MemberID int
	,@EventID int
)
RETURNS Bit
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result Bit

	-- Add the T-SQL statements to compute the return value here
    SELECT @Result = (
            SELECT CASE 
                    WHEN [NomineeID] IS NOT NULL
                        THEN 0
                    ELSE 1
                    END
            FROM Nominee
            WHERE MemberID = @MemberID AND EventID = @EventID
            )

	-- Return the result of the function
	RETURN @Result

END

GO

