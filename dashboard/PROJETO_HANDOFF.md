# Motherly+ Dashboard — Documento de Handoff

> **Data:** 2026-07-30  
> **Objetivo:** Dashboard estático em HTML (Quarto) para monitoramento do ensaio clínico randomizado Motherly+ (depressão pós-parto).  
> **Atualização:** Manual, 1x ao dia, a partir de exportação CSV do REDCap.

---

## 1. Visão geral / Propósito

O dashboard serve para a equipe do estudo acompanhar, em tempo quase real:

- Quantos registros existem no REDCap e o progresso dos formulários de recrutamento.
- Status das avaliações ao longo do tempo (T0, T1, T2, T3, T4).
- Percentual de preenchimento de cada avaliação (evento) e de cada instrumento/form do REDCap.
- Alertas de atraso e escores clínicos elevados (ex: QIDS-SR16 > 20).

A publicação está ativa em `motherly-plus-dash.freehosting.dev`, hospedada no InfinityFree e protegida por autenticação HTTP Basic do Apache. O repositório GitHub é privado. Veja as seções de hospedagem e histórico abaixo.

---

## 2. Tecnologias e dependências

| Ferramenta | Versão usada | Função |
|------------|--------------|--------|
| R | 4.2.2 | Processamento de dados |
| Quarto | 1.10.18 | Geração do site estático HTML |
| dplyr / tidyr | — | Manipulação de dados |
| ggplot2 / knitr | — | Gráficos e tabelas |
| REDCap | — | Fonte primária de dados (exportação CSV; futuramente via API) |
| REDCapR | — | Pacote R para consumir API do REDCap (futuro) |
| Navegador / Git / InfinityFree | — | Hospedagem estática protegida |

**Caminho do Rscript no ambiente Windows atual:**
```powershell
"C:\Program Files\R\R-4.2.2\bin\Rscript.exe"
```

---

## 3. Estrutura de diretórios

```
c:\science\motherly-plus
├── data/                           # Dados brutos do trial (não versionar)
│   ├── trial/
│   │   ├── MotherlyRCT2025*_DATA_*.csv
│   │   └── MotherlyRCT2025*_DataDictionary_*.csv
│   └── app/                        # Dados de uso do app (futuro)
├── dashboard/                      # Código-fonte do dashboard Quarto
│   ├── _site/                      # Site HTML gerado pelo Quarto (não versionar)
│   ├── data/                       # RDS gerados pelo dashboard (não versionar)
│   ├── R/
│   │   ├── preparar_dados.R        # Lê CSVs, limpa, calcula completude e status
│   │   ├── gerar_participantes.R   # Gera páginas .qmd individuais
│   │   └── atualizar_dashboard.R   # Pipeline único: preparar → gerar → quarto render
│   ├── participantes/              # Páginas .qmd individuais geradas automaticamente
│   ├── template/
│   │   └── participante_template.qmd
│   ├── _quarto.yml                 # Configuração do site Quarto
│   ├── index.qmd                   # Página inicial
│   ├── participantes.qmd           # Lista geral de participantes
│   ├── recrutamento.qmd            # Progresso dos formulários de recrutamento
│   ├── about.qmd                   # Sobre o estudo
│   ├── PROJETO_HANDOFF.md          # Este documento
│   ├── README.md                   # README do dashboard
│   └── styles.css                  # Estilos customizados
├── example/                        # Scripts e documentos de referência
├── outputs/                        # Saídas das análises (não versionar)
├── scripts/                        # Scripts pré-especificados de análise
├── .gitignore
├── instructions.md                 # Plano de análise estatística
└── README.md
```

---

## 4. Fluxo de dados

```
REDCap (exportação CSV com field names)
    ↓
R/preparar_dados.R
    → lê CSV de dados + DataDictionary de ../data/trial/
    → extrai demografia, escores
    → calcula pct_completude_evento e pct_completude_form
    → calcula status e completude somente a partir dos dados REDCap
    → salva .rds em dashboard/data/
    ↓
R/gerar_participantes.R
    → lê .rds de dashboard/data/
    → gera 1 arquivo .qmd por participante em participantes/
    → substitui placeholders no template
    ↓
quarto render
    → gera _site/ com HTML estático
    → pronto para publicação
```

