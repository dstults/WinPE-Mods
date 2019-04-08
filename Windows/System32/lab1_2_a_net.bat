netsh interface ipv4 set address "Ethernet" static 192.168.154.132 255.255.255.0 192.168.154.1
netsh interface ipv4 add dnsserver "Ethernet" address=168.156.192.44 index=1
netsh interface ipv4 add dnsserver "Ethernet" address=8.8.4.4 index=2
echo Network should be working!
echo.
pause
