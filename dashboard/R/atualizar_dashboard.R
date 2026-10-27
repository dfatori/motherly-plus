# -----------------------------------------------------------------------------
# Atualizar dashboard Motherly RCT
# 
# Este script:
# 1. Encontra o CSV mais recente exportado do REDCap
# 2. Processa os dados do REDCap
# 3. Gera as páginas individuais dos participantes
# 4. Renderiza o site com Quarto
# 5. Publica o site no InfinityFree via FTP
# 
# Uso:
#   source("dashboard/R/atualizar_dashboard.R")
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# 1. Detectar diretório base
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

if (!dir.exists(data_dir)) {
  stop("Pasta de dados do trial nao encontrada em ", normalizePath(data_dir, mustWork = FALSE),
       "\nVerifique se a estrutura esta correta.")
}

message("Raiz do projeto: ", normalizePath(project_root))
message("Diretorio base: ", normalizePath(base_dir))
message("Diretorio de dados brutos (trial): ", normalizePath(data_dir))
message("Diretorio de dados do dashboard: ", normalizePath(out_dir))

# -----------------------------------------------------------------------------
# 2. Verificar dependências
# -----------------------------------------------------------------------------
required_packages <- c("dplyr", "tidyr", "curl", "keyring")
missing_packages <- required_packages[!(required_packages %in% installed.packages()[, "Package"])]
if (length(missing_packages) > 0) {
  message("Instalando pacotes necessarios: ", paste(missing_packages, collapse = ", "))
  install.packages(missing_packages, repos = "https://cloud.r-project.org/")
}

library(dplyr, quietly = TRUE)
library(tidyr, quietly = TRUE)

# -----------------------------------------------------------------------------
# 3. Verificar Quarto
# -----------------------------------------------------------------------------
quarto_path <- Sys.which("quarto")
if (quarto_path == "") {
  # Tentar encontrar no Windows
  possible_paths <- c(
    file.path(Sys.getenv("LOCALAPPDATA"), "Programs", "Quarto", "bin", "quarto.exe"),
    file.path(Sys.getenv("ProgramFiles"), "Quarto", "bin", "quarto.exe"),
    file.path(Sys.getenv("ProgramFiles(x86)"), "Quarto", "bin", "quarto.exe")
  )
  for (p in possible_paths) {
    if (file.exists(p)) {
      quarto_path <- p
      break
    }
  }
}

if (quarto_path == "" || !file.exists(quarto_path)) {
  stop("Quarto nao encontrado. Instale o Quarto antes de continuar.")
}
message("Quarto encontrado: ", quarto_path)

# -----------------------------------------------------------------------------
# 4. Verificar CSV de dados
# -----------------------------------------------------------------------------
csv_files <- list.files(
  data_dir,
  pattern = "^MotherlyRCT2025.*_DATA_\\d{4}-\\d{2}-\\d{2}_\\d{4}\\.csv$",
  full.names = TRUE
)

if (length(csv_files) == 0) {
  stop("Nenhum CSV de dados encontrado em ", data_dir,
       "\nEsperado: MotherlyRCT2025*_DATA_YYYY-MM-DD_HHMM.csv")
}

raw_file <- sort(csv_files, decreasing = TRUE)[1]
message("Usando dados de: ", raw_file)

# -----------------------------------------------------------------------------
# 5. Rodar preparação de dados
# -----------------------------------------------------------------------------
message("\n[1/4] Preparando dados...")
source(file.path(base_dir, "R", "preparar_dados.R"))

# -----------------------------------------------------------------------------
# 6. Gerar páginas individuais
# -----------------------------------------------------------------------------
message("\n[2/4] Gerando paginas individuais...")
source(file.path(base_dir, "R", "gerar_participantes.R"))

# -----------------------------------------------------------------------------
# 7. Renderizar site
# -----------------------------------------------------------------------------
message("\n[3/4] Renderizando site com Quarto...")
quarto_args <- c("render", shQuote(base_dir))
message("Comando: ", shQuote(quarto_path), " ", paste(quarto_args, collapse = " "))

exit_code <- system2(quarto_path, quarto_args)

if (exit_code != 0) {
  stop("Erro ao renderizar o site. Verifique as mensagens acima.")
}

# -----------------------------------------------------------------------------
# 8. Publicar site via FTP
# -----------------------------------------------------------------------------
message("\n[4/4] Publicando site no InfinityFree...")

publish_site <- function(site_dir) {
  ftp_service <- "motherly-plus-dashboard-ftp"
  ftp_username <- "if0_42545575"
  ftp_base_url <- "ftp://ftpupload.net:21/htdocs"

  ftp_password <- tryCatch(
    keyring::key_get(ftp_service, username = ftp_username),
    error = function(e) NULL
  )

  if (is.null(ftp_password)) {
    message("Configuracao inicial: informe a senha FTP uma unica vez.")
    keyring::key_set(
      ftp_service,
      username = ftp_username,
      prompt = "Senha FTP do InfinityFree: "
    )
    ftp_password <- keyring::key_get(ftp_service, username = ftp_username)
  }

  site_files <- list.files(
    site_dir,
    recursive = TRUE,
    full.names = TRUE,
    all.files = TRUE,
    no.. = TRUE
  )
  site_files <- site_files[
    file.info(site_files)$isdir %in% FALSE &
      !basename(site_files) %in% c(".htaccess", ".htpasswd")
  ]
  site_root <- normalizePath(site_dir, winslash = "/")

  encode_ftp_path <- function(path) {
    parts <- strsplit(path, "/", fixed = TRUE)[[1]]
    paste(vapply(parts, utils::URLencode, character(1), reserved = TRUE), collapse = "/")
  }

  for (index in seq_along(site_files)) {
    relative_path <- substring(
      normalizePath(site_files[index], winslash = "/"),
      nchar(site_root) + 2
    )
    remote_url <- paste0(ftp_base_url, "/", encode_ftp_path(relative_path))

    message("  [", index, "/", length(site_files), "] ", relative_path)
    curl::curl_upload(
      site_files[index],
      remote_url,
      verbose = FALSE,
      username = ftp_username,
      password = ftp_password,
      ftp_create_missing_dirs = 1L,
      connecttimeout = 30L
    )
  }

  invisible(length(site_files))
}

site_dir <- file.path(base_dir, "_site")
uploaded_files <- publish_site(site_dir)
rm(publish_site)

message("\nDashboard atualizado e publicado com sucesso!")
message("Arquivos enviados: ", uploaded_files)
message("Site local: ", file.path(site_dir, "index.html"))
message("Site publicado: http://motherly-plus-dash.freehosting.dev/")
