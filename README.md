# WinIPFinder
Tries to find IP addresses from within Windows, using LotL (Living off the Land) tools. This is useful when engaged in an on-prem pentest / red teaming exercise.

Outputs a log file SubnetFinder-%USERDNSDOMAIN%-%COMPUTERNAME%-%ddmmyyyy%.txt

Uses the following commands to extract IP addresses from a Windows machine:

```
IPCONFIG /all
ROUTE PRINT
ARP -a
NETSTAT.EXE -n |FIND /v "127.0.0."
NET use
NETSH winhttp show proxy
TRACERT -h 2 8.8.8.8
WMIC printer get DriverName, Name, Portname | FIND /v /i "microsoft"
Qappsrv
REG query HKEY_CURRENT_USER\SOFTWARE\SimonTatham\PuTTY\SshHostKeys
REG query HKEY_CURRENT_USER\SOFTWARE\9bis.com\KiTTY\SshHostKeys
REG query HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces /s|find /i "address "
REG query HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces /s|find /i "server "
REG query "HKEY_CURRENT_USER\Software\Microsoft\Terminal Server Client\Default"
REG query "HKEY_CURRENT_USER\Software\Microsoft\Terminal Server Client\Servers"
FIND *\Documents\*.rdp "full address:"
NSLOOKUP %USERDNSDOMAIN%
NSLOOKUP -type=srv _kerberos._tcp.%USERDNSDOMAIN%
NSLOOKUP -type=srv _kpasswd._tcp.%USERDNSDOMAIN%
NSLOOKUP -type=srv _ldap._tcp.%USERDNSDOMAIN%
NSLOOKUP -type=srv _ldap._tcp.dc._msdcs.%USERDNSDOMAIN%
TRACERT -h 2 %USERDNSDOMAIN%
dsregcmd /status
```

%USERDNSDOMAIN% can also be replaced by %1 :)

Got additions? Pls let me know!
