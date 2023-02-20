# BuildMeAClub SQL Scripts

This folder contains sub-folders for each version of the SwimClubMeet SQL database. Archived versions are also stored here.

## Sub folder format rules

All T-SQL scripts are compatible with MS SQL EXPRESS version 2017 and up.

BuildMeAClub.exe sorts and then runs these scripts. Sorting is alphanumerically.

**Special Note.**

Included in the folder is a script written to create the internal SwimClubMeet table dbo.SCMSystem.
This script will assign the DBVersion, Major and Minor fields, to reflect the current SCM DB build version.
Typically this script is the last script to run.

> The following example creates a SwimClubMeet 1.5.0 database.

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

The SCMSystemID is used to identify the model. A MS SQLEXPRESS database uses SCMSystemID = 1.

---

## VERSION NOTES

### v1.1.5.2

- Members table schema changes.
- Additional fields added. (for club logos, scheduling of events, etc.)
- Additional scalar functions added.
- Performance improvements to scalar functions.
- Ground work for relay swimming events.
- SCMSystem values (1,1,5,2).

### v1.1.5.1

- Fix scalar function. `dbo.IsMemberNominated.UserDefinedFunction.sql`.
- New field SwimClubMeet.dbo.Member.IsSwimmer.
- New default IsArchived, IsActive, IsSwimmer.
- SCMSystem values (1,1,5,1).

### v1.1.5.0

Release version. Pushed to GitHub as `SCM_BuilMeAClub_x64_v1.1.0.0.exe`.

- SCMSystem values (1,1,5,0).

---

## INNO deployment

The INNO installation will place these scripts in the BMAC directory. Which is typically located at: `C:\Program Files\Artanemus\BuildMeAClub\BMAC_SCRIPTS\v????`
