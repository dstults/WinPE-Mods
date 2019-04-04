@echo off

set Full_IP=192.168.154.132

echo Enabling ethernet
netsh interface set interface name ="Ethernet" admin=enable > nul
if %errorlevel% neq 0 goto Error_Exit
echo Setting IP address to %Full_IP%, mask to 255.255.255.0, default gateway to 192.168.154.1
netsh interface ipv4 set address "Ethernet" static %Full_IP% 255.255.255.0 192.168.154.1 > nul
if %errorlevel% neq 0 goto Error_Exit
echo Assigning primary DNS server to 192.168.154.44
netsh interface ipv4 add dnsserver "Ethernet" address=192.168.154.44 index=1 > nul
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
	echo Try 'netdummy' ?
	goto Ending

:Ending
	echo.
	pause
