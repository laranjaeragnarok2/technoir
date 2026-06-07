#!/bin/bash

# Cores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}=== SCRIPT DE DESBLOQUEIO FORÇADO (BOOTLOADER UNLOCK) ===${NC}"
echo -e "${YELLOW}Objetivo: Forçar o estado de UNLOCKED via injeção BROM.${NC}"

# 1. Preparação Host
sudo modprobe -r cdc_acm 2>/dev/null
echo "-1" | sudo tee /sys/module/usbcore/parameters/autosuspend > /dev/null
echo "5000" | sudo tee /sys/module/usbcore/parameters/initial_descriptor_timeout > /dev/null

cd /home/krisluar/spreadtrum_flash

echo -e "\n[*] Monitorando barramento USB (Aguardando ID 1782:4d00)..."
echo -e "[*] Procedimento: Segure VOLUME BAIXO e conecte o cabo."

while true; do
    if lsusb | grep -q "1782:4d00"; then
        echo -e "\n${GREEN}[!] DISPOSITIVO DETECTADO! ENVIANDO COMANDO DE UNLOCK...${NC}"
        
        # O comando de unlock forçado
        # e config/persist/frp: Garante que as flags de trava de software sumam
        # unlock_bootloader: Comando de injeção direta no FDL2 para abrir o bootloader
        sudo ./spd_dump --wait 0 \
            fdl fdl1-dl.bin 0x65000800 \
            fdl fdl2-dl.bin 0x9efffe00 \
            exec_addr 0x65015f08 \
            exec \
            e config \
            e persist \
            e frp \
            reboot-fastboot
            
        if [ $? -eq 0 ]; then
            echo -e "\n${GREEN}[✔] INJEÇÃO DE UNLOCK CONCLUÍDA!${NC}"
            echo -e "${YELLOW}O celular vai reiniciar em modo FASTBOOT.${NC}"
            echo -e "${YELLOW}Agora, tente rodar no terminal: fastboot flashing unlock${NC}"
            exit 0
        else
            echo -ne "${RED}[!] Falha no timing. Tentando novamente...\r${NC}"
            sleep 0.5
        fi
    fi
    echo -ne "[*] Aguardando sinal... \r"
done
