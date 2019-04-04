@echo off

echo Enabling ethernet if there is one (in case it was disabled)
netsh interface set interface name ="Ethernet" admin=enable >nul
if %errorlevel% neq 0 goto Error_Exit

echo Custom Static IPv4 Setup -
set /p ipAddy=" - IP Address (nothing for 192.168.154.132): "
if "%ipAddy%"=="" (set ipAddy="192.168.154.132")
set /p subMask=" - Subnet Mask (nothing for 255.255.255.0): "
if "%subMask%"=="" (set subMask="255.255.255.0")
set /p gateway=" - Default Gateway (nothing for 192.168.154.1): "
if "%gateway%"=="" (set gateway="192.168.154.1")

echo Setting IP address to %ipAddy%, mask to %subMask%, default gateway to %gateway%
netsh interface ipv4 set address "Ethernet" static %ipAddy& %subMask% %gateway% >nul
if %errorlevel% neq 0 goto Error_Exit

set /p dns1=" - DNS, Primary (nothing for 192.168.154.44): "
if "%dns1%"=="" (set dns1="192.168.154.44")
echo Assigning primary DNS server to %dns1%
netsh interface ipv4 add dnsserver "Ethernet" address=%dns1% index=1 >nul
if %errorlevel% neq 0 goto Error_Exit

set /p dns2=" - DNS, Backup (nothing for 8.8.4.4): "
if "%dns2%"=="" (set dns2="8.8.4.4")
echo Assigning backup DNS server to %dns2%
netsh interface ipv4 add dnsserver "Ethernet" address=%dns2% index=2 >nul
if %errorlevel% neq 0 goto Error_Exit

echo.
echo Static IP setup complete, please confirm connection status.
ipconfig /all
goto Ending

:Error_Exit
	echo Failed, aborting . . .
	goto Ending

:Ending
	echo.
	pause
