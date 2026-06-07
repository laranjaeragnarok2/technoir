#!/bin/bash

# Cores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}=== ATAQUE FRACIONADO (VELOCIDADE MÁXIMA) ===${NC}"
cd /home/krisluar/spreadtrum_flash

# Parâmetros
FDL1="fdl1-dl.bin"
ADDR1="0x65000800"
FDL2="fdl2-dl.bin"
ADDR2="0x9efffe00"
EXEC_ADDR="0x65015f08"
PAYLOAD="custom_exec_no_verify_65015f08.bin"

echo -e "\n[*] Iniciando ciclo de limpeza por partes..."

# Ciclo 1: Limpeza de Travas de Segurança (Rápido)
echo -e "${YELLOW}[Fase 1] Limpando Persist, FRP e Config...${NC}"
sudo ./spd_dump --wait 300 \
    fdl "$FDL1" "$ADDR1" fdl "$FDL2" "$ADDR2" exec_addr "$EXEC_ADDR" exec "$PAYLOAD" \
    e persist e frp e config reset

if [ $? -eq 0 ]; then
    echo -e "${GREEN}[✔] Fase 1 Concluída!${NC}"
else
    echo -e "${RED}[!] Falha na Fase 1. Reconecte o celular.${NC}"
    exit 1
fi

# Aguarda o celular reiniciar para a próxima fase (ou o usuário reconectar)
echo -e "\n[*] Aguardando reinicialização para Fase 2 (My_Preload)..."
echo -e "[*] Procedimento: Segure VOL BAIXO novamente quando o celular apagar."

# Ciclo 2: Limpeza de Persistência de Apps (Pesado)
echo -e "${YELLOW}[Fase 2] Limpando My_Preload e Metadata...${NC}"
sudo ./spd_dump --wait 300 \
    fdl "$FDL1" "$ADDR1" fdl "$FDL2" "$ADDR2" exec_addr "$EXEC_ADDR" exec "$PAYLOAD" \
    e my_preload e metadata reset

if [ $? -eq 0 ]; then
    echo -e "${GREEN}[✔] Fase 2 Concluída! TUDO LIMPO.${NC}"
else
    echo -e "${RED}[!] Falha na Fase 2. Tente rodar apenas esta parte novamente.${NC}"
fi
