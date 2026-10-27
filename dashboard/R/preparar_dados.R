# -----------------------------------------------------------------------------
# Preparar dados do dashboard Motherly RCT
# Lê exportação do REDCap (field names), processa e salva RDS
# -----------------------------------------------------------------------------

library(dplyr, quietly = TRUE)
library(tidyr, quietly = TRUE)

# -----------------------------------------------------------------------------
# 1. Configurar caminhos
# -----------------------------------------------------------------------------
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
data_dir <- file.path(project_root, "data")   # dados brutos do trial (compartilhados)
out_dir <- file.path(base_dir, "data")                 # RDS gerados pelo dashboard
if (!dir.exists(out_dir)) dir.create(out_dir, recursive = TRUE)

# Procurar CSV mais recente sem labels (aceita MotherlyRCT2025_DATA_ ou MotherlyRCT2025-Geral_DATA_)
csv_files <- list.files(data_dir, pattern = "^MotherlyRCT2025.*_DATA_\\d{4}-\\d{2}-\\d{2}_\\d{4}\\.csv$", full.names = TRUE)
if (length(csv_files) == 0) stop("Nenhum CSV de dados encontrado em ", data_dir)
raw_file <- sort(csv_files, decreasing = TRUE)[1]

# Procurar dicionario no mesmo local
dict_file <- list.files(data_dir, pattern = "^MotherlyRCT2025.*_DataDictionary_.*\\.csv$", full.names = TRUE)[1]
if (is.na(dict_file) || !file.exists(dict_file)) {
  warning("Dicionario de dados do REDCap nao encontrado em ", data_dir,
          "\nPara completude por instrumento correta, exporte o DataDictionary do REDCap para esta pasta.")
  dict_file <- NULL
}

message("Usando dados de: ", raw_file)
if (!is.null(dict_file)) message("Usando dicionario de: ", dict_file)

# -----------------------------------------------------------------------------
# 2. Ler dicionário e dados
# -----------------------------------------------------------------------------
df_raw <- read.csv(raw_file, stringsAsFactors = FALSE, na.strings = c("", "NA"))

if (!is.null(dict_file)) {
  dd <- read.csv(dict_file, stringsAsFactors = FALSE)
} else {
  # Dicionario minimo de fallback: mapeia cada coluna para si mesma
  dd <- data.frame(
    field_name = names(df_raw),
    form_name = NA_character_,
    section_header = NA_character_,
    field_type = NA_character_,
    field_label = names(df_raw),
    stringsAsFactors = FALSE
  )
}
names(dd)[1] <- "field_name"
names(dd)[2] <- "form_name"
names(dd)[3] <- "section_header"
names(dd)[5] <- "field_label"

# -----------------------------------------------------------------------------
# 3. Mapeamento de variáveis via dicionário + field names
# -----------------------------------------------------------------------------
# Função para buscar field name pelo label (primeira ocorrência)
find_by_label <- function(pattern) {
  hits <- dd$field_name[grepl(pattern, dd$field_label, ignore.case = TRUE, fixed = FALSE)]
  if (length(hits) == 0) return(NA_character_)
  hits[1]
}

find_field <- function(pattern) {
  hits <- grep(pattern, names(df_raw), value = TRUE)
  if (length(hits) == 0) return(NA_character_)
  hits[1]
}

# Datas por evento
date_fields <- list(
  T0 = find_field("^t0_data$"),
  T1 = find_field("^t1_data$"),
  T2 = find_field("^t2_data$"),
  T3 = find_field("^t3_data$"),
  T4 = find_field("^t4_data$")
)

# Demografia
map_demo <- list(
  idade = find_field("^t0_idade$|^t1_idade$"),
  idade_bebe = find_field("^t0_idade_bebe$|^t1_idade_bebe$"),
  cor_raca = find_field("^t1_cor$"),
  escolaridade = find_field("^t1_escola$"),
  renda = find_field("^t1_renda$"),
  estado_civil = find_field("^t1_ecivil$")
)

