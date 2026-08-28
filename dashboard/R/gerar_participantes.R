# -----------------------------------------------------------------------------
# Gerar páginas individuais dos participantes em Quarto
# -----------------------------------------------------------------------------

library(dplyr, quietly = TRUE)
library(tidyr, quietly = TRUE)

this_file <- function() {
  # Quando sourceado, sys.frame()$ofile aponta para este arquivo
  ofile <- tryCatch(sys.frame(1)$ofile, error = function(e) NULL)
  if (!is.null(ofile) && file.exists(ofile)) {
    return(normalizePath(ofile, winslash = "/"))
  }
  # Quando rodado via Rscript, commandArgs contem --file=
  args <- commandArgs(trailingOnly = FALSE)
  f <- grep("^--file=", args, value = TRUE)
  if (length(f) > 0) {
    return(normalizePath(gsub("^--file=", "", f[1]), winslash = "/"))
  }
  NULL
}

script_file <- this_file()
if (is.null(script_file)) {
  project_root <- getwd()
} else {
  project_root <- normalizePath(file.path(dirname(script_file), "..", ".."))
}

base_dir <- file.path(project_root, "dashboard")
data_dir <- file.path(base_dir, "data")   # RDS gerados pelo dashboard

if (!dir.exists(data_dir)) {
  stop("Pasta de dados do dashboard nao encontrada em ", normalizePath(data_dir, mustWork = FALSE),
       "\nExecute primeiro dashboard/R/preparar_dados.R.")
}

participantes <- readRDS(file.path(data_dir, "participantes.rds"))
resumo <- readRDS(file.path(data_dir, "resumo_participantes.rds"))
completude_form <- readRDS(file.path(data_dir, "completude_form.rds"))

template_file <- file.path(base_dir, "template", "participante_template.qmd")
out_dir <- file.path(base_dir, "participantes")

if (!dir.exists(out_dir)) dir.create(out_dir, recursive = TRUE)
unlink(list.files(out_dir, pattern = "^[0-9]+\\.qmd$", full.names = TRUE))

template <- readLines(template_file, encoding = "UTF-8") |> paste(collapse = "\n")

formatar_data <- function(x) {
  if (is.na(x)) return("—")
  format(as.Date(x), "%d/%m/%Y")
}

status_badge <- function(status) {
  switch(status,
         "concluída" = "<span class=\"badge badge-success\">✓ Concluída</span>",
         "pendente" = "<span class=\"badge badge-warning\">○ Pendente</span>",
         "atrasada" = "<span class=\"badge badge-danger\">✗ Atrasada</span>",
         "não randomizado" = "<span class=\"badge badge-secondary\">— Não randomizado</span>",
         paste0("<span class=\"badge badge-secondary\">", status, "</span>"))
}

