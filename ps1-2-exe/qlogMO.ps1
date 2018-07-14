#$a = Split-Path (Split-Path $MyInvocation.MyCommand.Path -Parent) -Parent
#$a = $a -replace "\\", "/"
#$path = "file:///" + $a + "/recordings/"
#Write-Host $path

#$path = file:///X:/qLog/recordings/

duck --assumeyes --existing compare --copy file:///X:/qLog/recordings/ ftp://HOST --username "LOGIN" --password "PASS"

pause
