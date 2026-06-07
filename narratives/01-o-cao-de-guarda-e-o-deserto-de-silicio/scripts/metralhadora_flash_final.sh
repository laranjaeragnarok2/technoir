#!/bin/bash

# Script Metralhadora de Flash Final (Versão Segura)
# krisluar21

cd /home/krisluar/spreadtrum_flash

echo -e "\033[0;32m=== METRALHADORA DE FLASH FINAL: MODO SEGURO ===\033[0m"
echo -e "\033[1;33m[*] Objetivo: Gravar system.img (3GB) com proteção de periféricos.\033[0m"

# 1. Limpeza de drivers de modem apenas (não afeta teclado/mouse)
echo "krisluar21" | sudo -S modprobe -r cdc_acm 2>/dev/null

count=0
while true; do
    # 2. Tentativa de Flash
    # Usamos wait 0 para tiro curto e redirecionamos erros para não poluir
    # A senha é passada de forma segura via pipe
    echo "krisluar21" | sudo -S ./spd_dump_unlimited --wait 0 \
        fdl fdl1-dl.bin 0x65000800 \
        fdl fdl2-dl.bin 0x9efffe00 \
        exec_addr 0x65015f08 \
        exec w super system.img reset 2>/dev/null
    
    # Se o retorno for 0, o flash foi concluído
    if [ $? -eq 0 ]; then
        echo -e "\n\n\033[0;32m[✔] SUCESSO HISTÓRICO! ROM GSI GRAVADA!\033[0m"
        echo -e "\033[1;33mO celular vai reiniciar livre do MDM.\033[0m"
        exit 0
    fi

    ((count++))
    # Feedback visual a cada 20 tentativas para acompanhar o progresso
    if (( count % 20 == 0 )); then
        echo -ne "Sincronizando com o processador (Tentativa $count)... \r"
    fi
    
    # Pequeno atraso para não sobrecarregar o barramento USB do PC
    sleep 0.2
done