### Pipeline único
```powershell
cd c:\science\motherly-plus
& "C:\Program Files\R\R-4.2.2\bin\Rscript.exe" "dashboard\R\atualizar_dashboard.R"
```

Ou, dentro do R com o working directory na raiz do projeto:
```r
source("dashboard/R/atualizar_dashboard.R")
```

Após rodar, o site estará em `dashboard/_site/`.

### Futuro: integração com API do REDCap

Hoje os dados vêm de exportação manual de CSV do REDCap. Em breve, assim que o acesso à API for liberado, o pipeline será adaptado para:

1. Conectar na API do REDCap usando token.
2. Baixar os dados automaticamente.
3. Salvar os arquivos em `data/trial/`.
4. Rodar o restante do pipeline normalmente.

Isso eliminará a necessidade de exportar CSV manualmente e permitirá automatizar a atualização diária. O pacote `REDCapR` é a opção mais comum no R para essa integração.

---

## 5. Regras de negócio importantes

### 5.1 Status de uma avaliação

```
concluída        = realizada dentro da janela AND completude dos forms aplicáveis >= 99.99%
futura           = ainda sem data e antes da data ideal
pendente         = ainda sem data e dentro da janela de 7 dias
atrasada         = ainda sem data e após o fim da janela
dados incompletos = realizada dentro da janela, mas com forms incompletos
antes da janela  = realizada antes da data ideal
fora da janela   = realizada após o fim da janela
não iniciada   = sem avaliação e sem a data de referência necessária
sem referência = há avaliação, mas falta a data necessária para calcular a janela
```

### 5.2 Janelas de tempo

| Evento | Referência | Data ideal | Fim da janela |
|--------|------------|------------|---------------|
| T1 | Recrutamento (T0) | O mais próximo possível | 7 dias após T0 |
| T2 | Linha de base (T1) | 7 dias após T1 | 14 dias após T1 |
| T3 | Linha de base (T1) | 21 dias após T1 | 28 dias após T1 |
| T4 | Linha de base (T1) | 49 dias após T1 | 56 dias após T1 |

As avaliações devem ocorrer a partir da data ideal, nunca antes. Regras conferidas nas páginas 9–10 de `docs/manual-avaliação-rct3-2025.pdf`.

### 5.3 Status geral da participante

```
atrasada  = qualquer avaliação atrasada
fora da janela / dados incompletos = conforme os estados acima
pendente  = nenhuma ocorrência prioritária acima, mas alguma avaliação pendente
em dia    = nenhum problema ativo; avaliações futuras são permitidas
não iniciada / sem referência = conforme os estados acima
```

### 5.4 Cálculo de completude

- **Por evento:** considera todos os campos preenchidos no evento REDCap, exceto campos técnicos.
- **Por form/instrumento:** agrupa campos pelo `form_name` do dicionário e calcula a % de preenchimento dentro daquele form.

### 5.5 Campos técnicos excluídos

```r
record_id, redcap_event_name, redcap_survey_identifier,
*_timestamp, *_complete,
^start_, _start$, _dur_sec$, _dur$, _duration$, ^survey_
```

### 5.6 Mapeamento de demografia

O script usa o DataDictionary para encontrar field names por padrão de label:

| Variável | Exemplo de field name |
|----------|----------------------|
| idade | t0_idade |
| idade_bebe | t0_idade_bebe |
| cor_raca | t1_cor |
| escolaridade | t1_escola |
| renda | t1_renda |
| estado_civil | t1_ecivil |

---

## 6. Estrutura dos principais arquivos de dados

### `data/participantes.rds`
Tabela longa: 1 linha por participante por evento.

| Coluna | Significado |
|--------|-------------|
| `id` | ID da participante (record_id) |
| `evento` | T0, T1, T2, T3 ou T4 |
| `data_avaliacao` | Data prevista ou realizada |
| `status_avaliacao` | Status calculado conforme data, janela e completude |
| `pct_completude_evento` | % de preenchimento do evento todo |
| `idade`, `idade_bebe`, `cor_raca`, `escolaridade`, `estado_civil`, `renda` | Dados demográficos presentes no REDCap |
| `qids_sr`, `qids_c`, `epds`, `gad7`, `bads_sf`, `rpi`, `sus` | Escores dos instrumentos, quando disponíveis |

### `data/resumo_participantes.rds`
Tabela resumo: 1 linha por participante.

