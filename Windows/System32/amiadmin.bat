@echo off
:Title
	echo =================================
	echo Darren Stults
	echo Tool for determining whether you
	echo have admin privileges.
	echo (This didn't work in WinPE... and
	echo it wouldn't matter because in
	echo WinPE you are always admin, but I
	echo wanted to hold onto it until I
	echo found a script that can.)
	echo =================================
	echo.
	echo Checking for admin privileges...
	net file 1>nul 2>nul
	if %errorlevel% == 2 goto NotAdmin
	goto Success
:NotAdmin
	echo You are not admin!
	echo You must run the command prompt as administrator.
	goto Failure
:Success
	echo Success!
	echo.
	echo Network setup complete.
	goto Ending
:UnknownErrorFail
	echo.
	echo Please report to Darren!
	echo Encountered unknown error: %errorlevel%
	echo During phase: %myPhase%
	goto Failure
:Failure
	echo.
	echo Network setup failed.
	goto Ending
:Ending
	pause
