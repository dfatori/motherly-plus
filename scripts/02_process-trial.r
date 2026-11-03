#----------------------------------------------------------------------#
# Project: Motherly Plus
# Script: 02_process-trial.r
# Description: Process REDCap trial data and derive analytic variables
# Pre-specified analysis plan - intention-to-treat
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
# Load packages
#----------------------------------------------------------------------#

library(here)
library(tidyverse)
library(readr)

#----------------------------------------------------------------------#
# Set up folders
#----------------------------------------------------------------------#

output_folder_tables <- here("outputs", "tables")
output_folder_figures <- here("outputs", "figures")
output_folder_models <- here("outputs", "models")

if (!dir.exists(output_folder_tables)) dir.create(output_folder_tables, recursive = TRUE)
if (!dir.exists(output_folder_figures)) dir.create(output_folder_figures, recursive = TRUE)
if (!dir.exists(output_folder_models)) dir.create(output_folder_models, recursive = TRUE)

#----------------------------------------------------------------------#
# Load raw trial dataset
#----------------------------------------------------------------------#

rct_raw <- readRDS(here("outputs", "models", "01_trial_raw.rds"))

#----------------------------------------------------------------------#
# Scoring functions for PSQI and PSI-SF
# Both instruments reuse the same REDCap field names (t1_psqi_*, t1_psi*)
# in every event where they are applied (T1, T3, T4), so the functions take
# the rows of one event and return the scores for those rows.
#----------------------------------------------------------------------#

# Bed/rise times are read as HH:MM:SS (hms) or HH:MM text; keep HH:MM
hm_to_hours <- function(x) as.numeric(lubridate::hm(substr(as.character(x), 1, 5)), "hours")

# PSQI global score (Buysse et al., 1989). REDCap stores items as 0-3
# response categories (see data dictionary); Q1/Q3 are bed/rise times (HH:MM).
# Item mapping in this REDCap instrument:
#   t1_psqi_6 = subjective sleep quality, t1_psqi_7 = sleep medication,
#   t1_psqi_8 and t1_psqi_9 = daytime dysfunction.
# Sleep duration (t1_psqi_4) is stored as a category, so the hours used for
# habitual sleep efficiency are the category midpoints (assumption).
# t1_psqi_5j2 (other disturbance) may be hidden when no other reason exists;
# a missing value there is counted as 0.
score_psqi <- function(df) {
  q <- function(x) as.numeric(df[[x]])
  # Component score from a sum: 0 -> 0, 1-2 -> 1, 3-4 -> 2, 5+ -> 3
  band <- function(s, upper = c(0, 2, 4)) cut(s, c(-Inf, upper, Inf), labels = FALSE) - 1

  time_in_bed <- (hm_to_hours(df$t1_psqi_3) - hm_to_hours(df$t1_psqi_1)) %% 24
  sleep_hours <- c(7.5, 6.5, 5.5, 4.5)[q("t1_psqi_4") + 1]
  efficiency <- sleep_hours / time_in_bed * 100

  c1 <- q("t1_psqi_6")
  c2 <- band(q("t1_psqi_2") + q("t1_psqi_5a"))
  c3 <- q("t1_psqi_4")
  c4 <- case_when(efficiency > 85 ~ 0, efficiency >= 75 ~ 1, efficiency >= 65 ~ 2, efficiency < 65 ~ 3)
  disturbance <- q("t1_psqi_5b") + q("t1_psqi_5c") + q("t1_psqi_5d") + q("t1_psqi_5e") +
    q("t1_psqi_5f") + q("t1_psqi_5g") + q("t1_psqi_5h") + q("t1_psqi_5i") +
    coalesce(q("t1_psqi_5j2"), 0)
  c5 <- band(disturbance, upper = c(0, 9, 18))
  c6 <- q("t1_psqi_7")
  c7 <- band(q("t1_psqi_8") + q("t1_psqi_9"))

  c1 + c2 + c3 + c4 + c5 + c6 + c7
}

