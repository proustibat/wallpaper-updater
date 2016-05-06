@echo off
setlocal enableextensions
setlocal enabledelayedexpansion

REM #######################################################################
REM 	Setting variables
REM #######################################################################

REM Define your wallpapers directory
set wpDir=%USERPROFILE%\Pictures\wallpapers


REM Define the filename imposed by your IT department
set outputFilename=MazarineNoir_Grand.jpg

REM The path to the wallpaper file
set outPutDir=%WINDIR%
	
set title=WALLPAPER UPDATER FOR DESKTOP WINDOWS

REM #######################################################################
REM 	TERMINAL CUSTOMIZATION
REM #######################################################################
if not "%os%"=="Windows_NT" goto checkPermissions
Title %title% 
color 03
mode con: cols=120 lines=62


set LF=^


REM ** Two empty lines are required - it is a breakline alias
REM Save script location
::set srcDir=%~dp0



:checkPermissions
    net session >nul 2>&1
    if %errorLevel% == 0 (
		msg %username% /time:0 Please ensure all work is saved before you continue!
        echo Success: Administrative permissions confirmed.!LF!
		goto runScript
    ) else (
        echo Failure: you need to run this script as administrator^^!!LF!
		pause 
		:: BatchGotAdmin
		:askPermissions
			REM  --> Check for permissions
			IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
			>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
			) ELSE (
			>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
			)

			REM --> If error flag set, we do not have admin.
			if '%errorlevel%' NEQ '0' (
				echo Requesting administrative privileges...!LF!
				goto UACPrompt
			) else ( goto gotAdmin )

			:UACPrompt
				echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
				::set params = %srcDir%
				set params = %*:"=""
				echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

				"%temp%\getadmin.vbs"
				del "%temp%\getadmin.vbs"
				::exit /B
				goto DELAYCLOSE

			:gotAdmin
				pushd "%CD%"
				CD /D "%~dp0"
		
			
		
		goto END
    )

    
:--------------------------------------


:runScript


