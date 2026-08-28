#----------------------------------------------------------------------#
# Project: Motherly+ RCT3
# Script: 05_codebook-app.r
# Description: Codebook of processed Motherly app usage variables
# PLACEHOLDER: app data export not yet available.
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
# Load packages
#----------------------------------------------------------------------#

library(here)
library(tibble)

#----------------------------------------------------------------------#
# Define codebook
#----------------------------------------------------------------------#

app_codebook <- tribble(
  ~variable, ~description, ~type, ~values,
  "record_id", "Participant identifier", "character", "",
  "app_session_count", "Number of app sessions", "integer", "0+",
  "app_total_minutes", "Total time spent in app (minutes)", "numeric", "0+",
  "app_active_days", "Number of distinct days with app use", "integer", "0+",
  "app_modules_accessed", "Count of unique modules opened", "integer", "0+",
  "app_completed_activities", "Count of completed in-app activities", "integer", "0+"
)

#----------------------------------------------------------------------#
# Save codebook
#----------------------------------------------------------------------#

write_csv(app_codebook, here("outputs", "tables", "05_codebook_app.csv"))

#----------------------------------------------------------------------#
# End of script 05_codebook-app.r
#----------------------------------------------------------------------#