# PSI-SF: 36 items named with PSI-4 item numbers. Subscales follow the PSI-SF
# item order: parental distress (1-12), parent-child dysfunctional
# interaction (13-24), difficult child (25-36). Reverse-coded items (assumed):
# t1_psi58, t1_psi41, t1_psi42. A subscale is prorated if exactly 1 item is
# missing and set to NA if 2+ are missing. See instructions.md, Section 8.
psi_items <- c(
  "t1_psi56", "t1_psi69", "t1_psi70", "t1_psi72", "t1_psi73", "t1_psi76",
  "t1_psi80", "t1_psi85", "t1_psi91", "t1_psi92", "t1_psi93", "t1_psi100",
  "t1_psi10", "t1_psi14", "t1_psi13", "t1_psi12", "t1_psi34", "t1_psi23",
  "t1_psi24", "t1_psi26", "t1_psi38", "t1_psi58", "t1_psi63", "t1_psi64",
  "t1_psi17", "t1_psi19", "t1_psi20", "t1_psi44", "t1_psi32", "t1_psi18",
  "t1_psi36", "t1_psi41", "t1_psi42", "t1_psi31", "t1_psi47", "t1_psi50"
)
psi_reverse <- c("t1_psi58", "t1_psi41", "t1_psi42")

score_psi <- function(df) {
  items <- as.data.frame(lapply(df[psi_items], as.numeric))
  items[psi_reverse] <- 6 - items[psi_reverse]

  subscale <- function(cols) {
    total <- rowSums(items[cols])
    n_missing <- rowSums(is.na(items[cols]))
    ifelse(n_missing == 0, total, ifelse(n_missing == 1, rowSums(items[cols], na.rm = TRUE) * 12 / 11, NA_real_))
  }

  out <- tibble(
    psi_pd = subscale(psi_items[1:12]),
    psi_pcdi = subscale(psi_items[13:24]),
    psi_dc = subscale(psi_items[25:36])
  )
  out$psi_total <- out$psi_pd + out$psi_pcdi + out$psi_dc
  out
}

#----------------------------------------------------------------------#
# Create one-row-per-participant analytic dataset
# Use baseline (t1_arm_1) as the source of static covariates
#----------------------------------------------------------------------#

# Screening-event variables: in REDCap these are collected at t0_arm_1,
# not at t1_arm_1 (e.g., maternal age t0_idade). Pull them separately and
# join into the baseline (t1_arm_1) row by record_id.
screening <- rct_raw %>%
  filter(redcap_event_name == "t0_arm_1") %>%
  select(record_id, t0_idade)

baseline <- rct_raw %>%
  filter(redcap_event_name == "t1_arm_1") %>%
  select(-any_of("t0_idade")) %>%
  left_join(screening, by = "record_id") %>%
  mutate(
    # Group allocation: 1 = waitlist (control), 2 = intervention
    # rand_number or group should come from REDCap; recode here as factor
    group = as.numeric(rand_number),
    group_f = factor(group, levels = c(1, 2), labels = c("Waitlist", "Intervention")),

    # Demographics
    age = as.numeric(t0_idade),
    infant_age_months = as.numeric(t1_idade_bebe),
    white_race = ifelse(t1_cor == 1, 1, 0),  # 1 = branca; assume other codes = non-white
    higher_education = ifelse(t1_escola >= 5, 1, 0),  # adjust code if needed
    married_or_stable = ifelse(t1_ecivil == 1, 1, 0),  # 1 = married/stable union
    working = ifelse(t1_trabalho == 1, 1, 0),
    studying = ifelse(t1_estudando == 1, 1, 0),
    family_income = as.numeric(t1_renda),
    people_in_household = as.numeric(t1_familia1),
    number_of_children = as.numeric(t1_filhos),
    firstborn = ifelse(t1_filhos == 1, 1, 0),
    prenatal_visits = as.numeric(t1_prenatal1),
    high_risk_pregnancy = ifelse(t1_prenatal10 == 1, 1, 0),
    mental_health_treatment = ifelse(t1_sm1 == 1, 1, 0),

    # Baseline clinical scores
    qidsc16_t1 = as.numeric(t1_qidsc16_total),
    qidssr16_t1 = as.numeric(t1_qidssr16_total),
    gad7_t1 = as.numeric(t1_total_gad),
    sds_t1 = rowSums(across(c(t1_sds1, t1_sds2, t1_sds3), as.numeric), na.rm = FALSE),
    epds_t1 = as.numeric(t1_total_epds),
    cgi_s_t1 = as.numeric(t1_cgi_s),
    psqi_t1 = score_psqi(.)
  )

