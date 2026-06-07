import subprocess
import os
import sys

def metralhar():
    print("\033[0;32m=== METRALHADORA PRO PYTHON (MAX SPEED) ===\033[0m")
    print("[*] Objetivo: Capturar o T612 no milissegundo zero.")
    print("[*] Procedimento: Segure VOLUME BAIXO e conecte o cabo USB.")
    
    # Comando otimizado (Tiro Curto)
    cmd = [
        "sudo", "./spd_dump", "--wait", "0",
        "fdl", "fdl1-dl.bin", "0x65000800",
        "exec", "reboot-fastboot"
    ]
    
    count = 0
    try:
        while True:
            # Execução direta para menor latência
            res = subprocess.run(cmd, capture_output=True)
            
            if res.returncode == 0:
                print("\n\n\033[0;32m[✔] SUCESSO ABSOLUTO! DISPOSITIVO CAPTURADO!\033[0m")
                print(res.stdout.decode())
                sys.exit(0)
            
            count += 1
            if count % 100 == 0:
                print(f"[*] Tentativas: {count}...", end="\r")
    except KeyboardInterrupt:
        print("\n[*] Interrompido pelo usuário.")

if __name__ == "__main__":
    # Limpeza de ambiente host
    os.system("sudo modprobe -r cdc_acm 2>/dev/null")
    os.chdir("/home/krisluar/spreadtrum_flash")
    metralhar()
