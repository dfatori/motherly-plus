#----------------------------------------------------------------------#
# Project: Motherly Plus
# Script: 04_descriptive-baseline.r
# Description: Baseline Table 1 by randomized group
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
# Load packages
#----------------------------------------------------------------------#

library(here)
library(tidyverse)
library(gtsummary)
library(flextable)

#----------------------------------------------------------------------#
# Load data
#----------------------------------------------------------------------#

baseline <- readRDS(here("outputs", "models", "02_baseline_analytic.rds"))

#----------------------------------------------------------------------#
# Table 1: Baseline characteristics by group
#----------------------------------------------------------------------#

table1_vars <- c(
  "age", "infant_age_months", "white_race", "higher_education",
  "married_or_stable", "working", "studying", "family_income",
  "people_in_household", "number_of_children", "firstborn",
  "prenatal_visits", "high_risk_pregnancy", "mental_health_treatment",
  "qidsc16_t1", "qidssr16_t1", "gad7_t1", "sds_t1", "epds_t1",
  "psqi_t1",
  "psi_total_t1",
  "psi_pd_t1",
  "psi_pcdi_t1",
  "psi_dc_t1",
  "cgi_s_t1"
)

table1 <- baseline %>%
  select(all_of(table1_vars), group_f) %>%
  tbl_summary(
    by = group_f,
    type = list(
      age ~ "continuous",
      infant_age_months ~ "continuous",
      family_income ~ "continuous",
      people_in_household ~ "continuous",
      number_of_children ~ "continuous",
      prenatal_visits ~ "continuous",
      qidsc16_t1 ~ "continuous",
      qidssr16_t1 ~ "continuous",
      gad7_t1 ~ "continuous",
      sds_t1 ~ "continuous",
      epds_t1 ~ "continuous",
      psqi_t1 ~ "continuous",
      psi_total_t1 ~ "continuous",
      psi_pd_t1 ~ "continuous",
      psi_pcdi_t1 ~ "continuous",
      psi_dc_t1 ~ "continuous",
      cgi_s_t1 ~ "continuous",
      white_race ~ "dichotomous",
      higher_education ~ "dichotomous",
      married_or_stable ~ "dichotomous",
      working ~ "dichotomous",
      studying ~ "dichotomous",
      firstborn ~ "dichotomous",
      high_risk_pregnancy ~ "dichotomous",
      mental_health_treatment ~ "dichotomous"
    ),
    statistic = list(
      all_continuous() ~ "{mean} ({sd})",
      all_dichotomous() ~ "{n} ({p}%)"
    ),
    digits = all_continuous() ~ 2,
    missing = "ifany",
    label = list(
      age = "Age (years)",
      infant_age_months = "Infant age (months)",
      white_race = "White race/skin color",
      higher_education = "College degree or higher",
      married_or_stable = "Married or in stable relationship",
      working = "Working for pay",
      studying = "Currently studying",
      family_income = "Family income (BRL thousands)",
      people_in_household = "People in household",
      number_of_children = "Number of children",
      firstborn = "Firstborn child",
      prenatal_visits = "Prenatal visits",
      high_risk_pregnancy = "High-risk pregnancy",
      mental_health_treatment = "Receiving mental health treatment",
      qidsc16_t1 = "QIDS-C16 total score",
      qidssr16_t1 = "QIDS-SR16 total score",
      gad7_t1 = "GAD-7 total score",
      sds_t1 = "SDS total score",
      epds_t1 = "EPDS total score",
      psqi_t1 = "PSQI total score",
      psi_total_t1 = "PSI-SF total score",
      psi_pd_t1 = "PSI-SF parental distress",
      psi_pcdi_t1 = "PSI-SF dysfunctional interaction",
      psi_dc_t1 = "PSI-SF difficult child",
      cgi_s_t1 = "CGI-Severity score"
    )
  ) %>%
  add_overall() %>%
  modify_header(label ~ "**Characteristic**") %>%
  modify_caption("**Table 1. Baseline characteristics by randomized group**")

# Save Table 1
ft <- as_flex_table(table1)
save_as_docx(ft, path = here("outputs", "tables", "04_table1_baseline.docx"))
save_as_html(ft, path = here("outputs", "tables", "04_table1_baseline.html"))

# Save the gtsummary object for assembly in the report
saveRDS(table1, here("outputs", "models", "04_table1_gtsummary.rds"))

print(table1)

#----------------------------------------------------------------------#
# End of script 04_descriptive-baseline.r
#----------------------------------------------------------------------#
