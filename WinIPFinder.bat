@ECHO OFF
IF NOT "%1"=="" SET LookupDomain=%1
IF "%1"=="" SET LookupDomain=%USERDNSDOMAIN%
IF "%LookupDomain%"=="" SET LookupDomain=#_NO_DOMAIN_#

SET yy=%date:~-4%
SET mm=%date:~-7,2%
SET dd=%date:~-10,2%
SET curdate=%yy%%mm%%dd%

SET scriptpath=%~dp0

SET OutputFile="%scriptpath%IPAddressesFound-%USERDOMAIN%-%COMPUTERNAME%-%curdate%.txt"
ECHO ################################################################################################################>%OutputFile%
ECHO #                                                                                                               #>>%OutputFile% 2>&1
ECHO # IPCONFIG /a                                                                                                    #>>%OutputFile% 2>&1
ECHO #                                                                                                               #>>%OutputFile% 2>&1
ECHO ################################################################################################################>>%OutputFile% 2>&1
IPCONFIG /all>>%OutputFile% 2>&1

ECHO ################################################################################################################>>%OutputFile% 2>&1
ECHO #                                                                                                               #>>%OutputFile% 2>&1
ECHO # ROUTE print                                                                                                    #>>%OutputFile% 2>&1
ECHO #                                                                                                               #>>%OutputFile% 2>&1
ECHO ################################################################################################################>>%OutputFile% 2>&1
ROUTE PRINT>>%OutputFile% 2>&1

ECHO ################################################################################################################>>%OutputFile% 2>&1
ECHO #                                                                                                               #>>%OutputFile% 2>&1
ECHO # ARP -a                                                                                                         #>>%OutputFile% 2>&1
ECHO #                                                                                                               #>>%OutputFile% 2>&1
ECHO ################################################################################################################>>%OutputFile% 2>&1
ARP -a>>%OutputFile% 2>&1

ECHO ################################################################################################################>>%OutputFile% 2>&1
ECHO #                                                                                                               #>>%OutputFile% 2>&1
ECHO # NBTSTAT -c                                                                                                     #>>%OutputFile% 2>&1
ECHO #                                                                                                               #>>%OutputFile% 2>&1
ECHO ################################################################################################################>>%OutputFile% 2>&1
NBTSTAT -c>>%OutputFile% 2>&1

ECHO ################################################################################################################>>%OutputFile% 2>&1
ECHO #                                                                                                               #>>%OutputFile% 2>&1
ECHO # NETSTAT -n                                                                                                     #>>%OutputFile% 2>&1
ECHO #                                                                                                               #>>%OutputFile% 2>&1
ECHO ################################################################################################################>>%OutputFile% 2>&1
NETSTAT.EXE -n |FIND /v "127.0.0.">>%OutputFile% 2>&1

ECHO ################################################################################################################>>%OutputFile% 2>&1
ECHO #                                                                                                               #>>%OutputFile% 2>&1
ECHO # NET use                                                                                                        #>>%OutputFile% 2>&1
ECHO #                                                                                                               #>>%OutputFile% 2>&1
ECHO ################################################################################################################>>%OutputFile% 2>&1
NET use>>%OutputFile% 2>&1

ECHO ################################################################################################################>>%OutputFile% 2>&1
ECHO #                                                                                                               #>>%OutputFile% 2>&1
ECHO # NETSH winhttp show proxy                                                                                       #>>%OutputFile% 2>&1
ECHO #                                                                                                               #>>%OutputFile% 2>&1
ECHO ################################################################################################################>>%OutputFile% 2>&1
NETSH winhttp show proxy>>%OutputFile% 2>&1

ECHO ################################################################################################################>>%OutputFile% 2>&1
ECHO #                                                                                                               #>>%OutputFile% 2>&1
ECHO # TRACERT                                                                                                        #>>%OutputFile% 2>&1
ECHO #                                                                                                               #>>%OutputFile% 2>&1
ECHO ################################################################################################################>>%OutputFile% 2>&1
TRACERT -h 2 self.events.data.microsoft.com>>%OutputFile% 2>&1

ECHO ################################################################################################################>>%OutputFile% 2>&1
ECHO #                                                                                                               #>>%OutputFile% 2>&1
ECHO # WMIC printer                                                                                                   #>>%OutputFile% 2>&1
ECHO #                                                                                                               #>>%OutputFile% 2>&1
ECHO ################################################################################################################>>%OutputFile% 2>&1
WMIC printer get DriverName, Name, Portname | FIND /v /i "microsoft">>%OutputFile% 2>&1

ECHO ################################################################################################################>>%OutputFile% 2>&1
ECHO #                                                                                                               #>>%OutputFile% 2>&1
ECHO # Qappsrv                                                                                                        #>>%OutputFile% 2>&1
ECHO #                                                                                                               #>>%OutputFile% 2>&1
ECHO ################################################################################################################>>%OutputFile% 2>&1
Qappsrv>>%OutputFile% 2>&1

