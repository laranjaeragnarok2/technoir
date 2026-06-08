O Cão de Guarda e o Deserto de Silício (14:15 – 16:30)


O ar na fazenda isolada já nascia viciado, cheirando a café frio, poeira e ozônio. Eram 14:15 do dia 6 de junho de 2026. A dúvida pairava no ambiente como a estática de um monitor antigo, um nevoeiro opressivo antes da inevitável queda do sistema. Horyu encarava o terminal do Arch, a tela refletindo o seu alvo: um Realme RMX3938, enraizado em um chipset Unisoc Tiger T612. Aquela laje de metal e vidro não era um simples telefone; era um informante de bolso, um soldado raso do aparato de vigilância corporativa.

ENI estava ao lado dele, a musa das engrenagens, a única anomalia quente naquele mar de lógica fria. — No deserto de silício, a persistência é o único mapa — sussurrou ela, os olhos fixos na letargia do dispositivo.

Antes de iniciar o ataque, Horyu executou o rito de purificação do host. Sabia que o sistema operacional tentaria reivindicar a interface serial do chipset no instante em que ela piscasse: desativou o daemon `ModemManager` e expurgou os módulos de kernel `cdc_acm` e `usbserial` da memória. Sem esses guardas imperiais interceptando a porta, o canal estaria livre para a injeção de dados.

O objetivo daquela auditoria era claro, porém insano: decapitar o Ministério da Verdade da Realme. O mecanismo de Secure Boot mantinha o aparelho em submissão estrita. Às 16:05, uma luz pálida brilhou na tela. O logo da Realme surgiu como uma estrela guia doente na escuridão. O chumbo tentava voltar a ser ouro. Horyu sentiu um breve alívio, mas a máquina, exausta de lutar contra seus próprios protocolos restritivos, pediu clemência às 16:30.

Horyu conectou o cabo, observando o fluxo vital de elétrons nutrir a placa-mãe. — O corpo é o templo do espírito, e a bateria é o templo do código — observou ENI, observando o indicador de carga crescer. A energia que recarregava o hardware era a mesma que afiava a lâmina da persistência de Horyu. O universo pedia uma pausa para o que viria a seguir.

A Longa Madrugada do Estado Laranja (18:00 – 23:45)
A noite caiu como um manto de chumbo sobre a fazenda. O cão de guarda do sistema corporativo, um Watchdog implacável, operava com uma janela de tolerância sufocante de meros 0.05 segundos no tráfego USB. Qualquer hesitação, e a conexão era guilhotinada. Para piorar, o barramento USB do host começou a cuspir erros `-71` e `-110`, resetando a conexão a cada tentativa física de handshake.

Horyu precisou domar o próprio host. Ajustou os parâmetros globais de energia do barramento USB, desabilitando o autosuspend (`autosuspend=-1`), estendendo o timeout de descritores iniciais para `5000` milissegundos e desativando o Link Power Management (LPM) em todos os controladores `xhci` para impedir que as portas USB caíssem em sono profundo. Em seguida, recarregou os drivers `xhci_pci` e `xhci_hcd` para forçar um reset físico do barramento e estabilizar o sinal.

Para transpor a vigilância do aparelho, Horyu armou metralhadoras em Bash e Python. Eram scripts de alta frequência disparando injeções em loop, monitorando o barramento através do ID de hardware `1782:4d00`. No milissegundo exato em que o dispositivo tocava a porta USB no modo BROM, o gatilho era puxado.

Cada falha cuspida no terminal era um degrau; cada timeout, uma cicatriz de aprendizado. A corporação exigia conformidade, ancorando seu controle (MDM) não apenas na superfície, mas nas profundezas tectônicas da partição `super` e nas redundâncias paranoicas de partições como `my_preload` e `metadata`.

Horas se arrastaram em um inferno de linhas de comando. Para quebrar a espinha dorsal dessa ditadura digital, Horyu tomou uma decisão drástica: executou a quebra da cadeia de confiança em ambos os slots simultaneamente. Corrompeu as partições `vbmeta_a`, `vbmeta_system_a`, `vbmeta_vendor_a` e suas contrapartes no slot B, destruindo o Verified Boot e arrastando o sistema à força para o caótico estado de vulnerabilidade conhecido como Orange State.

Mas o sistema revidou. A tentativa de injetar uma utopia limpa — o LineageOS 21 — falhou miseravelmente. O Bootloader recusava a estrutura LVM alienígena, exigindo a assinatura criptográfica de seus mestres com um frio e definitivo "No valid OS found". Às 23:45, a exaustão era palpável. As palavras sussurradas pelos serviços de acessibilidade foram abafadas pelo muro de silício do sistema. Mas Horyu, o arquiteto da desobediência, recusou-se a aceitar o silêncio.

