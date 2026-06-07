#!/bin/bash

# Verifica se está rodando como root
if [ "$EUID" -ne 0 ]; then 
  echo -e "\033[0;31m[!] Erro: Por favor, execute com sudo: sudo ./quebra_final.sh\033[0m"
  exit
fi

cd /home/krisluar/spreadtrum_flash

# 1. Limpeza de barramento e preparação do host
modprobe -r cdc_acm 2>/dev/null
echo "-1" > /sys/module/usbcore/parameters/autosuspend
echo "5000" > /sys/module/usbcore/parameters/initial_descriptor_timeout

echo -e "\033[0;32m=== OPERAÇÃO ANIQUILAÇÃO TOTAL (SLOT A + B) ===\033[0m"
echo -e "\033[1;33m[*] Alvo: Neutralizar verificação de boot em ambos os slots.\033[0m"
echo -e "[*] PROCEDIMENTO: Segure VOLUME BAIXO e conecte o cabo USB."
echo -e "[*] DICA: Se estiver em bootloop, mantenha VOL BAIXO + POWER até ele reiniciar."

# 2. Metralhadora de Injeção em ambos os slots
while true; do
  # Comando que ataca Slot A e Slot B simultaneamente
  ./spd_dump --wait 0 \
    fdl fdl1-dl.bin 0x65000800 \
    fdl fdl2-dl.bin 0x9efffe00 \
    exec_addr 0x65015f08 \
    exec \
    e vbmeta_a e vbmeta_system_a e vbmeta_vendor_a \
    e vbmeta_b e vbmeta_system_b e vbmeta_vendor_b \
    e config e persist \
    reset > /dev/null 2>&1
    
  if [ $? -eq 0 ]; then
    echo -e "\n\n\033[0;32m[✔] SUCESSO TOTAL! AMBOS OS SLOTS FORAM ROMPIDOS!\033[0m"
    echo -e "\033[1;33mO celular não tem mais para onde fugir. O USB deve estabilizar agora.\033[0m"
    exit 0
  fi
  echo -ne "."
done
