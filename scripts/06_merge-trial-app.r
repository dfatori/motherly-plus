#----------------------------------------------------------------------#
# Project: Motherly+ RCT3
# Script: 06_merge-trial-app.r
# Description: Merge processed app usage data with trial analytic dataset
# PLACEHOLDER: app data export not yet available.
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
# Load packages
#----------------------------------------------------------------------#

library(here)
library(tidyverse)

#----------------------------------------------------------------------#
# Load trial and app datasets
#----------------------------------------------------------------------#

baseline <- readRDS(here("outputs", "models", "00_baseline_analytic.rds"))
long <- readRDS(here("outputs", "models", "00_long_analytic.rds"))

app_file <- here("outputs", "models", "04_app_processed.rds")
if (file.exists(app_file)) {
  app_data <- readRDS(app_file)
} else {
  message("No processed app data found. Creating empty placeholder.")
  app_data <- tibble(record_id = character())
}

#----------------------------------------------------------------------#
# Merge app metrics into baseline dataset
#----------------------------------------------------------------------#

baseline_with_app <- baseline %>%
  left_join(app_data, by = "record_id")

#----------------------------------------------------------------------#
# Save merged dataset
#----------------------------------------------------------------------#

saveRDS(baseline_with_app, here("outputs", "models", "06_baseline_with_app.rds"))
write_csv(baseline_with_app, here("outputs", "tables", "06_baseline_with_app.csv"))

#----------------------------------------------------------------------#
# End of script 06_merge-trial-app.r
#----------------------------------------------------------------------#
