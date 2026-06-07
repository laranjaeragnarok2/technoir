#!/bin/bash

# Cores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}=== ATAQUE FINAL REALME T612 (OTIMIZADO) ===${NC}"
echo -e "${YELLOW}Este script aguarda o dispositivo e aplica o bypass e limpeza total.${NC}"

# 1. Configuração de Estabilidade (Host)
sudo modprobe -r cdc_acm 2>/dev/null
echo "-1" | sudo tee /sys/module/usbcore/parameters/autosuspend > /dev/null
echo "5000" | sudo tee /sys/module/usbcore/parameters/initial_descriptor_timeout > /dev/null

cd /home/krisluar/spreadtrum_flash

echo -e "\n[*] Monitorando barramento USB (Aguardando ID 1782:4d00)..."
echo -e "[*] Procedimento: Mantenha VOLUME BAIXO segurado e conecte o cabo."

while true; do
    # Verifica a presença do ID Unisoc no barramento
    if lsusb | grep -q "1782:4d00"; then
        echo -e "\n${GREEN}[!] DISPOSITIVO DETECTADO! DISPARANDO EXPLOIT EM ALTA VELOCIDADE...${NC}"
        
        # Execução Direta: FDL1 -> FDL2 -> Bypass -> Limpeza Profunda -> Reset
        # e my_preload é incluído para remover o app da empresa
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
            echo -e "\n${GREEN}[✔] SUCESSO ABSOLUTO: TODAS AS CAMADAS FORAM SUPERADAS!${NC}"
            echo -e "${YELLOW}Verifique o celular. Se ele cair no Recovery, faça o Wipe Data manualmente.${NC}"
            exit 0
        else
            echo -e "${RED}[!] Timeout ou falha de conexão. Tente novamente (mantenha o cabo e segure os botões).${NC}"
            # Pequeno intervalo para não travar o log, mas rápido o suficiente para a próxima janela
            sleep 0.5
        fi
    fi
    # Varredura ultra-rápida do barramento
    echo -ne "[*] Aguardando sinal do hardware... \r"
done