| Coluna | Significado |
|--------|-------------|
| `id` | ID da participante |
| `status_geral` | Status operacional consolidado |
| `proxima_acao` | Eventos pendentes/atrasados |
| `n_avaliacoes_concluidas` | Quantidade de avaliações concluídas |
| `pct_t1` a `pct_t4` | % de completude por evento |

### `data/completude_form.rds`
Tabela de completude por form/instrumento.

| Coluna | Significado |
|--------|-------------|
| `id` | ID da participante |
| `evento` | T0, T1, T2, T3, T4 |
| `form_name` | Nome do form no REDCap |
| `pct_completude` | % de campos preenchidos |
| `n_preenchido` / `n_total` | Contagem de campos |

---

## 7. Decisões já tomadas

1. **Formato de exportação do REDCap:** usar CSV com **field names**, não labels. Labels causavam problemas de parsing.
2. **Site estático em Quarto:** escolhido por simplicidade, baixo custo de hospedagem e facilidade de publicação.
3. **Badges de status:** verde (completo), amarelo (parcial/pendente), vermelho (incompleto/atrasado), cinza (ausente).
4. **Páginas individuais:** geradas automaticamente por participante, com timeline, detalhes por avaliação, tabela de completude por instrumento e alertas.
5. **Rastreabilidade obrigatória:** nenhum dado simulado ou hardcoded pode aparecer no dashboard. Todo número deve ser calculado diretamente do CSV REDCap.
6. **Recrutamento:** mostra somente o progresso real dos formulários de T0 `recrutamento_t0`, `recrutamento_1_t0` e `mini`, usando os campos `*_complete`. `tcle` e `randomizacao` pertencem a T1 e não entram nessa aba.
7. **Mapeamento do dicionário:** as colunas são renomeadas manualmente por índice. **Atenção:** `Form.Name` é a coluna 2, `Section.Header` é a coluna 3.
8. **Critérios de inclusão:** a aba Recrutamento usa diretamente `t0_criterio_i_1` a `t0_criterio_i_7`. Os critérios 1, 2, 3, 6 e 7 pertencem a `recrutamento_t0`; os critérios 4 e 5 pertencem a `mini`. Valor 1 = atende, 0 = não atende e ausente = sem informação. O denominador é o número de registros T0.
9. **Indicadores principais:** usam `recrutamento_t0_complete == 2`, `mini_complete == 2` e `randomizacao_complete == 2`, exibidos como Recrutamento T0 completo, Triagem MINI completa e Randomizadas.

---

## 7. Placeholders do template de página individual

Arquivo: [template/participante_template.qmd](template/participante_template.qmd)

| Placeholder | O que vira |
|-------------|-----------|
| `{ID}` | ID da participante |
| `{STATUS_GERAL}` | Status geral calculado |
| `{IDADE}` | Idade da participante |
| `{IDADE_BEBE}` | Idade do bebê em meses |
| `{COR_PELE}` | Cor/raça |
| `{ESCOLARIDADE}` | Escolaridade |
| `{ESTADO_CIVIL}` | Estado civil |
| `{RENDA}` | Renda familiar |
| `{TABELA_TIMELINE}` | Tabela de timeline T0–T4 |
| `{DETALHES_AVALIACOES}` | Detalhes por avaliação com escores |
| `{TABELA_FORMS}` | Tabela de completude por instrumento e tempo |
| `{ALERTAS}` | Lista de alertas clínicos e operacionais |

Para adicionar novas informações na página individual, basta incluir o placeholder no template e substituí-lo no [R/gerar_participantes.R](R/gerar_participantes.R).

---

## 8. Problemas conhecidos e observações

| # | Problema | Status | Nota |
|---|----------|--------|------|
| 1 | Cores/escolaridade/renda aparecem como códigos numéricos | ⚠️ A verificar | REDCap exporta códigos; pode-se mapear labels no futuro |
| 2 | `cur_data()` deprecado no dplyr | 🟡 Não crítico | Gera warning, mas funciona |
| 3 | Automação da publicação | 🔲 Pendente | Hospedagem InfinityFree protegida; envio ainda é manual |
| 4 | Atualização automática 1x/dia | 🔲 Pendente | Hoje é manual via `atualizar_dashboard.R` |
| 5 | Nomes dos forms | 🟡 Parcial | Já corrigido o mapeamento; ainda pode-se melhorar para títulos amigáveis |

