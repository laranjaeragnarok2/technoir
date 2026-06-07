#!/bin/bash

# Cores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}=== SCRIPT FINALIZADOR DE LIBERDADE (REALME T612) ===${NC}"
echo -e "${YELLOW}[*] Objetivo: Capturar o Fastboot e confirmar o desbloqueio do bootloader.${NC}"

# 1. Preparação Host
sudo modprobe -r cdc_acm 2>/dev/null
echo "-1" | sudo tee /sys/module/usbcore/parameters/autosuspend > /dev/null

echo -e "\n[*] Monitorando modo FASTBOOT..."
echo -e "[*] PROCEDIMENTO: Se o celular ligar normal, force o Fastboot (Power + Vol Baixo)."

while true; do
    # Verifica se há dispositivo no fastboot
    if fastboot devices | grep -q "fastboot"; then
        echo -e "\n${GREEN}[!] DISPOSITIVO DETECTADO NO FASTBOOT!${NC}"
        
        # Tenta os comandos de unlock em sequência rápida
        echo "[*] Enviando comandos de desbloqueio..."
        fastboot flashing unlock 2>/dev/null
        fastboot flashing unlock_bootloader 2>/dev/null
        fastboot oem unlock 2>/dev/null
        
        # Verifica o status atualizado
        echo -e "\n[*] Verificando status do bootloader:"
        fastboot getvar unlocked
        
        # Se algum funcionou, tentamos o reboot para o sistema limpo
        echo -e "\n${YELLOW}[!] Verifique a tela do celular: se houver pergunta de UNLOCK, aceite com VOL UP.${NC}"
        echo "[*] Reiniciando em 10 segundos..."
        sleep 10
        fastboot reboot
        
        echo -e "\n${GREEN}[✔] Ciclo concluído. O Pentest chegou ao fim!${NC}"
        exit 0
    fi
    
    # Loop de monitoramento
    echo -ne "Aguardando Fastboot... \r"
    sleep 0.1
done
