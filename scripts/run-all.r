#----------------------------------------------------------------------#
# Project: Motherly Plus
# Script: run-all.r
# Description: Master script to run all pre-specified analyses in order
#              and then build the results report (reports/motherly-plus.Rmd)
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
# Load packages
#----------------------------------------------------------------------#

library(here)

#----------------------------------------------------------------------#
# Define script order
#----------------------------------------------------------------------#

script_files <- c(
  "01_load-trial.r",
  "02_process-trial.r",
  "03_codebook-trial.r",
  "04_descriptive-baseline.r",
  "05_missing-data.r",
  "06_multiple-imputation.r",
  "07_primary-outcome.r",
  "08_secondary-outcomes.r",
  "09_outcomes-complete-case.r",
  "10_adverse-events.r"
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
# Build the results report from the outputs produced above
#----------------------------------------------------------------------#

message("Building report: reports/motherly-plus.Rmd")
rmarkdown::render(here("reports", "motherly-plus.Rmd"), quiet = TRUE)
message("Report completed: reports/motherly-plus.html")

#----------------------------------------------------------------------#
# End of script run-all.r
#----------------------------------------------------------------------#