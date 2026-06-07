#!/bin/bash

# Cores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}=== ATAQUE DE LIMPEZA (REALME T612) ===${NC}"
echo -e "${YELLOW}Este script irá apagar as partições PERSIST, FRP e CONFIG.${NC}"
echo -e "${YELLOW}Isso deve remover o bloqueio de Organização/MDM.${NC}"

# Prevenção de interferências
sudo systemctl stop ModemManager 2>/dev/null
sudo modprobe -r usbserial 2>/dev/null
sudo modprobe -r cdc_acm 2>/dev/null
echo -1 | sudo tee /sys/module/usbcore/parameters/autosuspend > /dev/null

cd /home/krisluar/spreadtrum_flash

echo -e "\n[*] Aguardando celular..."
echo -e "[*] Procedimento: Segure VOLUME BAIXO e conecte o cabo USB."

while true; do
    # Executa o exploit e apaga as partições alvo
    sudo ./spd_dump --wait 0 \
        fdl fdl1-dl.bin 0x65000800 \
        fdl fdl2-dl.bin 0x9efffe00 \
        exec_addr 0x65015f08 \
        exec e persist e frp e config reset 2>/dev/null
    
    if [ $? -eq 0 ]; then
        echo -e "\n${GREEN}[!!!] SUCESSO: PARTIÇÕES APAGADAS E DISPOSITIVO REINICIADO! [!!!]${NC}"
        exit 0
    fi
    
    echo -ne "[*] Tentando detectar dispositivo...\r"
    sleep 0.1
done