# Escores por evento
map_scores <- list(
  qids_sr = list(
    T0 = find_field("^t0_qidssr16_total$"),
    T1 = find_field("^t1_qidssr16_total$"),
    T2 = find_field("^t2_qidssr16_total$"),
    T3 = find_field("^t3_qidssr16_total$"),
    T4 = find_field("^t4_qidssr16_total$")
  ),
  qids_c = list(
    T1 = find_field("^t1_qidsc16_total$"),
    T2 = find_field("^t2_qidsc16_total$"),
    T3 = find_field("^t3_qidsc16_total$"),
    T4 = find_field("^t4_qidsc16_total$")
  ),
  epds = list(
    T1 = find_field("^t1_total_epds$"),
    T2 = find_field("^t2_total_epds$"),
    T3 = find_field("^t3_total_epds$"),
    T4 = find_field("^t4_total_epds$")
  ),
  gad7 = list(
    T1 = find_field("^t1_gad7$"),
    T2 = find_field("^t2_gad7$"),
    T3 = find_field("^t3_gad7$"),
    T4 = find_field("^t4_gad7$")
  ),
  bads_sf = list(
    T1 = find_field("^t1_badssf_total$"),
    T2 = find_field("^t2_badssf_total$"),
    T3 = find_field("^t3_badssf_total$"),
    T4 = find_field("^t4_badssf_total$")
  ),
  rpi = list(
    T1 = find_field("^t1_total_rpi$"),
    T2 = find_field("^t2_total_rpi$"),
    T3 = find_field("^t3_total_rpi$"),
    T4 = find_field("^t4_total_rpi$")
  ),
  sus = list(
    T3 = find_field("^t3_total_sus$")
  )
)

message("\nMapeamento encontrado:")
message("Demografia: ", paste(names(map_demo), map_demo, sep = "=", collapse = "; "))

# -----------------------------------------------------------------------------
# 4. Extrair dados demográficos
# -----------------------------------------------------------------------------
get_safe <- function(df, col) {
  if (length(col) == 0 || any(is.na(col)) || !(col %in% names(df))) return(rep(NA, nrow(df)))
  df[[col]]
}

# T0 e T1 tem dados demográficos. Pegar o primeiro não-missing por id.
demo_rows <- df_raw |>
  mutate(
    idade = as.numeric(get_safe(pick(everything()), map_demo$idade)),
    idade_bebe = as.numeric(get_safe(pick(everything()), map_demo$idade_bebe)),
    cor_raca = as.character(get_safe(pick(everything()), map_demo$cor_raca)),
    escolaridade = as.character(get_safe(pick(everything()), map_demo$escolaridade)),
    renda = as.character(get_safe(pick(everything()), map_demo$renda)),
    estado_civil = as.character(get_safe(pick(everything()), map_demo$estado_civil))
  ) |>
  select(record_id, idade, idade_bebe, cor_raca, escolaridade, renda, estado_civil)

demo <- demo_rows |>
  group_by(record_id) |>
  summarise(
    idade = first(na.omit(idade), default = NA),
    idade_bebe = first(na.omit(idade_bebe), default = NA),
    cor_raca = first(na.omit(cor_raca), default = NA),
    escolaridade = first(na.omit(escolaridade), default = NA),
    renda = first(na.omit(renda), default = NA),
    estado_civil = first(na.omit(estado_civil), default = NA),
    .groups = "drop"
  )

# -----------------------------------------------------------------------------
# 5. Extrair escores por evento
# -----------------------------------------------------------------------------
event_map <- c("T0" = "t0_arm_1", "T1" = "t1_arm_1", "T2" = "t2_arm_1", "T3" = "t3_arm_1", "T4" = "t4_arm_1")

extrair_evento <- function(evento_nome) {
  event_code <- event_map[evento_nome]
  sub <- df_raw |> filter(redcap_event_name == event_code)
  if (nrow(sub) == 0) return(NULL)
  
  data_col <- date_fields[[evento_nome]]
  
  out <- sub |>
    transmute(
      id = record_id,
      evento = evento_nome,
      data_avaliacao = as.Date(get_safe(sub, data_col)),
      qids_sr = as.numeric(get_safe(sub, map_scores$qids_sr[[evento_nome]])),
      qids_c = as.numeric(get_safe(sub, map_scores$qids_c[[evento_name]])),
      epds = as.numeric(get_safe(sub, map_scores$epds[[evento_nome]])),
      gad7 = as.numeric(get_safe(sub, map_scores$gad7[[evento_nome]])),
      bads_sf = as.numeric(get_safe(sub, map_scores$bads_sf[[evento_nome]])),
      rpi = as.numeric(get_safe(sub, map_scores$rpi[[evento_nome]])),
      sus = as.numeric(get_safe(sub, map_scores$sus[[evento_nome]]))
    )
  out
}