echo   ______            _ _     _                   _                             _           _    _              _ 
echo   ^|  _  \          ( ) ^|   ^| ^|                 ^| ^|                           ^| ^|         ^| ^|  ^| ^|            ^| ^|
echo   ^| ^| ^| ^|___  _ __ ^|/^| ^|_  ^| ^|_ ___  _   _  ___^| ^|__    _ __ ___  _   _    __^| ^| ___  ___^| ^| _^| ^|_ ___  _ __ ^| ^|
echo   ^| ^| ^| / _ \^| '_ \  ^| __^| ^| __/ _ \^| ^| ^| ^|/ __^| '_ \  ^| '_ ` _ \^| ^| ^| ^|  / _` ^|/ _ \/ __^| ^|/ / __/ _ \^| '_ \^| ^|
echo   ^| ^|/ / (_) ^| ^| ^| ^| ^| ^|_  ^| ^|^| (_) ^| ^|_^| ^| (__^| ^| ^| ^| ^| ^| ^| ^| ^| ^| ^|_^| ^| ^| (_^| ^|  __/\__ \   ^<^| ^|^| (_) ^| ^|_) ^|_^|
echo   ^|___/ \___/^|_^| ^|_^|  \__^|  \__\___/ \__,_^|\___^|_^| ^|_^| ^|_^| ^|_^| ^|_^|\__, ^|  \__,_^|\___^|^|___/_^|\_\\__\___/^| .__/(_)
echo                                                                    __/ ^|                               ^| ^|      
echo                                                                   ^|___/                                ^|_^|      

	REM #######################################################################
	REM 	Check if script can know the current wallpaper
	REM #######################################################################
	echo !LF!----------------------------------------------------------------------------------------------------------------
	echo  Check current wallpaper	
	echo ----------------------------------------------------------------------------------------------------------------
	::for /f "tokens=* delims=" %%x in (currentwp.txt) do set currentWallpaper=%%x
	set /p currentWallpaper=<%wpDir%\currentwp.txt
	if [%currentWallpaper%] == [] goto listfiles
	echo Current wallpaper is %currentWallpaper%
	pause

	REM #######################################################################
	REM 	Listing and counting files in wallpapers directory
	REM #######################################################################
	:listfiles
	echo !LF!----------------------------------------------------------------------------------------------------------------
	echo  Listing all files in %wpDir%...
	echo ----------------------------------------------------------------------------------------------------------------
	cd %wpDir%
	set count=0
	for %%f in (*.*) do (
	   echo - %%f
	   if [%currentWallpaper%] == [%%f] (
		echo   will be excluded because it's the current wallpaper
	   )else (
	   	set /A count+=1
		set "file[!count!]=%%f"
	   )
	)
	echo There are %count% files.

::cd %currentDir%



	REM #######################################################################
	REM 	Choosing a random file in previous list
	REM #######################################################################
	echo !LF!----------------------------------------------------------------------------------------------------------------
	echo  Choosing a random file in previous list...
	echo ----------------------------------------------------------------------------------------------------------------
	set /A rand=%RANDOM% * count / 32768 + 1
	::call:getRandomNumber rand count
	echo Random number is %rand%, corresponding to the file !file[%rand%]!!LF!
	


	REM #######################################################################
	REM 	Prompt the user to continue
	REM #######################################################################
	setlocal
	:PROMPT
	echo !LF!----------------------------------------------------------------------------------------------------------------
	echo  Please confirm you wanna allow next steps
	echo ----------------------------------------------------------------------------------------------------------------
	echo "%outputFilename%" will be deleted and replaced by "!file[%rand%]!" with the same name.

	set /P AREYOUSURE=Are you ok with that (Y/[N])?
	if /I "%AREYOUSURE%" NEQ "Y" goto ENDTOOBAD


	REM #######################################################################
	REM 	Deleting old wallpaper
	REM #######################################################################
	:DELETEOLDWP
		echo !LF!^=^> Removing hidden and read-only properties on "%outputFilename%" in %outPutDir%...
		attrib -h %outPutDir%\%outputFilename%
		attrib -r %outPutDir%\%outputFilename%
		echo ^:^:Attributes changed!LF!
		
		echo !LF!^=^> Deleting old wallpaper "%outputFilename%" in %outPutDir%...
		del %outPutDir%\%outputFilename%
		echo ^:^:Deleting operation finished!LF!
	:--------------------------------------


	REM #######################################################################
	REM 	Copy the random file 
	REM #######################################################################
	:COPYNEWWP
		echo !LF!^=^> Copying !file[%rand%]! into %outputFilename%!LF!
		copy "!file[%rand%]!" %outPutDir%\%outputFilename%
		echo ^:^:Copying operation finished!LF!

		REM #######################################################################
		REM 	Wallpaper needs to be a hidden file and have read-only property
		REM #######################################################################
		echo !LF!^=^> Adding read-only and hidden properties on %outPutDir%\%outputFilename%...
		attrib +r %outPutDir%\%outputFilename%
		attrib +h %outPutDir%\%outputFilename%
		echo ^:^:Attributes changed!LF! 
	:--------------------------------------
	
	
	
	:BACKUPCURRENTWALLPAPER	
		echo !LF!----------------------------------------------------------------------------------------------------------------
		echo  Backup the name of the background installed in %wpDir%\currentwp.txt	
		echo ----------------------------------------------------------------------------------------------------------------
		echo !file[%rand%]!> %wpDir%\currentwp.txt	
		pause
	:--------------------------------------
	
	

	
	REM #######################################################################
	REM 	Restart explorer to refresh desktop background 
	REM #######################################################################
	:RESTARTEXPLORER
		echo !LF!----------------------------------------------------------------------------------------------------------------
		echo  It's almost done^!
		echo  Explorer needs to be restarted to refresh your wallpaper desktop
		echo ----------------------------------------------------------------------------------------------------------------
		pause
		taskkill /f /im explorer.exe
		start explorer.exe
		::%SystemRoot%\System32\RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters ,1 ,True
		::%SystemRoot%\System32\RUNDLL32.EXE user32.dll, LockWorkStation
	:--------------------------------------

	echo !LF!^:^:YOUR WALLPAPER IS CHANGED^^!!LF!
	echo #     _____                                                       _ 
	echo #    / ____^|                                                     ^| ^|
	echo #   ^| (___   ___  ___   _   _  ___  _   _   ___  ___   ___  _ __ ^| ^|
	echo #    \___ \ / _ \/ _ \ ^| ^| ^| ^|/ _ \^| ^| ^| ^| / __^|/ _ \ / _ \^| '_ \^| ^|
	echo #    ____) ^|  __/  __/ ^| ^|_^| ^| (_) ^| ^|_^| ^| \__ \ (_) ^| (_) ^| ^| ^| ^|_^|
	echo #   ^|_____/ \___^|\___^|  \__, ^|\___/ \__,_^| ^|___/\___/ \___/^|_^| ^|_(_)
	echo #                        __/ ^|                                      
	echo #                       ^|___/   
	goto BYE

	endlocal
:--------------------------------------


:ENDTOOBAD
	echo !LF!TOO BAD. YOU ARE NOT BRAVE^^!
	goto BYE
:--------------------------------------


:BYE
	echo BYE^^!!LF!
	goto DELAYCLOSE
:--------------------------------------


:END
::cmd
popd
cmd
PAUSE>nul&GOTO:EOF
::cd %srcDir%

:--------------------------------------
:DELAYCLOSE
	popd
	FOR /l %%a in (5,-1,1) do (
		TITLE %title% -- closing in %%as&ping -n 2 -w 1 127.0.0.1>NUL
		echo Terminal will close in %%a seconds
	)
	echo.&GOTO:EOF
:--------------------------------------
