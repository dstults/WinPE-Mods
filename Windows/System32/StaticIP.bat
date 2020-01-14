netsh interface ipv4 set address "Ethernet" static 192.168.1.132 255.255.255.0 192.168.1.1
netsh interface ipv4 add dnsserver "Ethernet" address=1.1.1.1 index=1
netsh interface ipv4 add dnsserver "Ethernet" address=8.8.8.8 index=2
echo Network should be working!
echo.
pause
