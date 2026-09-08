#----------------------------------------------------------------------#
# Project: Motherly+ RCT3
# Script: 04_process-app.r
# Description: Process Motherly app usage data and derive metrics
# PLACEHOLDER: app data export not yet available.
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
# Load packages
#----------------------------------------------------------------------#

library(here)
library(tidyverse)

#----------------------------------------------------------------------#
# Load raw app data
#----------------------------------------------------------------------#

app_raw <- readRDS(here("outputs", "models", "01_app_raw.rds"))

#----------------------------------------------------------------------#
# Derive app usage metrics
# PLACEHOLDER: update processing logic once data format is known.
# Suggested variables:
# - app_session_count: number of app sessions
# - app_total_minutes: total time spent in app
# - app_active_days: number of distinct days with app use
# - app_modules_accessed: count of unique modules opened
# - app_completed_activities: count of completed in-app activities
#----------------------------------------------------------------------#

if (nrow(app_raw) == 0) {
  app_processed <- tibble(
    record_id = integer(),
    app_session_count = integer(),
    app_total_minutes = numeric(),
    app_active_days = integer(),
    app_modules_accessed = integer(),
    app_completed_activities = integer()
  )
} else {
  app_processed <- app_raw %>%
    mutate(record_id = as.character(record_id)) %>%
    group_by(record_id) %>%
    summarise(
      app_session_count = NA_integer_,
      app_total_minutes = NA_real_,
      app_active_days = NA_integer_,
      app_modules_accessed = NA_integer_,
      app_completed_activities = NA_integer_,
      .groups = "drop"
    )
}

#----------------------------------------------------------------------#
# Save processed app data
#----------------------------------------------------------------------#

saveRDS(app_processed, here("outputs", "models", "04_app_processed.rds"))
write_csv(app_processed, here("outputs", "tables", "04_app_processed.csv"))

#----------------------------------------------------------------------#
# End of script 04_process-app.r
#----------------------------------------------------------------------#
