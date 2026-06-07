#!/bin/bash

# Cores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}=== INJETOR DE LIMPEZA E ESTABILIDADE (FASTBOOT) ===${NC}"
echo -e "${YELLOW}[*] Objetivo: Limpar travas residuais e forçar modo Fastboot estável.${NC}"

# 1. Preparação Host
sudo modprobe -r cdc_acm 2>/dev/null
sudo modprobe -r usbserial 2>/dev/null
echo "-1" | sudo tee /sys/module/usbcore/parameters/autosuspend > /dev/null
echo "5000" | sudo tee /sys/module/usbcore/parameters/initial_descriptor_timeout > /dev/null

cd /home/krisluar/spreadtrum_flash

# 2. Comando de Injeção
echo -e "\n[*] STATUS: Aguardando dispositivo (Janela de 5 minutos)..."
echo -e "[*] PROCEDIMENTO: Segure VOLUME BAIXO e conecte o cabo USB."

sudo ./spd_dump --wait 300 \
    fdl fdl1-dl.bin 0x65000800 \
    fdl fdl2-dl.bin 0x9efffe00 \
    exec_addr 0x65015f08 \
    exec \
    e persist \
    e metadata \
    reboot-fastboot

if [ $? -eq 0 ]; then
    echo -e "\n${GREEN}[✔] SUCESSO! Limpeza concluída e comando de boot enviado.${NC}"
    echo -e "${YELLOW}O celular deve entrar no modo FASTBOOT agora.${NC}"
else
    echo -e "\n${RED}[!] Erro na injeção. Verifique a conexão e tente novamente.${NC}"
fi
