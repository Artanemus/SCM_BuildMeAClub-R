CREATE TABLE [dbo].[PersonalBests] (
    [xlsPBID]     INT      NOT NULL,
    [xlsMemberID] INT      NOT NULL,
    [FR25]        TIME (7) NULL,
    [FR50]        TIME (7) NULL,
    [FR100]       TIME (7) NULL,
    [FR200]       TIME (7) NULL,
    [FR400]       TIME (7) NULL,
    [BR25]        TIME (7) NULL,
    [BR50]        TIME (7) NULL,
    [BR100]       TIME (7) NULL,
    [BR200]       TIME (7) NULL,
    [BR400]       TIME (7) NULL,
    [BA25]        TIME (7) NULL,
    [BA50]        TIME (7) NULL,
    [BA100]       TIME (7) NULL,
    [BA200]       TIME (7) NULL,
    [BA400]       TIME (7) NULL,
    [BU25]        TIME (7) NULL,
    [BU50]        TIME (7) NULL,
    [BU100]       TIME (7) NULL,
    [BU200]       TIME (7) NULL,
    [BU400]       TIME (7) NULL,
    [ME25]        TIME (7) NULL,
    [ME50]        TIME (7) NULL,
    [ME100]       TIME (7) NULL,
    [ME200]       TIME (7) NULL,
    [ME400]       TIME (7) NULL,
    CONSTRAINT [PK_SCMMembersPB] PRIMARY KEY CLUSTERED ([xlsPBID] ASC)
);


GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'SCM members personal best imported from flat file', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PersonalBests';


GO

