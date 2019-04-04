@echo off
:Title
	echo =================================
	echo Welcome to Darren's Network Setup
	echo for dummies batch file!
	echo I will attempt to automatically
	echo set up your internet and if it's
	echo not working I'll tell you why!
	echo =================================
	echo.
:Phase1
	set myPhase=Phase1
	echo Enabling Ethernet interface . . .
	set interfaceType=Ethernet
	netsh interface set interface name ="%interfaceType%" admin=enable >nul
	if %errorlevel% == 0 goto Phase2
	if %errorlevel% == 1 goto Phase1Wifi
	goto UnknownErrorFail
:Phase1Wifi
	set myPhase=Phase1b
	echo No Ethernet adapter!
	echo.
	echo Enabling Wi-Fi interface . . .
	set interfaceType=Wi-Fi
	netsh interface set interface name ="%interfaceType%" admin=enable >nul
	if %errorlevel% == 0 goto Phase2WiFi
	if %errorlevel% == 1 goto Phase1NoNet
	goto UnknownErrorFail
:Phase1NoNet
	set myPhase=Phase1c
	echo No Wi-Fi adapter!
	echo It seems you lack an ethernet or wifi adapter . . .
	goto Failure
:Phase2
	echo Success!
	echo.
	set ipAddy=192.168.154.132
	set mask=255.255.255.0
	set gateway=192.168.154.1
	set dns1=192.168.154.44
	set dns2=8.8.4.4
	echo Setting your IP to [%ipAddy%] static,
	echo     network mask to [%mask%], and
	echo     default gateway to [%gateway%] . . .
	set myPhase=Phase2-ip
	netsh interface ipv4 set address "%interfaceType%" static %ipAddy% %mask% %gateway%
	if %errorlevel% neq 0 goto UnknownErrorFail
	echo Success!
	echo.
	echo Setting DNS, primary to [%dns1%] . . .
	set myPhase=Phase2-dns1
	netsh interface ipv4 add dnsserver "%interfaceType%" address=%dns1% index=1
	if %errorlevel% neq 0 goto UnknownErrorFail
	echo Success!
	echo.
	echo Setting DNS, backup to [%dns2%] . . .
	set myPhase=Phase2-dns2
	netsh interface ipv4 add dnsserver "%interfaceType%" address=%dns2% index=2
	if %errorlevel% neq 0 goto UnknownErrorFail
	goto Success
:Phase2WiFi
	echo Success!
	echo.
	echo So uh...Wi-Fi isn't ready yet! Have fun!
	goto Ending
	echo Success!
	echo.
	echo Enabling DHCP . . .
	set myPhase=Phase2-dhcp
	rem netsh interface ipv4 set address "Local Area Connection" dhcp
	if %errorlevel% neq 0 goto UnknownErrorFail
	echo.
	echo Auto-connecting Wi-Fi to nearby server of choice . . .
	set myPhase=Phase2-wifi
	rem netsh wlan
	if %errorlevel% neq 0 goto UnknownErrorFail
	echo Success!
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
	exit /b

rem netsh interface set interface name ="Ethernet" admin=enable
rem netsh interface ipv4 set address "Ethernet" static 192.168.154.131 255.255.255.0 192.168.154.1
rem netsh interface ipv4 add dnsserver "Ethernet" address=168.156.192.44 index=1
rem netsh interface ipv4 add dnsserver "Ethernet" address=8.8.4.4 index=2
