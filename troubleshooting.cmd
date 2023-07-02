@echo off

REM Getting the user's desktop path
for /f "usebackq delims=" %%a in (`reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v Desktop`) do (
    set "desktop=%%a"
)

REM Creating the troubleshooting.txt file on the user's desktop
set "output=%desktop%\troubleshooting.txt"

REM Date and time
echo %date% %time% >> "%output%"

REM Running network diagnostic tools...

REM Displaying IP configuration
echo IP Configuration: >> "%output%"
ipconfig /all >> "%output%"

REM Displaying system information
echo System Information: >> "%output%"
systeminfo >> "%output%"

REM Ping test
echo Ping Test: >> "%output%"
ping www.google.com >> "%output%"

REM Tracert route test
echo Tracert Test: >> "%output%"
tracert www.google.com >> "%output%"

REM NSLookup
echo NSLookup: >> "%output%"
nslookup www.google.com >> "%output%"

REM Displaying ARP table
echo ARP Table: >> "%output%"
arp -a >> "%output%"

REM Netstat
echo Netstat: >> "%output%"
netstat -ano >> "%output%"

REM Connection logs
echo Connection Logs: >> "%output%"
netsh trace start capture=yes report=yes persistent=no overwrite=yes maxsize=1024 tracefile=tracelog.etl >> "%output%"
timeout /t 10
netsh trace stop
type tracelog.etl >> "%output%"
del tracelog.etl

REM DHCP settings
echo DHCP Settings: >> "%output%"
ipconfig /allcompartments /all >> "%output%"
timeout /t 5

REM Network traffic capture
echo Network Traffic Capture: >> "%output%"
netsh trace start capture=yes tracefile=networktrace.etl >> "%output%"
timeout /t 10
netsh trace stop
type networktrace.etl >> "%output%"
del networktrace.etl

REM DNS cache
echo DNS Cache: >> "%output%"
ipconfig /displaydns >> "%output%"

REM Script executed
echo Network diagnostic tools executed. Detailed information has been appended to the troubleshooting.txt file on the desktop.
