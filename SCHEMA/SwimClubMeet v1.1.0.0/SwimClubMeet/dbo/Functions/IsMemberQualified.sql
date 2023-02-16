-- =============================================
-- Author:		Ben Ambrose
-- Create date: 04/05/22
-- Description:	Is the member qualified to swim the event
-- =============================================
CREATE   FUNCTION [dbo].[IsMemberQualified] 
(
	-- Add the parameters for the function here
	@MemberID int
	,@SeedDate DateTime
	,@DistanceID int
	,@StrokeID int
	
)
RETURNS BIT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result bit;

	DECLARE @IsShortCourse AS BIT;-- calculated (important - uses SwimClubID)
	DECLARE @GenderID AS INT;-- calculated (important - qualification table splits MALE and FEMALE)
	DECLARE @SwimClubID AS INT;-- required (NULL returns no records)
	DECLARE @TrialTimePB AS time(7);

	SET @Result = 0;

	SET @GenderID = (SELECT GenderID FROM dbo.Member WHERE dbo.Member.MemberID = @MemberID) ;

	SET @SwimCLubID = 1;

	-- use todays date
    IF @SeedDate IS NULL
        SET @SeedDate = GETDATE();

	-- any thing under 50 meters is a shortcourse
	SET @IsShortCourse = (
		SELECT CASE 
				WHEN [SwimClub].[LenOfPool] >= 50
					THEN 0
				ELSE 1
				END
		FROM SwimClub
		WHERE SwimClubID = @SwimClubID
		);

	DECLARE @Trail TABLE (
		ID INT identity(1, 1)
		, TrialDistID INT
		, TrialTime time(7)
		);

	INSERT INTO @Trail(TrialDistID, TrialTime)
	SELECT TrialDistID, TrialTime
			FROM Qualify
			WHERE (Qualify.StrokeID = @StrokeID)
				AND (Qualify.QualifyDistID = @DistanceID)
				AND (Qualify.IsShortCourse = @IsShortCourse)
				AND (Qualify.GenderID = @GenderID);


	if EXISTS (SELECT * FROM @Trail) 
		SET @TrialTimePB = (SELECT dbo.PersonalBest(@MemberID, TrialDistID, @StrokeID, @SeedDate) FROM @Trail);
	ELSE 
		RETURN @Result;

	SET @Result =(SELECT IIF(@TrialTimePB <=TrialTime, 1, 0) FROM @Trail); 

	-- Return the result of the function
	RETURN @Result

END
GO

