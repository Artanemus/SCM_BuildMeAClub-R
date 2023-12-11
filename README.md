# SCM_BuildMeAClub RELEASE

![Hero BuildMeAClub ICON](ASSETS/SCM_BMAC_100x100.bmp)

### BuildMeAClub.exe (BMAC) is an application that creates the SwimClubMeet database in MS SQLEXPRESS and populates it with starter data

---
BMAC is a 64bit application written in pascal. It's part of an eco system of applications that make up the SwimClubMeet project. SCM lets amateur swimming clubs manage members and run their club night's.

![The eco system of SCM](ASSETS/SCM_GroupOfIcons.png)

To learn more about SCM view the [github pages](https://artanemus.github.io/index.html).

If you are interested in following a developer's blog and track my progress then you can find me at [ko-fi](https://ko-fi.com/artanemus).

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/V7V7EU686)

---

#### 09.12.2023

BMAC now is a universal SCM database builder. It looks for specific folders located in the `BMAC_SCRIPTS` sub-folder (located in the application's install directory). An additional button has been added that lets you choose what version to build.

---

### USING BMAC

After install, by default an icon isn't placed on the desktop. Type **build** in the windows search bar to discover it. Else navigate to the **Artanemus** folder on the start bar. (All SCM applications and utilities are located in this folder.)

### ON START-UP

The 'Build Me A Club' button will not be **visible** until a connection to the database server has been established. BMAC uses the SQL command utility, sqlcmd.exe. If you are using this application to create the database on a remote database server, then sqlcmd.exe must be correctly pathed.

> sqlcmd.exe is installed by default when you install MS SQLEXPRESS.

Use the `Select Database` button to pick the SwimClubMeet database to build. See the Wiki for info on the match-up of SCM application with SCM database. [WIKI: Version Info](https://github.com/Artanemus/SCM_BuildMeAClub-R/wiki/Version-Info). The 'Build Me A Club' button will not **enabled** until a database is chosen.

BMAC will not overwrite an existing SwimClubMeet database.

You would only ever need to run this application once. After a successful build the application can be removed. 😃

> Use Windows **Apps and Features** to remove the application.

A utility call `SCM_UpdateDatabase` is available to progress to other versions as they become available.

### ERRORS?

Any errors created by sqlcmd.exe are displayed in BMAC's text window.

A server side log file is also produced. This will be located in your documents folder with the filename **SCM_BuildMeAClub.log**.

> The log file is not removed on uninstall. This is intentional.

---

![ScreenShot of BMAC prior to login.](ASSETS/Screenshot%20BMAC%20MainForm.JPG)

![ScreenShot of Select Database DLG.](ASSETS/Screenshot%20BMAC%20Select%20DB.JPG)
