#----------------------------------------------------------------------#
# Project: Motherly+ RCT3
# Script: 03_codebook-trial.r
# Description: Generate codebook of trial analytic variables
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
# Load packages
#----------------------------------------------------------------------#

library(here)
library(tidyverse)
library(knitr)

#----------------------------------------------------------------------#
# Load analytic baseline dataset
#----------------------------------------------------------------------#

baseline <- readRDS(here("outputs", "models", "00_baseline_analytic.rds"))

#----------------------------------------------------------------------#
# Generate codebook
#----------------------------------------------------------------------#

codebook <- tibble(
  position = 1:length(names(baseline)),
  variable = names(baseline),
  type = map_chr(baseline, ~ paste(class(.x), collapse = ", ")),
  n_missing = map_int(baseline, ~ sum(is.na(.x))),
  example = map_chr(baseline, ~ {
    val <- .x[!is.na(.x)][1]
    if (is.numeric(val) || is.character(val)) as.character(val) else ""
  })
)

codebook %>%
  knitr::kable(
    format = "html",
    caption = "<p><strong>Codebook of trial analytic dataset</strong></p>",
    col.names = c("Position", "Variable", "Type", "N missing", "Example")
  ) %>%
  writeLines(here("outputs", "tables", "03_codebook_trial.html"))

codebook %>%
  write_csv(here("outputs", "tables", "03_codebook_trial.csv"))

#----------------------------------------------------------------------#
# End of script 03_codebook-trial.r
#----------------------------------------------------------------------#
