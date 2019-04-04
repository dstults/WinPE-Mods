echo Disabling Ethernet/Wi-Fi adapters...
netsh interface set interface name ="Ethernet" admin=disabled
netsh interface set interface name ="Wi-Fi" admin=disabled
wait 500
echo Restarting Ethernet/Wi-Fi adapters...
netsh interface set interface name ="Ethernet" admin=enabled
netsh interface set interface name ="Wi-Fi" admin=enabled
echo Done.
