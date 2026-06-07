#!/bin/bash

# Verifica root
if [ "$EUID" -ne 0 ]; then 
  echo -e "\033[0;31m[!] Erro: Use sudo.\033[0m"
  exit
fi

cd /home/krisluar/spreadtrum_flash

# 1. Criação do binário de comando MISC (Garante o boot em modo de serviço)
echo -ne "boot-fastboot\0" | dd of=misc-f.bin bs=1 count=2048 conv=sync 2>/dev/null

echo -e "\033[0;32m=== FORÇADOR DE FASTBOOT HÍBRIDO (BROM + MISC) ===\033[0m"
modprobe -r cdc_acm 2>/dev/null

# 2. Metralhadora de Injeção
# Tentamos gravar na MISC e dar o comando de boot simultaneamente
echo -e "\n[*] Monitorando BROM (Segure VOLUME BAIXO)..."
while true; do
  ./spd_dump --wait 0 \
    fdl fdl1-dl.bin 0x65000800 \
    fdl fdl2-dl.bin 0x9efffe00 \
    exec_addr 0x65015f08 \
    exec \
    w misc misc-f.bin \
    reboot-fastboot > /dev/null 2>&1
    
  if [ $? -eq 0 ]; then
    echo -e "\n\n\033[0;32m[✔] SUCESSO! FLAG GRAVADA E COMANDO DE REBOOT ENVIADO!\033[0m"
    echo -e "\033[1;33m[*] Aguardando o celular aparecer no modo Fastboot...\033[0m"
    
    # 3. Loop de detecção do Fastboot para provar que funcionou
    for i in {1..20}; do
        if fastboot devices | grep -q "fastboot"; then
            echo -e "\n\033[0;32m[!!!] DISPOSITIVO DETECTADO NO FASTBOOT! [!!!]\033[0m"
            fastboot devices
            echo -e "\033[1;33mO USB ESTABILIZOU! Rode o unlock agora.\033[0m"
            exit 0
        fi
        echo -ne "Sincronizando Fastboot... ($i/20)\r"
        sleep 0.5
    done
    echo -e "\n\033[0;31m[!] O celular reiniciou mas não parou no Fastboot. Tentando novamente...\033[0m"
  fi
  echo -ne "."
done
