CREATE TABLE [dbo].[SwimClub] (
    [SwimClubID]          INT            IDENTITY (1, 1) NOT NULL,
    [NickName]            NVARCHAR (128) NULL,
    [Caption]             NVARCHAR (128) NULL,
    [Email]               NVARCHAR (128) NULL,
    [ContactNum]          NVARCHAR (30)  NULL,
    [WebSite]             NVARCHAR (256) NULL,
    [HeatAlgorithm]       INT            NULL,
    [EnableTeamEvents]    BIT            NULL,
    [EnableSwimOThon]     BIT            NULL,
    [EnableExtHeatTypes]  BIT            NULL,
    [EnableMembershipStr] BIT            NULL,
    [NumOfLanes]          INT            NULL,
    [LenOfPool]           INT            NULL,
    [StartOfSwimSeason]   DATETIME       NULL,
    [CreatedOn]           DATETIME       NULL
);
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Allows for AlphaNumerical membership number. Once enabled Member.MembershipNum is ignored.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SwimClub', @level2type = N'COLUMN', @level2name = N'EnableMembershipStr';
GO

ALTER TABLE [dbo].[SwimClub]
    ADD CONSTRAINT [DF__SwimClub__NumOfL__440B1D61] DEFAULT ((8)) FOR [NumOfLanes];
GO

ALTER TABLE [dbo].[SwimClub]
    ADD CONSTRAINT [DF__SwimClub__Enable__403A8C7D] DEFAULT ((0)) FOR [EnableTeamEvents];
GO

ALTER TABLE [dbo].[SwimClub]
    ADD CONSTRAINT [DF__SwimClub__Enable__412EB0B6] DEFAULT ((0)) FOR [EnableSwimOThon];
GO

ALTER TABLE [dbo].[SwimClub]
    ADD CONSTRAINT [DF__SwimClub__LenOfP__44FF419A] DEFAULT ((25)) FOR [LenOfPool];
GO

ALTER TABLE [dbo].[SwimClub]
    ADD CONSTRAINT [DF__SwimClub__Enable__4222D4EF] DEFAULT ((0)) FOR [EnableExtHeatTypes];
GO

ALTER TABLE [dbo].[SwimClub]
    ADD CONSTRAINT [DF__SwimClub__Enable__4316F928] DEFAULT ((0)) FOR [EnableMembershipStr];
GO

GRANT SELECT
    ON OBJECT::[dbo].[SwimClub] TO [SCM_Guest]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[dbo].[SwimClub] TO [SCM_Marshall]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[dbo].[SwimClub] TO [SCM_Administrator]
    AS [dbo];
GO

ALTER TABLE [dbo].[SwimClub]
    ADD CONSTRAINT [PK_SwimClub] PRIMARY KEY NONCLUSTERED ([SwimClubID] ASC);
GO

