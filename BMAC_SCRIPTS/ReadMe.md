# BuildMeAClub SQL Scripts

This folder contains sub-folders for each version of the SwimClubMeet SQL database. Archived versions are also stored here.

## Sub folder format rules

All T-SQL scripts are compatible with MS SQL EXPRESS version 2017 and up.

BuildMeAClub.exe sorts and then runs these scripts. Sorting is alphanumerically.

**Special Note.**

Included in the folder is a script written to create the internal SwimClubMeet table dbo.SCMSystem.
This script will assign the DBVersion, Major and Minor fields, to reflect the current SCM DB build version.
Typically this script is the last script to run.

> The following example creates a SwimClubMeet 1.5.0 database. SCMSystemID must equal 1.  

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

---
## VERSION NOTES

### v1.6.0

- Additional fields added.
- Performance improvements to scalar functions
- Additional scalar functions added.
- SCMSystem values (1,1,6,0)

### v1.5.1

- Fix scalar function. `dbo.IsMemberNominated.UserDefinedFunction.sql`
- Renumbering of some files.
- SCMSystem values (1,1,5,1)

### v1.5

Release version.

- SCMSystem values (1,1,5,0)

---
## INNO deployment

The INNO installation will place these scripts in the BMAC directory. Which is typically located at: `C:\Program Files\Artanemus\BuildMeAClub\SQL`

~~~, INNO
Source: "{#GITHUB}{#MyBMACSQLPath}*"; DestDir: "{app}\Utilities\SQL\"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: util
~~~
