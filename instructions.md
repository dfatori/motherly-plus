_INSTRUCTIONS OF PROJECT_
_DELETE LATER_
_DELETE LATER_
_DELETE LATER_

# Motherly+ RCT3 — Pre-Specified Statistical Analysis Plan

## 1. Overview

Parallel-group randomized controlled trial (RCT) testing the efficacy of **single-session psychotherapy supported by a smartphone app (Motherly)** for postpartum depression (PPD), compared to a **waitlist control** group.

- **Planned N**: 104 women (18–40 years old, up to 12 months postpartum, with major depressive disorder).
- **Arms**: 1 = Waitlist (control); 2 = Intervention.
- **Timepoints**: T1 (baseline, week 1), T2 (week 2), T3 (week 4, post-treatment), T4 (week 8, follow-up).

## 2. Outcomes

### Primary outcome
- QIDS-C16 total score at T3 (week 4).

### Secondary outcomes (T3 and T4, unless otherwise noted)
- QIDS-SR16 total score
- GAD-7 total score
- PSQI total score
- PSI-SF scores: parental distress, parent-child dysfunctional interaction and total stress
- SDS total score
- EPDS total score
- CGI-I at T3 only (no baseline)

### Mediators (T1 and T2)
- BADS-SF total score
- RPI total score

### Moderators (baseline)
- Maternal age, race/skin color, education, income, number of children, marital status, social support (MSPSS), infant age, prenatal visits, baseline QIDS-SR16/QIDS-C16, baseline CGI-S, baseline SDS.

### Treatment-specific processes
- Therapeutic alliance (WAI-SR client and therapist versions) at T2.

## 3. Main analytical strategy

- **Intention-to-treat (ITT)**: all randomized participants are analyzed according to allocated group.
- **Missing data**: multiple imputation by chained equations (MICE), assuming data missing at random (MAR), in `scripts/06_multiple-imputation.r`. Before the analyses, `scripts/05_missing-data.r` describes the observed missing data (descriptive only, no statistical tests): availability of each outcome by timepoint and group (n and %).
  - One imputation model for all randomized participants, with group always included as a predictor.
  - Imputed variables: QIDS-C16 (T3); QIDS-SR16, GAD-7, PSQI, PSI-SF (parental distress, parent-child dysfunctional interaction, difficult child; the total is the sum of the three), SDS and EPDS (T3 and T4); CGI-I (T3, ordinal). T1 is complete.
  - Predictors (selected with `quickpred`, |r| ≥ 0.2, group always included): `age`, `infant_age_months`, `white_race`, `higher_education`, `married_or_stable`, `family_income`, `mental_health_treatment`, baseline CGI-S, T1 scores of all outcomes (including PSQI and PSI-SF) and the other timepoints of each outcome (QIDS-SR16 at T2 as auxiliary).
  - Methods: predictive mean matching (continuous scores) and proportional-odds model (CGI-I).
  - **m = 100** imputations, 20 iterations, fixed seed. Graham et al. (2007): m = 100 keeps the power loss under 1% (vs. maximum likelihood) for a fraction of missing information up to 0.7. The fraction of missing information (FMI) of each parameter is reported; if any exceeds 0.7, m is increased.
  - Results of the m analyses are combined with Rubin's rules.
- **Models**: generalized estimating equations (GEE) with first-order autoregressive correlation structure (AR1) and robust sandwich standard errors, following Twisk et al. (2018), equation 2d: `outcome ~ time + time × group` **without a group main effect**, with time as dummy variables. T1 is the intercept (assumed equal in both groups by randomization, so baseline differences are accounted for), and the intervention effect at each follow-up is the `time × group` coefficient.
  - Primary outcome (T1 and T3): `qidsc16 ~ T3 + T3:group`.
  - Secondary outcomes (T1, T3 and T4): `outcome ~ T3 + T4 + T3:group + T4:group`. T2 is not an outcome.
  - CGI-I (T3 only, no baseline): scored 1–7 and analyzed as a continuous outcome, with a linear regression of the score on group, fitted in each imputed dataset (imputed as an ordinal variable). Marginal means, the Waitlist − Intervention contrast and Cohen's d are reported as for the other outcomes.
