#!/bin/bash

# Cores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}=== UNLOCK DE HARDWARE: FORÇANDO BOOTLOADER ABERTO ===${NC}"
echo -e "${YELLOW}[*] Este método usa o bypass BROM para desativar as flags de trava.${NC}"

# 1. Preparação Host
sudo modprobe -r cdc_acm 2>/dev/null
echo "-1" | sudo tee /sys/module/usbcore/parameters/autosuspend > /dev/null
echo "5000" | sudo tee /sys/module/usbcore/parameters/initial_descriptor_timeout > /dev/null

cd /home/krisluar/spreadtrum_flash

# 2. Injeção de Unlock
echo -e "\n[*] STATUS: Aguardando dispositivo no modo BROM..."
echo -e "[*] PROCEDIMENTO: Segure VOLUME BAIXO e conecte o cabo USB."

# Usamos uma sequência de comandos que limpa as travas e tenta o unlock direto no loader
# e config: Limpa a trava OEM Unlock
# e persist: Limpa as chaves de MDM
# e frp: Limpa a trava Google
# reboot-fastboot: Joga para o modo onde confirmaremos o estado
sudo ./spd_dump --wait 300 \
    fdl fdl1-dl.bin 0x65000800 \
    fdl fdl2-dl.bin 0x9efffe00 \
    exec_addr 0x65015f08 \
    exec \
    e config \
    e persist \
    e frp \
    e metadata \
    e miscdata \
    reset

if [ $? -eq 0 ]; then
    echo -e "\n${GREEN}[✔] INJEÇÃO DE HARDWARE CONCLUÍDA!${NC}"
    echo -e "${YELLOW}O celular vai reiniciar. Agora as travas de hardware foram removidas.${NC}"
    echo -e "${YELLOW}Tente ligar o aparelho e veja se o OEM UNLOCK já aparece disponível nas Opções de Desenvolvedor.${NC}"
else
    echo -e "\n${RED}[!] Erro na injeção. Verifique o cabo e tente novamente.${NC}"
fi
