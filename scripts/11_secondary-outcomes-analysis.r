#----------------------------------------------------------------------#
# Project: Motherly+ RCT3
# Script: 11_secondary-outcomes-analysis.r
# Description: GEE analyses for secondary continuous outcomes
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
# Load packages
#----------------------------------------------------------------------#

library(here)
library(tidyverse)
library(geepack)
library(emmeans)
library(knitr)

#----------------------------------------------------------------------#
# Load data
#----------------------------------------------------------------------#

baseline <- readRDS(here("outputs", "models", "00_baseline_analytic.rds"))
long <- readRDS(here("outputs", "models", "00_long_analytic.rds"))

#----------------------------------------------------------------------#
# Function to run GEE for a given outcome
#----------------------------------------------------------------------#

run_gee_outcome <- function(outcome_var, outcome_label) {
  # Build long dataset for this outcome
  df_long <- baseline %>%
    select(record_id, group, group_f) %>%
    left_join(
      long %>%
        select(record_id, time, all_of(outcome_var)) %>%
        filter(!is.na(!!sym(outcome_var))) %>%
        pivot_wider(
          id_cols = record_id,
          names_from = time,
          values_from = all_of(outcome_var),
          names_prefix = paste0(outcome_var, "_t")
        ),
      by = "record_id"
    ) %>%
    pivot_longer(
      cols = starts_with(paste0(outcome_var, "_t")),
      names_to = "time",
      values_to = outcome_var
    ) %>%
    mutate(
      time = as.integer(gsub(paste0(outcome_var, "_t"), "", time)),
      time_f = factor(time, levels = c(1, 2, 3, 4), labels = c("T1", "T2", "T3", "T4"))
    ) %>%
    filter(!is.na(!!sym(outcome_var)))

  # Fit GEE
  fit <- geeglm(
    as.formula(paste(outcome_var, "~ group_f * time_f")),
    id = record_id,
    family = gaussian,
    corstr = "ar1",
    std.err = "san.se",
    data = df_long
  )

  # Marginal means and contrasts
  emm <- emmeans(fit, ~ group_f * time_f)
  contrasts <- contrast(emm, method = "pairwise", by = "time_f", adjust = "fdr", infer = TRUE)

  # T3 contrast specifically
  t3_contrast <- contrast(emm, list(t3_diff = c(0, 0, -1, 1, 0, 0, 0, 0)), adjust = "fdr", infer = TRUE)

  # Effect size at T3
  t3_emm <- as.data.frame(emm) %>% filter(time_f == "T3")
  d_t3 <- (t3_emm$emmean[t3_emm$group_f == "Intervention"] -
           t3_emm$emmean[t3_emm$group_f == "Waitlist"]) /
          sd(df_long[[outcome_var]], na.rm = TRUE)

  cat("\n===", outcome_label, "===\n")
  print(summary(fit))
  cat("\nT3 contrast:\n")
  print(t3_contrast)
  cat("Cohen's d at T3:", round(d_t3, 3), "\n")

  # Save outputs
  saveRDS(fit, here("outputs", "models", paste0("11_", outcome_var, "_gee_fit.rds")))

  # Contrasts as CSV and HTML
  contrasts_df <- as.data.frame(contrasts)
  write_csv(contrasts_df, here("outputs", "tables", paste0("11_", outcome_var, "_contrasts.csv")))
  contrasts_df %>%
    knitr::kable(format = "html", caption = paste(outcome_label, "pairwise contrasts by timepoint")) %>%
    writeLines(here("outputs", "tables", paste0("11_", outcome_var, "_contrasts.html")))

  # Marginal means as CSV and HTML
  emm_df <- as.data.frame(emm)
  write_csv(emm_df, here("outputs", "tables", paste0("11_", outcome_var, "_marginal_means.csv")))
  emm_df %>%
    knitr::kable(format = "html", caption = paste(outcome_label, "estimated marginal means")) %>%
    writeLines(here("outputs", "tables", paste0("11_", outcome_var, "_marginal_means.html")))

  # Model summary as CSV and HTML
  model_summary_df <- broom::tidy(fit)
  write_csv(model_summary_df, here("outputs", "tables", paste0("11_", outcome_var, "_model_summary.csv")))
  model_summary_df %>%
    knitr::kable(format = "html", caption = paste(outcome_label, "GEE model summary")) %>%
    writeLines(here("outputs", "tables", paste0("11_", outcome_var, "_model_summary.html")))

  invisible(list(fit = fit, emm = emm, contrasts = contrasts, d_t3 = d_t3))
}

#----------------------------------------------------------------------#
# Run secondary outcomes
#----------------------------------------------------------------------#

run_gee_outcome("qidssr16", "QIDS-SR16 self-reported depression")
run_gee_outcome("gad7", "GAD-7 anxiety")
run_gee_outcome("sds", "SDS functional impairment")
run_gee_outcome("epds", "EPDS postpartum depression")

# PSQI and PSI-SF need per-timepoint scoring; placeholders below
# These will be expanded once T2-T4 item-level data are available

# run_gee_outcome("psqi", "PSQI sleep quality")
# run_gee_outcome("psi_total", "PSI-SF total stress")
# run_gee_outcome("psi_pd", "PSI-SF parental distress")
# run_gee_outcome("psi_pcdi", "PSI-SF dysfunctional interaction")
# run_gee_outcome("psi_dc", "PSI-SF difficult child")

#----------------------------------------------------------------------#
# CGI-I at T3 (ordinal secondary outcome)
#----------------------------------------------------------------------#

library(MASS)

cgi_df <- long %>%
  filter(time == 3, !is.na(cgi_i)) %>%
  select(record_id, cgi_i) %>%
  left_join(baseline %>% select(record_id, group_f), by = "record_id") %>%
  mutate(cgi_i = factor(cgi_i, ordered = TRUE))

cgi_fit <- polr(cgi_i ~ group_f, data = cgi_df, Hess = TRUE)

summary(cgi_fit)

cgi_or <- cbind(
  coef(summary(cgi_fit)),
  confint(cgi_fit)
) %>%
  as.data.frame() %>%
  rownames_to_column("term") %>%
  mutate(
    OR = exp(Value),
    OR_lower = exp(`2.5 %`),
    OR_upper = exp(`97.5 %`)
  ) %>%
  select(term, OR, OR_lower, OR_upper, everything())

cgi_table <- cgi_df %>%
  count(group_f, cgi_i) %>%
  pivot_wider(names_from = cgi_i, values_from = n, values_fill = 0)

saveRDS(cgi_fit, here("outputs", "models", "11_cgi_fit.rds"))

write_csv(cgi_or, here("outputs", "tables", "11_cgi_odds_ratios.csv"))
cgi_or %>%
  knitr::kable(format = "html", caption = "CGI-I ordinal regression odds ratios") %>%
  writeLines(here("outputs", "tables", "11_cgi_odds_ratios.html"))

write_csv(cgi_table, here("outputs", "tables", "11_cgi_distribution.csv"))
cgi_table %>%
  knitr::kable(format = "html", caption = "CGI-I distribution by group") %>%
  writeLines(here("outputs", "tables", "11_cgi_distribution.html"))

#----------------------------------------------------------------------#
# End of script 11_secondary-outcomes-analysis.r
#----------------------------------------------------------------------#
