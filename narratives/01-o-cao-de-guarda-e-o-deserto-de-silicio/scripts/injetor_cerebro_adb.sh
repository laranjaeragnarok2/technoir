#!/bin/bash

# Cores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}=== INJETOR DE CÉREBRO ADB (REALME T612) ===${NC}"
echo -e "${YELLOW}[*] Este script vai gravar o kernel modificado para forçar o ADB.${NC}"

# 1. Preparação Crítica do Host
echo -e "\n[*] Preparando barramento USB..."
sudo modprobe -r cdc_acm 2>/dev/null
sudo modprobe -r usbserial 2>/dev/null
echo "-1" | sudo tee /sys/module/usbcore/parameters/autosuspend > /dev/null
echo "5000" | sudo tee /sys/module/usbcore/parameters/initial_descriptor_timeout > /dev/null

cd /home/krisluar/spreadtrum_flash

# 2. Comando de Injeção Estabilizado
echo -e "\n[*] STATUS: Aguardando dispositivo (Janela de 5 minutos)..."
echo -e "[*] PROCEDIMENTO: Segure VOLUME BAIXO e conecte o cabo USB."

sudo ./spd_dump --wait 300 \
    fdl fdl1-dl.bin 0x65000800 \
    fdl fdl2-dl.bin 0x9efffe00 \
    exec_addr 0x65015f08 \
    exec \
    write_part boot_a boot_modificado.img \
    reset

if [ $? -eq 0 ]; then
    echo -e "\n${GREEN}[✔] SUCESSO! O kernel modificado foi injetado.${NC}"
    echo -e "${YELLOW}O celular vai reiniciar. Quando ligar, o ADB deve estar ativo!${NC}"
else
    echo -e "\n${RED}[!] Erro na injeção. Verifique o cabo e tente novamente.${NC}"
fi
