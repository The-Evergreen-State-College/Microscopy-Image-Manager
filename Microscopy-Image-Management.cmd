@Echo Off
@SETLOCAL enableextensions
:: Author:		David Geeraerts
:: Location:	Olympia, Washington USA
:: E-Mail:		dgeeraerts.evergreen@gmail.com
::
::	Copyright License
:: 	Creative Commons: Attribution-NonCommercial-ShareAlike 3.0 Unported (CC BY-NC-SA 3.0)  
:: 	http://creativecommons.org/licenses/by-nc-sa/3.0/
::
::
::	NOTES
::		Script is intended to be run during the log off process.
::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
SET SCRIPT_NAME=Microscopy Image Manager
SET SCRIPT_VERSION=2.8.0
Title %SCRIPT_NAME% Version: %SCRIPT_VERSION%
Prompt MIM$G
color E4
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::



::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Declare Global variables
::	All User variables are set within here.
::		(configure variables)
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

SET INSTRUMENT_NAME=

SET CURRENT_SESSION_PATH=
SET PREVIOUS_SESSIONS_PATH=
SET BACKUP_LOCATION=
SET NETWORK_FILE_SHARE=


:: Logging
:: SET LOG_LOCATION=%ProgramData%\TESC\Microscopy_Image_Management
SET LOG_LOCATION=
SET LOG_FILE=Microscopy_Image_Management_Script.Log

:: LOGGING LEVEL CONTROL
::  by default, ALL=0 & DEBUG=0 & TRACE=0
SET LOG_LEVEL_ALL=0
SET LOG_LEVEL_INFO=1
SET LOG_LEVEL_WARN=1
SET LOG_LEVEL_ERROR=1
SET LOG_LEVEL_FATAL=1
SET LOG_LEVEL_DEBUG=0
SET LOG_LEVEL_TRACE=0

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::##### Everything below here is 'hard-coded' [DO NOT MODIFY] #####
::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: Start logging (new line)
ECHO. >> %LOG_LOCATION%\%LOG_FILE%

:: Dependency checks
::	Check to make sure there's actually a current session folder
IF NOT EXIST %CURRENT_SESSION_PATH% GoTO err00
:: CHECK TO MAKE SURE LOG LOCATION WORKS!
IF NOT EXIST %LOG_LOCATION% MD %LOG_LOCATION% || GoTo err01
IF EXIST %LOG_LOCATION% SET LOGFILE_STATUS=1


:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:flogl
:: FUNCTION: Check and configure for ALL LOG LEVEL
IF %LOG_LEVEL_ALL% EQU 1 (ECHO [TRACE]	ENTER: function Check for ALL log level!) >> %LOG_LOCATION%\%LOG_FILE%
IF %LOG_LEVEL_ALL% EQU 1 SET LOG_LEVEL_INFO=1
IF %LOG_LEVEL_ALL% EQU 1 SET LOG_LEVEL_WARN=1
IF %LOG_LEVEL_ALL% EQU 1 SET LOG_LEVEL_ERROR=1
IF %LOG_LEVEL_ALL% EQU 1 SET LOG_LEVEL_FATAL=1
IF %LOG_LEVEL_ALL% EQU 1 SET LOG_LEVEL_DEBUG=1
IF %LOG_LEVEL_ALL% EQU 1 SET LOG_LEVEL_TRACE=1
IF %LOG_LEVEL_TRACE% EQU 1 (ECHO [TRACE]	EXIT: function Check for ALL log level!) >> %LOG_LOCATION%\%LOG_FILE%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:fsTime
:: FUNCTION: Start Time
IF %LOG_LEVEL_TRACE% EQU 1 (ECHO [TRACE]	ENTER: function start time for lapse time!) >> %LOG_LOCATION%\%LOG_FILE%
:: Calculate lapse time by capturing start time
::	Parsing %TIME% variable to get an interger number
FOR /F "tokens=1 delims=:." %%h IN ("%TIME%") DO SET S_hh=%%h
FOR /F "tokens=2 delims=:." %%h IN ("%TIME%") DO SET S_mm=%%h
FOR /F "tokens=3 delims=:." %%h IN ("%TIME%") DO SET S_ss=%%h
FOR /F "tokens=4 delims=:." %%h IN ("%TIME%") DO SET S_ms=%%h
IF %LOG_LEVEL_DEBUG% EQU 1 (ECHO [DEBUG]	S_hh: %S_hh%) >> %LOG_LOCATION%\%LOG_FILE%
IF %LOG_LEVEL_DEBUG% EQU 1 (ECHO [DEBUG]	S_mm: %S_mm%) >> %LOG_LOCATION%\%LOG_FILE%
IF %LOG_LEVEL_DEBUG% EQU 1 (ECHO [DEBUG]	S_ss: %S_ss%) >> %LOG_LOCATION%\%LOG_FILE%
IF %LOG_LEVEL_DEBUG% EQU 1 (ECHO [DEBUG]	S_mm: %S_mm%) >> %LOG_LOCATION%\%LOG_FILE%
IF %LOG_LEVEL_TRACE% EQU 1 (ECHO [TRACE]	EXIT: function start time for lapse time!) >> %LOG_LOCATION%\%LOG_FILE%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:start
IF %LOG_LEVEL_TRACE% EQU 1 (ECHO [TRACE]	ENTER: function Start!) >> %LOG_LOCATION%\%LOG_FILE%
IF %LOG_LEVEL_INFO% EQU 1 ECHO [INFO]	START %DATE% %TIME% >> %LOG_LOCATION%\%LOG_FILE%
IF %LOG_LEVEL_INFO% EQU 1 ECHO [INFO]	SCRIPT_VERSION: %SCRIPT_VERSION% >> %LOG_LOCATION%\%LOG_FILE%
IF %LOG_LEVEL_ALL% EQU 1 (ECHO [DEBUG]	ALL logging is turned on!) >> %LOG_LOCATION%\%LOG_FILE%
hostname > %LOG_LOCATION%\var_hostname.txt
IF %LOG_LEVEL_DEBUG% EQU 1 ECHO [DEBUG]	File var_hostname.txt just got created. >> %LOG_LOCATION%\%LOG_FILE%
whoami > %LOG_LOCATION%\var_whoami.txt
IF %LOG_LEVEL_DEBUG% EQU 1 ECHO [DEBUG]	File var_whoami.txt just got created. >> %LOG_LOCATION%\%LOG_FILE%
SET /P var_WHOAMI= < %LOG_LOCATION%\var_whoami.txt
SET /P var_HOSTNAME= < %LOG_LOCATION%\var_hostname.txt
IF %LOG_LEVEL_INFO% EQU 1 ECHO [INFO]	USER: %var_WHOAMI% >> %LOG_LOCATION%\%LOG_FILE%
IF %LOG_LEVEL_INFO% EQU 1 ECHO [INFO]	HOSTNAME: %var_HOSTNAME% >> %LOG_LOCATION%\%LOG_FILE%
IF %LOG_LEVEL_INFO% EQU 1 ECHO [INFO]	%INSTRUMENT_NAME% >> %LOG_LOCATION%\%LOG_FILE%
:: Log Level debugging
IF %LOG_LEVEL_DEBUG% EQU 1 ECHO [DEBUG]	Log level ALL is [%LOG_LEVEL_ALL%] >> %LOG_LOCATION%\%LOG_FILE%
IF %LOG_LEVEL_DEBUG% EQU 1 ECHO [DEGUG]	Log level INFO is [%LOG_LEVEL_INFO%] >> %LOG_LOCATION%\%LOG_FILE%
IF %LOG_LEVEL_DEBUG% EQU 1 ECHO [DEBUG]	Log level WARN is [%LOG_LEVEL_WARN%] >> %LOG_LOCATION%\%LOG_FILE%
IF %LOG_LEVEL_DEBUG% EQU 1 ECHO [DEBUG]	Log level ERROR is [%LOG_LEVEL_ERROR%] >> %LOG_LOCATION%\%LOG_FILE%
IF %LOG_LEVEL_DEBUG% EQU 1 ECHO [DEBUG]	Log level FATAL is [%LOG_LEVEL_FATAL%] >> %LOG_LOCATION%\%LOG_FILE%
IF %LOG_LEVEL_DEBUG% EQU 1 ECHO [DEBUG]	Log level DEBUG is [%LOG_LEVEL_DEBUG%] >> %LOG_LOCATION%\%LOG_FILE%
IF %LOG_LEVEL_DEBUG% EQU 1 ECHO [DEBUG]	Log level TRACE is [%LOG_LEVEL_TRACE%] >> %LOG_LOCATION%\%LOG_FILE%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Script core
:core
IF %LOG_LEVEL_TRACE% EQU 1 ECHO [TRACE]	ENTER: Core >> %LOG_LOCATION%\%LOG_FILE%

