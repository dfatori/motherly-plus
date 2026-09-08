#----------------------------------------------------------------------#
# Project: Motherly+ RCT3
# Script: 11_secondary-outcomes-analysis.r
# Description: GEE analyses for secondary continuous outcomes (ITT)
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
long     <- readRDS(here("outputs", "models", "00_long_analytic.rds"))

#----------------------------------------------------------------------#
# QIDS-SR16 self-reported depression
# Self-report at T1-T4; all participants kept (ITT).
#----------------------------------------------------------------------#

qidssr16_wide <- baseline %>%
  select(record_id, group_f) %>%
  left_join(
    long %>%
      select(record_id, time, qidssr16) %>%
      pivot_wider(
        id_cols     = record_id,
        names_from  = time,
        values_from = qidssr16,
        names_prefix = "qidssr16_t"
      ),
    by = "record_id"
  )

qidssr16_long <- qidssr16_wide %>%
  pivot_longer(
    cols      = starts_with("qidssr16_t"),
    names_to  = "time",
    values_to = "qidssr16"
  ) %>%
  mutate(
    time   = as.integer(gsub("qidssr16_t", "", time)),
    time_f = factor(time, levels = c(1, 2, 3, 4), labels = c("T1", "T2", "T3", "T4"))
  )

fit_qidssr16 <- geeglm(
  qidssr16 ~ group_f * time_f,
  id      = record_id,
  family  = gaussian,
  corstr  = "ar1",
  std.err = "san.se",
  data    = qidssr16_long
)

emm_qidssr16       <- emmeans(fit_qidssr16, ~ group_f * time_f)
contrasts_qidssr16 <- contrast(emm_qidssr16, method = "pairwise", by = "time_f", adjust = "fdr", infer = TRUE)

saveRDS(fit_qidssr16, here("outputs", "models", "11_qidssr16_gee_fit.rds"))

# Save contrasts, marginal means and model summary as CSV/HTML.
write_csv(as.data.frame(contrasts_qidssr16), here("outputs", "tables", "11_qidssr16_contrasts.csv"))
as.data.frame(contrasts_qidssr16) %>%
  knitr::kable(format = "html", caption = "QIDS-SR16 pairwise contrasts by timepoint") %>%
  writeLines(here("outputs", "tables", "11_qidssr16_contrasts.html"))

write_csv(as.data.frame(emm_qidssr16), here("outputs", "tables", "11_qidssr16_marginal_means.csv"))
as.data.frame(emm_qidssr16) %>%
  knitr::kable(format = "html", caption = "QIDS-SR16 estimated marginal means") %>%
  writeLines(here("outputs", "tables", "11_qidssr16_marginal_means.html"))

write_csv(broom::tidy(fit_qidssr16), here("outputs", "tables", "11_qidssr16_model_summary.csv"))
broom::tidy(fit_qidssr16) %>%
  knitr::kable(format = "html", caption = "QIDS-SR16 GEE model summary") %>%
  writeLines(here("outputs", "tables", "11_qidssr16_model_summary.html"))

#----------------------------------------------------------------------#
# GAD-7 anxiety
#----------------------------------------------------------------------#

gad7_wide <- baseline %>%
  select(record_id, group_f) %>%
  left_join(
    long %>%
      select(record_id, time, gad7) %>%
      pivot_wider(
        id_cols     = record_id,
        names_from  = time,
        values_from = gad7,
        names_prefix = "gad7_t"
      ),
    by = "record_id"
  )

gad7_long <- gad7_wide %>%
  pivot_longer(
    cols      = starts_with("gad7_t"),
    names_to  = "time",
    values_to = "gad7"
  ) %>%
  mutate(
    time   = as.integer(gsub("gad7_t", "", time)),
    time_f = factor(time, levels = c(1, 2, 3, 4), labels = c("T1", "T2", "T3", "T4"))
  )

fit_gad7 <- geeglm(
  gad7 ~ group_f * time_f,
  id      = record_id,
  family  = gaussian,
  corstr  = "ar1",
  std.err = "san.se",
  data    = gad7_long
)

emm_gad7       <- emmeans(fit_gad7, ~ group_f * time_f)
contrasts_gad7 <- contrast(emm_gad7, method = "pairwise", by = "time_f", adjust = "fdr", infer = TRUE)

saveRDS(fit_gad7, here("outputs", "models", "11_gad7_gee_fit.rds"))

write_csv(as.data.frame(contrasts_gad7), here("outputs", "tables", "11_gad7_contrasts.csv"))
as.data.frame(contrasts_gad7) %>%
  knitr::kable(format = "html", caption = "GAD-7 pairwise contrasts by timepoint") %>%
  writeLines(here("outputs", "tables", "11_gad7_contrasts.html"))

write_csv(as.data.frame(emm_gad7), here("outputs", "tables", "11_gad7_marginal_means.csv"))
as.data.frame(emm_gad7) %>%
  knitr::kable(format = "html", caption = "GAD-7 estimated marginal means") %>%
  writeLines(here("outputs", "tables", "11_gad7_marginal_means.html"))

write_csv(broom::tidy(fit_gad7), here("outputs", "tables", "11_gad7_model_summary.csv"))
broom::tidy(fit_gad7) %>%
  knitr::kable(format = "html", caption = "GAD-7 GEE model summary") %>%
  writeLines(here("outputs", "tables", "11_gad7_model_summary.html"))

#----------------------------------------------------------------------#
# SDS functional impairment
#----------------------------------------------------------------------#

sds_wide <- baseline %>%
  select(record_id, group_f) %>%
  left_join(
    long %>%
      select(record_id, time, sds) %>%
      pivot_wider(
        id_cols     = record_id,
        names_from  = time,
        values_from = sds,
        names_prefix = "sds_t"
      ),
    by = "record_id"
  )

