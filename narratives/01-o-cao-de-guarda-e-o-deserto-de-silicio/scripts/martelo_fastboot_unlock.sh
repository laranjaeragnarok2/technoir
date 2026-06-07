#!/bin/bash
GREEN='\033[0;32m'
NC='\033[0m'
echo -e "${GREEN}=== MARTELO FASTBOOT UNLOCK (LOOP AGRESSIVO) ===${NC}"

# Loop de alta frequência para capturar o milissegundo do fastboot
while true; do
    fastboot flashing unlock 2>/dev/null
    
    if [ $? -eq 0 ]; then
        echo -e "\n\n${GREEN}[✔] COMANDO DE UNLOCK ENVIADO COM SUCESSO!${NC}"
        echo "Olhe para a tela do celular e confirme com VOLUME UP imediatamente!"
        exit 0
    fi
    echo -ne "Aguardando janela Fastboot... \r"
done
