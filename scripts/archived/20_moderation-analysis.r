#----------------------------------------------------------------------#
# Project: Motherly+ RCT3
# Script: 20_moderation-analysis.r
# Description: Moderation of treatment effect on QIDS-C16 at T3
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

# Build long QIDS-C16 dataset (T1 and T3 only)
qids_long <- baseline %>%
  select(record_id, group_f) %>%
  left_join(
    long %>%
      select(record_id, time, qidsc16) %>%
      filter(time %in% c(1, 3)),
    by = "record_id"
  ) %>%
  mutate(
    time_f = factor(time, levels = c(1, 3), labels = c("T1", "T3"))
  )

# Merge baseline moderators
qids_long_mod <- qids_long %>%
  left_join(
    baseline %>% select(
      record_id,
      age, infant_age_months, white_race, higher_education,
      married_or_stable, family_income, number_of_children,
      firstborn, prenatal_visits, qidssr16_t1, qidsc16_t1, sds_t1, cgi_s_t1
    ),
    by = "record_id"
  )

#----------------------------------------------------------------------#
# Function to test moderation of treatment effect at T3
#----------------------------------------------------------------------#

run_moderation <- function(mod_var, mod_label) {
  # Ensure moderator is numeric and centered
  df <- qids_long_mod %>%
    mutate(
      mod = as.numeric(!!sym(mod_var)),
      mod_c = mod - mean(mod, na.rm = TRUE)
    ) %>%
    filter(!is.na(mod_c))

  # Fit GEE with three-way interaction group x time x moderator
  fit <- geeglm(
    qidsc16 ~ group_f * time_f * mod_c,
    id = record_id,
    family = gaussian,
    corstr = "exchangeable",
    std.err = "san.se",
    data = df
  )

  # Marginal means and T3 contrast
  emm <- emmeans(fit, ~ group_f * time_f | mod_c)

  # Interaction test (try/catch because singularities can occur with binary moderators)
  int_test <- tryCatch(
    joint_tests(emm),
    error = function(e) {
      message("joint_tests failed for ", mod_label, ": ", conditionMessage(e))
      NULL
    }
  )

  cat("\n===", mod_label, "===\n")
  print(summary(fit))
  if (!is.null(int_test)) {
    cat("\nInteraction test:\n")
    print(int_test)
  }

  # Save
  saveRDS(fit, here("outputs", "models", paste0("20_moderation_", mod_var, "_fit.rds")))

  if (!is.null(int_test)) {
    int_test_df <- as.data.frame(int_test)
    write_csv(int_test_df, here("outputs", "tables", paste0("20_moderation_", mod_var, "_joint_tests.csv")))
    int_test_df %>%
      knitr::kable(format = "html", caption = paste(mod_label, "moderation joint tests")) %>%
      writeLines(here("outputs", "tables", paste0("20_moderation_", mod_var, "_joint_tests.html")))
  }

  model_summary_df <- broom::tidy(fit)
  write_csv(model_summary_df, here("outputs", "tables", paste0("20_moderation_", mod_var, "_model_summary.csv")))
  model_summary_df %>%
    knitr::kable(format = "html", caption = paste(mod_label, "moderation model summary")) %>%
    writeLines(here("outputs", "tables", paste0("20_moderation_", mod_var, "_model_summary.html")))

  invisible(list(fit = fit, int_test = int_test))
}

#----------------------------------------------------------------------#
# Run moderation analyses
#----------------------------------------------------------------------#

run_moderation("age", "Age")
run_moderation("white_race", "White race")
run_moderation("higher_education", "Higher education")
run_moderation("married_or_stable", "Married or stable relationship")
run_moderation("family_income", "Family income")
run_moderation("number_of_children", "Number of children")
run_moderation("firstborn", "Firstborn child")
run_moderation("prenatal_visits", "Prenatal visits")
run_moderation("qidsc16_t1", "Baseline QIDS-C16")
run_moderation("sds_t1", "Baseline SDS")
run_moderation("cgi_s_t1", "Baseline CGI-Severity")

#----------------------------------------------------------------------#
# End of script 20_moderation-analysis.r
#----------------------------------------------------------------------#
