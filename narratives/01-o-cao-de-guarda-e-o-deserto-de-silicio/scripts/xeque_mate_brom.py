import subprocess
import os
import sys

def xeque_mate():
    print("\033[0;32m=== XEQUE-MATE BROM: UNLOCK DIRETO E LIMPEZA MDM ===\033[0m")
    print("[*] Objetivo: Limpar config/persist via Hardware (Bypass Fastboot).")
    print("[*] Procedimento: Segure VOLUME BAIXO e conecte o cabo USB.")
    
    # Comando definitivo de limpeza e reset
    # e config: Remove trava de bootloader
    # e persist: Remove trava de MDM/Empresa
    # reset: Reinicia o sistema limpo
    cmd = [
        "sudo", "./spd_dump", "--wait", "0",
        "fdl", "fdl1-dl.bin", "0x65000800",
        "fdl", "fdl2-dl.bin", "0x9efffe00",
        "exec_addr", "0x65015f08",
        "exec", "e", "config", "e", "persist", "reset"
    ]
    
    count = 0
    try:
        while True:
            # Execução de alta performance
            res = subprocess.run(cmd, capture_output=True)
            
            if res.returncode == 0:
                print("\n\n\033[0;32m[✔] SUCESSO ABSOLUTO! MDM NEUTRALIZADO!\033[0m")
                print(res.stdout.decode())
                print("\033[1;33mO celular deve reiniciar limpo. Aguarde o boot.\033[0m")
                sys.exit(0)
            
            count += 1
            if count % 100 == 0:
                print(f"[*] Tentativas de injeção: {count}...", end="\r")
    except KeyboardInterrupt:
        print("\n[*] Interrompido pelo usuário.")

if __name__ == "__main__":
    # Limpeza de ambiente
    os.system("sudo modprobe -r cdc_acm 2>/dev/null")
    os.chdir("/home/krisluar/spreadtrum_flash")
    xeque_mate()
