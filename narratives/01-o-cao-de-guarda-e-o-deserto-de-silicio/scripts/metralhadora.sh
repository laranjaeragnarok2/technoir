#!/bin/bash
# MARTELO DE EXTRAÇÃO (DUMP DO BOOT)
cd /home/krisluar/spreadtrum_flash
sudo modprobe -r cdc_acm 2>/dev/null

echo -e "\033[0;32m=== MARTELO DE EXTRAÇÃO ATIVADO ===\033[0m"
echo -e "\033[1;33m[*] Objetivo: Extrair partição boot_a para boot_backup.img\033[0m"

count=0
while true; do
    # Tentativa agressiva de leitura da partição de boot
    ./spd_dump --wait 0 \
        exec_addr 0x65015f08 \
        fdl fdl1-dl.bin 0x65000800 \
        fdl fdl2-dl.bin 0x9efffe00 \
        exec \
        read_part boot_a 0 0x4000000 boot_backup.img \
        reset 2>/dev/null
    
    if [ $? -eq 0 ]; then
        echo -e "\n\n\033[0;32m[✔] SUCESSO! BOOT EXTRAÍDO COM SUCESSO!\033[0m"
        echo -e "\033[1;33mArquivo salvo como: /home/krisluar/spreadtrum_flash/boot_backup.img\033[0m"
        ls -lh boot_backup.img
        exit 0
    fi

    ((count++))
    if (( count % 100 == 0 )); then
        echo -ne "Aguardando janela para DUMP (Tentativa $count)... \r"
    fi
done