:: variable for the directory value whether its empty or not.
::	0 assumes folder is empty and is default value
SET DIRVALUE=0
IF %LOG_LEVEL_DEBUG% EQU 1 ECHO [DEBUG]	Directory value is set to [%DIRVALUE%] >> %LOG_LOCATION%\%LOG_FILE%
:: If the directory is empty, then just exit
FOR /F %%F IN ('dir %CURRENT_SESSION_PATH% /B') DO SET /a "DIRVALUE=DIRVALUE+1"
:: If directory value still equals 0, then its empty and go to end of session.
IF %LOG_LEVEL_DEBUG% EQU 1 ECHO [DEBUG]	Directory value is set to [%DIRVALUE%] after scan. >> %LOG_LOCATION%\%LOG_FILE%
IF %DIRVALUE% EQU 0 IF %LOG_LEVEL_INFO% EQU 1 ECHO [INFO]	Current Session folder is empty! >> %LOG_LOCATION%\%LOG_FILE%
IF %DIRVALUE% EQU 0 GoTo EOS
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Creating a time stamp
IF %LOG_LEVEL_TRACE% EQU 1 ECHO [TRACE]	ENTER: Time Stamp subroutine >> %LOG_LOCATION%\%LOG_FILE%

FOR /F "tokens=1-4 delims=/ " %%D IN ("%DATE%") Do Set Day=%%D
FOR /F "tokens=1-4 delims=/ " %%D IN ("%DATE%") Do Set mm=%%E
FOR /F "tokens=1-4 delims=/ " %%D IN ("%DATE%") Do Set dd=%%F
FOR /F "tokens=1-4 delims=/ " %%D IN ("%DATE%") Do Set yyyy=%%G
IF %LOG_LEVEL_DEBUG% EQU 1 ECHO [DEBUG]	Day is set to [%Day%] >> %LOG_LOCATION%\%LOG_FILE%
IF %LOG_LEVEL_DEBUG% EQU 1 ECHO [DEBUG]	mm is set to [%mm%] >> %LOG_LOCATION%\%LOG_FILE%
IF %LOG_LEVEL_DEBUG% EQU 1 ECHO [DEBUG]	dd is set to [%dd%] >> %LOG_LOCATION%\%LOG_FILE%
IF %LOG_LEVEL_DEBUG% EQU 1 ECHO [DEBUG]	yyyy is set to [%yyyy%] >> %LOG_LOCATION%\%LOG_FILE%
IF %LOG_LEVEL_TRACE% EQU 1 ECHO [TRACE]	EXIT: Time Stamp subroutine >> %LOG_LOCATION%\%LOG_FILE%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: Create a previous local session folder for the user
IF %LOG_LEVEL_TRACE% EQU 1 ECHO [TRACE]	ENTER: Create a Previous user folder [%PREVIOUS_SESSIONS_PATH%\%YYYY%-%MM%-%DD%_%USERNAME%] >> %LOG_LOCATION%\%LOG_FILE%
IF NOT EXIST "%PREVIOUS_SESSIONS_PATH%\%YYYY%-%MM%-%DD%_%USERNAME%" MD "%PREVIOUS_SESSIONS_PATH%\%YYYY%-%MM%-%DD%_%USERNAME%" || GoTo err03
IF %LOG_LEVEL_TRACE% EQU 1 ECHO [TRACE]	EXIT: Create a Previous user folder [%PREVIOUS_SESSIONS_PATH%\%YYYY%-%MM%-%DD%_%USERNAME%] >> %LOG_LOCATION%\%LOG_FILE%
IF %LOG_LEVEL_TRACE% EQU 1 ECHO [TRACE]	ENTER: Robocopy current session to Previous Session >> %LOG_LOCATION%\%LOG_FILE%
:: Copy the contents of the current session folder into the previous session folder for the user
Robocopy "%CURRENT_SESSION_PATH%" "%PREVIOUS_SESSIONS_PATH%\%YYYY%-%MM%-%DD%_%USERNAME%" /S /E /R:2 /W:5 /NP /LOG+:%LOG_LOCATION%\%LOG_FILE%
IF %LOG_LEVEL_TRACE% EQU 1 ECHO [TRACE]	EXIT: Robocopy current session to Previous Session >> %LOG_LOCATION%\%LOG_FILE%
:: Move the current session folder onto a network file share
::	at this point the contents are already copied to the local previous session folder
IF %LOG_LEVEL_TRACE% EQU 1 ECHO [TRACE]	ENTER: Robocopy Previous Session to Network file share >> %LOG_LOCATION%\%LOG_FILE%
IF NOT EXIST %NETWORK_FILE_SHARE% GoTo err04
IF NOT EXIST "%NETWORK_FILE_SHARE%\%YYYY%-%MM%-%DD%_%USERNAME%" MD "%NETWORK_FILE_SHARE%\%YYYY%-%MM%-%DD%_%USERNAME%" || GoTo err04

