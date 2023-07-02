@echo off

REM Teams folder paths
set "teamsAppData=%APPDATA%\Microsoft\Teams"
set "teamsLocalAppData=%LOCALAPPDATA%\Microsoft\Teams"

REM Deleting unnecessary files from Teams folders
echo Deleting unnecessary files from Teams folders...
echo.

REM Delay between deletions (3 seconds)
timeout /t 3 >nul

REM Deleting files from Teams folders
echo Deleting files from Teams folders...
rd /s /q "%teamsAppData%\*"
rd /s /q "%teamsLocalAppData%\*"
echo.

REM Delay before browser history deletion (3 seconds)
timeout /t 3 >nul

REM Clearing browser history
echo Clearing browser history...
echo.

REM Deleting Edge browser history
echo Deleting Edge browser history...
start msedge:history
timeout /t 5 >nul
taskkill /im msedge.exe >nul 2>&1
echo Edge browser history has been cleared.
echo.

REM Deleting Firefox browser history
echo Deleting Firefox browser history...
start firefox.exe -url "about:preferences#privacy"
timeout /t 5 >nul
taskkill /im firefox.exe >nul 2>&1
echo Firefox browser history has been cleared.
echo.

REM Deleting Chrome browser history
echo Deleting Chrome browser history...
start chrome.exe --chrome-frame --incognito "chrome://settings/clearBrowserData"
timeout /t 5 >nul
taskkill /im chrome.exe >nul 2>&1
echo Chrome browser history has been cleared.
echo.

REM Deleting Safari browser history
echo Deleting Safari browser history...
start /b /wait /min /d "%ProgramFiles%\Safari" safari.exe -E
timeout /t 5 >nul
taskkill /im Safari.exe >nul 2>&1
echo Safari browser history has been cleared.
echo.

REM Delay before shutdown (3 seconds)
timeout /t 3 >nul

REM Emptying Recycle Bin
echo Emptying Recycle Bin...
echo.
echo Set objShell = CreateObject("Shell.Application") > "%temp%\emptybin.vbs"
echo Set recycleBin = objShell.Namespace(10) >> "%temp%\emptybin.vbs"
echo recycleBin.EmptyRecycleBin 0, False >> "%temp%\emptybin.vbs"
cscript //nologo "%temp%\emptybin.vbs"
del /q "%temp%\emptybin.vbs"
echo.

REM Delay before restart (3 seconds)
timeout /t 3 >nul

REM Forcing restart
echo Forcing restart...
shutdown /s /f /t 0

REM Done
echo Done.
