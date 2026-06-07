#!/bin/bash

# Cores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${RED}=== ATAQUE NUCLEAR (LIMPEZA TOTAL + UNLOCK) ===${NC}"
echo -e "${YELLOW}Este script vai apagar TUDO (Userdata, Persist, Config, Metadata).${NC}"
echo -e "${YELLOW}Isso deve aniquilar qualquer aplicativo de MDM/Organização.${NC}"

# Prevenção de interferências
sudo systemctl stop ModemManager 2>/dev/null
sudo modprobe -r usbserial 2>/dev/null
sudo modprobe -r cdc_acm 2>/dev/null
echo -1 | sudo tee /sys/module/usbcore/parameters/autosuspend > /dev/null

cd /home/krisluar/spreadtrum_flash

echo -e "\n[*] Aguardando celular (BROM Mode)..."
echo -e "[*] Segure VOLUME BAIXO e conecte o cabo."

while true; do
    # 1. Exploit + Limpeza Profunda
    sudo ./spd_dump --wait 0 \
        fdl fdl1-dl.bin 0x65000800 \
        fdl fdl2-dl.bin 0x9efffe00 \
        exec_addr 0x65015f08 \
        exec \
        e persist \
        e frp \
        e config \
        e userdata \
        e metadata \
        e misc \
        reboot-fastboot 2>/dev/null
    
    if [ $? -eq 0 ]; then
        echo -e "\n${GREEN}[!!!] LIMPEZA CONCLUÍDA! ENTRANDO EM MODO FASTBOOT... [!!!]${NC}"
        echo -e "[*] Aguardando o dispositivo aparecer no Fastboot..."
        
        # Espera um pouco o bootloader subir
        sleep 5
        
        # 2. Tentativa de Unlock Imediato
        echo -e "[*] Tentando comando de desbloqueio de bootloader..."
        sudo fastboot flashing unlock_bootloader 2>/dev/null || sudo fastboot oem unlock 2>/dev/null
        
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}>>> SUCESSO ABSOLUTO: BOOTLOADER DESBLOQUEADO! <<<${NC}"
            echo -e "${GREEN}O MDM nunca mais voltará. O celular vai reiniciar agora.${NC}"
            exit 0
        else
            echo -e "${RED}Limpeza feita, mas o Unlock via Fastboot falhou.${NC}"
            echo -e "${YELLOW}O celular deve estar na tela de Fastboot. Tente rodar o comando manual se necessário.${NC}"
            exit 1
        fi
    fi
    
    echo -ne "[*] Escaneando porta USB...\r"
    sleep 0.1
done
