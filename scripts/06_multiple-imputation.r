#----------------------------------------------------------------------#
# Project: Motherly Plus
# Script: 06_multiple-imputation.r
# Description: Multiple imputation by chained equations (MICE, assuming MAR)
#              of the pre-registered outcomes. One imputation model for all
#              randomized participants (ITT), with group as a predictor.
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
# Load packages
#----------------------------------------------------------------------#

library(here)
library(tidyverse)
library(mice)

source(here("scripts", "mi-helpers.r"))

#----------------------------------------------------------------------#
# Imputation settings
# m = 100: Graham et al. (2007) recommend 100 imputations for a fraction of
# missing information up to 0.7 (power loss < 1% vs. maximum likelihood).
#----------------------------------------------------------------------#

m_imputations <- 100
max_iterations <- 20
imputation_seed <- 20261027
min_correlation <- 0.2

#----------------------------------------------------------------------#
# Load analytic datasets
#----------------------------------------------------------------------#

baseline <- readRDS(here("outputs", "models", "02_baseline_analytic.rds"))
long <- readRDS(here("outputs", "models", "02_long_analytic.rds"))

#----------------------------------------------------------------------#
# Wide dataset: one row per randomized participant
# Outcome scores by timepoint follow the REDCap instrument-event mapping.
# QIDS-SR16 at T2 is an auxiliary variable (not an outcome).
#----------------------------------------------------------------------#

score_times <- list(
  qidsc16 = c(1, 3),
  qidssr16 = c(1, 2, 3, 4),
  gad7 = c(1, 3, 4),
  psqi = c(1, 3, 4),
  psi_pd = c(1, 3, 4),
  psi_pcdi = c(1, 3, 4),
  psi_dc = c(1, 3, 4),
  sds = c(1, 3, 4),
  epds = c(1, 3, 4)
)

wanted <- unname(unlist(Map(function(stem, times) paste0(stem, "_t", times), names(score_times), score_times)))

wide <- baseline %>%
  select(
    record_id, group_f,
    age, infant_age_months, white_race, higher_education,
    married_or_stable, family_income, mental_health_treatment,
    cgi_s_t1
  ) %>%
  left_join(long_to_wide(long, c(names(score_times), "cgi_i")), by = "record_id") %>%
  select(record_id, group_f, age:cgi_s_t1, all_of(wanted), cgi_i_t3) %>%
  # CGI-I (T3 only, no baseline) is imputed as an ordinal variable
  mutate(cgi_i_t3 = factor(cgi_i_t3, ordered = TRUE))

#----------------------------------------------------------------------#
# Imputation model
# Predictive mean matching for continuous scores, proportional-odds model
# for CGI-I. Predictors are selected with quickpred (|r| >= min_correlation
# with the variable being imputed); group is always included.
#----------------------------------------------------------------------#

incomplete <- names(wide)[colSums(is.na(wide)) > 0]

method <- setNames(rep("", ncol(wide)), names(wide))
method[incomplete] <- "pmm"
method["cgi_i_t3"] <- "polr"

predictor_matrix <- quickpred(
  wide,
  mincor = min_correlation,
  include = "group_f",
  exclude = "record_id"
)

write.csv(predictor_matrix, here("outputs", "tables", "06_predictor_matrix.csv"))

imp <- mice(
  wide,
  m = m_imputations,
  maxit = max_iterations,
  method = method,
  predictorMatrix = predictor_matrix,
  seed = imputation_seed,
  printFlag = FALSE
)

if (!is.null(imp$loggedEvents)) {
  message("mice logged ", nrow(imp$loggedEvents), " events (see imp$loggedEvents).")
}

#----------------------------------------------------------------------#
# Convergence diagnostics (chain means and SDs by iteration)
#----------------------------------------------------------------------#

convergence_vars <- intersect(
  c("qidsc16_t3", "qidssr16_t3", "gad7_t3", "psqi_t3", "psi_pd_t3",
    "psi_pcdi_t3", "sds_t3", "epds_t3"),
  incomplete
)

if (length(convergence_vars) > 0) {
  png(here("outputs", "figures", "06_mice_convergence.png"),
      width = 8, height = 1.6 * length(convergence_vars), units = "in", res = 150)
  print(plot(imp, convergence_vars, layout = c(2, length(convergence_vars))))
  dev.off()
}

#----------------------------------------------------------------------#
# Save imputations
#----------------------------------------------------------------------#

saveRDS(imp, here("outputs", "models", "06_mice_imputations.rds"))

#----------------------------------------------------------------------#
# End of script 06_multiple-imputation.r
#----------------------------------------------------------------------#
