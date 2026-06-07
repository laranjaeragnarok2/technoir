#!/bin/bash
# === ATAQUE DE DESBLOQUEIO ESTILO NUCLEAR ===
# Este script segue o padrão que funcionou para levar o celular ao Fastboot.

echo "=== INICIANDO ATAQUE DE DESBLOQUEIO (PADRÃO NUCLEAR) ==="
echo "Procedimento: Segure VOLUME BAIXO e conecte o cabo."

# Prevenção de interferências (Padrão que funcionou)
sudo systemctl stop ModemManager 2>/dev/null
sudo modprobe -r usbserial 2>/dev/null
sudo modprobe -r cdc_acm 2>/dev/null
echo -1 | sudo tee /sys/module/usbcore/parameters/autosuspend > /dev/null

cd /home/krisluar/spreadtrum_flash

while true; do
    # Usando a mesma estrutura do ataque_nuclear.sh que teve sucesso
    sudo ./spd_dump --wait 0 \
        fdl fdl1-dl.bin 0x65000800 \
        fdl fdl2-dl.bin 0x9efffe00 \
        exec_addr 0x65015f08 \
        exec \
        e persist \
        e frp \
        e config \
        e userdata \
        e metadata \
        e misc \
        verity 0 \
        reboot-fastboot 2>/dev/null
    
    if [ $? -eq 0 ]; then
        echo ""
        echo "!!! SUCESSO: LIMPEZA E DESBLOQUEIO ENVIADOS !!!"
        echo "O celular deve entrar em modo Fastboot agora."
        echo "Aguarde as letras aparecerem na tela."
        exit 0
    fi
    
    # Pequeno delay para ser "ágil" mas não sobrecarregar (igual ao anterior)
    sleep 0.1
done