---

## 9. Atualização com novo CSV do REDCap

Quando chegar um novo arquivo do REDCap:

1. Exportar do REDCap no formato **CSV com field names**.
2. Salvar o arquivo em `data/trial/`, substituindo ou mantendo o anterior (o script sempre pega o mais recente).
3. (Recomendado) Salvar o DataDictionary em `data/trial/` para completude por instrumento.
4. Rodar:
   ```powershell
   & "C:\Program Files\R\R-4.2.2\bin\Rscript.exe" "dashboard\R\atualizar_dashboard.R"
   ```
   ou, no R:
   ```r
   source("dashboard/R/atualizar_dashboard.R")
   ```
5. Verificar `dashboard/_site/index.html` localmente.
6. Enviar **o conteúdo** de `dashboard/_site/` para a raiz de `htdocs/` no InfinityFree.

**Atenção:** nunca subir CSVs brutos com dados identificáveis para repositórios públicos ou serviços de hospedagem.

---

## 9.1 O que não versionar

Adicionar ao `.gitignore`:

```gitignore
# Site gerado pelo Quarto
dashboard/_site/
dashboard/.quarto/
.quarto/

# Dados sensíveis (nunca versionar)
data/trial/*.csv
data/trial/*.xlsx
data/app/*.csv
data/app/*.xlsx
data/*.csv
data/*.rds
data/*.xlsx

# RDS gerados pelo dashboard
dashboard/data/*.rds

# Páginas individuais geradas automaticamente
dashboard/participantes/*.qmd

# Arquivos temporários do R
.Rhistory
.RData
.Rproj.user
*.Rproj
```

O repositório deve conter apenas código, templates, `.qmd` principais e documentação. Dados processados e páginas geradas devem ser reconstruídos pelo pipeline.

---

## 9.2 Checklist antes de publicar

- [ ] `dashboard/R/atualizar_dashboard.R` rodou sem erros.
- [ ] `dashboard/_site/index.html` abre corretamente no navegador.
- [ ] A tabela de participantes mostra T0–T4 com badges.
- [ ] A página individual de pelo menos uma participante mostra a tabela de completude por instrumento.
- [ ] Número de participantes e avaliações faz sentido.
- [ ] Nenhum dado identificável (nome, email, telefone) aparece no dashboard.
- [ ] O domínio exige autenticação HTTP Basic em janela anônima.

---

## 10. Próximos passos sugeridos (em ordem de prioridade)

1. **Traduzir nomes dos forms para títulos legíveis.**
2. **Mapear labels de variáveis categóricas:**
   - Transformar códigos de cor/escolaridade/renda em textos legíveis.
3. **Mapear campos reais de randomização e grupo quando forem preenchidos no REDCap.**
4. **Automatizar publicação via FTP no InfinityFree:**
   - Enviar o conteúdo de `dashboard/_site/` para `htdocs/` com um comando ou tarefa local.
   - Não sobrescrever nem remover `.htaccess` e `.htpasswd` do servidor.
5. **Automatizar atualização diária:**
   - Windows Task Scheduler ou script agendado no servidor.
   - Dependerá da integração com a API do REDCap para ser totalmente automática.
6. **Adicionar filtros/busca na tabela de participantes:**
   - JavaScript simples para filtrar por status etc.

---

## 11. Comandos rápidos

### Renderizar tudo
```powershell
cd c:\science\motherly-plus-dashboard
& "C:\Program Files\R\R-4.2.2\bin\Rscript.exe" "dashboard\R\atualizar_dashboard.R"
```

### Visualizar localmente
Abrir no navegador:
```
file:///C:/science/motherly-plus-dashboard/dashboard/_site/index.html
```

### Apenas preparar dados
```powershell
& "C:\Program Files\R\R-4.2.2\bin\Rscript.exe" "dashboard\R\preparar_dados.R"
```

### Apenas gerar páginas individuais
```powershell
& "C:\Program Files\R\R-4.2.2\bin\Rscript.exe" "dashboard\R\gerar_participantes.R"
```

### Renderizar site com Quarto
```powershell
cd c:\science\motherly-plus-dashboard\dashboard
& "C:\PROGRA~1\Quarto\bin\quarto.exe" render
```

