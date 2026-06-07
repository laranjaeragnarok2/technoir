#!/bin/bash

# Verifica root
if [ "$EUID" -ne 0 ]; then 
  echo -e "\033[0;31m[!] Erro: Use sudo: sudo ./resgate_realme.sh\033[0m"
  exit
fi

cd /home/krisluar/spreadtrum_flash

# 1. Preparação Host
modprobe -r cdc_acm 2>/dev/null
echo "-1" > /sys/module/usbcore/parameters/autosuspend
echo "5000" > /sys/module/usbcore/parameters/initial_descriptor_timeout

echo -e "\033[0;32m=== SCRIPT DE RESGATE: FORÇAR MODO RECOVERY ===\033[0m"
echo -e "\033[1;33m[*] Esse aviso no canto da tela é o 'Orange State'. Significa que quebramos a trava!\033[0m"
echo -e "[*] PROCEDIMENTO: Segure VOLUME BAIXO + POWER até o celular apagar."
echo -e "[*] No milissegundo que apagar, solte POWER e mantenha VOL BAIXO colado."

# 2. Metralhadora de Resgate (Tentando Recovery)
while true; do
  # Tentamos forçar o Recovery, que é mais estável que o bootloader normal
  ./spd_dump --wait 0 \
    fdl fdl1-dl.bin 0x65000800 \
    fdl fdl2-dl.bin 0x9efffe00 \
    exec_addr 0x65015f08 \
    exec \
    reboot-recovery > /dev/null 2>&1
    
  if [ $? -eq 0 ]; then
    echo -e "\n\n\033[0;32m[✔] COMANDO ENVIADO! SOLTE O BOTÃO!\033[0m"
    echo -e "\033[1;33m[*] Aguardando celular entrar no modo Recovery...\033[0m"
    echo -e "[*] Se aparecer um menu ou o robozinho, o USB vai estabilizar."
    
    # Loop de monitoramento de estabilidade
    for i in {1..10}; do
        if lsusb | grep -q "22d9" || lsusb | grep -q "18d1"; then
            echo -e "\n\033[0;32m[!!!] USB ESTABILIZADO! DISPOSITIVO NO MODO DE SERVIÇO! [!!!]\033[0m"
            exit 0
        fi
        sleep 1
    done
    echo -e "\n\033[0;31m[!] Não estabilizou. Tentando novamente...\033[0m"
  fi
  echo -ne "Aguardando sinal do hardware... \r"
done
