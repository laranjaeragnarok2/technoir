#!/bin/bash

# Cores para o relatório
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}=== SCRIPT ANIQUILADOR DE PERSISTÊNCIA (PENTEST NÍVEL 2) ===${NC}"
echo -e "${YELLOW}Objetivo: Eliminar apps de organização na partição my_preload e limpar travas.${NC}"

# 1. Preparação do Ambiente
sudo modprobe -r cdc_acm 2>/dev/null
echo "-1" | sudo tee /sys/module/usbcore/parameters/autosuspend > /dev/null
echo "5000" | sudo tee /sys/module/usbcore/parameters/initial_descriptor_timeout > /dev/null

cd /home/krisluar/spreadtrum_flash

echo -e "\n[*] Monitorando barramento USB (ID 1782:4d00)..."
echo -e "[*] Procedimento: Mantenha VOLUME BAIXO segurado e conecte o cabo."

while true; do
    if lsusb | grep -q "1782:4d00"; then
        echo -e "\n${GREEN}[!] DISPOSITIVO DETECTADO! INICIANDO LIMPEZA PROFUNDA...${NC}"
        
        # Ataque expandido para partições de persistência
        # e my_preload: Remove apps injetados pela Realme/Empresa
        # e metadata: Remove metadados de criptografia e gerenciamento
        # e persist/frp/config: Remove as travas de segurança
        sudo ./spd_dump --wait 0 \
            fdl fdl1-dl.bin 0x65000800 \
            fdl fdl2-dl.bin 0x9efffe00 \
            exec_addr 0x65015f08 \
            exec \
            e persist \
            e frp \
            e config \
            e my_preload \
            e metadata \
            reset
            
        if [ $? -eq 0 ]; then
            echo -e "\n${GREEN}[✔] SUCESSO: PERSISTÊNCIA ANIQUILADA E DISPOSITIVO REINICIADO!${NC}"
            echo -e "${YELLOW}PENTEST: Verifique se o app da empresa sumiu após o primeiro boot.${NC}"
            exit 0
        else
            echo -e "${RED}[!] Falha no timing ou permissão. Tentando novamente...${NC}"
        fi
    fi
    sleep 0.1
done
