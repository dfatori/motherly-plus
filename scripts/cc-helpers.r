#----------------------------------------------------------------------#
# Project: Motherly Plus
# Script: cc-helpers.r
# Description: Helpers for the complete-case analysis (no imputation).
#              Sourced by 09_outcomes-complete-case.r; not run by run-all.r.
#
# Only participants with every timepoint of the outcome observed are kept;
# the same GEE (Twisk et al., 2018, equation 2d) is then fitted once on the
# observed data. Participants with any missing value are excluded BEFORE
# the model, so they do not contribute even their baseline value.
#----------------------------------------------------------------------#

library(here)
library(broom)

source(here("scripts", "mi-helpers.r"))

# Observed wide data for one outcome (one row per randomized participant)
cc_wide <- function(baseline, long, stem, times) {
  baseline %>%
    select(record_id, group_f) %>%
    left_join(long_to_wide(long, stem), by = "record_id") %>%
    select(record_id, group_f, all_of(paste0(stem, "_t", times)))
}

# Keep only participants observed at every timepoint of the outcome
complete_cases_for <- function(d, stem, times) {
  drop_na(d, all_of(paste0(stem, "_t", times)))
}

# Continuous outcome: one GEE on the complete cases, plus the number of
# participants analyzed and excluded.
analyze_gee_cc <- function(d_all, stem, times) {
  d <- complete_cases_for(d_all, stem, times)
  fit <- fit_gee(d, stem, times)

  res <- gee_emmeans(fit, list(d), stem, times)
  res$contrasts <- res$contrasts %>%
    mutate(
      n_waitlist = sum(d$group_f == "Waitlist"),
      n_intervention = sum(d$group_f == "Intervention"),
      n_excluded = nrow(d_all) - nrow(d)
    )

  c(list(model = tidy(fit, conf.int = TRUE)), res)
}

# CGI-I (T3 only): linear regression on group, using participants with the
# score. Returns the same layout as analyze_gee_cc().
analyze_cgi_cc <- function(baseline, long) {
  d_all <- cc_wide(baseline, long, "cgi_i", 3)
  d <- complete_cases_for(d_all, "cgi_i", 3) %>%
    mutate(int = as.numeric(group_f == "Intervention"))

  fit <- lm(cgi_i_t3 ~ int, data = d)

  res <- lm_emmeans(fit, list(d), "cgi_i")
  res$contrasts <- res$contrasts %>%
    mutate(
      n_waitlist = sum(d$group_f == "Waitlist"),
      n_intervention = sum(d$group_f == "Intervention"),
      n_excluded = nrow(d_all) - nrow(d)
    )

  c(list(model = tidy(fit, conf.int = TRUE)), res)
}
