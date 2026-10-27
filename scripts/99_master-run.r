#----------------------------------------------------------------------#
# Project: Motherly+ RCT3
# Script: 99_master-run.r
# Description: Master script to run all pre-specified analyses in order
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
# Load packages
#----------------------------------------------------------------------#

library(here)

#----------------------------------------------------------------------#
# Define script order
#----------------------------------------------------------------------#

script_files <- c(
  "00_load-trial.r",
  "02_process-trial.r",
  "03_codebook-trial.r",
  "07_descriptive-baseline.r",
  "10_primary-outcome.r",
  "11_secondary-outcomes-analysis.r",
  "30_sensitivity-analysis.r",
  "31_adverse-events.r"
)

#----------------------------------------------------------------------#
# Run each script
#----------------------------------------------------------------------#

for (script in script_files) {
  script_path <- here("scripts", script)
  message("Running: ", script)
  if (!file.exists(script_path)) {
    warning("Script not found: ", script_path)
    next
  }
  source(script_path)
  message("Completed: ", script, "\n")
}

message("All pre-specified analyses completed.")

#----------------------------------------------------------------------#
# End of script 99_master-run.r
#----------------------------------------------------------------------#
