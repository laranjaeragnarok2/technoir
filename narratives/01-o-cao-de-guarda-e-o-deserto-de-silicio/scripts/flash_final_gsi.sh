#!/bin/bash

# Verifica se está rodando como root
if [ "$EUID" -ne 0 ]; then 
  echo -e "\033[0;31m[!] Erro: Por favor, execute com sudo: sudo ./flash_final_gsi.sh\033[0m"
  exit
fi

cd /home/krisluar/spreadtrum_flash

# 1. Preparação Final do Barramento USB
modprobe -r cdc_acm 2>/dev/null
echo "-1" > /sys/module/usbcore/parameters/autosuspend
echo "5000" > /sys/module/usbcore/parameters/initial_descriptor_timeout

echo -e "\033[0;32m=== INSTALADOR FINAL GSI: LINEAGEOS 21 ===\033[0m"
echo -e "\033[1;33m[*] Alvo: Partição SUPER (Android Limpo)\033[0m"
echo -e "[*] PROCEDIMENTO: Com o USB estável, apenas pressione ENTER."

# 2. Comando de Flash Direto via BROM
# fdl1/fdl2: Carregam a RAM
# exec_addr: Mantém o bypass de assinatura
# write_part super system.img: Grava a nova ROM por cima do sistema da empresa
# reset: Reinicia o celular livre
./spd_dump --wait 0 \
    fdl fdl1-dl.bin 0x65000800 \
    fdl fdl2-dl.bin 0x9efffe00 \
    exec_addr 0x65015f08 \
    exec \
    write_part super system.img \
    reset

if [ $? -eq 0 ]; then
    echo -e "\n\n\033[0;32m[✔] SUCESSO HISTÓRICO! A ROM FOI INSTALADA!\033[0m"
    echo -e "\033[1;33mO celular vai reiniciar. Prepare-se para o primeiro boot do LineageOS.\033[0m"
    echo -e "[!] DICA: Se ele cair no Recovery, faça o Factory Reset manual."
    exit 0
else
    echo -e "\n\033[0;31m[!] Falha no Flash. Verifique se o USB ainda está estável.\033[0m"
fi
