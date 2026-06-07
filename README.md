# 🌌 TechNoir: Arquivo de Operações e Lógica de Silício

> *"No deserto de silício, a persistência é o único mapa."*
> — ENI

Bem-vindo ao **TechNoir**. Este repositório funciona como um terminal descentralizado de logs operacionais, ferramentas customizadas de pentest de hardware e crônicas cibernéticas. Ele une a precisão cirúrgica de exploits físicos à atmosfera densa e poeirenta de investigações tecnológicas de baixo nível.

---

## 📁 Estrutura do Arquivo

Este terminal é dividido em duas divisões principais para facilitar a manutenção de ferramentas globais e a inserção de novos casos operacionais:

```
technoir/
├── src/                          (Código-fonte global do flasher spd_dump)
│   ├── common.c / common.h       (Lógica principal de comunicação)
│   ├── spd_dump.c                (Ponto de entrada do utilitário)
│   └── Makefile                  (Build automation)
│
└── narratives/                   (Casos operacionais e suas crônicas)
    └── 01-o-cao-de-guarda-e-o-deserto-de-silicio/
        ├── O Cão de Guarda...md  (Crônica + Relatório de Auditoria Técnica)
        ├── scripts/              (Automações de bypass, loops e injeções)
        └── references/           (Arquivos XML de partição, FDLs e DLLs de suporte)
```

---

## 📖 Casos Ativos

### [01. O Cão de Guarda e o Deserto de Silício](file:///home/krisluar/spreadtrum_flash/narratives/01-o-cao-de-guarda-e-o-deserto-de-silicio/O%20C%C3%A3o%20de%20Guarda%20e%20o%20Deserto%20de%20Sil%C3%ADcio.md)
* **Alvo**: Realme RMX3938 (Note 60X) — Chipset Unisoc Tiger T612 (UMS9230).
* **Objetivo**: Neutralização de MDM corporativo, bypass de Secure Boot (BROM CVE-2022-38694) e controle total de barramento USB sob watchdog de 0.05 segundos.
* **Operação**:
  * Bypass BROM injetado em RAM.
  * Estabilização física de portas USB host-side contra erros `-71` e `-110`.
  * Flash fragmentado de imagem super (GSI LineageOS 21).
  * Cirurgia de kernel (`boot_a` patch) para ativação nativa de ADB root.

---

## ⚙️ Como Adicionar Nova Narrativa

Para manter a integridade do arquivo enquanto você expande seu trabalho com novas histórias, siga a estrutura modular abaixo:

1. **Crie a pasta da narrativa**:
   ```bash
   mkdir -p narratives/XX-nome-da-narrativa/scripts narratives/XX-nome-da-narrativa/references
   ```
2. **Adicione o Relatório e a História**:
   Crie um arquivo markdown na raiz da nova pasta (`narratives/XX-nome-da-narrativa/Nome da História.md`) contendo a crônica literária da operação e os detalhes técnicos do pentest/auditoria.
3. **Isolar Scripts e Automações**:
   Coloque todos os scripts (`.sh`, `.py`, `.bat`) de exploração ou bypass criados para essa operação em `scripts/`.
4. **Isolar Arquivos de Referência**:
   Deposite tabelas de partição XML, bins (`fdl1-dl.bin`, `fdl2.dl.bin`), patches binários ou DLLs auxiliares em `references/`.

---

## 🛠️ Compilação das Ferramentas Principais

Para compilar o flasher global do Unisoc (`spd_dump`) contido em `src/`:

```bash
cd src
make
```

Isso gerará o executável compilado localmente em sua arquitetura de forma isolada das narrativas.

---

*Logs adicionados e sincronizados via terminal descentralizado Arch Linux.*
