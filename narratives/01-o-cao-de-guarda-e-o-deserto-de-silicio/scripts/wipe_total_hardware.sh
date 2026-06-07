#!/bin/bash

# Verifica root
if [ "$EUID" -ne 0 ]; then 
  echo -e "\033[0;31m[!] Use sudo: sudo ./wipe_total_hardware.sh\033[0m"
  exit
fi

cd /home/krisluar/spreadtrum_flash

# 1. Preparação Host
modprobe -r cdc_acm 2>/dev/null
echo "-1" > /sys/module/usbcore/parameters/autosuspend
echo "5000" > /sys/module/usbcore/parameters/initial_descriptor_timeout

echo -e "\033[0;32m=== SCRIPT: WIPE TOTAL VIA HARDWARE ===\033[0m"
echo -e "\033[1;33m[*] Objetivo: Formatar Userdata e Metadata para destravar o boot do LineageOS.\033[0m"
echo -e "[*] PROCEDIMENTO: Segure VOLUME BAIXO e conecte o cabo USB."

# 2. Comando de Limpeza (Userdata + Metadata)
# e userdata: Formata a memória interna (Demorado, pode dar timeout aos 96% - IGNORE)
# e metadata: Limpa as chaves de criptografia antigas
# reset: Reinicia o celular
./spd_dump --wait 0 \
    fdl fdl1-dl.bin 0x65000800 \
    fdl fdl2-dl.bin 0x9efffe00 \
    exec_addr 0x65015f08 \
    exec \
    e userdata \
    e metadata \
    e cache \
    reset

if [ $? -eq 0 ]; then
    echo -e "\n\n\033[0;32m[✔] WIPE EXECUTADO COM SUCESSO!\033[0m"
    echo -e "\033[1;33mO celular vai reiniciar. Agora o LineageOS deve conseguir criar seus arquivos.\033[0m"
    exit 0
else
    echo -e "\n\033[0;31m[!] Ocorreu um timeout (normal para 108GB). Verifique se o celular começou o boot.\033[0m"
fi
