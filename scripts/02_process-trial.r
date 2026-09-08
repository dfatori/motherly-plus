#----------------------------------------------------------------------#
# Project: Motherly+ RCT3 - Single-session psychotherapy + app
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

rct_raw <- readRDS(here("outputs", "models", "00_trial_raw.rds"))

#----------------------------------------------------------------------#
# Create one-row-per-participant analytic dataset
# Use baseline (t1_arm_1) as the source of static covariates
#----------------------------------------------------------------------#

baseline <- rct_raw %>%
  filter(redcap_event_name == "t1_arm_1") %>%
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
    cgi_s_t1 = as.numeric(t1_cgi_s)
  )

#----------------------------------------------------------------------#
# Derive PSQI total score (T1)
# Official PSQI scoring: 7 components, each 0-3, summed to 0-21.
# Source: example/psqi/psqi scoring.pdf (Buysse et al., 1989).
# NOTE: Assumes REDCap Likert items are coded 1-4 and are shifted to 0-3.
# Verify REDCap value labels before analysis.
#----------------------------------------------------------------------#

baseline <- baseline %>%
  mutate(
    # Convert bed/rise times (assumed HH:MM) to decimal hours
    psqi_bed_h = as.numeric(substr(t1_psqi_1, 1, 2)) + as.numeric(substr(t1_psqi_1, 4, 5)) / 60,
    psqi_rise_h = as.numeric(substr(t1_psqi_3, 1, 2)) + as.numeric(substr(t1_psqi_3, 4, 5)) / 60,
    # Hours in bed (handle crossing midnight)
    psqi_tib = ifelse(psqi_rise_h >= psqi_bed_h,
                      psqi_rise_h - psqi_bed_h,
                      (psqi_rise_h + 24) - psqi_bed_h),
    psqi_sleep_h = as.numeric(t1_psqi_4),
    psqi_efficiency = (psqi_sleep_h / psqi_tib) * 100,

    # Component 1: subjective sleep quality (Q9)
    psqi_c1 = as.numeric(t1_psqi_9) - 1,

    # Component 2: sleep latency (Q2 + Q5a)
    psqi_q2_score = case_when(
      as.numeric(t1_psqi_2) <= 15 ~ 0,
      as.numeric(t1_psqi_2) <= 30 ~ 1,
      as.numeric(t1_psqi_2) <= 60 ~ 2,
      TRUE ~ 3
    ),
    psqi_q5a_score = as.numeric(t1_psqi_5a) - 1,
    psqi_c2 = case_when(
      (psqi_q2_score + psqi_q5a_score) == 0 ~ 0,
      (psqi_q2_score + psqi_q5a_score) <= 2 ~ 1,
      (psqi_q2_score + psqi_q5a_score) <= 4 ~ 2,
      TRUE ~ 3
    ),

    # Component 3: sleep duration (Q4)
    psqi_c3 = case_when(
      psqi_sleep_h > 7 ~ 0,
      psqi_sleep_h >= 6 ~ 1,
      psqi_sleep_h >= 5 ~ 2,
      TRUE ~ 3
    ),

    # Component 4: sleep efficiency
    psqi_c4 = case_when(
      psqi_efficiency > 85 ~ 0,
      psqi_efficiency >= 75 ~ 1,
      psqi_efficiency >= 65 ~ 2,
      TRUE ~ 3
    ),

    # Component 5: sleep disturbance (Q5b to Q5j)
    psqi_c5_sum = rowSums(across(c(t1_psqi_5b, t1_psqi_5c, t1_psqi_5d, t1_psqi_5e,
                                    t1_psqi_5f, t1_psqi_5g, t1_psqi_5h, t1_psqi_5i,
                                    t1_psqi_5j2), ~ as.numeric(.) - 1), na.rm = TRUE),
    psqi_c5 = case_when(
      psqi_c5_sum == 0 ~ 0,
      psqi_c5_sum <= 9 ~ 1,
      psqi_c5_sum <= 18 ~ 2,
      TRUE ~ 3
    ),

    # Component 6: use of sleep medication (Q6)
    psqi_c6 = as.numeric(t1_psqi_6) - 1,

    # Component 7: daytime dysfunction (Q7 + Q8)
    psqi_q7_score = as.numeric(t1_psqi_7) - 1,
    psqi_q8_score = as.numeric(t1_psqi_8) - 1,
    psqi_c7 = case_when(
      (psqi_q7_score + psqi_q8_score) == 0 ~ 0,
      (psqi_q7_score + psqi_q8_score) <= 2 ~ 1,
      (psqi_q7_score + psqi_q8_score) <= 4 ~ 2,
      TRUE ~ 3
    ),

    # Global PSQI score
    psqi_t1 = psqi_c1 + psqi_c2 + psqi_c3 + psqi_c4 + psqi_c5 + psqi_c6 + psqi_c7
  )

#----------------------------------------------------------------------#
# Derive PSI-SF subscales and total (T1)
# NOTE: The REDCap variables use PSI-4 item numbers. The PSI-SF consists
# of a fixed subset of 36 items from the full PSI-4. Some additional
# PSI-4 subscale items were collected in this trial; they are ignored
# for the PSI-SF scoring below.
#
# Source: labels in data/trial/MotherlyRCT2025-Geral_R_*.r and scoring sheet.
# Verification recommended against the official Brazilian PSI-SF manual.
#----------------------------------------------------------------------#

