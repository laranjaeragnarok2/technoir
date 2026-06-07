#!/bin/bash

# Cores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}=== SCRIPT QUEBRA DE CADEIA (FORÇAR ESTABILIDADE USB) ===${NC}"
cd /home/krisluar/spreadtrum_flash

# 1. Preparação Crítica do Host
sudo modprobe -r cdc_acm 2>/dev/null
echo "-1" | sudo tee /sys/module/usbcore/parameters/autosuspend > /dev/null
echo "5000" | sudo tee /sys/module/usbcore/parameters/initial_descriptor_timeout > /dev/null

# 2. Loop de Alta Frequência (Metralhadora)
echo -e "\n[*] MODO METRALHADORA ATIVADO!"
echo -e "[*] PROCEDIMENTO: Segure VOLUME BAIXO e conecte o cabo USB."
echo -e "[*] ALVO: Neutralizar VBMETA e travas de MDM."

count=0
while true; do
    # Tentativa agressiva de apagar partições de verificação e segurança
    # e vbmeta: Quebra a integridade para parar o bootloop do MDM
    # e config/persist: Limpa travas de MDM e Bootloader
    ./spd_dump --wait 0 \
        exec_addr 0x65015f08 \
        fdl fdl1-dl.bin 0x65000800 \
        fdl fdl2-dl.bin 0x9efffe00 \
        exec \
        e vbmeta_a \
        e vbmeta_system_a \
        e vbmeta_vendor_a \
        e config \
        e persist \
        reset > /dev/null 2>&1
    
    if [ $? -eq 0 ]; then
        echo -e "\n\n${GREEN}[✔] SUCESSO ABSOLUTO! CADEIA DE CONFIANÇA ROMPIDA!${NC}"
        echo -e "${YELLOW}O celular deve travar em uma tela de erro ou Fastboot ESTÁVEL agora.${NC}"
        exit 0
    fi

    ((count++))
    if (( count % 200 == 0 )); then
        echo -ne "Tentando capturar (Ciclo $count)... \r"
    fi
done
