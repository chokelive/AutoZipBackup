@echo off
set year=%date:~-4,4%
set month=%date:~-10,2%
set day=%date:~-7,2%
set hour=%time:~-11,2%
set hour=%hour: =0%
set min=%time:~-8,2%
set zipname_prefix= REM <Zip name prefix>

set source= REM <Source Directory for backup>
set backuppath= REM <Destination Directory for keep backup file>
set serverpath= REM <Destination server path for keep backup file>
set serveruser= REM <server username for keep backup file>
set serverpass= REM <server password for keep backup file>
set zipapp= REM <7zip program path. Exemple : C:\Program Files (x86)\7-Zip\7z.exe>

set FileDate=%year%%month%%day%_%hour%%min%
set BackupFile=%backuppath%\%zipname_prefix%_%FileDate%.7z

forfiles /p "%backuppath%" /s /m *.7z /D -7 /C "cmd /c del @path"

del %BackupFile%

cd %source%
"%zipapp%" a -t7z -mx=1  %BackupFile%
@echo on

net use %serverpath% /delete
net use %serverpath% %serverpass% /user:%serveruser%
robocopy %backuppath% %serverpath% /MIR /FFT

exit