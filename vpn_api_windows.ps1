while($true){

$input = Read-Host -Prompt "
New connection :1
Delete old     :2
Exit           :3"

if ($input -eq 1){
Start-Connection
}

elseif ($input -eq 2){
Remove-Connection
}

elseif($input -eq 3){
break
}
}



Function Remove-Connection{
&  "c:\Program Files\WireGuard\wireguard.exe" /uninstalltunnelservice wg0
Start-Sleep -Seconds 5
Write-Host "Verbindung entfernt!"
}


Function Start-Connection{

$data = Invoke-RestMethod -Uri http://PUBLIC-SERVER-IP:8000/key?gen=true
$path = "C:\Users\"+$env:UserName+"\Desktop\wg0.conf"
$target = "PUBLIC-SERVER-IP:51820"
$privkey = $data[0]
$servkey = $data[1]
$address = $data[2]

Set-Content -Path $path -Value "
[Interface]
Address = $address
PrivateKey = $privkey
DNS = 8.8.8.8
[Peer]
PublicKey = $servkey
Endpoint = $target
AllowedIPs = 0.0.0.0/0, ::/0"


& "c:\Program Files\WireGuard\wireguard.exe" /installtunnelservice $path

Start-Sleep -Seconds 10
if(ping google.com){
    Write-Host "Verbindung erfolgreich!"
    }
}