- **Reporting**: marginal means and group contrasts (Waitlist − Intervention, positive favors the intervention) at T3 and T4 only, with no baseline contrast or test. No multiplicity correction (one contrast per timepoint and outcome).
- **Complete-case analysis** (`scripts/09_outcomes-complete-case.r`): the same models, with no imputation. For each outcome, participants with any missing value at the timepoints of that outcome (T1 and T3 for the primary; T1, T3 and T4 for the secondary outcomes; T3 for CGI-I) are excluded before fitting, so they do not contribute even their baseline. The GEE is fitted once on the observed data and the number analysed and excluded is reported for each outcome.
- **Effect size**: Cohen's d = contrast / pooled within-group SD at that timepoint (averaged over the imputed datasets).
- **Significance**: p < 0.05; 95% confidence intervals for all parameters.

## 4. Analytic variable naming

### Allocation
- `group`: 1 = Waitlist, 2 = Intervention
- `group_f`: factor with labels

### Longitudinal outcomes
Instruments by event follow the REDCap instrument-event mapping (`data/MotherlyRCT2026_InstrumentDesignations_*.csv`). The same REDCap field names (e.g., `t1_psqi_*`, `t1_total_epds`) are reused in every event where the instrument is applied. A dash means the instrument is not applied in that event.

| Construct | T1 | T2 | T3 | T4 |
|---|---|---|---|---|
| QIDS-C16 | `qidsc16_t1` | — | `qidsc16_t3` | — |
| QIDS-SR16 | `qidssr16_t1` | `qidssr16_t2` (auxiliary only) | `qidssr16_t3` | `qidssr16_t4` |
| GAD-7 | `gad7_t1` | — | `gad7_t3` | `gad7_t4` |
| PSQI | `psqi_t1` | — | `psqi_t3` | `psqi_t4` |
| SDS | `sds_t1` | — | `sds_t3` | `sds_t4` |
| EPDS | `epds_t1` | — | `epds_t3` | `epds_t4` |
| PSI-SF parental distress | `psi_pd_t1` | — | `psi_pd_t3` | `psi_pd_t4` |
| PSI-SF P-CDI | `psi_pcdi_t1` | — | `psi_pcdi_t3` | `psi_pcdi_t4` |
| PSI-SF difficult child (only to build the total) | `psi_dc_t1` | — | `psi_dc_t3` | `psi_dc_t4` |
| PSI-SF total | `psi_total_t1` | — | `psi_total_t3` | `psi_total_t4` |
| CGI-I | — | — | `cgi_i_t3` | — |

### Baseline variables
- `age`, `infant_age_months`, `white_race`, `higher_education`, `married_or_stable`, `working`, `studying`, `family_income`, `people_in_household`, `number_of_children`, `firstborn`, `prenatal_visits`, `high_risk_pregnancy`, `mental_health_treatment`.

## 5. Script structure

| Script | Purpose |
|---|---|
| `01_load-trial.r` | Load raw REDCap trial data export |
| `02_process-trial.r` | Process trial data: recoding, instrument scores (PSQI and PSI-SF at T1, T3 and T4), baseline/long datasets |
| `03_codebook-trial.r` | Codebook of trial analytic variables |
| `04_descriptive-baseline.r` | Sample description and Table 1 |
| `05_missing-data.r` | Description of missing data (availability of each outcome by timepoint and group) |
| `06_multiple-imputation.r` | Multiple imputation (MICE, m = 100) of the pre-registered outcomes |
| `07_primary-outcome.r` | Primary outcome analysis (QIDS-C16 at T3) on the imputed datasets |
| `08_secondary-outcomes.r` | Secondary outcomes at T3 and T4, and CGI-I at T3, on the imputed datasets |
| `09_outcomes-complete-case.r` | Complete-case analysis (no imputation) of the primary and secondary outcomes |
| `10_adverse-events.r` | Definition and description of adverse events |
| `mi-helpers.r` | Helpers: GEE per imputed dataset (`mice::as.mira`, `mice::pool`), marginal means, contrasts and Cohen's d (`emmeans`) (sourced, not run directly) |
| `cc-helpers.r` | Helpers for the complete-case analysis: per-outcome filter (`tidyr::drop_na`) and single GEE fit (sourced, not run directly) |
| `figures-helpers.r` | Shared plotting helpers (sourced, not run directly) |
| `run-all.r` | Run all scripts in order and build the report |
| `simulate-data.r` | Temporary simulator of REDCap-style data (delete before final analysis) |
| `archived/20_moderation-analysis.r` | **Not pre-registered** — moderation models (archived) |
| `archived/21_mediation-analysis.r` | **Not pre-registered** — parallel mediation, BADS-SF and RPI (archived) |
| `archived/22_process-analysis.r` | **Not pre-registered** — therapeutic alliance and app engagement (archived) |

