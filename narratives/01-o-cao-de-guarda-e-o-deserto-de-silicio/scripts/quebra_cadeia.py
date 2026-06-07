import subprocess
import os
import sys

def quebrar_cadeia():
    print("\033[0;31m=== OPERAÇÃO QUEBRA DE CADEIA: FORÇANDO ESTABILIDADE ===\033[0m")
    print("[*] Objetivo: Apagar vbmeta para impedir o boot do MDM e estabilizar o USB.")
    print("[*] PROCEDIMENTO: Segure VOLUME BAIXO e conecte o cabo USB.")
    
    # Comando para apagar as partições de verificação
    # Isso forçará o celular a parar o bootloop e aceitar o Fastboot
    cmd = [
        "sudo", "./spd_dump", "--wait", "0",
        "fdl", "fdl1-dl.bin", "0x65000800",
        "fdl", "fdl2-dl.bin", "0x9efffe00",
        "exec_addr", "0x65015f08",
        "exec", 
        "e", "vbmeta_a", 
        "e", "vbmeta_system_a", 
        "e", "vbmeta_vendor_a",
        "reset"
    ]
    
    count = 0
    try:
        while True:
            # Execução de alta frequência
            res = subprocess.run(cmd, capture_output=True)
            
            if res.returncode == 0:
                print("\n\n\033[0;32m[✔] CADEIA DE CONFIANÇA ROMPIDA COM SUCESSO!\033[0m")
                print("\033[1;33mO celular deve reiniciar para uma tela de erro ou Fastboot estável.\033[0m")
                print(res.stdout.decode())
                sys.exit(0)
            
            count += 1
            if count % 100 == 0:
                print(f"[*] Tentativas: {count}...", end="\r")
    except KeyboardInterrupt:
        print("\n[*] Interrompido pelo usuário.")

if __name__ == "__main__":
    # Limpeza de ambiente
    os.system("sudo modprobe -r cdc_acm 2>/dev/null")
    os.chdir("/home/krisluar/spreadtrum_flash")
    quebrar_cadeia()