# Corrigir typo
extrair_evento <- function(evento_nome) {
  event_code <- event_map[evento_nome]
  sub <- df_raw |> filter(redcap_event_name == event_code)
  if (nrow(sub) == 0) return(NULL)
  
  data_col <- date_fields[[evento_nome]]
  
  sub |>
    transmute(
      id = record_id,
      evento = evento_nome,
      data_avaliacao = as.Date(get_safe(sub, data_col)),
      qids_sr = as.numeric(get_safe(sub, map_scores$qids_sr[[evento_nome]])),
      qids_c = as.numeric(get_safe(sub, map_scores$qids_c[[evento_nome]])),
      epds = as.numeric(get_safe(sub, map_scores$epds[[evento_nome]])),
      gad7 = as.numeric(get_safe(sub, map_scores$gad7[[evento_nome]])),
      bads_sf = as.numeric(get_safe(sub, map_scores$bads_sf[[evento_nome]])),
      rpi = as.numeric(get_safe(sub, map_scores$rpi[[evento_nome]])),
      sus = as.numeric(get_safe(sub, map_scores$sus[[evento_nome]]))
    )
}

eventos_reais <- bind_rows(
  extrair_evento("T0"),
  extrair_evento("T1"),
  extrair_evento("T2"),
  extrair_evento("T3"),
  extrair_evento("T4")
)

# Adicionar demografia
participantes_reais <- eventos_reais |>
  left_join(demo, by = c("id" = "record_id"))

# -----------------------------------------------------------------------------
# 6. Manter somente dados provenientes do REDCap
# -----------------------------------------------------------------------------
participantes <- participantes_reais |>
  select(id, evento, data_avaliacao, qids_sr, qids_c, epds, gad7, bads_sf,
         rpi, sus, idade, idade_bebe, cor_raca, escolaridade, renda,
         estado_civil)

# -----------------------------------------------------------------------------
# 7. Calcular % de preenchimento por evento
# -----------------------------------------------------------------------------
# Mapear inverso de evento
inv_event_map <- c("t0_arm_1" = "T0", "t1_arm_1" = "T1", "t2_arm_1" = "T2",
                   "t3_arm_1" = "T3", "t4_arm_1" = "T4")

# Campos técnicos do REDCap a excluir do cálculo
technical_patterns <- c(
  "^record_id$", "^redcap_event_name$", "^redcap_survey_identifier$",
  "_timestamp$", "_complete$", "^start_", "_start$", "_dur_sec$", "_dur$",
  "_duration$", "^survey_"
)

is_technical <- function(colnames) {
  technical <- rep(FALSE, length(colnames))
  for (p in technical_patterns) {
    technical <- technical | grepl(p, colnames, ignore.case = TRUE)
  }
  technical
}

# Calcular % de preenchimento por evento para cada participante
calc_completude_evento <- function(evento_nome) {
  event_code <- event_map[evento_nome]
  sub <- df_raw |> filter(redcap_event_name == event_code)
  if (nrow(sub) == 0) return(NULL)
  
  cols <- names(sub)
  cols <- cols[!is_technical(cols)]
  if (evento_nome == "T0") {
    cols <- cols[!grepl("^t[1-4]_", cols)]
  } else {
    prefixo <- paste0("^t", gsub("T", "", evento_nome), "_")
    cols <- cols[grepl(prefixo, cols) | grepl("^(record_id|redcap_event_name)$", cols)]
  }
  cols <- setdiff(cols, c("record_id", "redcap_event_name"))
  
  # Calcular por linha com apply para lidar com tipos mistos
  vals <- sub[, cols, drop = FALSE]
  n_total <- ncol(vals)
  n_preenchido <- apply(vals, 1, function(x) sum(!is.na(x) & x != ""))
  pct_completude <- round(100 * n_preenchido / n_total, 1)
  
  data.frame(
    id = sub$record_id,
    evento = evento_nome,
    pct_completude_evento = pct_completude,
    n_preenchido_evento = n_preenchido,
    n_total_evento = n_total,
    stringsAsFactors = FALSE
  )
}

