#----------------------------------------------------------------------#
# Project: Motherly+ RCT3
# Script: 22_process-analysis.r
# Description: Treatment-specific process analyses
#              (therapeutic alliance; app engagement placeholder)
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
# Load packages
#----------------------------------------------------------------------#

library(here)
library(tidyverse)
library(knitr)

#----------------------------------------------------------------------#
# Load data
#----------------------------------------------------------------------#

baseline <- readRDS(here("outputs", "models", "00_baseline_analytic.rds"))
long <- readRDS(here("outputs", "models", "00_long_analytic.rds"))

#----------------------------------------------------------------------#
# Therapeutic alliance (WAI-SR) at T2
# Compute total and subscale scores
#----------------------------------------------------------------------#

alliance <- long %>%
  filter(time == 2) %>%
  dplyr::select(record_id, starts_with("waisrc_"), starts_with("waisrt_")) %>%
  mutate(
    waisrc_total = rowSums(across(starts_with("waisrc_") & !matches("goals|tasks|bond"))),
    waisrt_total = rowSums(across(starts_with("waisrt_") & !matches("goals|tasks|bond")))
  )

# Descriptive table
alliance_desc <- alliance %>%
  dplyr::select(waisrc_total, waisrc_goals, waisrc_tasks, waisrc_bond,
         waisrt_total, waisrt_goals, waisrt_tasks, waisrt_bond) %>%
  pivot_longer(everything(), names_to = "scale", values_to = "score") %>%
  group_by(scale) %>%
  summarise(
    n = sum(!is.na(score)),
    mean = mean(score, na.rm = TRUE),
    sd = sd(score, na.rm = TRUE),
    min = min(score, na.rm = TRUE),
    max = max(score, na.rm = TRUE)
  )

write_csv(alliance_desc, here("outputs", "tables", "22_alliance_descriptive.csv"))
alliance_desc %>%
  knitr::kable(format = "html", caption = "WAI-SR descriptive statistics at T2") %>%
  writeLines(here("outputs", "tables", "22_alliance_descriptive.html"))

# Association with T3 QIDS-C16
alliance_outcome <- alliance %>%
  left_join(
    long %>% filter(time == 3) %>% dplyr::select(record_id, qidsc16) %>% rename(qidsc16_t3 = qidsc16),
    by = "record_id"
  ) %>%

  filter(!is.na(qidsc16_t3))

waisrc_fit <- lm(qidsc16_t3 ~ waisrc_total, data = alliance_outcome)
waisrt_fit <- lm(qidsc16_t3 ~ waisrt_total, data = alliance_outcome)

summary(waisrc_fit)
summary(waisrt_fit)

saveRDS(waisrc_fit, here("outputs", "models", "22_waisrc_fit.rds"))
saveRDS(waisrt_fit, here("outputs", "models", "22_waisrt_fit.rds"))

waisrc_summary <- broom::tidy(waisrc_fit)
waisrt_summary <- broom::tidy(waisrt_fit)

write_csv(waisrc_summary, here("outputs", "tables", "22_waisrc_model_summary.csv"))
write_csv(waisrt_summary, here("outputs", "tables", "22_waisrt_model_summary.csv"))

waisrc_summary %>%
  knitr::kable(format = "html", caption = "WAI-SR client total predicting QIDS-C16 at T3") %>%
  writeLines(here("outputs", "tables", "22_waisrc_model_summary.html"))

waisrt_summary %>%
  knitr::kable(format = "html", caption = "WAI-SR therapist total predicting QIDS-C16 at T3") %>%
  writeLines(here("outputs", "tables", "22_waisrt_model_summary.html"))

#----------------------------------------------------------------------#
# App engagement placeholder
# Data not yet available; add when backend usage metrics are integrated
#----------------------------------------------------------------------#

message("App engagement analysis: placeholder — data not yet available.")

#----------------------------------------------------------------------#
# End of script 22_process-analysis.r
#----------------------------------------------------------------------#
