#----------------------------------------------------------------------#
# Project: Motherly+ RCT3
# Script: 01_load-app.r
# Description: Load raw Motherly app usage data export
# PLACEHOLDER: app data export not yet available.
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
# Load packages
#----------------------------------------------------------------------#

library(here)
library(tidyverse)
library(readr)

#----------------------------------------------------------------------#
# Locate latest app data export
# PLACEHOLDER: update filename pattern when data format is known.
# Expected location: data/app/
#----------------------------------------------------------------------#

app_files <- list.files(
  here("data", "app"),
  pattern = "\\.(csv|xlsx|json|parquet)$",
  full.names = TRUE
)

if (length(app_files) == 0) {
  message("No app data file found in data/app/. Creating empty placeholder dataset.")
  app_raw <- tibble(record_id = character())
} else {
  latest_app_file <- sort(app_files, decreasing = TRUE)[1]
  message("Loading app data file: ", latest_app_file)

  # PLACEHOLDER: adjust read function and column types once format is known.
  app_raw <- read_csv(latest_app_file, col_types = cols(.default = "?"))
}

#----------------------------------------------------------------------#
# Save raw app dataset
#----------------------------------------------------------------------#

saveRDS(app_raw, here("outputs", "models", "01_app_raw.rds"))

#----------------------------------------------------------------------#
# End of script 01_load-app.r
#----------------------------------------------------------------------#