Robocopy "%CURRENT_SESSION_PATH%" "%NETWORK_FILE_SHARE%\%YYYY%-%MM%-%DD%_%USERNAME%" /MOVE /S /E /R:2 /W:5 /NP /LOG+:%LOG_LOCATION%\%LOG_FILE%
:: The /move switch deletes the current session folder, so it needs to be recreated.
IF NOT EXIST %CURRENT_SESSION_PATH% MD %CURRENT_SESSION_PATH%
IF %LOG_LEVEL_TRACE% EQU 1 ECHO [TRACE]	EXIT: Robocopy Previous Session to Network file share >> %LOG_LOCATION%\%LOG_FILE%

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Archive compress
::	Check for the existence of 7z
IF %LOG_LEVEL_TRACE% EQU 1 ECHO [TRACE]	ENTER: Archive compress subroutine >> %LOG_LOCATION%\%LOG_FILE%
SET ARCHIVER_STATUS=0
IF %LOG_LEVEL_DEBUG% EQU 1 ECHO [DEBUG]	Archiver 7z default status is [%ARCHIVER_STATUS%] >> %LOG_LOCATION%\%LOG_FILE%
IF EXIST "%PROGRAMFILES%\7-Zip\7z.exe" SET ARCHIVER_STATUS=1
IF EXIST "%PROGRAMFILES(x86)%\7-Zip\7z.exe" SET ARCHIVER_STATUS=1
IF %LOG_LEVEL_DEBUG% EQU 1 ECHO [DEBUG]	ARCHIVER_STATUS is [%ARCHIVER_STATUS%] >> %LOG_LOCATION%\%LOG_FILE%
IF %ARCHIVER_STATUS% EQU 0 GoTo skip1
7z i | FIND "7-Zip" > %LOG_LOCATION%\var_7zip.txt
FOR /F "delims=:" %%Z IN (%LOG_LOCATION%\var_7zip.txt) DO (IF %LOG_LEVEL_INFO% EQU 1 ECHO [INFO]	%%Z) >> %LOG_LOCATION%\%LOG_FILE%
7z a -r -mx1 "%PREVIOUS_SESSIONS_PATH%\%YYYY%-%MM%-%DD%_%USERNAME%\%YYYY%-%MM%-%DD%_%USERNAME%.7z" "%PREVIOUS_SESSIONS_PATH%\%YYYY%-%MM%-%DD%_%USERNAME%"
IF %LOG_LEVEL_DEBUG% EQU 1 ECHO [DEBUG] 7z error level is [%ERRORLEVEL%] >> %LOG_LOCATION%\%LOG_FILE%
IF EXIST "%PREVIOUS_SESSIONS_PATH%\%YYYY%-%MM%-%DD%_%USERNAME%\%YYYY%-%MM%-%DD%_%USERNAME%.7z" IF %LOG_LEVEL_DEBUG% EQU 1 ECHO [DEBUG]	Archive package just got created [%YYYY%-%MM%-%DD%_%USERNAME%.7z] >> %LOG_LOCATION%\%LOG_FILE%
IF NOT EXIST "%PREVIOUS_SESSIONS_PATH%\%YYYY%-%MM%-%DD%_%USERNAME%\%YYYY%-%MM%-%DD%_%USERNAME%.7z" IF %LOG_LEVEL_ERROR% EQU 1 ECHO [ERROR]	Archive package [%YYYY%-%MM%-%DD%_%USERNAME%.7z] failed to be created! >> %LOG_LOCATION%\%LOG_FILE%
IF EXIST %PREVIOUS_SESSIONS_PATH%\%YYYY%-%MM%-%DD%_%USERNAME%\%YYYY%-%MM%-%DD%_%USERNAME%.7z (Robocopy "%PREVIOUS_SESSIONS_PATH%\%YYYY%-%MM%-%DD%_%USERNAME%" "%NETWORK_FILE_SHARE%\%YYYY%-%MM%-%DD%_%USERNAME%" *.7z /MOV /R:2 /W:5 /NP /LOG+:%LOG_LOCATION%\%LOG_FILE%)
:skip1
IF %LOG_LEVEL_TRACE% EQU 1 ECHO [TRACE]	EXIT: Archive compress subroutine >> %LOG_LOCATION%\%LOG_FILE%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

