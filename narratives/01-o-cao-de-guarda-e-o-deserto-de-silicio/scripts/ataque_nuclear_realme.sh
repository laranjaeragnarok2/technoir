#!/bin/bash

# Cores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}=== ATAQUE NUCLEAR REALME (PENTEST NÍVEL 3) ===${NC}"
echo -e "${YELLOW}Objetivo: Limpar TODAS as partições de reserva e travas persistentes.${NC}"

# 1. Configuração de Estabilidade (Host)
sudo modprobe -r cdc_acm 2>/dev/null
echo "-1" | sudo tee /sys/module/usbcore/parameters/autosuspend > /dev/null
echo "5000" | sudo tee /sys/module/usbcore/parameters/initial_descriptor_timeout > /dev/null

cd /home/krisluar/spreadtrum_flash

echo -e "\n[*] Monitorando barramento USB (Aguardando ID 1782:4d00)..."
echo -e "[*] Procedimento: Mantenha VOLUME BAIXO segurado e conecte o cabo."

while true; do
    if lsusb | grep -q "1782:4d00"; then
        echo -e "\n${GREEN}[!] DISPOSITIVO DETECTADO! INICIANDO LIMPEZA NUCLEAR...${NC}"
        
        # O comando definitivo que atinge todas as áreas de reserva da Realme/Oppo
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
            e misc \
            e miscdata \
            e opporeserve \
            e oplusreserve1 \
            e oplusreserve3 \
            e oplusreserve5 \
            reset
            
        if [ $? -eq 0 ]; then
            echo -e "\n${GREEN}[✔] SUCESSO: TODAS AS RESERVAS FORAM LIMPAS!${NC}"
            echo -e "${YELLOW}DICA: Se ele cair no Recovery, faça o Wipe Data. Se o Wi-Fi ainda forçar, a trava está na ROM.${NC}"
            exit 0
        else
            echo -ne "${RED}[!] Falha no timing. Tentando novamente na próxima janela...\r${NC}"
            sleep 0.5
        fi
    fi
    echo -ne "[*] Escaneando hardware... \r"
done
