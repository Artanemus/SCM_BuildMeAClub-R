# BuildMeAClub SQL Scripts

This folder contains sub-folders for each version of the SwimClubMeet SQL database. Archived versions are also stored here.

## Sub folder format rules

This folder contains T-SQL scripts that are compatible with MS SQL EXPRESS version 2017 and up.

BuildMeAClub.exe sorts and then runs these scripts. Sorting is alphanumerically.

**Special Note.**

Included in the folder is a script written to create the internal SwimClubMeet table dbo.SCMSystem.
This script will assign the DBVersion, Major and Minor fields, to reflect the current SCM DB build version.
Typically this script is the last script to run.

The following example creates a SwimClubMeet 1.5 database. SCMSystemID must equal 1. The field 'Minor' isn't being used by SCM and should be set to 0.  

~~~,T-SQL
USE [SwimClubMeet]
GO
SET IDENTITY_INSERT [dbo].[SCMSystem] ON

INSERT [dbo].[SCMSystem]
(
    [SCMSystemID]
  , [DBVersion]
  , [Major]
  , [Minor]
)
VALUES
(1, 1, 5, 0)
SET IDENTITY_INSERT [dbo].[SCMSystem] OFF
GO
~~~

## Inno deployment

The Inno installation will locate these scripts in the BMAC utilities directory.

~~~, Inno
Source: "{#GITHUB}{#MySCM_BMAC_SQLPath}*"; DestDir: "{app}\Utilities\SQL\"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: util
~~~