IF %LOG_LEVEL_TRACE% EQU 1 ECHO [TRACE]	EXIT: Core >> %LOG_LOCATION%\%LOG_FILE%
:: Jump to End Of Session to bypass Error section
GoTo EOS
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                    START ERROR SECTION
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:://///////////////////////////////////////////////////////////////////////////
:: ERROR LEVEL 00's (DEPENDENCY ERROR)

:: ERROR 00
::	Current Session Path doesn't exist
:err00
IF NOT EXIST %LOG_LOCATION% MD %LOG_LOCATION% || GoTo err01
IF %LOG_LEVEL_TRACE% EQU 1 ECHO [TRACE]	ENTER: Error 00 [err00] >> %LOG_LOCATION%\%LOG_FILE%
IF %LOG_LEVEL_FATAL% EQU 1 ECHO [FATAL]	Folder [%CURRENT_SESSION_PATH%] Does not exist! Aborting! >> %LOG_LOCATION%\%LOG_FILE%
IF %LOG_LEVEL_TRACE% EQU 1 ECHO [TRACE]	EXIT: Error 00 [err00] >> %LOG_LOCATION%\%LOG_FILE%
GoTo feTime

:: ERROR 01
::	Log location could not be created
:erro1
IF NOT EXIST %LOG_LOCATION% MD %LOG_LOCATION% || GoTo EOF
IF %LOG_LEVEL_TRACE% EQU 1 ECHO [TRACE]	ENTER: Error 01 [err01] >> %LOG_LOCATION%\%LOG_FILE%
IF %LOG_LEVEL_FATAL% EQU 1 ECHO [FATAL]	Folder [%Current_Session%] Does not exist! Aborting! >> %LOG_LOCATION%\%LOG_FILE%
SET LOGFILE_STATUS=0
IF %LOG_LEVEL_TRACE% EQU 1 ECHO [TRACE]	EXIT: Error 01 [err01] >> %LOG_LOCATION%\%LOG_FILE%
:: Try to run the script even if there is no logfile
:: Go to the core of the script
GoTo core

:: Error 03
::	Error creating users previous session folder
IF %LOGFILE_STATUS% EQU 0 GoTo EOS
IF %LOG_LEVEL_TRACE% EQU 1 ECHO [TRACE]	ENTER: Error 03 [err03] >> %LOG_LOCATION%\%LOG_FILE%
IF %LOG_LEVEL_FATAL% EQU 1 ECHO [FATAL]	Folder [%PREVIOUS_SESSIONS_PATH%] creation failure! Aborting! >> %LOG_LOCATION%\%LOG_FILE%
IF %LOG_LEVEL_TRACE% EQU 1 ECHO [TRACE]	EXIT: Error 03 [err03] >> %LOG_LOCATION%\%LOG_FILE%
GoTo EOF

