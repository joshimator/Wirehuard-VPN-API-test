# Wireguard-VPN-API


`sudo apt install python3 && sudo apt install pip && sudo apt install wireguard`    
`pip install fastapi`  
`pip install uvicorn`  

wg0.conf -> /etc/wireguard  

`cd /etc/wireguard`  

`wg genkey | sudo tee /etc/wireguard/private.key`  
`cat /etc/wireguard/private.key | wg pubkey | sudo tee`  

configure files with own ip  

`sudo wg-quick up wg0`  
`sudo systemctl enable wg-quick@wg0`  

`python3 -m uvicorn main:app --host 0.0.0.0 --port 8000`  

`sudo nano /etc/sysctl.conf`  

start powershell script
