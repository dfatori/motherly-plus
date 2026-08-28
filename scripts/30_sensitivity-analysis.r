#----------------------------------------------------------------------#
# Project: Motherly+ RCT3
# Script: 30_sensitivity-analysis.r
# Description: Sensitivity analyses for primary outcome (QIDS-C16)
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

qids_long <- baseline %>%
  select(record_id, group_f) %>%
  left_join(
    long %>%
      select(record_id, time, qidsc16) %>%
      filter(!is.na(qidsc16)),
    by = "record_id"
  ) %>%
  mutate(
    time_f = factor(time, levels = c(1, 2, 3, 4), labels = c("T1", "T2", "T3", "T4"))
  ) %>%
  filter(!is.na(qidsc16))

#----------------------------------------------------------------------#
# Sensitivity 1: Completers only (observed data at T1 and T3)
#----------------------------------------------------------------------#

completers <- qids_long %>%
  group_by(record_id) %>%
  filter(all(c(1, 3) %in% time)) %>%
  ungroup()

fit_completers <- geeglm(
  qidsc16 ~ group_f * time_f,
  id = record_id,
  family = gaussian,
  corstr = "ar1",
  std.err = "san.se",
  data = completers
)

emm_completers <- emmeans(fit_completers, ~ group_f * time_f)
contrasts_completers <- contrast(emm_completers, method = "pairwise", by = "time_f",
                                 adjust = "fdr", infer = TRUE)

saveRDS(fit_completers, here("outputs", "models", "30_qids_completers_fit.rds"))
write_csv(as.data.frame(contrasts_completers), here("outputs", "tables", "30_qids_completers_contrasts.csv"))
as.data.frame(contrasts_completers) %>%
  knitr::kable(format = "html", caption = "QIDS-C16 completers-only contrasts") %>%
  writeLines(here("outputs", "tables", "30_qids_completers_contrasts.html"))

#----------------------------------------------------------------------#
# Sensitivity 2: Adjusted for baseline QIDS-C16 as covariate
#----------------------------------------------------------------------#

qids_long_adj <- qids_long %>%
  left_join(
    baseline %>% select(record_id, qidsc16_t1),
    by = "record_id"
  )

fit_adjusted <- geeglm(
  qidsc16 ~ group_f * time_f + qidsc16_t1,
  id = record_id,
  family = gaussian,
  corstr = "ar1",
  std.err = "san.se",
  data = qids_long_adj
)

emm_adjusted <- emmeans(fit_adjusted, ~ group_f * time_f)
contrasts_adjusted <- contrast(emm_adjusted, method = "pairwise", by = "time_f",
                               adjust = "fdr", infer = TRUE)

saveRDS(fit_adjusted, here("outputs", "models", "30_qids_baseline_adjusted_fit.rds"))
write_csv(as.data.frame(contrasts_adjusted), here("outputs", "tables", "30_qids_baseline_adjusted_contrasts.csv"))
as.data.frame(contrasts_adjusted) %>%
  knitr::kable(format = "html", caption = "QIDS-C16 baseline-adjusted contrasts") %>%
  writeLines(here("outputs", "tables", "30_qids_baseline_adjusted_contrasts.html"))

#----------------------------------------------------------------------#
# Sensitivity 3: Unstructured working correlation
#----------------------------------------------------------------------#

fit_unstructured <- geeglm(
  qidsc16 ~ group_f * time_f,
  id = record_id,
  family = gaussian,
  corstr = "unstructured",
  std.err = "san.se",
  data = qids_long
)

emm_unstructured <- emmeans(fit_unstructured, ~ group_f * time_f)
contrasts_unstructured <- contrast(emm_unstructured, method = "pairwise", by = "time_f",
                                   adjust = "fdr", infer = TRUE)

saveRDS(fit_unstructured, here("outputs", "models", "30_qids_unstructured_fit.rds"))
write_csv(as.data.frame(contrasts_unstructured), here("outputs", "tables", "30_qids_unstructured_contrasts.csv"))
as.data.frame(contrasts_unstructured) %>%
  knitr::kable(format = "html", caption = "QIDS-C16 unstructured correlation contrasts") %>%
  writeLines(here("outputs", "tables", "30_qids_unstructured_contrasts.html"))

#----------------------------------------------------------------------#
# End of script 30_sensitivity-analysis.r
#----------------------------------------------------------------------#
