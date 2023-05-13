from fastapi import FastAPI
import subprocess
counter = 1
app = FastAPI()
@app.get("/key")
def generate_wireguard_keys(gen: bool):
    if gen is True:
        privkey = subprocess.check_output("wg genkey", shell=True).decode("utf-8").strip()
        pubkey = subprocess.check_output(f"echo '{privkey}' | wg pubkey", shell=True).decode("utf-8").strip()
        global counter
        ip = "192.168.1."+str(counter)+"/32"
        addPubkey = ["wg", "set", "wg0", "peer", str(pubkey), "allowed-ips", "192.168.1."+str(counter)+"/32"]
        subprocess.run(addPubkey)
        counter +=1
        serverpub = "PUBLIC SERVER IP"

        return (privkey,serverpub,ip)
