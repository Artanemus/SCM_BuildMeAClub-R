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
		 'Members Personal Bests seed data.'
		,'2000-01-01 20:00'
		,'2000-01-01 20:30'
		,1
		,1
);

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
    (1,'Seed-event for PB 25mFR',NULL,@SessionID,1,1,1,1),
    (2,'Seed-event for PB 50mFR',NULL,@SessionID,1,1,2,1),
    (3,'Seed-event for PB 100mFR',NULL,@SessionID,1,1,3,1),
    (4,'Seed-event for PB 200mFR',NULL,@SessionID,1,1,4,1),
    (5,'Seed-event for PB 400mFR',NULL,@SessionID,1,1,5,1),
    (6,'Seed-event for PB 1000mFR',NULL,@SessionID,1,1,6,1),
    -- Breaststroke
    (7,'Seed-event for PB 25mBR',NULL,@SessionID,1,2,1,1),
    (8,'Seed-event for PB 50mBR',NULL,@SessionID,1,2,2,1),
    (9,'Seed-event for PB 100mBR',NULL,@SessionID,1,2,3,1),
    (10,'Seed-event for PB 200mBR',NULL,@SessionID,1,2,4,1),
    (11,'Seed-event for PB 400mBR',NULL,@SessionID,1,2,5,1),
    (12,'Seed-event for PB 1000mBR',NULL,@SessionID,1,2,6,1),
    -- Backstroke
    (13,'Seed-event for PB 25mBA',NULL,@SessionID,1,3,1,1),
    (14,'Seed-event for PB 50mBA',NULL,@SessionID,1,3,2,1),
    (15,'Seed-event for PB 100mBA',NULL,@SessionID,1,3,3,1),
    (16,'Seed-event for PB 200mBA',NULL,@SessionID,1,3,4,1),
    (17,'Seed-event for PB 400mBA',NULL,@SessionID,1,3,5,1),
    (18,'Seed-event for PB 1000mBA',NULL,@SessionID,1,3,6,1),
    -- Butterfly
    (19,'Seed-event for PB 25mBU',NULL,@SessionID,1,4,1,1),
    (20,'Seed-event for PB 50mBU',NULL,@SessionID,1,4,2,1),
    (21,'Seed-event for PB 100mBU',NULL,@SessionID,1,4,3,1),
    (22,'Seed-event for PB 200mBU',NULL,@SessionID,1,4,4,1),
    (23,'Seed-event for PB 400mBU',NULL,@SessionID,1,4,5,1),
    (24,'Seed-event for PB 1000mBU',NULL,@SessionID,1,4,6,1),
    -- Medley
    (25,'Seed-event for PB 25mME',NULL,@SessionID,1,5,1,1), -- 25m Medley Nah!
    (26,'Seed-event for PB 50mME',NULL,@SessionID,1,5,2,1), -- 50m Medley Nah!
    (27,'Seed-event for PB 100mME',NULL,@SessionID,1,5,3,1),
    (28,'Seed-event for PB 200mME',NULL,@SessionID,1,5,4,1),
    (29,'Seed-event for PB 400mME',NULL,@SessionID,1,5,5,1),
    (30,'Seed-event for PB 1000mME',NULL,@SessionID,1,5,6,1)
    ;

