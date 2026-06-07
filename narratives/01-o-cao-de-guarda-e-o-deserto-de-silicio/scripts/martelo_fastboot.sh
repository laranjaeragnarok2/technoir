#!/bin/bash

# Cores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}=== MARTELO FASTBOOT (LOOP AGRESSIVO) ===${NC}"
echo -e "${YELLOW}Objetivo: Capturar a janela de 2 segundos do Fastboot para rodar comandos.${NC}"

# Prevenção de economia de energia USB
echo -1 | sudo tee /sys/module/usbcore/parameters/autosuspend > /dev/null

echo -e "\n[*] Aguardando dispositivo em modo Fastboot..."
echo -e "[*] DICA: Se o celular reiniciar, mantenha os botões segurados para forçar o Fastboot novamente."

# Lista de comandos que queremos tentar (em ordem de prioridade)
# 1. Tenta resetar as partições de trava via fastboot (se permitido)
# 2. Tenta dar o boot para o sistema (se estiver travado em loop)
# 3. Tenta pegar info do dispositivo

while true; do
    # Verifica se há dispositivo fastboot
    if fastboot devices | grep -q "fastboot"; then
        echo -e "\n${GREEN}[!] DISPOSITIVO DETECTADO! DISPARANDO COMANDOS...${NC}"
        
        # Sequência rápida de comandos
        # Tentando desativar bloqueios se o bootloader permitir comandos OEM
        fastboot erase frp
        fastboot erase persist
        fastboot erase config
        
        # Tenta desbloqueio de bootloader (geralmente falha em T612 sem token, mas vale o tiro)
        fastboot flashing unlock
        
        # Se algum funcionou, tentamos reboot
        fastboot reboot
        
        echo -e "\n${GREEN}[✔] Ciclo de ataque concluído. Verifique o celular.${NC}"
        exit 0
    fi
    
    # Loop de alta frequência (sem sleep para não perder o timing)
    echo -ne "[*] Escaneando barramento USB... \r"
done