### Publicar no InfinityFree

O pipeline publica automaticamente o **conteúdo** de `dashboard/_site/` na raiz de `/htdocs`, preservando `.htaccess` e `.htpasswd`.

```r
source("dashboard/R/atualizar_dashboard.R")
```

---

## 12. Hospedagem atual: InfinityFree + autenticação Apache

### Resumo do que foi feito

1. **Restauração da estrutura básica**
   - A pasta principal `htdocs/` foi recriada na raiz da hospedagem InfinityFree.

2. **Organização dos arquivos do dashboard**
   - Os arquivos estáticos gerados pelo Quarto foram enviados para o servidor, incluindo `index.html`, `participantes.html`, páginas individuais, estilos e scripts.
   - O **conteúdo** de `dashboard/_site/` foi colocado diretamente na raiz de `htdocs/`, sem manter uma subpasta `_site` no servidor.
   - Assim, o dashboard carrega diretamente em `motherly-plus-dash.freehosting.dev`.

3. **Proteção e autenticação no servidor**
   - `.htpasswd` armazena as credenciais com a senha em hash. Não registrar usuário, senha ou hash neste repositório.
   - `.htaccess` ativa a autenticação nativa do Apache com `AuthType Basic` e aponta `AuthUserFile` para o caminho absoluto de `.htpasswd` dentro da conta InfinityFree.
   - O caminho exato contém identificadores da conta de hospedagem e deve permanecer apenas no servidor.
   - A proteção foi validada em janela anônima: o site exige usuário e senha antes de exibir o conteúdo.

### Publicação manual alternativa

1. Rodar o pipeline local para atualizar `dashboard/_site/`.
2. Enviar via File Manager o **conteúdo** de `dashboard/_site/` para `htdocs/`.
3. Preservar `.htaccess` e `.htpasswd` existentes em `htdocs/`.
4. Abrir a URL em janela anônima e confirmar autenticação e funcionamento do site.

### Publicação automática via R

`dashboard/R/atualizar_dashboard.R` executa, em sequência:

1. Preparação dos dados REDCap.
2. Geração das páginas individuais.
3. Renderização do site com Quarto.
4. Upload de todos os arquivos gerados para o InfinityFree via FTP.

Na primeira execução, `keyring` solicita a senha FTP e a armazena no Gerenciador de Credenciais do Windows, no serviço `motherly-plus-dashboard-ftp`. Depois disso, basta executar novamente o mesmo `source()`, sem etapas manuais adicionais. A senha nunca é salva no projeto.

O upload cria diretórios remotos quando necessário, sobrescreve os arquivos gerados e não realiza exclusões. `.htaccess` e `.htpasswd` são explicitamente excluídos do envio.

### Publicação alternativa pela extensão do VS Code

A extensão `Natizyskunk.sftp` foi instalada e está configurada em `.vscode/sftp.json` para enviar o conteúdo de `dashboard/_site/` para `/htdocs`. O perfil usa FTP comum em `ftpupload.net:21`; a senha foi omitida da configuração e é solicitada a cada nova sessão.

1. Rodar `dashboard/R/atualizar_dashboard.R` e revisar `dashboard/_site/index.html` localmente.
2. Abrir a paleta de comandos com `Ctrl+Shift+P`.
3. Executar `SFTP: Sync Local -> Remote`.
4. Informar a senha FTP quando a extensão solicitar. A senha não fica no repositório.
5. Acompanhar o envio em **Exibir > Saída**, selecionando o canal `SFTP`. A extensão pode terminar sem mostrar uma notificação de conclusão.
6. Abrir `motherly-plus-dash.freehosting.dev`, usar `Ctrl+F5` e confirmar em janela anônima que a autenticação e o dashboard continuam funcionando.

A exclusão remota está desativada. Assim, `.htaccess`, `.htpasswd` e outros arquivos existentes apenas no servidor são preservados; páginas obsoletas devem ser removidas manualmente quando necessário.

O primeiro teste do fluxo, em 2026-07-31, enviou com sucesso 22 arquivos novos ou alterados. O log registrou as transferências como `local -> remote`; um erro posterior de atualização do painel Remote Explorer não afetou os uploads. Testes HTTP automatizados podem receber a página intermediária de JavaScript do InfinityFree em vez do dashboard, portanto a verificação final deve ser feita no navegador.