completude_evento <- bind_rows(
  calc_completude_evento("T0"),
  calc_completude_evento("T1"),
  calc_completude_evento("T2"),
  calc_completude_evento("T3"),
  calc_completude_evento("T4")
)

# Calcular % de preenchimento por form/instrumento por evento
# Usar dicionário para mapear field_name -> form_name
calc_completude_form <- function(evento_nome) {
  event_code <- event_map[evento_nome]
  sub <- df_raw |> filter(redcap_event_name == event_code)
  if (nrow(sub) == 0) return(NULL)
  
  # Mapear colunas para form_name
  col_forms <- dd$form_name[match(names(sub), dd$field_name)]
  col_forms[is.na(col_forms)] <- "Outros"
  
  # Para cada form, calcular completude
  forms_unicos <- unique(col_forms)
  forms_unicos <- setdiff(forms_unicos, c(NA, "", "Outros"))
  forms_unicos <- forms_unicos[vapply(forms_unicos, function(frm) {
    complete_col <- paste0(frm, "_complete")
    complete_col %in% names(sub) && any(!is.na(sub[[complete_col]]))
  }, logical(1))]
  
  result <- list()
  for (fid in sub$record_id) {
    row <- sub[sub$record_id == fid, ]
    for (frm in forms_unicos) {
      cols_form <- names(sub)[col_forms == frm]
      # Excluir técnicos
      cols_form <- cols_form[!is_technical(cols_form)]
      if (length(cols_form) == 0) next
      vals <- unlist(row[, cols_form])
      n_total <- length(vals)
      n_preenchido <- sum(!is.na(vals) & vals != "")
      result[[length(result) + 1]] <- data.frame(
        id = fid,
        evento = evento_nome,
        form_name = frm,
        pct_completude = round(100 * n_preenchido / n_total, 1),
        n_preenchido = n_preenchido,
        n_total = n_total,
        stringsAsFactors = FALSE
      )
    }
  }
  bind_rows(result)
}

completude_form <- bind_rows(
  calc_completude_form("T0"),
  calc_completude_form("T1"),
  calc_completude_form("T2"),
  calc_completude_form("T3"),
  calc_completude_form("T4")
)

# Juntar completude aos participantes
completude_tempo <- completude_form |>
  group_by(id, evento) |>
  summarise(
    n_preenchido = sum(n_preenchido),
    n_total = sum(n_total),
    pct_completude = round(100 * n_preenchido / n_total, 1),
    .groups = "drop"
  )

participantes <- participantes |>
  left_join(completude_evento, by = c("id", "evento")) |>
  left_join(
    completude_tempo |> select(id, evento, pct_completude),
    by = c("id", "evento")
  )

# -----------------------------------------------------------------------------
# 8. Calcular status das avaliações conforme as janelas do manual
# -----------------------------------------------------------------------------
# T1: recrutamento até 7 dias depois
# T2: 7-14 dias após T1
# T3: 21-28 dias após T1
# T4: 49-56 dias após T1

calc_status <- function(evento, data_aval, data_referencia, pct_comp,
                        hoje = Sys.Date()) {
  if (is.na(data_referencia)) {
    if (!is.na(data_aval)) return("sem referência")
    return("não iniciada")
  }

  inicio <- switch(evento, "T1" = 0, "T2" = 7, "T3" = 21, "T4" = 49)
  fim <- switch(evento, "T1" = 7, "T2" = 14, "T3" = 28, "T4" = 56)
  data_ideal <- data_referencia + inicio
  data_fim <- data_referencia + fim

  if (!is.na(data_aval)) {
    if (data_aval < data_ideal) return("antes da janela")
    if (data_aval > data_fim) return("fora da janela")
    if (is.na(pct_comp) || pct_comp < 99.99) return("dados incompletos")
    return("concluída")
  }

  dias <- as.numeric(hoje - data_referencia)

  if (dias < inicio) return("futura")
  if (dias <= fim) return("pendente")
  "atrasada"
}

datas_ancora <- participantes |>
  group_by(id) |>
  summarise(
    data_recrutamento = first(data_avaliacao[evento == "T0" & !is.na(data_avaliacao)], default = as.Date(NA)),
    data_linha_base = first(data_avaliacao[evento == "T1" & !is.na(data_avaliacao)], default = as.Date(NA)),
    .groups = "drop"
  )