# Reverse-code function: 1->5, 2->4, 3->3, 4->2, 5->1
rev5 <- function(x) 6 - as.numeric(x)

# PSI-SF item variables in REDCap (using PSI-4 numbers)
psi_items <- c(
  "t1_psi56", "t1_psi69", "t1_psi70", "t1_psi72", "t1_psi73", "t1_psi76",
  "t1_psi80", "t1_psi85", "t1_psi91", "t1_psi92", "t1_psi93", "t1_psi100",
  "t1_psi10", "t1_psi14", "t1_psi13", "t1_psi12", "t1_psi34", "t1_psi23",
  "t1_psi24", "t1_psi26", "t1_psi38", "t1_psi58", "t1_psi63", "t1_psi64",
  "t1_psi17", "t1_psi19", "t1_psi20", "t1_psi44", "t1_psi32", "t1_psi18",
  "t1_psi36", "t1_psi41", "t1_psi42", "t1_psi31", "t1_psi47", "t1_psi50"
)

# Subscales (item order in PSI-SF, 1-36)
psi_pd    <- psi_items[1:12]   # Parental Distress
psi_pcdi  <- psi_items[13:24]  # Parent-Child Dysfunctional Interaction
psi_dc    <- psi_items[25:36]  # Difficult Child

# Items that require reverse coding (positive-worded / low = more stress)
# Item 22 (t1_psi58): self-rating of competence
# Item 32 (t1_psi41): difficulty getting child to do/stop something
# Item 33 (t1_psi42): number of bothersome behaviours
psi_reverse <- c("t1_psi58", "t1_psi41", "t1_psi42")

baseline <- baseline %>%
  mutate(
    across(all_of(psi_items), as.numeric),
    # Apply reverse coding where needed
    across(all_of(psi_reverse), rev5),
    # Subscale totals (mean imputation if <= 1 item missing per subscale)
    psi_pd_t1 = rowSums(across(all_of(psi_pd)),   na.rm = FALSE),
    psi_pcdi_t1 = rowSums(across(all_of(psi_pcdi)), na.rm = FALSE),
    psi_dc_t1 = rowSums(across(all_of(psi_dc)),   na.rm = FALSE),
    psi_total_t1 = psi_pd_t1 + psi_pcdi_t1 + psi_dc_t1,
    # Missing count per subscale
    psi_pd_missing_t1 = rowSums(is.na(across(all_of(psi_pd)))),
    psi_pcdi_missing_t1 = rowSums(is.na(across(all_of(psi_pcdi)))),
    psi_dc_missing_t1 = rowSums(is.na(across(all_of(psi_dc))))
  ) %>%
  mutate(
    # Prorate if exactly 1 item missing; set to NA if 2+ missing
    psi_pd_t1 = ifelse(psi_pd_missing_t1 == 1, psi_pd_t1 * 12 / 11,
                ifelse(psi_pd_missing_t1 >= 2, NA_real_, psi_pd_t1)),
    psi_pcdi_t1 = ifelse(psi_pcdi_missing_t1 == 1, psi_pcdi_t1 * 12 / 11,
                  ifelse(psi_pcdi_missing_t1 >= 2, NA_real_, psi_pcdi_t1)),
    psi_dc_t1 = ifelse(psi_dc_missing_t1 == 1, psi_dc_t1 * 12 / 11,
                ifelse(psi_dc_missing_t1 >= 2, NA_real_, psi_dc_t1)),
    psi_total_t1 = ifelse(
      is.na(psi_pd_t1) | is.na(psi_pcdi_t1) | is.na(psi_dc_t1),
      NA_real_, psi_pd_t1 + psi_pcdi_t1 + psi_dc_t1
    )
  )

#----------------------------------------------------------------------#
# Long-format outcomes dataset
# One row per participant x timepoint for repeated-measures GEE
# Timepoints: 1 = T1 baseline, 2 = T2 week 2, 3 = T3 week 4, 4 = T4 week 8
#----------------------------------------------------------------------#

extract_timepoint <- function(df, event_name, time_code) {
  df %>%
    filter(redcap_event_name == event_name) %>%
    mutate(
      # SDS total: same field names are reused across events in REDCap
      total_sds = rowSums(across(c(t1_sds1, t1_sds2, t1_sds3), as.numeric), na.rm = FALSE)
    ) %>%
    select(
      record_id,
      starts_with("t1_qidsc16_total"), starts_with("t1_qidssr16_total"),
      starts_with("t1_total_gad"), starts_with("total_sds"),
      starts_with("t1_total_epds"),
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

saveRDS(baseline, here("outputs", "models", "00_baseline_analytic.rds"))
saveRDS(rct_long, here("outputs", "models", "00_long_analytic.rds"))

# Save group allocation crosswalk for inspection
baseline %>%
  select(record_id, group, group_f) %>%
  write_csv(here("outputs", "tables", "00_group_allocation.csv"))

#----------------------------------------------------------------------#
# End of script 02_process-trial.r
#----------------------------------------------------------------------#