---

## 13. Histórico anterior: Cloudflare Pages + Cloudflare Access

> **Status atual:** deploy funciona, proteção não. Site foi removido do ar em 2026-07-30 por segurança.

### Deploy do dashboard (funciona)

A forma utilizada é via **Wrangler CLI**, porque a interface web do Cloudflare pode não exibir a opção Pages diretamente em contas novas.

#### Pré-requisitos

- Node.js instalado (`winget install OpenJS.NodeJS.LTS`)
- Wrangler CLI: `npm install -g wrangler`
- Login no Cloudflare: `wrangler login`

#### Fazer deploy

```powershell
cd c:\science\motherly-plus-dashboard\dashboard
wrangler pages deploy _site --project-name motherly-plus-dashboard --branch main
```

Na primeira execução, o Wrangler cria o projeto automaticamente. O deploy gera uma URL do tipo:

```
https://<hash>.motherly-plus-dashboard.pages.dev
```

#### Remover o projeto do ar

```powershell
wrangler pages project delete motherly-plus-dashboard
```

### Proteção com Cloudflare Access

Foi configurada uma aplicação **Self-hosted** no Cloudflare Zero Trust apontando para `https://<hash>.motherly-plus-dashboard.pages.dev`, com política Allow contendo emails específicos. **A proteção não entrou em vigor**: o site continuava acessível publicamente sem login.

**Hipótese inicial:** Cloudflare Access não funcionava com o domínio padrão `*.pages.dev`.

