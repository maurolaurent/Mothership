# Mothership
Mothership is a software to monitor and capture network and hardware information in Windows Clients

MOTHERSHIP . Remote Control Shell
© By Mauro Laurent [maurolaurent@gmail]
Licensed by MIT Licence.

1) Installation & Unpacking Instructions

1.1. Database warning:
This program uses SQL Server 2012r2 or superior. The creation script is contained in this repository, under DB directory.

1.2. Pre-requisites:

- 64-bit processor architecture
- Windows 7 or superior operating system
- Visual Studio 2013 or superior, with WCF, Entity Framework & MVC components installed
- SQL Server 2012r2 or superior
- .Net Framework 4.5 or superior
- User running this must have administrative rights
- IIS Server as per OS, must have the following features turned on: 
	https://i.imgur.com/CxmWRDd.png
	https://i.imgur.com/Gg2a9Xj.png


To use the files, please unzip this file to a location you can access without issues.


2) Database

2.1 Installing the database

The database included in the file specified within this repo file is a one-time run script only. For this, follow these steps:
- You must connect to your database engine as a superadmin user, using SQL Server Management Service, so you won't have problems 
installing a new database.
- Open a new script window, and paste the MothershipBDScript.sql script. Alternatively you can just open it from the SSMS file menu.
- Run the script. It already contains all the CREATE routines.

2.2 Resultant tables

The resultant tables from the script are:
- dbo.Audit
- dbo.Client
- dbo.Client_Comm
- dbo.Client_Comm_Line
- dbo.Client_Handshake
- dbo.Client_Info
- dbo.Command
- dbo.Job


3) Source code

To compile the source code, follow these steps. There are two different directories:

[MinionService]
- Open Visual Studio as administrator. Open the file Source\MinionService\MinionService.sln
- Compile the source.

[MothershipService]
- Open Visual Studio as administrator. Open the file Source\MothershipService\MothershipService.sln
- Compile the source. NuGet packages were deleted from the .zip file due to space reasons, but building the solution would download 
them again. 

Since these services communication rely on the TCP protocol, we need to turn any firewall off. We will be testing locally, 
so no remote ports should be open, however, if you expect to connect minions from / to other pcs, open the ports TCP 8523 & TCP 8525 
on both server and client machine. 
If you're a Windows Firewall user, a rule should be added in addition of the open port.

Before working with the service, please change the url for the mothership & the minion. Find all ocurrences of the following lines

 <add key="MothershipURI" value="net.tcp://192.168.0.3:8525/" />
 <add key="MinionURI" value="net.tcp://192.168.0.3:8523/" />
 
Change the ip address to the one bound to your current pc. The port needs no change.

Next thing you need to do is to run the windows services.

The first service that need to be ran is the Mothership Service.

For this, run the following command using installutil.exe. 
(This utility is bundled when using the VS* Developer Command, but it is located at c:\Windows\Microsoft.net\Framework64\v4.0.30319\installutil.exe)

[Mothership Service]
> installutil.exe c:\<path_to>\Mauro_Laurent_Architect_NET-Scheduler\Source\MothershipService\MothershipWinService\bin\Debug\MothershipWinService.exe

[Minion Service]
> installutil.exe c:\<path_to>\Mauro_Laurent_Architect_NET-Scheduler\Source\MinionService\MinionWService\bin\Debug\MinionWService.exe


After installing, type the run command "services.msc" and look for the following services:

- Mothership Service
- Mothership - Minion Service

IMPORTANT: Mothership service MUST BE STARTED FIRST. Minion Service comes second. The services may fail to start 
if the IP are not configured correctly. 
All these services report directly to the Windows Event Logger. You may access this information using the 
run command "Eventvwr.msc", under Application Logs.

4) Run the testing suite

The test units probe the services for its correct functioning. Running these test will asses that all the basic functionality of the services
is ready to be consumed. The test are under the project Mauro_Laurent_Architect_NET-Scheduler\Source\MothershipService\MothershipTest\

Just choose the project and under Test > Run > All Tests, will run the test.

5) Running the administration tool

A web application is used to administrate the application. For this, and given the security added to such application, 
you must run it directly from the Visual Studio, or your IIS is configured to run under HTTPS.

- Add the MothershipUI project as start-up project, then press f5.
- Your browser might warn you that the site does use an invalid certificate. Just add an exception, this security feature needs to include 
a domain certificate which is not covered in this technical test.
- When the application runs, log in into the application. The default user is "maurolaurent@gmail.com", and the password is "Krsh0751!". 
You might be able to add additional users as you log in.
- If the minion service connected without issues, you will see your machine name represented on the screen. Click on Command Console to 
view the jobs for this minion.
- The list might or might not have jobs available. To add a new job, click on the purple button "New Job", and then enter a
name, a date to execute and the command to run into the minion. You may execute immediately; but this selection overrides the 
schedule execution.
- The job will appear as green if was ran successfully. For the scheduled jobs, you might have to close and reopen the window as a push notification
service was not able to be implemented. The commands to be run must be only those that a local, standard account user can run. Elevated 
privilege commands such as netstat are not available remotely.


---------------------

Version history:
[Minion] 0.5 beta.
[Mothership Service] 0.5 beta.
[Mothership Library] 0.1 alpha.
[Mothership Admin] RC1.
