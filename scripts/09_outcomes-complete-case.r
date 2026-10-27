#----------------------------------------------------------------------#
# Project: Motherly Plus
# Script: 09_outcomes-complete-case.r
# Description: Complete-case analysis of the primary and secondary outcomes.
#              No imputation: for each outcome, only participants observed
#              at every timepoint of that outcome are analyzed. Same models
#              as the ITT analyses (GEE, Twisk et al. 2018, eq. 2d; CGI-I
#              with linear regression).
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
# Load packages and helpers
#----------------------------------------------------------------------#

library(here)
library(tidyverse)
library(geepack)

source(here("scripts", "cc-helpers.r"))

#----------------------------------------------------------------------#
# Load analytic datasets (observed data, before imputation)
#----------------------------------------------------------------------#

baseline <- readRDS(here("outputs", "models", "02_baseline_analytic.rds"))
long <- readRDS(here("outputs", "models", "02_long_analytic.rds"))

#----------------------------------------------------------------------#
# Continuous outcomes: primary (T1, T3) and secondary (T1, T3, T4)
#----------------------------------------------------------------------#

outcomes <- list(
  list(stem = "qidsc16", label = "QIDS-C16 (primary)", times = c(1, 3)),
  list(stem = "qidssr16", label = "QIDS-SR16", times = c(1, 3, 4)),
  list(stem = "gad7", label = "GAD-7", times = c(1, 3, 4)),
  list(stem = "psqi", label = "PSQI", times = c(1, 3, 4)),
  list(stem = "psi_pd", label = "PSI-SF parental distress", times = c(1, 3, 4)),
  list(stem = "psi_pcdi", label = "PSI-SF parent-child dysfunctional interaction", times = c(1, 3, 4)),
  list(stem = "psi_total", label = "PSI-SF total stress", times = c(1, 3, 4)),
  list(stem = "sds", label = "SDS", times = c(1, 3, 4)),
  list(stem = "epds", label = "EPDS", times = c(1, 3, 4))
)

results <- lapply(outcomes, function(o) {
  message("Fitting: ", o$label)
  d_all <- cc_wide(baseline, long, o$stem, o$times)
  res <- analyze_gee_cc(d_all, o$stem, o$times)
  lapply(res, function(tbl) mutate(tbl, outcome = o$label, .before = 1))
})

#----------------------------------------------------------------------#
# CGI-I at T3 (no baseline): linear regression on group
#----------------------------------------------------------------------#

cgi_cc <- analyze_cgi_cc(baseline, long)
results <- c(results, list(lapply(cgi_cc, function(tbl) mutate(tbl, outcome = "CGI-I", .before = 1))))

combine <- function(name) bind_rows(lapply(results, `[[`, name))

#----------------------------------------------------------------------#
# Save outputs (one combined table per type)
#----------------------------------------------------------------------#

save_table(combine("contrasts"), "09_cc_contrasts", "Complete-case group contrasts by timepoint")
save_table(combine("means"), "09_cc_marginal_means", "Complete-case estimated marginal means")
save_table(combine("model"), "09_cc_model_summary", "Complete-case model summaries")

#----------------------------------------------------------------------#
# End of script 09_outcomes-complete-case.r
#----------------------------------------------------------------------#