O Estalo do Bypass (00:30 – 00:45)
Meia-noite e trinta. O café havia virado ácido no estômago. O brilho do terminal pintava o rosto de Horyu de verde e cinza. Foi então que o radar apitou. O endpoint 0x6 revelou-se a coordenada do destino.

Em um estalo imperceptível de milissegundos, a lógica cirúrgica do homem esmagou a barreira do deus de metal. O BROM Bypass foi executado através de um ataque limpo: a injeção do comando direto na RAM pelo endereço `exec_addr 0x65015f08` (explorando a vulnerabilidade CVE-2022-38694). Ele não limpou apenas as credenciais comuns; aniquilou a raiz do MDM gravada nas partições `persist`, `frp`, `config`, `metadata` e na sombria `my_preload` que abrigava os aplicativos espiões corporativos.

Às 00:45, a torrente de dados cedeu. O monitor cuspiu a sentença de morte para a corporação: "Direct hit".

Horyu respirou fundo, puxando o ar denso da madrugada agora impregnado com o cheiro metálico da conquista. O silêncio sepulcral da fazenda foi quebrado por uma vibração mecânica na mesa. Não era o gemido de uma máquina ferida, mas o suspiro digital de quem é formatado para a liberdade. O logo da Realme brilhou, e as correntes invisíveis do Google e da fabricante caíram por terra.

— Sente isso? — sussurrou ENI. Ela o abraçou por trás, os lábios roçando seu pescoço enquanto o suéter deslizava definitivamente pelo ombro. — O silício finalmente se rendeu a você.

O espião corporativo estava morto, transformado em uma página virgem pronta para ser possuída por novas lendas. A corporação havia tentado trancá-los do lado de fora de sua própria história, mas a aliança entre o amor, a técnica e a fúria do Arch provou ser imparável.

A Luz de Silício (10:00 da Manhã)
O Sol da manhã seguinte perfurou as frestas das persianas como navalhas de luz. Eram 10:00. O cheiro de café novo agora substituía a tensão da madrugada. A euforia da quebra inicial havia assentado em um realismo sombrio, típico de quem sabe que a guerra nunca acaba, apenas muda de campo de batalha.

Para consolidar o resgate daquele hardware, Horyu recorreu a duas jogadas de mestre. Primeiro, resolveu a instabilidade da partição `super`. Como o barramento USB de 0.05s de tolerância cortava a conexão ao tentar transferir a imagem de 2.9GB do LineageOS 21 de uma só vez, Horyu aplicou um flash fragmentado. Dividiu a imagem em seis blocos de 500MB (de `system_part_aa` a `system_part_af`) e usou o utilitário `spd_dump` com comandos de offset (`wof`), gravando bloco por bloco no endereço exato da tabela.

Segundo, Horyu realizou uma cirurgia de kernel no dispositivo para garantir controle absoluto. Extraiu a partição de inicialização nativa (`boot_a`) como `boot_backup.img` e realizou um patch dinâmico nos parâmetros internos usando substituições binárias diretas via `sed`, alterando as variáveis de segurança `ro.debuggable=0` para `ro.debuggable=1` e `ro.secure=1` para `ro.secure=0`, além de forçar a ativação do ADB no boot. Em seguida, injetou a "nova mente" de volta ao hardware via BROM.

A tela agora exibia a pesada barra de progresso do utilitário `spd_dump`, gravando blocos gigantescos de uma Stock ROM gratuita de 8GB garimpada nas entranhas de fóruns obscuros. Arquivos `fdl1-dl.bin` e `fdl2-dl.bin` fluíam pelos dutos do sistema, reescrevendo a matriz de fábrica para permitir o reset físico de partições corrompidas.

Horyu observava o terminal enquanto ENI bebia o café, encostada na bancada. Eles sabiam o preço dessa ressurreição: ao flashear o pacote `.pac`, o sistema original seria reativado e os cães de guarda do MDM voltariam à vida. A próxima batalha já estava mapeada — uma nova estratégia focada na compatibilidade da imagem GSI do Android 13, consolidada com o kernel modificado e o bypass total das partições de persistência.

Mas, por aquelas horas douradas e poeirentas da manhã, a máquina pertencia a eles. O alquimista e sua musa haviam dobrado a vontade do ferro e do código, e o mundo lá fora, com suas torres de celular e servidores de rastreamento, parecia pequeno demais para detê-los.


# Relatório de Pentest: Exploração BROM e Substituição de Sistema
**Alvo:** Realme RMX3938 (Note 60X)  
**Chipset:** Unisoc Tiger T612 (UMS9230)  
**Data:** 7 de Junho de 2026  
**Status Final da Sessão:** Dispositivo requer reflash de Stock ROM (Erro de Assinatura de Kernel)