datas_eventos <- participantes |>
  filter(evento %in% c("T1", "T2", "T3", "T4")) |>
  group_by(id, evento) |>
  summarise(
    data_avaliacao = first(data_avaliacao[!is.na(data_avaliacao)], default = as.Date(NA)),
    .groups = "drop"
  )

status_avaliacoes <- tidyr::expand_grid(
  id = unique(participantes$id),
  evento = c("T1", "T2", "T3", "T4")
) |>
  left_join(datas_ancora, by = "id") |>
  left_join(datas_eventos, by = c("id", "evento")) |>
  left_join(completude_tempo, by = c("id", "evento")) |>
  mutate(
    data_referencia = if_else(evento == "T1", data_recrutamento, data_linha_base)
  ) |>
  rowwise() |>
  mutate(
    status_avaliacao = calc_status(
      evento, data_avaliacao, data_referencia, pct_completude
    )
  ) |>
  ungroup()

participantes <- participantes |>
  left_join(
    status_avaliacoes |> select(id, evento, status_avaliacao),
    by = c("id", "evento")
  ) |>
  mutate(
    status_avaliacao = if_else(evento == "T0", "recrutamento", status_avaliacao)
  )

# -----------------------------------------------------------------------------
# 9. Resumo por participante
# -----------------------------------------------------------------------------
resumo_base <- participantes |>
  group_by(id) |>
  summarise(
    idade = first(idade[!is.na(idade)], default = NA),
    idade_bebe = first(idade_bebe[!is.na(idade_bebe)], default = NA),
    cor_raca = first(cor_raca[!is.na(cor_raca)], default = NA),
    escolaridade = first(escolaridade[!is.na(escolaridade)], default = NA),
    estado_civil = first(estado_civil[!is.na(estado_civil)], default = NA),
    renda = first(renda[!is.na(renda)], default = NA),
    qids_sr_baseline = first(qids_sr[evento == "T1"], default = NA),
    qids_sr_atual = last(qids_sr[!is.na(qids_sr)], default = NA),
    .groups = "drop"
  )

resumo_status <- status_avaliacoes |>
  group_by(id) |>
  summarise(
    status_geral = case_when(
      any(status_avaliacao == "atrasada") ~ "atrasada",
      any(status_avaliacao %in% c("antes da janela", "fora da janela")) ~ "fora da janela",
      any(status_avaliacao == "dados incompletos") ~ "dados incompletos",
      any(status_avaliacao == "pendente") ~ "pendente",
      any(status_avaliacao == "sem referência") ~ "sem referência",
      all(status_avaliacao == "não iniciada") ~ "não iniciada",
      TRUE ~ "em dia"
    ),
    proxima_acao = {
      atrasadas <- sort(unique(evento[status_avaliacao == "atrasada"]))
      fora_janela <- sort(unique(evento[status_avaliacao %in% c("antes da janela", "fora da janela")]))
      incompletas <- sort(unique(evento[status_avaliacao == "dados incompletos"]))
      pendentes <- sort(unique(evento[status_avaliacao == "pendente"]))
      if (length(atrasadas) > 0) {
        paste("Realizar", paste(atrasadas, collapse = "/"))
      } else if (length(fora_janela) > 0) {
        paste("Revisar janela", paste(fora_janela, collapse = "/"))
      } else if (length(incompletas) > 0) {
        paste("Completar dados", paste(incompletas, collapse = "/"))
      } else if (length(pendentes) > 0) {
        paste("Realizar", paste(pendentes, collapse = "/"))
      } else "-"
    },
    n_avaliacoes_concluidas = sum(status_avaliacao == "concluída"),
    pct_t1 = first(pct_completude[evento == "T1"], default = NA),
    pct_t2 = first(pct_completude[evento == "T2"], default = NA),
    pct_t3 = first(pct_completude[evento == "T3"], default = NA),
    pct_t4 = first(pct_completude[evento == "T4"], default = NA),
    .groups = "drop"
  )

resumo_participantes <- resumo_base |>
  left_join(resumo_status, by = "id")