for (i in seq_len(nrow(resumo))) {
  p <- resumo[i, ]
  dados_p <- participantes |> filter(id == p$id) |> arrange(evento)
  
  # Timeline
  timeline_rows <- c()
  for (j in seq_len(nrow(dados_p))) {
    ev <- dados_p[j, ]
    row <- paste0("| ", ev$evento, " | ", formatar_data(ev$data_avaliacao), " | ", status_badge(ev$status_avaliacao), " |")
    timeline_rows <- c(timeline_rows, row)
  }
  timeline_table <- paste0(
    "| Avaliação | Data | Status |\n|---|---|---|\n",
    paste(timeline_rows, collapse = "\n")
  )
  
  # Detalhes por avaliação
  detalhes <- c()
  for (j in seq_len(nrow(dados_p))) {
    ev <- dados_p[j, ]
    scores <- c()
    if (!is.na(ev$qids_sr)) scores <- c(scores, paste0("- **QIDS-SR16:** ", ev$qids_sr))
    if (!is.na(ev$qids_c)) scores <- c(scores, paste0("- **QIDS-C16:** ", ev$qids_c))
    if (!is.na(ev$epds)) scores <- c(scores, paste0("- **EPDS:** ", ev$epds))
    if (!is.na(ev$gad7)) scores <- c(scores, paste0("- **GAD-7:** ", ev$gad7))
    if (!is.na(ev$bads_sf)) scores <- c(scores, paste0("- **BADS-SF:** ", ev$bads_sf))
    if (!is.na(ev$rpi)) scores <- c(scores, paste0("- **RPI:** ", ev$rpi))
    if (!is.na(ev$sus)) scores <- c(scores, paste0("- **SUS:** ", ev$sus))
    
    if (length(scores) == 0) scores <- "- _Sem escores disponíveis_"
    
    det <- paste0(
      "### ", ev$evento, "\n\n",
      "- **Data prevista/realizada:** ", formatar_data(ev$data_avaliacao), "\n",
      "- **Status:** ", status_badge(ev$status_avaliacao), "\n",
      paste(scores, collapse = "\n"), "\n\n"
    )
    detalhes <- c(detalhes, det)
  }
  detalhes_text <- paste(detalhes, collapse = "")

  # Completude por instrumento (REDCap form) e por tempo
  form_p <- completude_form |>
    filter(id == p$id, evento %in% c("T0", "T1", "T2", "T3", "T4")) |>
    select(evento, form_name, pct_completude)

  form_badge <- function(pct) {
    if (is.na(pct)) return("<span class=\"badge badge-secondary\">—</span>")
    cls <- ifelse(pct >= 99.99, "badge-success",
                  ifelse(pct >= 80, "badge-warning", "badge-danger"))
    paste0("<span class=\"badge ", cls, "\">", round(pct, 0), "%</span>")
  }

  form_rows <- c()
  if (nrow(form_p) > 0) {
    form_wide <- form_p |>
      pivot_wider(
        id_cols = form_name,
        names_from = evento,
        values_from = pct_completude
      )
    for (k in seq_len(nrow(form_wide))) {
      cols <- sapply(c("T0", "T1", "T2", "T3", "T4"), function(ev) {
        col_name <- ev
        if (!col_name %in% names(form_wide)) return(form_badge(NA_real_))
        form_badge(form_wide[[col_name]][k])
      })
      form_rows <- c(form_rows, paste0("| ", form_wide$form_name[k], " | ",
                                       paste(cols, collapse = " | "), " |"))
    }
  }

  if (length(form_rows) > 0) {
    form_table <- paste0(
      "| Instrumento / Form | T0 | T1 | T2 | T3 | T4 |\n|---|---|---|---|---|---|\n",
      paste(form_rows, collapse = "\n")
    )
  } else {
    form_table <- "_Sem dados de completude por instrumento para este participante._"
  }

  # Alertas
  alertas <- c()
  atrasadas <- dados_p$evento[dados_p$status_avaliacao == "atrasada"]
  if (length(atrasadas) > 0) {
    alertas <- c(alertas, paste0("- ⚠️ **Avaliações atrasadas:** ", paste(atrasadas, collapse = ", ")))
  }
  pendente <- dados_p$evento[dados_p$status_avaliacao == "pendente"]
  if (length(pendente) > 0) {
    alertas <- c(alertas, paste0("- ⏰ **Avaliações pendentes:** ", paste(pendente, collapse = ", ")))
  }
  qids_alto <- dados_p$qids_sr[dados_p$qids_sr >= 21 | dados_p$qids_c >= 21]
  if (length(qids_alto) > 0 && any(!is.na(qids_alto))) {
    alertas <- c(alertas, "- 🚨 **QIDS muito alto (>20):** avaliar encaminhamento")
  }
  if (length(alertas) == 0) alertas <- "- ✅ Nenhum alerta ativo"
  alertas_text <- paste(alertas, collapse = "\n")
  
  # Valores para substituir
  val_idade <- ifelse(is.na(p$idade), "—", as.character(p$idade))
  val_idade_bebe <- ifelse(is.na(p$idade_bebe), "—", as.character(round(p$idade_bebe, 1)))
  val_cor <- ifelse(is.na(p$cor_raca), "—", as.character(p$cor_raca))
  val_escola <- ifelse(is.na(p$escolaridade), "—", as.character(p$escolaridade))
  val_ecivil <- ifelse(is.na(p$estado_civil), "—", as.character(p$estado_civil))
  val_renda <- ifelse(is.na(p$renda), "—", as.character(p$renda))
  val_status <- ifelse(is.na(p$status_geral), "—", as.character(p$status_geral))
  
  # Substituir placeholders
  content <- template |>
    gsub(pattern = "\\{ID\\}", replacement = p$id, fixed = FALSE) |>
    gsub(pattern = "\\{STATUS_GERAL\\}", replacement = val_status, fixed = FALSE) |>
    gsub(pattern = "\\{IDADE\\}", replacement = val_idade, fixed = FALSE) |>
    gsub(pattern = "\\{IDADE_BEBE\\}", replacement = val_idade_bebe, fixed = FALSE) |>
    gsub(pattern = "\\{COR_PELE\\}", replacement = val_cor, fixed = FALSE) |>
    gsub(pattern = "\\{ESCOLARIDADE\\}", replacement = val_escola, fixed = FALSE) |>
    gsub(pattern = "\\{ESTADO_CIVIL\\}", replacement = val_ecivil, fixed = FALSE) |>
    gsub(pattern = "\\{RENDA\\}", replacement = val_renda, fixed = FALSE) |>
    gsub(pattern = "\\{TABELA_TIMELINE\\}", replacement = timeline_table, fixed = FALSE) |>
    gsub(pattern = "\\{DETALHES_AVALIACOES\\}", replacement = detalhes_text, fixed = FALSE) |>
    gsub(pattern = "\\{TABELA_FORMS\\}", replacement = form_table, fixed = FALSE) |>
    gsub(pattern = "\\{ALERTAS\\}", replacement = alertas_text, fixed = FALSE)
  
  # Atualizar título no YAML
  content <- gsub('title: "Participante"', paste0('title: "Participante #', p$id, '"'), content, fixed = TRUE)
  
  out_file <- file.path(out_dir, paste0(p$id, ".qmd"))
  writeLines(content, out_file, useBytes = TRUE)
}

message("Geradas ", nrow(resumo), " páginas individuais em: ", out_dir)
