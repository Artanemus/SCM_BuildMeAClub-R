CREATE TABLE [dbo].[SwimClub] (
    [SwimClubID]          INT            IDENTITY (1, 1) NOT NULL,
    [NickName]            NVARCHAR (128) NULL,
    [Caption]             NVARCHAR (128) NULL,
    [Email]               NVARCHAR (128) NULL,
    [ContactNum]          NVARCHAR (30)  NULL,
    [WebSite]             NVARCHAR (256) NULL,
    [HeatAlgorithm]       INT            NULL,
    [EnableTeamEvents]    BIT            CONSTRAINT [DF__SwimClub__Enable__403A8C7D] DEFAULT ((0)) NULL,
    [EnableSwimOThon]     BIT            CONSTRAINT [DF__SwimClub__Enable__412EB0B6] DEFAULT ((0)) NULL,
    [EnableExtHeatTypes]  BIT            CONSTRAINT [DF__SwimClub__Enable__4222D4EF] DEFAULT ((0)) NULL,
    [EnableMembershipStr] BIT            CONSTRAINT [DF__SwimClub__Enable__4316F928] DEFAULT ((0)) NULL,
    [NumOfLanes]          INT            CONSTRAINT [DF__SwimClub__NumOfL__440B1D61] DEFAULT ((8)) NULL,
    [LenOfPool]           INT            CONSTRAINT [DF__SwimClub__LenOfP__44FF419A] DEFAULT ((25)) NULL,
    [StartOfSwimSeason]   DATETIME       NULL,
    [CreatedOn]           DATETIME       NULL,
    CONSTRAINT [PK_SwimClub] PRIMARY KEY NONCLUSTERED ([SwimClubID] ASC)
);


GO

GRANT SELECT
    ON OBJECT::[dbo].[SwimClub] TO [SCM_Administrator]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[SwimClub] TO [SCM_Marshall]
    AS [dbo];


GO

GRANT SELECT
    ON OBJECT::[dbo].[SwimClub] TO [SCM_Guest]
    AS [dbo];


GO