baseline <- bind_cols(
  baseline,
  score_psi(baseline) %>% rename_with(~ paste0(.x, "_t1"))
)

#----------------------------------------------------------------------#
# Long-format outcomes dataset
# One row per participant x timepoint (only events present in the export)
# Timepoints: 1 = T1 baseline, 2 = T2 week 2, 3 = T3 week 4, 4 = T4 week 8
# Instruments by event follow the REDCap instrument-event mapping
# (data/MotherlyRCT2026_InstrumentDesignations_*.csv); scores are NA where
# an instrument is not applied.
#----------------------------------------------------------------------#

extract_timepoint <- function(df, event_name, time_code) {
  df <- df %>% filter(redcap_event_name == event_name)
  psi <- score_psi(df)

  df %>%
    mutate(
      # SDS total: same field names are reused across events in REDCap
      total_sds = rowSums(across(c(t1_sds1, t1_sds2, t1_sds3), as.numeric), na.rm = FALSE),
      psqi = score_psqi(df),
      psi_pd = psi$psi_pd,
      psi_pcdi = psi$psi_pcdi,
      psi_dc = psi$psi_dc,
      psi_total = psi$psi_total
    ) %>%
    select(
      record_id,
      starts_with("t1_qidsc16_total"), starts_with("t1_qidssr16_total"),
      starts_with("t1_total_gad"), starts_with("total_sds"),
      starts_with("t1_total_epds"),
      psqi, psi_pd, psi_pcdi, psi_dc, psi_total,
      starts_with("t1_badssf_total"), starts_with("t1_total_rpi"),
      starts_with("t3_cgi_i"),
      starts_with("t2_waisrc_goals"), starts_with("t2_waisrc_tasks"), starts_with("t2_waisrc_bond"),
      starts_with("t2_waisrt_goals"), starts_with("t2_waisrt_tasks"), starts_with("t2_waisrt_bond"),
      starts_with("t1_qidsc16_12"), starts_with("t1_qidssr16_12")
    ) %>%
    mutate(time = time_code)
}

tp1 <- extract_timepoint(rct_raw, "t1_arm_1", 1)
tp2 <- extract_timepoint(rct_raw, "t2_arm_1", 2)
tp3 <- extract_timepoint(rct_raw, "t3_arm_1", 3)
tp4 <- extract_timepoint(rct_raw, "t4_arm_1", 4)

# Combine and rename to standardized names
rct_long <- bind_rows(tp1, tp2, tp3, tp4) %>%
  rename(
    qidsc16 = t1_qidsc16_total,
    qidssr16 = t1_qidssr16_total,
    gad7 = t1_total_gad,
    sds = total_sds,
    epds = t1_total_epds,
    badssf = t1_badssf_total,
    rpi = t1_total_rpi,
    cgi_i = t3_cgi_i,
    waisrc_goals = t2_waisrc_goals,
    waisrc_tasks = t2_waisrc_tasks,
    waisrc_bond = t2_waisrc_bond,
    waisrt_goals = t2_waisrt_goals,
    waisrt_tasks = t2_waisrt_tasks,
    waisrt_bond = t2_waisrt_bond,
    qidsc16_item12 = t1_qidsc16_12,
    qidssr16_item12 = t1_qidssr16_12
  )

#----------------------------------------------------------------------#
# Save analytic datasets
#----------------------------------------------------------------------#

saveRDS(baseline, here("outputs", "models", "02_baseline_analytic.rds"))
saveRDS(rct_long, here("outputs", "models", "02_long_analytic.rds"))

# Save group allocation crosswalk for inspection
baseline %>%
  select(record_id, group, group_f) %>%
  write_csv(here("outputs", "tables", "02_group_allocation.csv"))

#----------------------------------------------------------------------#
# End of script 02_process-trial.r
#----------------------------------------------------------------------#