#----------------------------------------------------------------------#
# Project: Motherly+ RCT3
# Script: 00_load-trial.r
# Description: Load raw REDCap trial data export
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
# Load packages
#----------------------------------------------------------------------#

library(here)
library(readr)

#----------------------------------------------------------------------#
# Locate and load latest REDCap CSV export
#----------------------------------------------------------------------#

redcap_files <- list.files(
  here("data"),
  pattern = "MotherlyRCT.*_DATA_.*\\.csv$",
  full.names = TRUE
)

if (length(redcap_files) == 0) stop("No REDCap CSV file found in data/")
latest_file <- sort(redcap_files, decreasing = TRUE)[1]

message("Loading trial data file: ", latest_file)

rct_raw <- read_csv(
  latest_file,
  col_types = cols(.default = "?"),
  na = c("", "NA", " ")
)

#----------------------------------------------------------------------#
# Basic structure checks
#----------------------------------------------------------------------#

cat("Dimensions (rows x columns):", nrow(rct_raw), "x", ncol(rct_raw), "\n")
cat("Unique participants:", length(unique(rct_raw$record_id)), "\n")
cat("Events:", paste(unique(rct_raw$redcap_event_name), collapse = ", "), "\n")

#----------------------------------------------------------------------#
# Save raw trial dataset
#----------------------------------------------------------------------#

saveRDS(rct_raw, here("outputs", "models", "00_trial_raw.rds"))

#----------------------------------------------------------------------#
# End of script 00_load-trial.r
#----------------------------------------------------------------------#