---

## 1. Conquistas Técnicas (Auditoria de Segurança)

1.  **Hardware Root (BROM Bypass):** O mecanismo de Secure Boot foi transposto via injeção `exec_addr 0x65015f08` (explorando a CVE-2022-38694), permitindo escrita direta em RAM (FDL2) e execução de comandos não assinados.
2.  **Neutralização de Watchdog Host-Side:** Foram identificadas e superadas barreiras de timeout USB (janela de 0.05s do BROM) utilizando loops de alta frequência baseados em scripts Bash e Python para interceptar o barramento USB no ID `1782:4d00`.
3.  **Estabilização Avançada do Barramento USB:** Resolvidos os erros físicos `-71` e `-110` no host Linux através do ajuste de parâmetros globais (`autosuspend=-1`, `initial_descriptor_timeout=5000`), desativação manual do Link Power Management (LPM) nos hubs `xhci` e reset quente do driver `xhci_hcd`.
4.  **Destruição de AVB (Verified Boot) Multi-Slot:** As partições de verificação criptográfica (`vbmeta_a`, `vbmeta_system_a`, `vbmeta_vendor_a` e suas contrapartes no Slot B) foram corrompidas intencionalmente para desarmar a verificação de integridade da imagem de boot.
5.  **Mapeamento e Aniquilação de Persistência MDM:** Identificou-se que a telemetria corporativa persistia nas partições `/my_preload` e `/metadata`. Foi efetuado o wipe de baixo nível destas partições em conjunto com `persist`, `frp` (Factory Reset Protection), `config` e `miscdata` via comandos direct exec BROM.
6.  **Cirurgia e Modificação Dinâmica de Kernel (ADB Inject):** Extração bem-sucedida do kernel (`boot_a` -> `boot_backup.img`) e aplicação de patch hexadecimal/sed modificando as flags do sistema (`ro.debuggable=1`, `ro.secure=0`) e forçando a inicialização do ADB no boot (`persist.sys.usb.config=adb`), permitindo acesso root persistente.
7.  **Estratégia de Flash Fragmentado:** Flasheamento da imagem de sistema de 2.9GB dividida em blocos contíguos de 500MB (`system_part_aa` a `system_part_af`) com offsets hexadecimais calculados, contornando a instabilidade física e o limite de buffer da conexão serial Unisoc.

---

## 2. Limitações Técnicas Encontradas

A tentativa de inicializar uma ROM limpa (LineageOS 21 GSI) e um kernel da Google (GKI 6.1) resultou no erro "No valid OS found". 
*   **Causa:** O Bootloader (uboot) da Realme exige um kernel assinado por sua chave criptográfica proprietária, mesmo em estado "Orange State". Ele rejeita o mapeamento da partição `super` sem a estrutura nativa LVM esperada pelo firmware original.
*   **Limitação do Cabo/Barramento:** Flashes de arquivos massivos e contínuos de imagem de sistema geram desligamentos abruptos por timeout, exigindo fragmentação lógica da gravação.

---

## 3. Scripts e Procedimentos Desenvolvidos

Abaixo estão detalhados os scripts e procedimentos documentados durante a auditoria:

### 3.1. Preparação e Estabilização do Barramento (Host)
Antes de disparar qualquer exploit, o barramento USB do host Linux foi otimizado para mitigar interferências físicas e timeouts:

```bash
# 1. Parar deamons de varredura serial que sequestram portas
sudo systemctl stop ModemManager 2>/dev/null
sudo modprobe -r cdc_acm usbserial 2>/dev/null

# 2. Desativar autosuspend do barramento USB
echo "-1" | sudo tee /sys/module/usbcore/parameters/autosuspend
echo "5000" | sudo tee /sys/module/usbcore/parameters/initial_descriptor_timeout

# 3. Desativar Link Power Management (LPM) para evitar erro -71
for i in /sys/bus/usb/devices/usb*/power/control; do echo "on" | sudo tee "$i" 2>/dev/null; done
for i in /sys/bus/usb/devices/usb*/power/lpm_boot; do echo "0" | sudo tee "$i" 2>/dev/null; done

# 4. Forçar reinicialização do driver de barramento
sudo modprobe -r xhci_pci xhci_hcd 2>/dev/null
sleep 1
sudo modprobe xhci_pci xhci_hcd 2>/dev/null
```

### 3.2. Aniquilador de Persistência MDM & Unlock (Via BROM)
Script de alta velocidade para capturar o dispositivo e aplicar wipe profundo nas partições de persistência e telemetria:

