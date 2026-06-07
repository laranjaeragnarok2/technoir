#!/bin/bash

# Cores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}=== RESTAURADOR DE ESTABILIDADE: BOOT ORIGINAL ===${NC}"
echo -e "${YELLOW}[*] Objetivo: Restaurar o kernel original para normalizar o barramento USB.${NC}"

# 1. Preparação Host
sudo modprobe -r cdc_acm 2>/dev/null
echo "-1" | sudo tee /sys/module/usbcore/parameters/autosuspend > /dev/null
echo "5000" | sudo tee /sys/module/usbcore/parameters/initial_descriptor_timeout > /dev/null

cd /home/krisluar/spreadtrum_flash

# Verificação do arquivo de backup
if [ ! -f "boot_backup.img" ]; then
    echo -e "${RED}[!] ERRO: Arquivo boot_backup.img não encontrado!${NC}"
    exit 1
fi

# 2. Comando de Restauração
echo -e "\n[*] STATUS: Aguardando dispositivo (Modo BROM)..."
echo -e "[*] PROCEDIMENTO: Segure VOLUME BAIXO e conecte o cabo USB."

sudo ./spd_dump --wait 300 \
    fdl fdl1-dl.bin 0x65000800 \
    fdl fdl2-dl.bin 0x9efffe00 \
    exec_addr 0x65015f08 \
    exec \
    write_part boot_a boot_backup.img \
    reset

if [ $? -eq 0 ]; then
    echo -e "\n${GREEN}[✔] SUCESSO! O kernel original foi restaurado.${NC}"
    echo -e "${YELLOW}O celular deve voltar a ser reconhecido pelo USB normalmente.${NC}"
else
    echo -e "\n${RED}[!] Erro na restauração. Verifique o cabo e tente novamente.${NC}"
fi
