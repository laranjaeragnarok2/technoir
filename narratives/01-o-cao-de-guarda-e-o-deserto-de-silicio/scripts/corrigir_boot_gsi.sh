#!/bin/bash

# Verifica se está rodando como root
if [ "$EUID" -ne 0 ]; then 
  echo -e "\033[0;31m[!] Erro: Por favor, execute com sudo.\033[0m"
  exit
fi

cd /home/krisluar/spreadtrum_flash

# 1. Preparação do Host
modprobe -r cdc_acm 2>/dev/null
echo "-1" > /sys/module/usbcore/parameters/autosuspend
echo "5000" > /sys/module/usbcore/parameters/initial_descriptor_timeout

echo -e "\033[0;32m=== CORRETOR DE BOOT GSI: BYPASS DE VERIFICAÇÃO ===\033[0m"
echo -e "\033[1;33m[*] Objetivo: Desativar AVB e limpar dados para o LineageOS iniciar.\033[0m"
echo -e "[*] PROCEDIMENTO: Segure VOLUME BAIXO e conecte o cabo USB."

# 2. Comando de Correção via Hardware
# Gravamos o vbmeta.bin (verificação) para desarmar o bloqueio
# Limpamos userdata (format data) para o Android 14 criar nova estrutura
./spd_dump --wait 0 \
    fdl fdl1-dl.bin 0x65000800 \
    fdl fdl2-dl.bin 0x9efffe00 \
    exec_addr 0x65015f08 \
    exec \
    w vbmeta_a vbmeta.bin \
    w vbmeta_b vbmeta.bin \
    w vbmeta_system_a vbmeta.bin \
    w vbmeta_vendor_a vbmeta.bin \
    e metadata \
    e userdata \
    reset

if [ $? -eq 0 ]; then
    echo -e "\n\n\033[0;32m[✔] CORREÇÃO APLICADA COM SUCESSO!\033[0m"
    echo -e "\033[1;33mO celular vai reiniciar. O primeiro boot do LineageOS é LENTO (5-10 min).\033[0m"
    echo -e "[!] Se ele cair no Recovery, selecione 'Factory Data Reset' uma última vez."
    exit 0
else
    echo -e "\n\033[0;31m[!] Falha na correção. Verifique o cabo USB.\033[0m"
fi
