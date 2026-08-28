# Motherly+

## Overview

This repository contains materials for the **Motherly+ randomized controlled trial**, a study evaluating a digital intervention for postpartum depression. The project includes study documentation, data management workflows, analysis scripts, and operational tools for monitoring the trial.

One core component is an internal dashboard built with [Quarto](https://quarto.org/) as a static HTML site. The dashboard reads exported REDCap data (CSV with field names), processes it in R, generates one page per participant, and renders a website for real-time monitoring of recruitment, randomization, assessment completion, and follow-up across study timepoints (T0–T4). Because it displays sensitive health data, the dashboard must be published behind access control.

---

## Authors

- **Daniel Fatori**¹² — conception, analysis, and code

**Affiliations**

- ¹ Departamento de Psiquiatria, Faculdade de Medicina, Universidade de São Paulo
- ² Laboratório de Psicopatologia e Terapêutica Psiquiátrica LIM-23, Instituto de Psiquiatria, Hospital das Clínicas HCFMUSP, Faculdade de Medicina, Universidade de São Paulo

---

## Structure

```
motherly-plus/
├── dashboard/                      # Quarto website source
│   ├── _quarto.yml                 # Quarto website configuration
│   ├── index.qmd                   # Overview page
│   ├── participantes.qmd           # Participant list
│   ├── recrutamento.qmd            # Recruitment funnel
│   ├── about.qmd                   # About the study
│   ├── styles.css                  # Custom styles
│   ├── R/
│   │   ├── atualizar_dashboard.R   # Full pipeline: prepare → generate → render
│   │   ├── preparar_dados.R        # Process REDCap CSVs and save RDS files
│   │   └── gerar_participantes.R   # Generate one .qmd per participant
│   ├── template/
│   │   └── participante_template.qmd
│   └── participantes/              # Generated individual pages (not versioned)
├── data/                           # Study data (not versioned)
│   ├── trial/                      # REDCap CSV exports
│   └── app/                        # Motherly app usage data (future)
├── docs/                           # Study documentation
├── .gitignore
├── README.md
└── PROJETO_HANDOFF.md              # Internal handoff notes (Portuguese)
```

---

## Requirements

- R >= 4.2
- [Quarto](https://quarto.org/docs/get-started/)
- Packages: `dplyr`, `tidyr`, `ggplot2`, `knitr`, `curl`, `keyring`

---

## Dashboard

For details about the dashboard, see [dashboard/PROJETO_HANDOFF.md](../dashboard/PROJETO_HANDOFF.md) and [dashboard/README.md](../dashboard/README.md).

### Update and publish the dashboard

1. Export data from REDCap as **CSV with field names**.
2. Save the file to `data/trial/MotherlyRCT2025*_DATA_YYYY-MM-DD_HHMM.csv`.
3. (Recommended) Save the REDCap DataDictionary to `data/trial/` for instrument-level completeness.
4. Run one command from the project root in R:

   ```r
   source("dashboard/R/atualizar_dashboard.R")
   ```

The script automatically selects the latest REDCap CSV, processes the data, generates the participant pages, renders the Quarto site, and uploads every generated file to InfinityFree.

On the first run only, enter the InfinityFree FTP password when prompted. It is stored in Windows Credential Manager through `keyring`, never in the repository. Later runs require only the same `source()` command.

The upload does not delete remote files and never sends `.htaccess` or `.htpasswd`, preserving the server authentication configuration. The VS Code SFTP profile in `.vscode/sftp.json` remains available only as a manual fallback.

Never add the FTP password, the Apache authentication credentials, or the contents of `.htpasswd` to the repository.

---