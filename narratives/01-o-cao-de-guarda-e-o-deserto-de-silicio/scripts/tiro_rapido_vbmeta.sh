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

echo -e "\033[0;32m=== SCRIPT: TIRO RÁPIDO VBMETA (ESTABILIZADOR) ===\033[0m"
echo -e "\033[1;33m[*] Objetivo: Gravar vbmeta sem timeout de userdata.\033[0m"
echo -e "[*] PROCEDIMENTO: Segure VOLUME BAIXO e conecte o cabo USB."

# 2. Comando de Injeção Ultra-Rápida
# Focamos apenas na verificação de boot (arquivos pequenos = sem timeout)
./spd_dump --wait 0 \
    fdl fdl1-dl.bin 0x65000800 \
    fdl fdl2-dl.bin 0x9efffe00 \
    exec_addr 0x65015f08 \
    exec \
    w vbmeta_a vbmeta.bin \
    w vbmeta_system_a vbmeta.bin \
    reset

if [ $? -eq 0 ]; then
    echo -e "\n\n\033[0;32m[✔] SUCESSO! VBMETA GRAVADO!\033[0m"
    echo -e "\033[1;33mO celular deve reiniciar. O LineageOS deve tentar o boot agora.\033[0m"
    exit 0
else
    echo -e "\n\033[0;31m[!] Falha na captura. Tentando novamente...\033[0m"
fi