:: Error 04
::	Network File share unavailable
IF %LOGFILE_STATUS% EQU 0 GoTo EOS
IF %LOG_LEVEL_TRACE% EQU 1 ECHO [TRACE]	ENTER: Error 04 [err04] >> %LOG_LOCATION%\%LOG_FILE%
IF %LOG_LEVEL_FATAL% EQU 1 ECHO [FATAL]	The network file share [%NETWORK_FILE_SHARE%] is unavailable! Aborting! >> %LOG_LOCATION%\%LOG_FILE%
IF %LOG_LEVEL_FATAL% EQU 1 ECHO [FATAL]	Content from [[%Current_Session%] not copied to [%NETWORK_FILE_SHARE%]! >> %LOG_LOCATION%\%LOG_FILE%
IF %LOG_LEVEL_TRACE% EQU 1 ECHO [TRACE]	EXIT: Error 04 [err04] >> %LOG_LOCATION%\%LOG_FILE%
GoTo EOS

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


:: End the session cleanup
:EOS
IF %LOG_LEVEL_TRACE% EQU 1 ECHO [TRACE]	ENTER: FUNCTION End-Of-Session >> %LOG_LOCATION%\%LOG_FILE%
IF EXIST %LOG_LOCATION%\var_hostname.txt DEL /F /Q %LOG_LOCATION%\var_hostname.txt
IF NOT EXIST %LOG_LOCATION%\var_hostname.txt IF %LOG_LEVEL_DEBUG% EQU 1 ECHO [DEBUG]	File [var_hostname.txt] just got deleted! >> %LOG_LOCATION%\%LOG_FILE%
IF EXIST %LOG_LOCATION%\var_whoami.txt DEL /F /Q %LOG_LOCATION%\var_whoami.txt
IF NOT EXIST %LOG_LOCATION%\var_whoami.txt IF %LOG_LEVEL_DEBUG% EQU 1 ECHO [DEBUG]	File [var_whoami.txt] just got deleted! >> %LOG_LOCATION%\%LOG_FILE%
IF EXIST %LOG_LOCATION%\var_7zip.txt DEL /F /Q %LOG_LOCATION%\var_7zip.txt
IF NOT EXIST %LOG_LOCATION%\var_7zip.txt IF %LOG_LEVEL_DEBUG% EQU 1 ECHO [DEBUG]	File [var_7zip.txt] just got deleted! >> %LOG_LOCATION%\%LOG_FILE%
IF %LOG_LEVEL_TRACE% EQU 1 ECHO [TRACE]	EXIT: FUNCTION End-Of-Session >> %LOG_LOCATION%\%LOG_FILE%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: FUNCTION: End Time
:feTime
IF %LOG_LEVEL_TRACE% EQU 1 ECHO [TRACE]	ENTER: FUNCTION end time >> %LOG_LOCATION%\%LOG_FILE%

:: Calculate lapse time by capturing end time
::	Parsing %TIME% variable to get an interger number
FOR /F "tokens=1 delims=:." %%h IN ("%TIME%") DO SET E_hh=%%h
FOR /F "tokens=2 delims=:." %%h IN ("%TIME%") DO SET E_mm=%%h
FOR /F "tokens=3 delims=:." %%h IN ("%TIME%") DO SET E_ss=%%h
FOR /F "tokens=4 delims=:." %%h IN ("%TIME%") DO SET E_ms=%%h
IF %LOG_LEVEL_DEBUG% EQU 1 (ECHO [DEBUG]	E_hh: %E_hh%) >> %LOG_LOCATION%\%LOG_FILE%
IF %LOG_LEVEL_DEBUG% EQU 1 (ECHO [DEBUG]	E_mm: %E_mm%) >> %LOG_LOCATION%\%LOG_FILE%
IF %LOG_LEVEL_DEBUG% EQU 1 (ECHO [DEBUG]	E_ss: %E_ss%) >> %LOG_LOCATION%\%LOG_FILE%
IF %LOG_LEVEL_DEBUG% EQU 1 (ECHO [DEBUG]	E_mm: %E_mm%) >> %LOG_LOCATION%\%LOG_FILE%

:: Calculate the actual lapse time
IF %E_hh% GEQ %S_hh% (SET /A "L_hh=%E_hh%-%S_hh%") ELSE (SET /A "L_hh=%S_hh%-%E_hh%")
IF %E_mm% GEQ %S_mm% (SET /A "L_mm=%E_mm%-%S_mm%") ELSE (SET /A "L_mm=%S_mm%-%E_mm%")
IF %E_ss% GEQ %S_ss% (SET /A "L_ss=%E_ss%-%S_ss%") ELSE (SET /A "L_ss=%S_ss%-%E_ss%")
IF %E_ms% GEQ %S_ms% (SET /A "L_ms=%E_ms%-%S_ms%") ELSE (SET /A "L_ms=%S_ms%-%E_ms%")
:: turn hours into minutes and add to total minutes
IF %L_hh% GTR 0 SET /A "L_hhh=%L_hh%*60"
IF %L_hh% EQU 0 SET L_hhh=0
IF %L_hhh% GTR 0 SET /A "L_tm=%L_hhh%+%L_mm%"
IF %L_hhh% EQU 0 SET L_tm=%L_mm%
:: Lapse Time
IF %LOG_LEVEL_INFO% EQU 1 ECHO [INFO]	Time Lapsed (mm:ss.ms): %L_tm%:%L_ss%.%L_ms% >> %LOG_LOCATION%\%LOG_FILE%
IF %LOG_LEVEL_TRACE% EQU 1 ECHO [TRACE]	EXIT: FUNCTION end time >> %LOG_LOCATION%\%LOG_FILE%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


:EOF
IF %LOG_LEVEL_INFO% EQU 1 ECHO [INFO]	END %DATE% %TIME% >> %LOG_LOCATION%\%LOG_FILE%
ECHO. >> %LOG_LOCATION%\%LOG_FILE%
Exit