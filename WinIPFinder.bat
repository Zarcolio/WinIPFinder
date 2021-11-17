@ECHO OFF
IF NOT "%1"=="" SET LookupDomain=%1
IF "%1"=="" SET LookupDomain=%USERDOMAIN%
IF "%LookupDomain%"=="" SET LookupDomain=#_NO_DOMAIN_#

SET yy=%date:~-4%
SET mm=%date:~-7,2%
SET dd=%date:~-10,2%
SET curdate=%yy%%mm%%dd%

SET scriptpath=%~dp0

SET OutputFile="%scriptpath%IPAddressesFound-%USERDOMAIN%-%COMPUTERNAME%-%curdate%.txt"
ECHO ################################################################################################################>%OutputFile%
ECHO #                                                                                                               #>>%OutputFile%
ECHO # IPCONFIG /a                                                                                                    #>>%OutputFile%
ECHO #                                                                                                               #>>%OutputFile%
ECHO ################################################################################################################>>%OutputFile%
IPCONFIG /all>>%OutputFile%
ECHO ################################################################################################################>>%OutputFile%
ECHO #                                                                                                               #>>%OutputFile%
ECHO # ROUTE print                                                                                                    #>>%OutputFile%
ECHO #                                                                                                               #>>%OutputFile%
ECHO ################################################################################################################>>%OutputFile%
ROUTE PRINT>>%OutputFile%
ECHO ################################################################################################################>>%OutputFile%
ECHO #                                                                                                               #>>%OutputFile%
ECHO # ARP -a                                                                                                         #>>%OutputFile%
ECHO #                                                                                                               #>>%OutputFile%
ECHO ################################################################################################################>>%OutputFile%
ARP -a>>%OutputFile%
ECHO ################################################################################################################>>%OutputFile%
ECHO #                                                                                                               #>>%OutputFile%
ECHO # NETSTAT -n                                                                                                     #>>%OutputFile%
ECHO #                                                                                                               #>>%OutputFile%
ECHO ################################################################################################################>>%OutputFile%
NETSTAT.EXE -n |FIND /v "127.0.0.">>%OutputFile%
ECHO ################################################################################################################>>%OutputFile%
ECHO #                                                                                                               #>>%OutputFile%
ECHO # NET use                                                                                                        #>>%OutputFile%
ECHO #                                                                                                               #>>%OutputFile%
ECHO ################################################################################################################>>%OutputFile%
NET use>>%OutputFile%
ECHO ################################################################################################################>>%OutputFile%
ECHO #                                                                                                               #>>%OutputFile%
ECHO # NETSH winhttp show proxy                                                                                       #>>%OutputFile%
ECHO #                                                                                                               #>>%OutputFile%
ECHO ################################################################################################################>>%OutputFile%
NETSH winhttp show proxy>>%OutputFile%
ECHO ################################################################################################################>>%OutputFile%
ECHO #                                                                                                               #>>%OutputFile%
ECHO # TRACERT                                                                                                        #>>%OutputFile%
ECHO #                                                                                                               #>>%OutputFile%
ECHO ################################################################################################################>>%OutputFile%
TRACERT -h 2 8.8.8.8>>%OutputFile%
ECHO ################################################################################################################>>%OutputFile%
ECHO #                                                                                                               #>>%OutputFile%
ECHO # WMIC printer                                                                                                   #>>%OutputFile%
ECHO #                                                                                                               #>>%OutputFile%
ECHO ################################################################################################################>>%OutputFile%
WMIC printer get DriverName, Name, Portname | FIND /v /i "microsoft">>%OutputFile%
ECHO ################################################################################################################>>%OutputFile%
ECHO #                                                                                                               #>>%OutputFile%
ECHO # Qappsrv                                                                                                        #>>%OutputFile%
ECHO #                                                                                                               #>>%OutputFile%
ECHO ################################################################################################################>>%OutputFile%
Qappsrv>>%OutputFile%
ECHO ################################################################################################################>>%OutputFile%
ECHO #                                                                                                               #>>%OutputFile%
ECHO # REG query HKCU SshHostKeys                                                                                     #>>%OutputFile%
ECHO #                                                                                                               #>>%OutputFile%
ECHO ################################################################################################################>>%OutputFile%
REG query HKEY_CURRENT_USER\SOFTWARE\SimonTatham\PuTTY\SshHostKeys>>%OutputFile%
REG query HKEY_CURRENT_USER\SOFTWARE\9bis.com\KiTTY\SshHostKeys>>%OutputFile%
ECHO ################################################################################################################>>%OutputFile%
ECHO #                                                                                                               #>>%OutputFile%
ECHO # REG query HKLM SshHostKeys Tcpip Interfaces                                                                    #>>%OutputFile%
ECHO #                                                                                                               #>>%OutputFile%
ECHO ################################################################################################################>>%OutputFile%
REG query HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces /s|find /i "address ">>%OutputFile%
REG query HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces /s|find /i "server ">>%OutputFile%

IF NOT "%1"=="" GOTO manualDomain

IF "%USERDOMAIN%"=="AzureAD" (
	ECHO This computer is connected to AzureAD...
	GOTO Ending
)
IF "%LOGONSERVER%"=="\\%COMPUTERNAME%" ECHO This computer doesn't seem to be domain-joined...
IF "%LOGONSERVER%"=="\\%COMPUTERNAME%" GOTO skipDomain
IF "%USERDOMAIN%"=="" ECHO This computer doesn't seem to be domain-joined...
IF "%USERDOMAIN%"=="" GOTO skipDomain
:manualDomain

	NSLOOKUP %LookupDomain%>>%OutputFile%
	NSLOOKUP -type=srv _kerberos._tcp.%LookupDomain%>>%OutputFile%
	NSLOOKUP -type=srv _kpasswd._tcp.%LookupDomain%>>%OutputFile%
	NSLOOKUP -type=srv _ldap._tcp.%LookupDomain%>>%OutputFile%
	NSLOOKUP -type=srv _ldap._tcp.dc._msdcs.%LookupDomain%>>%OutputFile%
	TRACERT -h 2 %LookupDomain%>>%OutputFile%

	GOTO Ending
rem :skipDomain

For /F "tokens=1 Delims={}" %%A In (   'WMIC NICConfig Where "IPEnabled='TRUE'" Get DNSDomainSuffixSearchOrder') Do (
	SET LookupDomain=%%~A
	rem echo %LookupDomain%
	NSLOOKUP %LookupDomain%>>%OutputFile%
	NSLOOKUP -type=srv _kerberos._tcp.%LookupDomain%>>%OutputFile%
	NSLOOKUP -type=srv _kpasswd._tcp.%LookupDomain%>>%OutputFile%
	NSLOOKUP -type=srv _ldap._tcp.%LookupDomain%>>%OutputFile%
	NSLOOKUP -type=srv _ldap._tcp.dc._msdcs.%LookupDomain%>>%OutputFile%
	TRACERT -h 2 %LookupDomain%>>%OutputFile%
)

:skipDomain
:Ending