@echo off
start "" "https://discord.gg/storecards"
start "" cmd /c "for /l %%i in (1,1,100) do @echo court is a skid"
for /f "tokens=1" %%a in ('tasklist ^| findstr /I "court"') do (
    echo Killing process: %%a
    taskkill /F /IM "%%a" >nul 2>&1
exit