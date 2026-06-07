#!/bin/bash

# Cores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}=== MARTELO INJETOR (REALME T612) ===${NC}"
echo -e "${YELLOW}Objetivo: Injetar o bypass de assinatura via hardware.${NC}"

cd /home/krisluar/spreadtrum_flash

# Parâmetros confirmados
FDL1="fdl1-dl.bin"
ADDR1="0x65000800"
FDL2="fdl2-dl.bin"
ADDR2="0x9efffe00"
EXEC_ADDR="0x65015f08"
PAYLOAD="custom_exec_no_verify_65015f08.bin"

echo -e "\n[*] Aguardando celular no modo BROM..."
echo -e "[*] Procedimento: Segure VOLUME BAIXO e conecte o cabo."

count=0
while true; do
    # Tentativa de injeção direta
    # --wait 0 para não travar o loop se o dispositivo não estiver pronto
    ./spd_dump --wait 0 \
        fdl "$FDL1" "$ADDR1" \
        fdl "$FDL2" "$ADDR2" \
        exec_addr "$EXEC_ADDR" \
        exec "$PAYLOAD" 2>/dev/null
    
    if [ $? -eq 0 ]; then
        echo -e "\n\n${GREEN}[!!!] SUCESSO: EXPLOIT INJETADO COM SUCESSO! [!!!]${NC}"
        echo -e "${YELLOW}Verifique se o celular reiniciou ou se aceita comandos fastboot agora.${NC}"
        exit 0
    fi

    # Feedback visual
    ((count++))
    if (( count % 50 == 0 )); then
        echo -ne "[*] Tentativas de conexão: $count...\r"
    fi
done
