#----------------------------------------------------------------------#
# Project: Motherly Plus
# Script: 05_missing-data.r
# Description: Description of missing data in the observed data (before any
#              imputation): availability of each outcome by timepoint and
#              group. Descriptive only.
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
# Load packages and helpers
#----------------------------------------------------------------------#

library(here)
library(tidyverse)
library(gtsummary)

source(here("scripts", "mi-helpers.r"))

#----------------------------------------------------------------------#
# Load analytic datasets (observed data)
# "Missing" = randomized participant without a value at a timepoint where the
# instrument is scheduled (including participants with no row for that event).
#----------------------------------------------------------------------#

baseline <- readRDS(here("outputs", "models", "02_baseline_analytic.rds"))
long <- readRDS(here("outputs", "models", "02_long_analytic.rds"))

# Pre-registered outcomes and the timepoints where they are collected
schedule <- tribble(
  ~label,                                          ~stem,        ~times,
  "QIDS-C16 (primary)",                            "qidsc16",    c(1, 3),
  "QIDS-SR16",                                     "qidssr16",   c(1, 3, 4),
  "GAD-7",                                         "gad7",       c(1, 3, 4),
  "PSQI",                                          "psqi",       c(1, 3, 4),
  "PSI-SF parental distress",                      "psi_pd",     c(1, 3, 4),
  "PSI-SF parent-child dysfunctional interaction", "psi_pcdi",   c(1, 3, 4),
  "PSI-SF total stress",                           "psi_total",  c(1, 3, 4),
  "SDS",                                           "sds",        c(1, 3, 4),
  "EPDS",                                          "epds",       c(1, 3, 4),
  "CGI-I",                                         "cgi_i",      3
) %>%
  unnest(times) %>%
  rename(time = times) %>%
  mutate(column = paste0(stem, "_t", time))

wide <- baseline %>%
  select(record_id, group_f) %>%
  left_join(long_to_wide(long, unique(schedule$stem)), by = "record_id")

#----------------------------------------------------------------------#
# Availability of each outcome at the follow-up timepoints, by group
# (n and % observed)
#----------------------------------------------------------------------#

follow_up <- filter(schedule, time > 1)

observed <- follow_up %>%
  mutate(name = paste0(label, ", T", time)) %>%
  {setNames(lapply(.$column, function(col) !is.na(wide[[col]])), .$name)} %>%
  as_tibble(.name_repair = "minimal") %>%
  mutate(group_f = wide$group_f, .before = 1)

table_a <- observed %>%
  tbl_summary(
    by = group_f,
    statistic = all_dichotomous() ~ "{n} ({p}%)"
  ) %>%
  add_overall() %>%
  modify_header(label ~ "**Outcome observed**") %>%
  modify_caption("**Availability of outcome data by group**")

#----------------------------------------------------------------------#
# Save outputs
#----------------------------------------------------------------------#

saveRDS(table_a, here("outputs", "models", "05_availability_gtsummary.rds"))
write_csv(as_tibble(table_a, col_labels = FALSE), here("outputs", "tables", "05_availability.csv"))

print(table_a)

#----------------------------------------------------------------------#
# End of script 05_missing-data.r
#----------------------------------------------------------------------#