sds_long <- sds_wide %>%
  pivot_longer(
    cols      = starts_with("sds_t"),
    names_to  = "time",
    values_to = "sds"
  ) %>%
  mutate(
    time   = as.integer(gsub("sds_t", "", time)),
    time_f = factor(time, levels = c(1, 2, 3, 4), labels = c("T1", "T2", "T3", "T4"))
  )

fit_sds <- geeglm(
  sds ~ group_f * time_f,
  id      = record_id,
  family  = gaussian,
  corstr  = "ar1",
  std.err = "san.se",
  data    = sds_long
)

emm_sds       <- emmeans(fit_sds, ~ group_f * time_f)
contrasts_sds <- contrast(emm_sds, method = "pairwise", by = "time_f", adjust = "fdr", infer = TRUE)

saveRDS(fit_sds, here("outputs", "models", "11_sds_gee_fit.rds"))

write_csv(as.data.frame(contrasts_sds), here("outputs", "tables", "11_sds_contrasts.csv"))
as.data.frame(contrasts_sds) %>%
  knitr::kable(format = "html", caption = "SDS pairwise contrasts by timepoint") %>%
  writeLines(here("outputs", "tables", "11_sds_contrasts.html"))

write_csv(as.data.frame(emm_sds), here("outputs", "tables", "11_sds_marginal_means.csv"))
as.data.frame(emm_sds) %>%
  knitr::kable(format = "html", caption = "SDS estimated marginal means") %>%
  writeLines(here("outputs", "tables", "11_sds_marginal_means.html"))

write_csv(broom::tidy(fit_sds), here("outputs", "tables", "11_sds_model_summary.csv"))
broom::tidy(fit_sds) %>%
  knitr::kable(format = "html", caption = "SDS GEE model summary") %>%
  writeLines(here("outputs", "tables", "11_sds_model_summary.html"))

#----------------------------------------------------------------------#
# EPDS postpartum depression
#----------------------------------------------------------------------#

epds_wide <- baseline %>%
  select(record_id, group_f) %>%
  left_join(
    long %>%
      select(record_id, time, epds) %>%
      pivot_wider(
        id_cols     = record_id,
        names_from  = time,
        values_from = epds,
        names_prefix = "epds_t"
      ),
    by = "record_id"
  )

epds_long <- epds_wide %>%
  pivot_longer(
    cols      = starts_with("epds_t"),
    names_to  = "time",
    values_to = "epds"
  ) %>%
  mutate(
    time   = as.integer(gsub("epds_t", "", time)),
    time_f = factor(time, levels = c(1, 2, 3, 4), labels = c("T1", "T2", "T3", "T4"))
  )

fit_epds <- geeglm(
  epds ~ group_f * time_f,
  id      = record_id,
  family  = gaussian,
  corstr  = "ar1",
  std.err = "san.se",
  data    = epds_long
)

emm_epds       <- emmeans(fit_epds, ~ group_f * time_f)
contrasts_epds <- contrast(emm_epds, method = "pairwise", by = "time_f", adjust = "fdr", infer = TRUE)

saveRDS(fit_epds, here("outputs", "models", "11_epds_gee_fit.rds"))

write_csv(as.data.frame(contrasts_epds), here("outputs", "tables", "11_epds_contrasts.csv"))
as.data.frame(contrasts_epds) %>%
  knitr::kable(format = "html", caption = "EPDS pairwise contrasts by timepoint") %>%
  writeLines(here("outputs", "tables", "11_epds_contrasts.html"))

write_csv(as.data.frame(emm_epds), here("outputs", "tables", "11_epds_marginal_means.csv"))
as.data.frame(emm_epds) %>%
  knitr::kable(format = "html", caption = "EPDS estimated marginal means") %>%
  writeLines(here("outputs", "tables", "11_epds_marginal_means.html"))

write_csv(broom::tidy(fit_epds), here("outputs", "tables", "11_epds_model_summary.csv"))
broom::tidy(fit_epds) %>%
  knitr::kable(format = "html", caption = "EPDS GEE model summary") %>%
  writeLines(here("outputs", "tables", "11_epds_model_summary.html"))

#----------------------------------------------------------------------#
# CGI-I at T3 (ordinal secondary outcome)
#----------------------------------------------------------------------#

cgi_df <- long %>%
  filter(time == 3) %>%
  select(record_id, cgi_i) %>%
  left_join(
    baseline %>% select(record_id, group_f),
    by = "record_id"
  ) %>%
  mutate(cgi_i = factor(cgi_i, ordered = TRUE))

cgi_fit <- MASS::polr(cgi_i ~ group_f, data = cgi_df, Hess = TRUE)

summary(cgi_fit)

cgi_ci_raw <- confint(cgi_fit)
cgi_ci     <- as.data.frame(cgi_ci_raw)

if (ncol(cgi_ci) == 1) {
  cgi_ci <- as.data.frame(t(cgi_ci_raw))
  names(cgi_ci) <- c("OR_lower", "OR_upper")
} else {
  cgi_ci <- cgi_ci %>% rename(OR_lower = `2.5 %`, OR_upper = `97.5 %`)
}
cgi_ci <- cgi_ci %>% rownames_to_column("term")

cgi_or <- coef(summary(cgi_fit)) %>%
  as.data.frame() %>%
  rownames_to_column("term") %>%
  left_join(cgi_ci, by = "term") %>%
  mutate(
    OR       = exp(Value),
    OR_lower = exp(OR_lower),
    OR_upper = exp(OR_upper)
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