## 6. Folder structure

```
motherly-plus/
├── data/                      # All study data: REDCap CSV exports (not versioned)
├── example/                   # Reference scripts and protocol
├── outputs/                   # All generated analysis outputs
│   ├── figures/               # Plots and images (prefixed by script number)
│   ├── models/                # RDS files: datasets and fitted models (prefixed by script number)
│   └── tables/                # CSV and HTML tables (prefixed by script number)
├── scripts/                   # Pre-specified analysis scripts
├── .gitignore                 # Excludes raw data and generated files
├── instructions.md            # This analysis plan
└── README.md
```

All analysis output filenames are prefixed with the script number that generated them (e.g., `06_qids_contrasts.csv` from `06_primary-outcome.r`).

## 7. Important notes

- REDCap data are exported in long format (`record_id` + `redcap_event_name`).
- The real export of 2026-10-27 is partial (T0–T2 only, 2 participants with T2). Instruments in T3 and T4 follow the REDCap instrument-event mapping; the simulated dataset mirrors it.
- Scripts must be reproducible from the exported REDCap CSV.

## 8. Items requiring verification

The following implementation details in the analysis scripts were written as placeholders or based on assumptions and **must be verified against the final REDCap data dictionary and official instrument scoring keys** before running the analyses:

1. **PSI-SF scoring**: The current subscale and total score calculations assume the 36 PSI-SF items are ordered 1–36 in the REDCap instrument and mapped to the PSI-4 variable names (`t1_psi10`, `t1_psi12`, `t1_psi13`, `t1_psi14`, `t1_psi17`, `t1_psi18`, `t1_psi19`, `t1_psi20`, `t1_psi23`, `t1_psi24`, `t1_psi26`, `t1_psi31`, `t1_psi32`, `t1_psi34`, `t1_psi36`, `t1_psi38`, `t1_psi41`, `t1_psi42`, `t1_psi44`, `t1_psi47`, `t1_psi50`, `t1_psi56`, `t1_psi58`, `t1_psi63`, `t1_psi64`, `t1_psi69`, `t1_psi70`, `t1_psi72`, `t1_psi73`, `t1_psi76`, `t1_psi80`, `t1_psi85`, `t1_psi91`, `t1_psi92`, `t1_psi93`, `t1_psi100`). Reverse-coded items are assumed to be `t1_psi58` (item 22), `t1_psi41` (item 32), and `t1_psi42` (item 33). This reverse-coding assumption must be verified against the official Brazilian PSI-SF manual before analysis; if REDCap already stores items in the stress direction, the `rev5()` transformation must be removed.
2. **PSQI scoring**: The total score uses the 7-component algorithm (Buysse et al., 1989) on the REDCap items, which are stored as 0–3 response categories (data dictionary). Item mapping in this instrument: `t1_psqi_6` = subjective sleep quality, `t1_psqi_7` = sleep medication, `t1_psqi_8` and `t1_psqi_9` = daytime dysfunction; `t1_psqi_2` (latency) and `t1_psqi_4` (duration) are already categories. Habitual sleep efficiency needs hours slept, but `t1_psqi_4` is categorical, so category midpoints (7.5, 6.5, 5.5, 4.5 h) are assumed; bed and rise times (`t1_psqi_1`, `t1_psqi_3`) are assumed to be "HH:MM". A missing `t1_psqi_5j2` (other disturbance) counts as 0. Verify these assumptions before analysis.
3. **SDS at T4**: The pre-registration includes the SDS at T4, but the instrument-event mapping of 2026-10-27 applied it only at T1 and T3. The REDCap schedule is being updated to include T4; confirm in the final mapping.
4. **WAI-SR scoring**: The analysis uses the REDCap-derived subscale scores for client (`t2_waisrc_goals`, `t2_waisrc_tasks`, `t2_waisrc_bond`) and therapist (`t2_waisrt_goals`, `t2_waisrt_tasks`, `t2_waisrt_bond`). Verify that these are the official WAI-SR subscales and that directionality is correct.
5. **BADS-SF and RPI**: The scripts use REDCap totals `t1_badssf_total` and `t1_total_rpi`. Verify these are correctly computed.
6. **Sociodemographic recoding**: Codes for race (`t1_cor`), education (`t1_escola`), marital status (`t1_ecivil`), employment and other categorical variables were assumed. Final codes from REDCap must be confirmed.
7. **Group allocation**: The variable `rand_number` was assumed to hold the allocation code. The final variable name and codes must be confirmed once randomization is completed.
8. **CGI-I values**: The variable `t3_cgi_i` is used. Confirm directionality as 1 = very much improved to 7 = very much worse.
9. **QIDS item 12 (suicidality)**: The scripts use `qidsc16_12` and `qidssr16_12` extracted from the long dataset, plus clinical fields `pron_ideacao`, `enc_1___2`, `enc_1___3`, and `dropout7`. Verify these variable names and thresholds in the final REDCap export.

