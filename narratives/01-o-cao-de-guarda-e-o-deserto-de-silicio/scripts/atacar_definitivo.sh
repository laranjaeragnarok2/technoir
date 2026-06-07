#!/bin/bash

# Cores
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}=== SCRIPT DE DESBLOQUEIO DE BOOTLOADER (REALME T612) ===${NC}"

# Prevenção de interferências
sudo systemctl stop ModemManager 2>/dev/null
sudo modprobe -r usbserial 2>/dev/null
echo -1 | sudo tee /sys/module/usbcore/parameters/autosuspend > /dev/null

cd /home/krisluar/spreadtrum_flash

echo -e "\n[*] Iniciando loop de desbloqueio..."
echo -e "[*] Segure VOLUME BAIXO e conecte o cabo USB."

while true; do
    # O comando abaixo usa o exploit para permitir o desbloqueio
    # Ele carrega os FDLs e executa o patch de assinatura
    sudo ./spd_dump --wait 0 fdl fdl1-dl.bin 0x65000800 fdl fdl2-dl.bin 0x9efffe00 exec_addr 0x65015f08 2>/dev/null
    
    if [ $? -eq 0 ]; then
        echo -e "\n${GREEN}[!!!] EXPLOIT INJETADO COM SUCESSO! [!!!]${NC}"
        echo "Agora o celular deve estar em um modo especial."
        echo "Vou tentar enviar o comando de desbloqueio via Fastboot agora..."
        
        # Tenta o desbloqueio via fastboot (isso vai apagar o celular de novo)
        sudo fastboot flashing unlock_bootloader 2>/dev/null || sudo fastboot oem unlock 2>/dev/null
        
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}BOOTLOADER DESBLOQUEADO!${NC}"
            exit 0
        else
            echo -e "${RED}Exploit funcionou, mas o comando fastboot falhou. Verifique se o celular entrou em modo Fastboot.${NC}"
            exit 1
        fi
    fi
done
