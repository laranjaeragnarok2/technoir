#!/bin/bash
# PESCADOR DE FASTBOOTD (CAPTURAR BOOTLOOP)
# Este script deve rodar em loop para 'pescar' o celular no milissegundo que ele liga.

echo -e "\033[0;32m=== OPERAÇÃO PESCADOR: CAPTURA DE FASTBOOTD ===\033[0m"
echo -e "[*] Objetivo: Congelar o dispositivo no modo de serviço estável."
echo -e "[*] PROCEDIMENTO: Deixe o celular no bootloop conectado ao cabo."

# 1. Preparação Host
sudo modprobe -r cdc_acm 2>/dev/null
echo "-1" | sudo tee /sys/module/usbcore/parameters/autosuspend > /dev/null
echo "5000" | sudo tee /sys/module/usbcore/parameters/initial_descriptor_timeout > /dev/null

# 2. Metralhadora de Comando Fastboot
while true; do
    # Tenta forçar o modo FastbootD, que é estável e desativa o watchdog
    fastboot reboot fastboot 2>/dev/null
    
    if [ $? -eq 0 ]; then
        echo -e "\n\n\033[0;32m[✔] SUCESSO! DISPOSITIVO CAPTURADO NO MODO FASTBOOTD!\033[0m"
        echo -e "\033[1;33mO USB AGORA ESTÁ ESTÁVEL. NÃO DESCONECTE!\033[0m"
        exit 0
    fi
    echo -ne "Vigiando janela de boot... \r"
done