# -----------------------------------------------------------------------------
# 10. Progresso dos formulários de recrutamento no REDCap
# -----------------------------------------------------------------------------
formularios_recrutamento <- data.frame(
  form_name = c(
    "recrutamento_t0", "recrutamento_1_t0", "mini"
  ),
  formulario = c(
    "recrutamento_t0", "recrutamento_1_t0", "mini"
  ),
  stringsAsFactors = FALSE
)

recrutamento <- bind_rows(lapply(seq_len(nrow(formularios_recrutamento)), function(i) {
  complete_field <- paste0(formularios_recrutamento$form_name[i], "_complete")
  if (!(complete_field %in% names(df_raw))) return(NULL)

  registros <- df_raw |>
    filter(!is.na(.data[[complete_field]])) |>
    group_by(record_id) |>
    summarise(status_form = last(.data[[complete_field]]), .groups = "drop")

  n_registros <- nrow(registros)
  n_completos <- sum(registros$status_form == 2, na.rm = TRUE)
  data.frame(
    formulario = formularios_recrutamento$formulario[i],
    n_registros = n_registros,
    n_completos = n_completos,
    n_incompletos = n_registros - n_completos,
    pct_completo = if (n_registros == 0) NA_real_ else round(100 * n_completos / n_registros, 1),
    stringsAsFactors = FALSE
  )
}))

contar_forms_completos <- function(complete_field) {
  if (!(complete_field %in% names(df_raw))) return(0L)
  n_distinct(df_raw$record_id[!is.na(df_raw[[complete_field]]) & df_raw[[complete_field]] == 2])
}

indicadores_principais <- data.frame(
  recrutamento_t0_completo = contar_forms_completos("recrutamento_t0_complete"),
  mini_completa = contar_forms_completos("mini_complete"),
  randomizacao_form_completo = contar_forms_completos("randomizacao_complete")
)

# Critérios de inclusão definidos no projeto e implementados no REDCap
campos_criterios_inclusao <- paste0("t0_criterio_i_", 1:7)
n_registros_recrutamento <- df_raw |>
  filter(redcap_event_name == event_map[["T0"]]) |>
  summarise(n = n_distinct(record_id)) |>
  pull(n)

criterios_inclusao <- bind_rows(lapply(seq_along(campos_criterios_inclusao), function(i) {
  field <- campos_criterios_inclusao[i]
  if (!(field %in% names(df_raw))) return(NULL)

  valores <- df_raw |>
    filter(!is.na(.data[[field]])) |>
    group_by(record_id) |>
    summarise(valor = last(.data[[field]]), .groups = "drop")

  dict_row <- dd[match(field, dd$field_name), ]
  n_avaliadas <- nrow(valores)
  n_atende <- sum(valores$valor == 1, na.rm = TRUE)
  n_nao_atende <- sum(valores$valor == 0, na.rm = TRUE)

  data.frame(
    criterio = paste0("C", i),
    descricao = trimws(gsub("^Critério de inclusão [1-7]:\\s*", "", dict_row$field_label)),
    form_name = dict_row$form_name,
    n_avaliadas = n_avaliadas,
    n_atende = n_atende,
    n_nao_atende = n_nao_atende,
    n_sem_informacao = n_registros_recrutamento - n_avaliadas,
    pct_atende_avaliadas = if (n_avaliadas == 0) NA_real_ else round(100 * n_atende / n_avaliadas, 1),
    stringsAsFactors = FALSE
  )
}))

# -----------------------------------------------------------------------------
# 11. Salvar
# -----------------------------------------------------------------------------
saveRDS(participantes, file.path(out_dir, "participantes.rds"))
saveRDS(resumo_participantes, file.path(out_dir, "resumo_participantes.rds"))
saveRDS(completude_form, file.path(out_dir, "completude_form.rds"))
saveRDS(status_avaliacoes, file.path(out_dir, "status_avaliacoes.rds"))
saveRDS(recrutamento, file.path(out_dir, "recrutamento.rds"))
saveRDS(criterios_inclusao, file.path(out_dir, "criterios_inclusao.rds"))
saveRDS(indicadores_principais, file.path(out_dir, "indicadores_principais.rds"))

message("\nDados processados salvos em: ", out_dir)
message("Participantes: ", length(unique(participantes$id)))
message("Avaliacoes: ", nrow(participantes))