ECHO ################################################################################################################>>%OutputFile% 2>&1
ECHO #                                                                                                               #>>%OutputFile% 2>&1
ECHO # REG query HKCU SshHostKeys                                                                                     #>>%OutputFile% 2>&1
ECHO #                                                                                                               #>>%OutputFile% 2>&1
ECHO ################################################################################################################>>%OutputFile% 2>&1
REG query HKEY_CURRENT_USER\SOFTWARE\SimonTatham\PuTTY\SshHostKeys>>%OutputFile% 2>&1
REG query HKEY_CURRENT_USER\SOFTWARE\9bis.com\KiTTY\SshHostKeys>>%OutputFile% 2>&1

ECHO ################################################################################################################>>%OutputFile% 2>&1
ECHO #                                                                                                               #>>%OutputFile% 2>&1
ECHO # REG query HKLM SshHostKeys Tcpip Interfaces                                                                    #>>%OutputFile% 2>&1
ECHO #                                                                                                               #>>%OutputFile% 2>&1
ECHO ################################################################################################################>>%OutputFile% 2>&1
REG query HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces /s|find /i "address ">>%OutputFile% 2>&1
REG query HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces /s|find /i "server ">>%OutputFile% 2>&1

ECHO ################################################################################################################>>%OutputFile% 2>&1
ECHO #                                                                                                               #>>%OutputFile% 2>&1
ECHO # REG query HKCU Terminal Servers                                                                                #>>%OutputFile% 2>&1
ECHO #                                                                                                               #>>%OutputFile% 2>&1
ECHO ################################################################################################################>>%OutputFile% 2>&1
REG query "HKEY_CURRENT_USER\Software\Microsoft\Terminal Server Client\Default">>%OutputFile% 2>&1
REG query "HKEY_CURRENT_USER\Software\Microsoft\Terminal Server Client\Servers">>%OutputFile% 2>&1

ECHO ################################################################################################################>>%OutputFile% 2>&1
ECHO #                                                                                                               #>>%OutputFile% 2>&1
ECHO # FIND *\Documents\*.rdp                                                                                         #>>%OutputFile% 2>&1
ECHO #                                                                                                               #>>%OutputFile% 2>&1
ECHO ################################################################################################################>>%OutputFile% 2>&1
FIND %userprofile%\documents\*.rdp "full address:">>%OutputFile% 2>&1
FIND %OneDrive%\documents\*.rdp "full address:">>%OutputFile% 2>&1

ECHO ################################################################################################################>>%OutputFile% 2>&1
ECHO #                                                                                                               #>>%OutputFile% 2>&1
ECHO # dsregcmd /status                                                                                               #>>%OutputFile% 2>&1
ECHO #                                                                                                               #>>%OutputFile% 2>&1
ECHO ################################################################################################################>>%OutputFile% 2>&1
dsregcmd /status>>%OutputFile% 2>&1

IF NOT "%1"=="" GOTO manualDomain

IF "%LookupDomain%"=="" ECHO This computer doesn't seem to be domain-joined...
IF "%LookupDomain%"=="" GOTO skipDomain
IF "%LOGONSERVER%"=="\\%COMPUTERNAME%" ECHO This computer doesn't seem to be domain-joined...
IF "%LOGONSERVER%"=="\\%COMPUTERNAME%" GOTO skipDomain
:manualDomain

	NSLOOKUP %LookupDomain%>>%OutputFile% 2>&1
	NSLOOKUP -type=srv _kerberos._tcp.%LookupDomain%>>%OutputFile% 2>&1
	NSLOOKUP -type=srv _kpasswd._tcp.%LookupDomain%>>%OutputFile% 2>&1
	NSLOOKUP -type=srv _ldap._tcp.%LookupDomain%>>%OutputFile% 2>&1
	NSLOOKUP -type=srv _ldap._tcp.dc._msdcs.%LookupDomain%>>%OutputFile% 2>&1
	TRACERT -h 2 %LookupDomain%>>%OutputFile% 2>&1

	GOTO Ending
rem :skipDomain

For /F "tokens=1 Delims={}" %%A In (   'WMIC NICConfig Where "IPEnabled='TRUE'" Get DNSDomainSuffixSearchOrder') Do (
	SET LookupDomain=%%~A
	rem echo %LookupDomain%
	NSLOOKUP %LookupDomain%>>%OutputFile% 2>&1
	NSLOOKUP -type=srv _kerberos._tcp.%LookupDomain%>>%OutputFile% 2>&1
	NSLOOKUP -type=srv _kpasswd._tcp.%LookupDomain%>>%OutputFile% 2>&1
	NSLOOKUP -type=srv _ldap._tcp.%LookupDomain%>>%OutputFile% 2>&1
	NSLOOKUP -type=srv _ldap._tcp.dc._msdcs.%LookupDomain%>>%OutputFile% 2>&1
	TRACERT -h 2 %LookupDomain%>>%OutputFile% 2>&1
)

:skipDomain
:Ending
