#!/bin/bash

# Cores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}=== SCRIPT TIRO CURTO DEFINITIVO (NO SEGFAULT) ===${NC}"
echo -e "${YELLOW}[*] Preparando barramento USB e limpando drivers...${NC}"

# 1. Configurações de Estabilidade
sudo modprobe -r cdc_acm 2>/dev/null
sudo modprobe -r usbserial 2>/dev/null
echo "-1" | sudo tee /sys/module/usbcore/parameters/autosuspend > /dev/null
echo "5000" | sudo tee /sys/module/usbcore/parameters/initial_descriptor_timeout > /dev/null

cd /home/krisluar/spreadtrum_flash

# 2. Execução do spd_dump (Versão Segura)
# Removemos o exec_addr para evitar o erro de Falha de Segmentação no seu Linux
echo -e "\n[*] STATUS: Aguardando dispositivo (Janela de 5 minutos)..."
echo -e "[*] PROCEDIMENTO: Segure VOLUME BAIXO e conecte o cabo USB."

sudo ./spd_dump --wait 300 \
    fdl fdl1-dl.bin 0x65000800 \
    exec \
    reboot-fastboot

if [ $? -eq 0 ]; then
    echo -e "\n${GREEN}[✔] SUCESSO! O comando de reboot foi enviado.${NC}"
    echo -e "${YELLOW}O celular deve entrar no modo FASTBOOT agora.${NC}"
else
    echo -e "\n${RED}[!] Falha na injeção. Verifique o cabo ou tente Volume Cima + Baixo.${NC}"
fi
