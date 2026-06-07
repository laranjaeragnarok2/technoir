#!/bin/bash

# Cores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}=== SCRIPT CIRURGIÃO ADB: MODIFICAÇÃO DE KERNEL ===${NC}"

cd /home/krisluar/spreadtrum_flash

# 1. Aplicando o Patch no arquivo extraído
echo -e "${YELLOW}[*] Aplicando patch de depuração no boot_backup.img...${NC}"
cp boot_backup.img boot_modificado.img

# Substituição de flags de segurança (Forçando ADB)
# Usamos strings fixas para garantir que o binário não seja corrompido
sed -i 's/ro.debuggable=0/ro.debuggable=1/g' boot_modificado.img
sed -i 's/ro.secure=1/ro.secure=0/g' boot_modificado.img
sed -i 's/persist.sys.usb.config=mtp/persist.sys.usb.config=adb/g' boot_modificado.img
sed -i 's/persist.sys.usb.config=none/persist.sys.usb.config=adb/g' boot_modificado.img

if [ $? -eq 0 ]; then
    echo -e "${GREEN}[✔] Patch aplicado com sucesso no arquivo boot_modificado.img!${NC}"
else
    echo -e "${RED}[!] Falha ao aplicar patch. Verifique se o arquivo boot_backup.img existe.${NC}"
    exit 1
fi

# 2. Injeção da "Nova Mente" (Metralhadora de Escrita)
echo -e "\n[*] Iniciando Metralhadora de Escrita (boot_a)..."
echo -e "[*] Procedimento: Segure VOLUME BAIXO e conecte o cabo."

sudo modprobe -r cdc_acm 2>/dev/null

count=0
while true; do
    # Tentativa agressiva de escrever o novo kernel
    ./spd_dump --wait 0 \
        exec_addr 0x65015f08 \
        fdl fdl1-dl.bin 0x65000800 \
        fdl fdl2-dl.bin 0x9efffe00 \
        exec \
        write_part boot_a boot_modificado.img \
        reset 2>/dev/null
    
    if [ $? -eq 0 ]; then
        echo -e "\n\n${GREEN}[✔] SUCESSO TOTAL! KERNEL MODIFICADO INJETADO!${NC}"
        echo -e "${YELLOW}O celular vai reiniciar. O ADB deve ligar automaticamente no boot.${NC}"
        exit 0
    fi

    ((count++))
    if (( count % 50 == 0 )); then
        echo -ne "Aguardando janela de escrita (Tentativa $count)... \r"
    fi
done
