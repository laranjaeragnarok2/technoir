#!/bin/bash

# Verifica se está rodando como root
if [ "$EUID" -ne 0 ]; then 
  echo -e "\033[0;31m[!] Use sudo: sudo ./estabilizar_usb_pro.sh\033[0m"
  exit
fi

echo -e "\033[0;32m=== OTIMIZADOR DE BARRAMENTO USB (ANTI-ERRO -71/-110) ===\033[0m"

# 1. Desativa Autosuspend Global
echo -n "Limpando configurações de energia... "
echo -1 > /sys/module/usbcore/parameters/autosuspend
echo "Y" > /sys/module/usbcore/parameters/initial_descriptor_timeout
echo -e "\033[0;32m[OK]\033[0m"

# 2. Desativa o LPM (Link Power Management) - O Culpado do erro -71
# Procuramos por controladores xhci e desativamos o LPM neles
for i in /sys/bus/usb/devices/usb*/power/control; do
    echo "on" > "$i" 2>/dev/null
done

for i in /sys/bus/usb/devices/usb*/power/lpm_boot; do
    echo 0 > "$i" 2>/dev/null
done

# 3. Reset Físico do Controlador (Derruba e sobe o driver)
echo -n "Reiniciando driver xhci_hcd... "
modprobe -r xhci_pci 2>/dev/null
modprobe -r xhci_hcd 2>/dev/null
sleep 1
modprobe xhci_pci 2>/dev/null
modprobe xhci_hcd 2>/dev/null
echo -e "\033[0;32m[OK]\033[0m"

echo -e "\n\033[1;33m[*] Barramento estabilizado! Tente o flash agora.\033[0m"
echo -e "[*] DICA: Se possível, use uma porta USB 2.0 (preta) em vez da 3.0 (azul).\033[0m"
