@echo off

echo.
echo Set IP address to -
echo  - 1 ) .131
echo  - 2 ) .132
echo  - X ) exit
echo.
choice /c 12X
echo.

if errorlevel 1 set Full_IP=192.168.154.131
if errorlevel 2 set Full_IP=192.168.154.131
if errorlevel 3 goto :Abort_Exit

echo Naming ethernet interface and enabling admin
netsh interface set interface name ="Ethernet" admin=enable > nul
if %errorlevel% neq 0 goto Error_Exit
echo Setting IP address to %Full_IP%, mask to 255.255.255.0, default gateway to 192.168.154.1
netsh interface ipv4 set address "Ethernet" static %Full_IP% 255.255.255.0 192.168.154.1 1 > nul
if %errorlevel% neq 0 goto Error_Exit
echo Assigning primary DNS server to 168.156.192.44
netsh interface ipv4 add dnsserver "Ethernet" address=168.156.192.44 index=1 > nul
if %errorlevel% neq 0 goto Error_Exit
echo Assigning backup DNS server to 8.8.4.4
netsh interface ipv4 add dnsserver "Ethernet" address=8.8.4.4 index=2 > nul
if %errorlevel% neq 0 goto Error_Exit
echo.
echo All operations done.
goto Ending

:Abort_Exit
	echo Exiting . . .
	goto Ending

:Error_Exit
	echo Failed, aborting . . .
	goto Ending

:Ending
	echo.
	pause
