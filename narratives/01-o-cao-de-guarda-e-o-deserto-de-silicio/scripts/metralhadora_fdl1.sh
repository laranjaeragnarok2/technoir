#!/bin/bash
cd /home/krisluar/spreadtrum_flash
sudo modprobe -r cdc_acm 2>/dev/null
echo -e "\033[0;32m=== METRALHADORA FDL1 ATIVADA ===\033[0m"
echo -e "\033[1;33m[*] Tentando capturar o dispositivo no milissegundo zero...\033[0m"

while true; do
    # Tentativa ultra-rápida sem wait
    ./spd_dump --wait 0 fdl fdl1-dl.bin 0x65000800 exec_addr 0x65015f08 exec reboot-fastboot 2>/dev/null
    
    # Se o spd_dump retornar 0, significa que conseguiu enviar o comando
    if [ $? -eq 0 ]; then
        echo -e "\n\n\033[0;32m[✔] SUCESSO! COMANDO REBOOT-FASTBOOT ENVIADO!\033[0m"
        exit 0
    fi
done