## 9. Change log

Session on 2026-10-27:
- **CGI-I changed to linear regression**: O CGI-I (T3, sem basal) passou de regressão ordinal (`polr`, OR) para regressão linear do escore (1–7) no grupo, em cada conjunto imputado e combinada pelas regras de Rubin (`lm` + `mice::pool`; médias e contraste via `emmeans`, d de Cohen como nos demais desfechos). A imputação continua ordinal (`polr` no MICE). O gráfico de contagens (só observados, sem imputação, n diferente entre grupos) foi substituído por médias marginais estimadas com IC 95%; a tabela de distribuição foi removida. A análise de casos completos usa o mesmo modelo e o CGI-I entra na tabela de contrastes (a tabela de OR saiu). Relatório: CGI-I Tabelas 12a/b e Figura 10, casos completos Tabela 13, eventos adversos Tabela 14. Helpers: `lm_emmeans()` em `scripts/mi-helpers.r` e `plot_group_means()` em `scripts/figures-helpers.r`.- **Missing-data description added**: Novo `scripts/05_missing-data.r`, antes das análises, só descritivo (sem testes de MAR, sem regressões de missingness e sem comparar características de quem perdeu): tabela de disponibilidade por desfecho, tempo e grupo (n e %). Padrões de visitas, perfil basal de observados vs. faltantes, figura de % observado e motivos de perda foram descartados. Scripts renumerados: `04_descriptive-baseline`, `05_missing-data`, `06_multiple-imputation`, `07_primary-outcome`, `08_secondary-outcomes`, `09_outcomes-complete-case`, `10_adverse-events` (outputs com o mesmo prefixo). No relatório, nova seção "Missing data" (Tabela 2) e as demais tabelas/figuras deslocadas (primário 3a–c e Figura 1, secundários 4–11, CGI-I 12a/b, casos completos 13–14, eventos adversos 15).
- **Refactor to package functions**: As análises passaram a usar funções de pacotes no lugar de código à mão: `mice::as.mira` e `mice::pool` (combinação pelas regras de Rubin, incluindo CGI-I com `polr`), `emmeans` (médias marginais, contrastes e d de Cohen via `eff_size`), `broom::tidy` (análise de casos completos), `tidyr::pivot_wider`/`pivot_longer`/`drop_na` (montagem dos dados) e `lubridate`/`cut`/`case_when` (escore do PSQI). Conferência contra a versão anterior: estimativas, EPs e d de Cohen idênticos (diferença < 1e-15) e escores de PSQI/PSI-SF idênticos. Mudam apenas os ICs e p-valores, porque `emmeans` e `pool` usam os graus de liberdade do pacote (baseados no número de observações) em vez do z ou de n−k de participantes, e o IC do d passa a incluir a incerteza do SD (`eff_size`, `edf` = n−2).
- **Complete-case analysis added**: Novo `scripts/08_outcomes-complete-case.r` (com `scripts/cc-helpers.r`): versão sem imputação de todas as análises (primário, secundários e CGI-I), em que, por desfecho, só entram participantes sem nenhum valor faltante nos tempos daquele desfecho (filtro aplicado antes do GEE). Os mesmos modelos de Twisk 2d, ajustados uma vez nos dados observados, com n analisado e excluído. `08_adverse-events` passou a `09_adverse-events` (outputs com prefixo `09_`); relatório com nova seção (Tabelas 12 e 13, eventos adversos na Tabela 14). A construção das matrizes de contraste foi movida para `gee_design()` em `scripts/mi-helpers.r`, sem mudar os resultados da ITT.
- **Analysis aligned with Twisk et al. (2018) and multiple imputation**: Os modelos passaram de `outcome ~ group * time` (que inclui o efeito principal de grupo e não ajusta pelo basal) para `outcome ~ time + time × group` sem efeito principal de grupo (Twisk, equação 2d), com GEE-AR1, como no Zuccolo et al. (2024). Foi adicionada imputação múltipla (MICE, MAR, m = 100 por Graham et al. 2007, imputação única com grupo como preditor) em `scripts/04_multiple-imputation.r`; os GEE rodam em cada conjunto imputado e são combinados pelas regras de Rubin (`scripts/mi-helpers.r`). Contrastes e médias só em T3 e T4 (sem contraste basal, sem FDR), com d de Cohen. CGI-I (sem basal) segue em regressão ordinal por imputação. Os secundários agora seguem o pré-registro (T3 e T4): entram PSQI e PSI-SF (distress parental, P-CDI e total), o SDS passa a T3 e T4, o EPDS permanece, e T2 deixa de ser desfecho. Scripts renumerados: `04_multiple-imputation`, `05_descriptive-baseline`, `06_primary-outcome`, `07_secondary-outcomes`, `08_adverse-events`; o relatório e os outputs foram regenerados (tabelas 2 a 11).
- **Instrument schedule and scoring**: O simulador e o `02_process-trial.r` seguem o mapeamento instrumento-evento do REDCap (`MotherlyRCT2026_InstrumentDesignations_2026-10-27.csv`): itens de PSQI e PSI-SF em T1, T3 e T4, escores calculados em cada evento, sem T2 para os instrumentos que não são aplicados nele, e sem perdas em T1. O escore do PSQI foi corrigido para o dicionário (itens 0–3, `t1_psqi_6` = qualidade do sono, `t1_psqi_7` = medicação, `t1_psqi_8`/`t1_psqi_9` = disfunção diurna); antes assumia itens 1–4 e outra ordem dos itens. O simulador deixou de exportar os totais que não existem no REDCap (`t1_total_sds`, `t1_psqi_total`, `t1_psi_total`).
- **Sensitivity analyses removed**: Removeu as análises de sensibilidade (completers-only, ajustada pelo basal e correlação exchangeable), que não faziam parte do que foi solicitado: apagou `scripts/07_sensitivity-analysis.r`, seus outputs, a seção do relatório e as menções em `README.md`, `instructions.md` e `scripts/run-all.r`. `08_adverse-events` passou a `07_adverse-events` (prefixo `07_` nos outputs) e a tabela de eventos adversos do relatório passou a Tabela 8.
- **Scripts renumbered**: Numeração sequencial 01–08 na ordem de execução, sem buracos: `00_load-trial`→`01_load-trial`, `07_descriptive-baseline`→`04_descriptive-baseline`, `10_primary-outcome`→`05_primary-outcome`, `11_secondary-outcomes-analysis`→`06_secondary-outcomes`, `30_sensitivity-analysis`→`07_sensitivity-analysis`, `31_adverse-events`→`08_adverse-events` (`02_process-trial` e `03_codebook-trial` mantidos). Os arquivos sem número ficam soltos em `scripts/`: `run-all.r` (antes `99_master-run.r`), `simulate-data.r` (antes `98_simulate-data.r`) e `figures-helpers.r` (antes `_figure-helpers.r`). Os prefixos dos outputs passam a corresponder ao script que os gera (ex.: `02_baseline_analytic.rds`, `04_table1_baseline.*`, `05_qids_*`, `06_*`, `07_*`, `08_*`); antes, `00_` e `03_table1` não batiam com o script gerador. Atualizou caminhos nos scripts, no relatório e nas docs, e regenerou `outputs/`. Os scripts de `archived/` mantêm seus nomes.
- **Dashboard moved out of this repository**: Moveu o dashboard operacional (`dashboard/`) para o projeto separado `C:\science\motherly-plus-dashboard\dashboard\`, sem alterações de conteúdo. Removeu a Seção 7 (dashboard) deste documento, as menções a ele em `README.md` e `.gitignore`, e renumerou as seções seguintes. Este repositório contém apenas o plano de análise, scripts, outputs e relatório.
- **Results report (RMD)**: Criou `reports/motherly-plus.Rmd`, um relatório HTML em formato de artigo científico que **monta** os outputs já produzidos (não re-roda modelos): Tabela 1, desfecho primário (QIDS-C16), secundários (QIDS-SR16, GAD-7, SDS, EPDS, CGI-I), análises de sensibilidade e eventos adversos. Para viabilizar a montagem sem re-fit, `scripts/07_descriptive-baseline.r` e `scripts/31_adverse-events.r` passaram a salvar os objetos gtsummary (`07_table1_gtsummary.rds`, `31_ae_table_gtsummary.rds`). Corrigiu bug latente em `scripts/31_adverse-events.r` (faltava `library(flextable)`, que só funcionava no master-run porque o script 07 o carregava antes).
- **Outcome figures for all outcomes + readability fix**: Criou o helper `scripts/_figure-helpers.r` (funções `plot_marginal_means`, `plot_ordinal_distribution`, `save_figure`) com estilo e cores consistentes. `scripts/10_primary-outcome.r` passou a usar o helper e o título longo agora quebra em linhas (antes era cortado na borda). `scripts/11_secondary-outcomes-analysis.r` agora gera figuras para todos os desfechos secundários: médias marginais estimadas ao longo do tempo para QIDS-SR16, GAD-7, SDS e EPDS (`11_<outcome>_marginal_means.png`) e distribuição ordinal do CGI-I em T3 por grupo (`11_cgi_distribution.png`).
- **Flattened data folder**: Removeu o subnível `data/trial/`; os CSVs brutos do REDCap passam a ficar direto em `data/` (subpastas `data/piloto/` e `data/_archived/` mantidas). Atualizou os caminhos em `scripts/00_load-trial.r`, `scripts/31_adverse-events.r`, `scripts/98_simulate-data.r`, `scripts/02_process-trial.r` (comentário), os scripts e docs do dashboard (`dashboard/R/preparar_dados.R`, `dashboard/R/atualizar_dashboard.R`, `dashboard/about.qmd`, `dashboard/README.md`, `dashboard/PROJETO_HANDOFF.md`), o `.gitignore` e as docs (`README.md`, `instructions.md`).
- **App data pipeline removed**: Removeu o componente de dados de uso do app, que não será coletado/analisado: excluiu os scripts placeholder `01_load-app.r`, `04_process-app.r`, `05_codebook-app.r` e `06_merge-trial-app.r`, a pasta `data/app/` e os outputs relacionados (`01_app_raw.rds`, `04_app_processed.rds`, `06_baseline_with_app.rds`, `04_app_processed.csv`, `05_codebook_app.csv`, `06_baseline_with_app.csv`). Atualizou `scripts/99_master-run.r`, `README.md`, `.gitignore` e `instructions.md`. A intervenção continua sendo a psicoterapia apoiada pelo app Motherly; o que saiu foi apenas o pipeline de métricas de engajamento no app.
- **Simulated data structure aligned with real REDCap**: Em `scripts/98_simulate-data.r`, `t0_idade` (idade materna) passa a existir **apenas** no evento `t0_arm_1` (screening), como no export real; antes era duplicada em todos os eventos. `rand_number` fica em branco no `t0_arm_1` (coletada a partir do `t1_arm_1`). Objetivo: o simulado ser estruturalmente idêntico ao real para que o mesmo script pré-registrado rode em ambos sem quebrar.
- **Age derivation fix**: Em `scripts/02_process-trial.r`, a variável analítica `age` passa a ser obtida do evento `t0_arm_1` (join por `record_id`) em vez de ser lida das linhas `t1_arm_1`. Com os dados simulados anteriores (que duplicavam `t0_idade`) o script funcionava, mas com o REDCap real `age` ficaria NA para todos. Validado: `age` preenchido para os 104 participantes simulados.
- **Primary-outcome plot fix**: Em `scripts/10_primary-outcome.r`, o gráfico de médias marginais usava `asymp.LCL`/`asymp.UCL`, que as versões atuais do `emmeans` nomeiam como `lower.CL`/`upper.CL`, causando erro. Normalizado para funcionar com ambas as convenções.
- **Archived non-pre-registered analyses**: Moveu `20_moderation-analysis.r`, `21_mediation-analysis.r` e `22_process-analysis.r` para `scripts/archived/`, pois as análises de moderação, mediação e processo (aliança terapêutica / engajamento no app) **não** serão pré-registradas. Removeu esses scripts de `scripts/99_master-run.r`, criou `scripts/archived/README.md` e atualizou `README.md` e `instructions.md`. Se conduzidas, essas análises devem ser reportadas como post-hoc/exploratórias.

Session on 2026-08-29:
- **Dashboard migration**: Migrou o projeto `C:\science\motherly-plus-dashboard` para `dashboard/`, mantendo-o separado dos scripts de análise. Adaptou caminhos para ler CSV bruto de `data/trial/` e salvar RDS em `dashboard/data/`. Atualizou `dashboard/about.qmd` e criou `dashboard/README.md`.
- **Documentation revision**: Revisou `README.md` e `instructions.md` para descrever corretamente os dois componentes do repositório (análises em `scripts/` e dashboard em `dashboard/`), o fluxo de dados compartilhado, as regras de independência, governança de dados/privacidade e a separação de outputs. Adicionou Seção 7 em `instructions.md` dedicada ao dashboard e atualizou numeração das seções subsequentes.

Session on 2026-08-28:
- **PSI-SF scoring**: Implemented in `scripts/02_process-trial.r` using the 36 PSI-SF items mapped to REDCap PSI-4 variable names. Subscales: PD (items 1–12), P-CDI (items 13–24), DC (items 25–36). Reverse-coded items: `t1_psi58` (item 22), `t1_psi41` (item 32), `t1_psi42` (item 33). Proration applied if exactly 1 item missing per subscale; set to NA if 2+ missing. Added to Table 1 in `scripts/07_descriptive-baseline.r`.
- **PSQI scoring**: Implemented official 7-component algorithm in `scripts/02_process-trial.r`. Assumes REDCap Likert items coded 1–4 and Q1/Q3 stored as "HH:MM". Added to Table 1 in `scripts/07_descriptive-baseline.r`.
- **PSI-SF cleanup**: Identified 14 extra PSI-4 items not part of the PSI-SF (`t1_psi28`, `t1_psi29`, `t1_psi30`, `t1_psi51`, `t1_psi52`, `t1_psi53`, `t1_psi54`, `t1_psi55`, `t1_psi57`, `t1_psi61`, `t1_psi62`, `t1_psi65`, `t1_psi66`, `t1_psi67`). User removed these from REDCap.
- **BADS-SF / RPI / WAI-SR / CGI-I / QIDS item 12**: Corrected variable names in `scripts/02_process-trial.r` (`t1_badssf_total`, `t1_total_rpi`, `t3_cgi_i`, WAI-SR subscales, QIDS item 12). Enriched `scripts/31_adverse-events.r` with clinical AE fields (`pron_ideacao`, `enc_1___2`, `enc_1___3`, `dropout7`) and raw REDCap loading.
- **Data folder structure**: Moved REDCap files to `data/trial/` and reserved `data/app/` for future app usage data; updated `scripts/02_process-trial.r`, `example/README_example.md`, `scripts/31_adverse-events.r`, and folder structure in `instructions.md` accordingly.
- **Script reorganization**: Split data loading and processing into separate scripts: `00_load-trial.r`, `01_load-app.r`, `02_process-trial.r`, `03_codebook-trial.r`, `04_process-app.r`, `05_codebook-app.r`, `06_merge-trial-app.r`, and `07_descriptive-baseline.r`. Created placeholders for app data pipeline. Merged `12_cgi-analysis.r` into `11_secondary-outcomes-analysis.r`. Renamed `10_qids-primary-analysis.r` to `10_primary-outcome.r`.
- **Documentation updated**: Created `README.md` with project overview, structure, and run instructions. Updated `instructions.md` and `example/README_example.md` to reflect the current script names and folder structure.
- **Verification notes updated**: Section 8 expanded to document PSI-SF, PSQI, WAI-SR, BADS-SF/RPI, CGI-I, QIDS item 12, and app data assumptions requiring future verification.

## 10. Main references

- Protocol: `example/projeto-motherly-rct3.docx`
- Previous analysis example: `example/00_setup-main-df.r` and JG2 Efficacy scripts
- RCT publication example (Table 1): `example/Zuccolo-2024.pdf`
- PSI-SF scoring reference: `example/psi/ParentingStressIndexPSI_Mother.pdf`
- PSQI scoring reference: `example/psqi/psqi scoring.pdf`