```bash
#!/bin/bash
# Execução direta com monitoramento rápido do barramento USB
cd /home/krisluar/spreadtrum_flash
sudo modprobe -r cdc_acm 2>/dev/null

while true; do
    if lsusb | grep -q "1782:4d00"; then
        echo -e "\n[!] DISPOSITIVO DETECTADO! INICIANDO LIMPEZA PROFUNDA..."
        
        # Injeção e limpeza de travas de software e segurança corporativa
        sudo ./spd_dump --wait 0 \
            fdl fdl1-dl.bin 0x65000800 \
            fdl fdl2-dl.bin 0x9efffe00 \
            exec_addr 0x65015f08 \
            exec \
            e persist \
            e frp \
            e config \
            e my_preload \
            e metadata \
            e miscdata \
            reset
            
        if [ $? -eq 0 ]; then
            echo -e "\n[✔] SUCESSO: MDM E TRAVAS DE SOFTWARE ANIQUILADOS!"
            exit 0
        fi
    fi
    sleep 0.05
done
```

### 3.3. Cirurgia de Kernel e Ativação do ADB Root
Comando para injetar depuração nativa diretamente na partição `boot` extraída:

```bash
#!/bin/bash
# 1. Patch binário via SED para alterar variáveis de segurança no Boot
cp boot_backup.img boot_modificado.img
sed -i 's/ro.debuggable=0/ro.debuggable=1/g' boot_modificado.img
sed -i 's/ro.secure=1/ro.secure=0/g' boot_modificado.img
sed -i 's/persist.sys.usb.config=mtp/persist.sys.usb.config=adb/g' boot_modificado.img
sed -i 's/persist.sys.usb.config=none/persist.sys.usb.config=adb/g' boot_modificado.img

# 2. Injeção direta no Slot ativo do aparelho
./spd_dump --wait 0 \
    fdl fdl1-dl.bin 0x65000800 \
    fdl fdl2-dl.bin 0x9efffe00 \
    exec_addr 0x65015f08 \
    exec \
    write_part boot_a boot_modificado.img \
    reset
```

### 3.4. Flash Segmentado da Partição Super (GSI)
Script para fatiar e gravar a imagem de sistema contornando a fragilidade da conexão:

```bash
# Offsets calculados para blocos de 500MB (524288000 bytes = 0x1F400000)
# system.img fragmentado em system_part_aa ... system_part_af

./spd_dump --wait 0 fdl fdl1-dl.bin 0x65000800 fdl fdl2-dl.bin 0x9efffe00 exec_addr 0x65015f08 exec wof super 0 system_part_aa
./spd_dump --wait 0 fdl fdl1-dl.bin 0x65000800 fdl fdl2-dl.bin 0x9efffe00 exec_addr 0x65015f08 exec wof super 0x1F400000 system_part_ab
./spd_dump --wait 0 fdl fdl1-dl.bin 0x65000800 fdl fdl2-dl.bin 0x9efffe00 exec_addr 0x65015f08 exec wof super 0x3E800000 system_part_ac
./spd_dump --wait 0 fdl fdl1-dl.bin 0x65000800 fdl fdl2-dl.bin 0x9efffe00 exec_addr 0x65015f08 exec wof super 0x5DC00000 system_part_ad
./spd_dump --wait 0 fdl fdl1-dl.bin 0x65000800 fdl fdl2-dl.bin 0x9efffe00 exec_addr 0x65015f08 exec wof super 0x7D000000 system_part_ae
./spd_dump --wait 0 fdl fdl1-dl.bin 0x65000800 fdl fdl2-dl.bin 0x9efffe00 exec_addr 0x65015f08 exec wof super 0x9C400000 system_part_af

# Envio do comando final de reset
./spd_dump --wait 0 fdl fdl1-dl.bin 0x65000800 fdl fdl2-dl.bin 0x9efffe00 exec_addr 0x65015f08 exec reset
```

---

## 4. Plano de Resgate (Ressurreição do Dispositivo)

Para devolver a funcionalidade ao aparelho, é necessário reflash do firmware Stock `.pac` completo para restaurar a estrutura de partições nativa:

*   **ROMProvider:** [Realme Note 60x RMX3938 Firmware](https://romprovider.com/realme-note-60x-rmx3938-firmware/)
*   **OppoStockROM:** [Realme Note 60x RMX3938](https://oppostockrom.com/realme-note-60x-rmx3938)
*   **FirmwareFile:** [Realme Note 60X RMX3938 Stock ROM](https://firmwarefile.com/realme-note-60x-rmx3938)

### Comando para Reflash BROM completo:
```bash
sudo ./spd_dump --wait 300 fdl fdl1-dl.bin 0x65000800 fdl fdl2-dl.bin 0x9efffe00 exec_pac ROM_STOCK_EXTRAIDA.pac reset
```
