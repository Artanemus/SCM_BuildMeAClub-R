USE SwimClubMeet;

DECLARE @SessionID AS INT;
DECLARE @EventNum AS INT;

-- A very basic test to see if BuildMeAClub ran.
-- Do we have raw starting data?
IF NOT EXISTS (SELECT SwimClubID FROM SwimClub WHERE SwimClubID = 1)
RETURN;

INSERT INTO [SwimClubMeet].[dbo].[Session]
(
		 [Caption]
		,[SessionStart]
		,[ClosedDT]
		,[SwimClubID]
		,[SessionStatusID]
)
VALUES
(
		 'Members Personal Best seed-data'
		,'2000-01-01 20:00'
		,'2000-01-01 20:30'
		,1
		,1
)

SET @SessionID = (IDENT_CURRENT('Session'));

/*
    Create every type of event
*/

INSERT INTO [SwimClubMeet].[dbo].[Event]
(
		 [EventNum]
		,[Caption]
		,[ClosedDT]
		,[SessionID]
		,[EventTypeID]
		,[StrokeID]
		,[DistanceID]
		,[EventStatusID]
)
VALUES
    -- Freestyle 
    (1,'Seed-event for Personal Bests',NULL,@SessionID,1,1,1,1),
    (2,'Seed-event for Personal Bests',NULL,@SessionID,1,1,2,1),
    (3,'Seed-event for Personal Bests',NULL,@SessionID,1,1,3,1),
    (4,'Seed-event for Personal Bests',NULL,@SessionID,1,1,4,1),
    (5,'Seed-event for Personal Bests',NULL,@SessionID,1,1,5,1),
    (6,'Seed-event for Personal Bests',NULL,@SessionID,1,1,6,1),
    -- Breaststroke
    (7,'Seed-event for Personal Bests',NULL,@SessionID,1,2,1,1),
    (8,'Seed-event for Personal Bests',NULL,@SessionID,1,2,2,1),
    (9,'Seed-event for Personal Bests',NULL,@SessionID,1,2,3,1),
    (10,'Seed-event for Personal Bests',NULL,@SessionID,1,2,4,1),
    (11,'Seed-event for Personal Bests',NULL,@SessionID,1,2,5,1),
    (12,'Seed-event for Personal Bests',NULL,@SessionID,1,2,6,1),
    -- Backstroke
    (13,'Seed-event for Personal Bests',NULL,@SessionID,1,3,1,1),
    (14,'Seed-event for Personal Bests',NULL,@SessionID,1,3,2,1),
    (15,'Seed-event for Personal Bests',NULL,@SessionID,1,3,3,1),
    (16,'Seed-event for Personal Bests',NULL,@SessionID,1,3,4,1),
    (17,'Seed-event for Personal Bests',NULL,@SessionID,1,3,5,1),
    (18,'Seed-event for Personal Bests',NULL,@SessionID,1,3,6,1),
    -- Butterfly
    (19,'Seed-event for Personal Bests',NULL,@SessionID,1,4,1,1),
    (20,'Seed-event for Personal Bests',NULL,@SessionID,1,4,2,1),
    (21,'Seed-event for Personal Bests',NULL,@SessionID,1,4,3,1),
    (22,'Seed-event for Personal Bests',NULL,@SessionID,1,4,4,1),
    (23,'Seed-event for Personal Bests',NULL,@SessionID,1,4,5,1),
    (24,'Seed-event for Personal Bests',NULL,@SessionID,1,4,6,1),
    -- Medley
    (25,'Seed-event for Personal Bests',NULL,@SessionID,1,5,1,1), -- 25m Medley Nah!
    (26,'Seed-event for Personal Bests',NULL,@SessionID,1,5,2,1), -- 50m Medley Nah!
    (27,'Seed-event for Personal Bests',NULL,@SessionID,1,5,3,1),
    (28,'Seed-event for Personal Bests',NULL,@SessionID,1,5,4,1),
    (29,'Seed-event for Personal Bests',NULL,@SessionID,1,5,5,1),
    (30,'Seed-event for Personal Bests',NULL,@SessionID,1,5,6,1)
    ;

