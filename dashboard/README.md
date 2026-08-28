# Motherly+ — Dashboard de monitoramento

Componente separado do repositório `motherly-plus` para acompanhamento operacional do ensaio clínico. Não executa análises estatísticas; gera um site Quarto com indicadores de recrutamento, completude e status das avaliações.

## Separação de responsabilidades

| Componente | Local | Propósito |
|---|---|---|
| Dados brutos do trial | `../data/trial/` | CSV exportado do REDCap (compartilhado) |
| Dados do app | `../data/app/` | Uso do app (compartilhado) |
| Análises estatísticas | `../scripts/` | Código pré-especificado do RCT |
| **Dashboard** | **`./`** | **Monitoramento operacional e site Quarto** |
| RDS do dashboard | `./data/` | Cache gerado pelos scripts `R/` |

## Atualização

1. Exportar CSV do REDCap com **field names**.
2. Salvar em `../data/trial/MotherlyRCT2025*_DATA_YYYY-MM-DD_HHMM.csv`.
3. (Recomendado) Exportar o DataDictionary do REDCap para `../data/trial/MotherlyRCT2025*_DataDictionary_YYYY-MM-DD.csv`. Sem ele, a completude por instrumento fica indisponível.
4. Rodar o pipeline:

```r
source("dashboard/R/atualizar_dashboard.R")
```

Ou passo a passo:

```r
source("dashboard/R/preparar_dados.R")
source("dashboard/R/gerar_participantes.R")
```

E depois, no terminal:

```bash
cd dashboard
quarto render
```

5. O site estático fica em `./_site/`.

## Scripts

- `R/preparar_dados.R`: lê o CSV mais recente de `../data/trial/`, calcula completude, status das avaliações e indicadores, e salva RDS em `./data/`.
- `R/gerar_participantes.R`: lê os RDS de `./data/` e gera uma página `.qmd` por participante em `./participantes/`.
- `R/atualizar_dashboard.R`: orquestra preparação, geração de páginas, `quarto render` e publicação FTP.

## Configuração do FTP

`R/atualizar_dashboard.R` usa `keyring` para armazenar a senha do InfinityFree. Na primeira execução, solicita a senha interativamente.

## Notas

- Não salve dados brutos identificáveis em `./data/`; essa pasta deve conter apenas os RDS derivados gerados pelos scripts.
- Os arquivos em `./participantes/*.qmd` são regenerados a cada atualização; não os edite manualmente.
