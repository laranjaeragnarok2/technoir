#!/bin/bash

# Verifica root
if [ "$EUID" -ne 0 ]; then 
  echo -e "\033[0;31m[!] Erro: Use sudo: sudo ./ancora_realme.sh\033[0m"
  exit
fi

cd /home/krisluar/spreadtrum_flash

# 1. Preparação Host (USB Zerado)
modprobe -r cdc_acm 2>/dev/null
echo "-1" > /sys/module/usbcore/parameters/autosuspend
echo "5000" > /sys/module/usbcore/parameters/initial_descriptor_timeout

echo -e "\033[0;32m=== OPERAÇÃO ÂNCORA: PARAR BOOTLOOP DO MDM ===\033[0m"
echo -e "\033[1;33m[*] Objetivo: Limpar dados corrompidos para estabilizar o USB.\033[0m"
echo -e "[*] PROCEDIMENTO: Segure VOLUME BAIXO + POWER até o celular apagar."
echo -e "[*] Quando apagar, solte POWER e mantenha VOLUME BAIXO."

# 2. Metralhadora de Limpeza Profunda
# e metadata: Limpa flags de criptografia
# e userdata: Limpa o Android inteiro (Wipe de Hardware)
# e misc: Limpa comandos de boot antigos
while true; do
  ./spd_dump --wait 0 \
    fdl fdl1-dl.bin 0x65000800 \
    fdl fdl2-dl.bin 0x9efffe00 \
    exec_addr 0x65015f08 \
    exec \
    e metadata \
    e userdata \
    e misc \
    reset > /dev/null 2>&1
    
  if [ $? -eq 0 ]; then
    echo -e "\n\n\033[0;32m[✔] SUCESSO! O CELULAR FOI ANCORADO E LIMPO!\033[0m"
    echo -e "\033[1;33m[*] Agora o bootloop deve parar. O celular vai demorar para ligar.\033[0m"
    echo -e "[*] Verifique se o USB agora permanece conectado sem piscar."
    exit 0
  fi
  echo -ne "Metralhando hardware... \r"
done
