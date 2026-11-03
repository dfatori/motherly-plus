# Motherly Plus RCT

This repository is part of **Motherly Plus: Study Protocol of a Randomized Controlled Trial Evaluating a Smartphone-Assisted Single-Session Psychotherapy Intervention for Postpartum Depression**. It contains the analytical plan of the **Motherly Plus** randomized controlled trial. All scripts were tested on simulated data.

---

## Repository structure

```
motherly-plus/
├── data/                           # Data dictionary, simulated data
├── outputs/
│   ├── figures/                    # Figures
│   ├── models/                     # Models
│   └── tables/                     # Tables
├── references/                     # SAP/protocol guideline references
├── reports/
│   └── motherly-plus.Rmd           # Summary of results
├── sap/
│   ├── SAP.md                      # Statistical Analysis Plan
│   └── render-sap.r                # Renders SAP.md to SAP.docx and SAP.pdf
├── scripts/
│   ├── 01_load-trial.r             # Load REDCap export
│   ├── 02_process-trial.r          # Recode, score instruments, build datasets
│   ├── 03_codebook-trial.r         # Codebook
│   ├── 04_descriptive-baseline.r   # Table 1
│   ├── 05_missing-data.r           # Missing data description
│   ├── 06_multiple-imputation.r    # MICE
│   ├── 07_primary-outcome.r        # Primary outcome (ITT)
│   ├── 08_secondary-outcomes.r     # Secondary outcomes (ITT)
│   ├── 09_outcomes-complete-case.r # All outcomes, complete-case
│   ├── 10_adverse-events.r         # Adverse events
│   ├── mi-helpers.r                # Pooling of imputed analyses
│   ├── cc-helpers.r                # Complete-case analysis
│   ├── figures-helpers.r           # Plot figures
│   ├── run-all.r                   # Runs 01-10 and the report
│   ├── simulate-data.r             # Data simulation to run scripts
├── instructions.md
└── README.md
```

---

## Requirements

- R >= 4.2
- R packages used by the pipeline (`scripts/01` to `10` and the report): `here`, `tidyverse`, `readr`, `knitr`, `kableExtra`, `rmarkdown`, `geepack`, `mice`, `emmeans`, `broom`, `MASS`, `gtsummary`, `gt`, `flextable`.

---

## Analysis plan

- **Model**: Generalized estimating equations (GEE) with AR1 correlation and robust SEs, `outcome ~ time + time × group` without a group main effect (Twisk et al., 2018, equation 2d), fitted in each imputed dataset and pooled with Rubin's rules;
- **Missing data**: multiple imputation by chained equations (MICE, m = 100; Graham et al., 2007) of all pre-registered outcomes, with group and baseline covariates/scores as predictors (`scripts/06_multiple-imputation.r`). ITT: all randomized participants. Before the analyses, the availability of each outcome by timepoint and group is described (`scripts/05_missing-data.r`);
- **Timepoints**: T1= week 1, baseline; T2= week 2, mid-treatment; T3= week 4, post-treatment; T4= week 8, follow-up;
- **Primary outcome analysis**: QIDS-C16 total score at T3;
- **Secondary outcomes analyses**: QIDS-SR16, GAD-7, PSQI, PSI-SF (parental distress, parent-child dysfunctional interaction, total), SDS and EPDS at T3 and T4; CGI-I at T3;
- **Complete-case analysis** (`scripts/09_outcomes-complete-case.r`): same models for the primary and secondary outcomes, but with no imputation.

---

## Authors

- **Daniel Fatori**: conception, analysis, and code;
- **Pedro Zuccolo**: revision.

---