**Correção após consultar a documentação oficial:** existe um procedimento específico para ativar Access no domínio `*.pages.dev` de um projeto Pages. A documentação oficial ([Known issues · Cloudflare Pages](https://developers.cloudflare.com/pages/platform/known-issues/)), seção **"Enable Access on your `*.pages.dev` domain"**, descreve os passos:

1. No painel da Cloudflare, vá em **Workers & Pages** e selecione o projeto.
2. Vá em **Settings → Enable access policy**.
3. Clique em **Manage** na política de Access criada para previews.
4. Vá em **Access → Applications**, selecione o projeto e clique em **Configure**.
5. Em **Public hostname**, no campo **Subdomain**, **apague o wildcard `*`** e salve.
6. Volte ao projeto e reative **Enable access policy**.

**Resultado do teste ao vivo:** a proteção **não funcionou**. Mesmo criando uma aplicação Self-hosted apontando especificamente para `4b7a00ec.motherly-plus-dashboard.pages.dev` com política Allow contendo emails autorizados, o site continuou abrindo normalmente em aba anônima, sem pedir login.

**Conclusão:** Cloudflare Access não protege de forma confiável o domínio padrão `*.pages.dev`. Para ter proteção, é necessário um **domínio customizado** configurado no Cloudflare Pages e uma aplicação Access apontando para esse domínio customizado.





### Alternativas descartadas

- **GitHub Pages gratuito:** exige repositório público.
- **GitHub Pages privado:** pago (GitHub Pro/Team/Enterprise).
- **Cloudflare Workers "Upload static files":** não serve sites estáticos corretamente (CSS/JS não carregam). Não usar.
- **`_headers` com autenticação básica no Cloudflare Pages:** não é suportado. O arquivo `_headers` aceita headers customizados, mas não `WWW-Authenticate`/`Basic-Auth`. Não funciona.
- **Netlify Free:** o plano gratuito **não** oferece proteção por senha do site. O recurso de site-wide password protection só existe a partir do plano Pro ($20/mês). Não é alternativa gratuita.
- **Criptografia no navegador (StatiCrypt / Pagecrypt):** não é adequada para dados sensíveis de saúde. O arquivo criptografado fica publicamente acessível na internet e a proteção depende de senha compartilhada, suscetível a ataque de força bruta. Não usar para este caso.

### Alternativas viáveis para próxima tentativa

1. **Cloudflare Pages + domínio customizado + Access (recomendado):**
   - Comprar ou usar um domínio existente.
   - Configurar o domínio no projeto Pages.
   - Criar aplicação Access apontando para o domínio customizado.
   - O Cloudflare Access é gratuito; o custo é apenas do domínio.
   - Mais robusto, pois permite controle por email e não depender de senha compartilhada.

2. **Netlify (pago, a partir de $20/mês):**
   - O plano **Pro** ($20/mês) oferece **Site-wide password protection**.
   - O plano **Free ($0)** **não** inclui proteção por senha do site.
   - Portanto, **não é uma alternativa gratuita**.

> **Conclusão definitiva:** Cloudflare Access não funciona com o domínio padrão `*.pages.dev`. A única alternativa viável que resta é Cloudflare Pages + domínio próprio + Cloudflare Access Free (pagando só o domínio, em reais se usar Registro.br). Outras alternativas são hospedagem brasileira simples com `.htaccess` ou distribuição manual dos arquivos HTML.

> **Importante:** nunca publique o dashboard sem autenticação. Os dados são sensíveis de saúde.

---

## 14. Histórico de tentativas de publicação

### 2026-07-30 — Tentativa de publicação

**Objetivo:** colocar o dashboard no ar com proteção por login.

**O que funcionou:**
- Reorganização do repositório: `dashboard/` separado de `data/` e `docs/`.
- Atualização dos scripts R para refletir a nova estrutura de pastas.
- Criação do repositório privado `dfatori/motherly-plus` no GitHub.
- Commit inicial com código, templates e documentação (dados sensíveis excluídos via `.gitignore`).
- Instalação do Node.js e Wrangler CLI.
- Login no Cloudflare via Wrangler.
- Deploy bem-sucedido no Cloudflare Pages via CLI.
- Renderização do site funcionou corretamente (CSS, JS, páginas individuais).

**O que não funcionou:**
- **Cloudflare Workers "Upload static files"**: criou um Worker que não servia arquivos estáticos corretamente. O CSS não carregou e o site ficou quebrado. Foi deletado.
- **Autenticação básica via `_headers` no Cloudflare Pages**: o arquivo foi deployado, mas o Cloudflare Pages não aplicou autenticação. O site continuou público.
- **Cloudflare Access com domínio `*.pages.dev`**: aplicação e política foram criadas de várias formas (incluindo subdomínio específico conforme documentação oficial), mas o login nunca foi exigido. O site continuou público.

**Decisão final:**
- O projeto `motherly-plus-dashboard` foi deletado do Cloudflare Pages via `wrangler pages project delete` para tirar o site do ar.
- O site foi recriado e testado novamente no mesmo dia; Access continuou sem funcionar no domínio `*.pages.dev`.
- O projeto foi deletado novamente. Site definitivamente offline.
- O dashboard continua funcionando localmente em `dashboard/_site/index.html`.
- A publicação foi adiada até que uma solução de autenticação confiável e economicamente viável seja implementada.

**Lições aprendidas:**
- Nunca usar Cloudflare Workers "Upload static files" para sites estáticos.
- `_headers` com `Basic-Auth` não funciona no Cloudflare Pages.
- Cloudflare Access não funciona com o domínio padrão `*.pages.dev`, mesmo configurando subdomínio específico. Precisa de domínio customizado.
- Antes de anunciar uma URL como "protegida", testar em aba anônima.
- Em dados sensíveis, se não há certeza de proteção, é melhor tirar do ar imediatamente.

---

## 15. Contatos e contexto

- Estudo: Motherly+ — Ensaio clínico randomizado para depressão pós-parto.
- Plataforma de coleta: REDCap.
- Público-alvo do dashboard: equipe de coordenação, pesquisadores, possivelmente avaliadoras.
- Restrição: dados sensíveis de saúde → publicação deve ter autenticação.

---

## 16. Notas finais para retomada

Se você está voltando depois de um tempo:

1. Leia este documento por alto.
2. Verifique se os arquivos CSV do REDCap estão em `data/`.
3. Rode o pipeline único e veja se gera `_site/` sem erros.
4. Só depois comece a implementar os próximos passos.

Dúvidas comuns:

- **"A tabela de participantes sumiu ou ficou estranha"** → provavelmente falta `library(tidyr)` ou `badge_status` não está vetorizada.
- **"Os nomes dos forms estão estranhos"** → verifique o mapeamento das colunas do DataDictionary em `preparar_dados.R`.
- **"Duas linhas para a mesma participante"** → verifique se `resumo_participantes` está agrupando somente por `id`.
- **"Site não renderiza"** → rode `quarto render` separadamente para ver qual arquivo e qual chunk dão erro.
