#!/bin/bash

# Verifica root
if [ "$EUID" -ne 0 ]; then 
  echo -e "\033[0;31m[!] Erro: Use sudo.\033[0m"
  exit
fi

cd /home/krisluar/spreadtrum_flash

# 1. Preparação Host
modprobe -r cdc_acm 2>/dev/null
echo "-1" > /sys/module/usbcore/parameters/autosuspend
echo "5000" > /sys/module/usbcore/parameters/initial_descriptor_timeout

echo -e "\033[0;32m=== SCRIPT: RESGATE TOTAL DE BOOT (GSI) ===\033[0m"
echo -e "\033[1;33m[*] Objetivo: Forçar Slot A e desativar TODAS as verificações.\033[0m"
echo -e "[*] PROCEDIMENTO: Segure VOLUME BAIXO e conecte o cabo USB."

# 2. Comando de Injeção de Resgate
# e vbmeta: Apagamos as assinaturas em ambos os slots
# set_active a: Forçamos o celular a carregar o Slot A
./spd_dump --wait 0 \
    fdl fdl1-dl.bin 0x65000800 \
    fdl fdl2-dl.bin 0x9efffe00 \
    exec_addr 0x65015f08 \
    exec \
    e vbmeta_a \
    e vbmeta_b \
    e vbmeta_system_a \
    e vbmeta_system_b \
    e vbmeta_vendor_a \
    e vbmeta_vendor_b \
    set_active a \
    reset

if [ $? -eq 0 ]; then
    echo -e "\n\n\033[0;32m[✔] RESGATE CONCLUÍDO!\033[0m"
    echo -e "\033[1;33mO celular deve reiniciar forçando o Slot A sem verificações.\033[0m"
    echo -e "[!] Se ele cair no erro 'No valid OS', precisaremos conferir o Kernel (boot_a).\033[0m"
    exit 0
else
    echo -e "\n\033[0;31m[!] Falha na injeção. Tente novamente.\033[0m"
fi
