#----------------------------------------------------------------------#
# Project: Motherly+ RCT3
# Script: 21_mediation-analysis.r
# Description: Parallel mediation of treatment effect on QIDS-C16 at T3
#              through BADS-SF and RPI change (T1 to T2)
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
# Load packages
#----------------------------------------------------------------------#

library(here)
library(tidyverse)
library(mediation)
library(knitr)

#----------------------------------------------------------------------#
# Load data
#----------------------------------------------------------------------#

baseline <- readRDS(here("outputs", "models", "00_baseline_analytic.rds"))
long <- readRDS(here("outputs", "models", "00_long_analytic.rds"))

# Build wide dataset with mediators at T1 and T2 and outcome at T3
mediation_wide <- baseline %>%
  select(record_id, group_f, qidsc16_t1) %>%
  left_join(
    long %>%
      filter(time %in% c(1, 2)) %>%
      select(record_id, time, badssf, rpi) %>%
      pivot_wider(
        id_cols = record_id,
        names_from = time,
        values_from = c(badssf, rpi),
        names_sep = "_t"
      ),
    by = "record_id"
  ) %>%
  left_join(
    long %>%
      filter(time == 3) %>%
      select(record_id, qidsc16) %>%
      rename(qidsc16_t3 = qidsc16),
    by = "record_id"
  ) %>%
  mutate(
    group_num = ifelse(group_f == "Intervention", 1, 0),
    badssf_change = badssf_t2 - badssf_t1,
    rpi_change = rpi_t2 - rpi_t1
  ) %>%
  filter(!is.na(qidsc16_t3), !is.na(badssf_change), !is.na(rpi_change))

#----------------------------------------------------------------------#
# Single-mediator function
#----------------------------------------------------------------------#

run_mediation <- function(mediator_var, mediator_label) {
  # Mediator model
  med_formula <- as.formula(paste(mediator_var, "~ group_num + qidsc16_t1"))
  med_model <- lm(med_formula, data = mediation_wide)

  # Outcome model
  out_formula <- as.formula(paste("qidsc16_t3 ~ group_num +", mediator_var, "+ qidsc16_t1"))
  out_model <- lm(out_formula, data = mediation_wide)

  # Mediation analysis
  med_out <- mediate(
    med_model,
    out_model,
    treat = "group_num",
    mediator = mediator_var,
    boot = TRUE,
    sims = 1000,
    robustSE = TRUE
  )

  summary(med_out)

  # Save
  saveRDS(med_out, here("outputs", "models", paste0("21_mediation_", mediator_var, "_fit.rds")))

  med_summary <- summary(med_out)
  med_df <- data.frame(
    effect = c("ACME", "ADE", "Total Effect", "Prop. Mediated"),
    estimate = c(med_summary$d0, med_summary$z0, med_summary$tau.coef, med_summary$n0),
    ci_lower = c(med_summary$d0.ci[1], med_summary$z0.ci[1], med_summary$tau.ci[1], med_summary$n0.ci[1]),
    ci_upper = c(med_summary$d0.ci[2], med_summary$z0.ci[2], med_summary$tau.ci[2], med_summary$n0.ci[2]),
    p_value = c(med_summary$d0.p, med_summary$z0.p, med_summary$tau.p, med_summary$n0.p)
  )

  write_csv(med_df, here("outputs", "tables", paste0("21_mediation_", mediator_var, "_summary.csv")))
  med_df %>%
    knitr::kable(format = "html", caption = paste(mediator_label, "mediation summary")) %>%
    writeLines(here("outputs", "tables", paste0("21_mediation_", mediator_var, "_summary.html")))

  invisible(med_out)
}

#----------------------------------------------------------------------#
# Run mediation analyses
#----------------------------------------------------------------------#

run_mediation("badssf_change", "BADS-SF change (T1 to T2)")
run_mediation("rpi_change", "RPI change (T1 to T2)")

#----------------------------------------------------------------------#
# End of script 21_mediation-analysis.r
#----------------------------------------------------------------------#
