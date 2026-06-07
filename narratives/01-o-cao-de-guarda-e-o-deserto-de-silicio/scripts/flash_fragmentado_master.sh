#!/bin/bash

# Script Master de Flash Fragmentado
# Offsets calculados para blocos de 500MB (524288000 bytes = 0x1F400000)

if [ "$EUID" -ne 0 ]; then 
  echo -e "\033[0;31m[!] Erro: Use sudo.\033[0m"
  exit
fi

cd /home/krisluar/spreadtrum_flash

echo -e "\033[0;32m=== INSTALADOR MASTER: FLASH FRAGMENTADO (6 FASES) ===\033[0m"
echo -e "\033[1;33m[*] Objetivo: Gravar 2.9GB em blocos de 500MB para evitar timeout.\033[0m"

# Configuração de Handshake
FDL_ARGS="fdl fdl1-dl.bin 0x65000800 fdl fdl2-dl.bin 0x9efffe00 exec_addr 0x65015f08 exec"

# Função de Flash Seguro
flash_block() {
    local part=$1
    local offset=$2
    local file=$3
    echo -e "\n\033[1;34m[⚡] Gravando $file no offset $offset...\033[0m"
    ./spd_dump --wait 0 $FDL_ARGS wof super $offset $file
}

# Sequência de Ataque
# Nota: Não enviamos o 'reset' até o último bloco para manter a conexão BROM viva se possível
flash_block "aa" "0" "system_part_aa"
flash_block "ab" "0x1F400000" "system_part_ab"
flash_block "ac" "0x3E800000" "system_part_ac"
flash_block "ad" "0x5DC00000" "system_part_ad"
flash_block "ae" "0x7D000000" "system_part_ae"
flash_block "af" "0x9C400000" "system_part_af"

echo -e "\n\033[0;32m[✔] TODOS OS BLOCOS GRAVADOS COM SUCESSO!\033[0m"
echo -e "\033[1;33m[*] Enviando comando de RESET final...\033[0m"
./spd_dump --wait 0 $FDL_ARGS reset

echo -e "\n\033[0;32m=== PENTEST CONCLUÍDO! AGUARDE O BOOT DA GSI ===\033[0m"
