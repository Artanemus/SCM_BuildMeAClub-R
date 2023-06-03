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

#### 02.06.2023

Just some quick notes on the BMAC_SCRIPTS folder. In future builds there will be a single SQL script for each database version. (02/06/23 Keep a watch on the folder and look for some new release builds for SCM_BuildMeAClub.)

I've done a little work on the repo's wiki. Here you'll find some info on the versions and other bits.

It takes time to build a solid, well performing database 😋. I reach out to users - do you want to sponsor me?

---

### USING BMAC

After install, by default an icon isn't placed on the desktop. Type **build** in the windows search bar to discover it. Else navigate to the **Artanemus** folder on the start bar. (All SCM applications and utilities are located in this folder.)

### ON START-UP

The 'Build Me A Club' button will not be visible until a connection to the database server has been established. BMAC requires the SQL command utility, sqlcmd.exe. If you are using this application to create the database on a remote database server, then sqlcmd.exe must be correctly pathed.

> Typically sqlcmd.exe is installed by default when you install MS SQLEXPRESS.

BMAC will not overwrite an existing SwimClubMeet database.

You would only ever need to run this application once. After a successful build the application can be removed. 😃

> Use Windows **Apps and Features** to remove the application.

### ERRORS?

Any errors created by sqlcmd.exe are displayed in BMAC's text window.

A server side log file is also produced. This will be located in your documents folder with the filename **SCM_BuildMeAClub.log**. View this file should an error occur.

> The log file is not removed on uninstall. This is intentional.

---

![ScreenShot of BMAC after logging in.](ASSETS/Screenshot%20BMAC%20MainForm.JPG)



