import usb.core
import usb.util
import subprocess
import time
import sys
import os

# IDs do chip Unisoc/Spreadtrum
ID_VENDOR = 0x1782
ID_PRODUCT = 0x4d00

# Configurações do comando
SPD_DUMP_PATH = "/home/krisluar/spreadtrum_flash/spd_dump"
FDL1 = "/home/krisluar/spreadtrum_flash/fdl1-dl.bin"
FDL2 = "/home/krisluar/spreadtrum_flash/fdl2-dl.bin"

def find_device():
    print(f"[*] Procurando por dispositivo {ID_VENDOR:04x}:{ID_PRODUCT:04x}...")
    while True:
        dev = usb.core.find(idVendor=ID_VENDOR, idProduct=ID_PRODUCT)
        if dev:
            print(f"\n[!] DISPOSITIVO DETECTADO!")
            return dev
        time.sleep(0.01) # Alta frequência de varredura

def run_attack():
    cmd = [
        "sudo", SPD_DUMP_PATH,
        "--wait", "0",
        "fdl", FDL1, "0x65000800",
        "fdl", FDL2, "0x9efffe00",
        "exec_addr", "0x65015f08"
    ]
    
    print(f"[*] Executando comando: {' '.join(cmd)}")
    try:
        # Tenta o comando de desbloqueio logo em seguida
        process = subprocess.Popen(cmd)
        process.wait()
        
        print("\n[*] Primeira fase concluída. Tentando comando de desbloqueio via Fastboot...")
        time.sleep(2)
        subprocess.run(["sudo", "fastboot", "flashing", "unlock_bootloader"])
        subprocess.run(["sudo", "fastboot", "oem", "unlock"])
        
    except Exception as e:
        print(f"[!] Erro: {e}")

if __name__ == "__main__":
    if os.geteuid() != 0:
        print("[!] Este script precisa ser rodado como ROOT (sudo python3 ataque_unisoc.py)")
        sys.exit(1)
        
    # Desativa ModemManager para evitar conflitos
    subprocess.run(["systemctl", "stop", "ModemManager"])
    
    dev = find_device()
    # Pequeno delay para o sistema operacional estabilizar o descritor
    time.sleep(0.1)
    run_attack()
