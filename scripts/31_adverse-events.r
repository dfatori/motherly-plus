#----------------------------------------------------------------------#
# Project: Motherly+ RCT3
# Script: 31_adverse-events.r
# Description: Define and describe adverse events
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
# Load packages
#----------------------------------------------------------------------#

library(here)
library(tidyverse)
library(gtsummary)
library(knitr)

#----------------------------------------------------------------------#
# Load data
#----------------------------------------------------------------------#

baseline <- readRDS(here("outputs", "models", "00_baseline_analytic.rds"))
long <- readRDS(here("outputs", "models", "00_long_analytic.rds"))

# Raw REDCap data for clinical adverse-event fields not in analytic datasets
redcap_files <- list.files(here("data", "trial"), pattern = "MotherlyRCT.*_DATA_.*\\.csv$", full.names = TRUE)
if (length(redcap_files) == 0) stop("No REDCap CSV file found in data/trial/")
latest_file <- sort(redcap_files, decreasing = TRUE)[1]
rct_raw <- read_csv(latest_file, col_types = cols(.default = "?"), na = c("", "NA", " "))

#----------------------------------------------------------------------#
# Define adverse events
# Adverse event: increase of >= 30% in QIDS16 (C or SR) at T3 or T4 vs T1
# Serious adverse event: QIDS item 12 score >= 2 at T3 or T4, or clinical
# adverse event fields (suicidal ideation, referral, dropout due to adverse effects)
#----------------------------------------------------------------------#

ae_wide <- baseline %>%
  dplyr::select(record_id, group_f) %>%
  left_join(
    long %>%
      filter(time %in% c(1, 3, 4)) %>%
      dplyr::select(record_id, time, qidsc16, qidssr16, qidsc16_item12, qidssr16_item12) %>%
      pivot_wider(
        id_cols = record_id,
        names_from = time,
        values_from = c(qidsc16, qidssr16, qidsc16_item12, qidssr16_item12)
      ),
    by = "record_id"
  ) %>%
  left_join(
    rct_raw %>%
      filter(redcap_event_name == "t2_arm_1") %>%
      dplyr::select(record_id, pron_ideacao, pron_ideacao_plano),
    by = "record_id"
  ) %>%
  left_join(
    rct_raw %>%
      filter(redcap_event_name == "t3_arm_1") %>%
      dplyr::select(record_id, t3_cgi_i),
    by = "record_id"
  ) %>%
  left_join(
    rct_raw %>%
      filter(redcap_event_name == "t4_arm_1") %>%
      dplyr::select(record_id, enc_1___2, enc_1___3, dropout7),
    by = "record_id"
  ) %>%
  mutate(
    ae_qidsc16 = ifelse(
      !is.na(qidsc16_3) & (qidsc16_3 - qidsc16_1) / qidsc16_1 >= 0.30,
      1, 0
    ),
    ae_qidssr16 = ifelse(
      (!is.na(qidssr16_3) & (qidssr16_3 - qidssr16_1) / qidssr16_1 >= 0.30) |
      (!is.na(qidssr16_4) & (qidssr16_4 - qidssr16_1) / qidssr16_1 >= 0.30),
      1, 0
    ),
    sae_qidsc16_item12 = ifelse(
      (!is.na(qidsc16_item12_3) & qidsc16_item12_3 >= 2) |
      (!is.na(qidsc16_item12_4) & qidsc16_item12_4 >= 2),
      1, 0
    ),
    sae_qidssr16_item12 = ifelse(
      (!is.na(qidssr16_item12_3) & qidssr16_item12_3 >= 2) |
      (!is.na(qidssr16_item12_4) & qidssr16_item12_4 >= 2),
      1, 0
    ),
    ae_ideation_session = ifelse(pron_ideacao == 1, 1, 0),
    ae_referral_ideation = ifelse(enc_1___2 == 1 | enc_1___3 == 1, 1, 0),
    ae_dropout_related = ifelse(dropout7 == 1, 1, 0),
    any_sae = ifelse(
      sae_qidsc16_item12 == 1 | sae_qidssr16_item12 == 1 |
      ae_referral_ideation == 1,
      1, 0
    )
  )

#----------------------------------------------------------------------#
# Descriptive table of adverse events by group
#----------------------------------------------------------------------#

ae_table <- ae_wide %>%
  dplyr::select(group_f, ae_qidsc16, ae_qidssr16, sae_qidsc16_item12,
         sae_qidssr16_item12, ae_ideation_session, ae_referral_ideation,
         ae_dropout_related, any_sae) %>%
  tbl_summary(
    by = group_f,
    label = list(
      ae_qidsc16 = "Adverse event: >=30% increase in QIDS-C16",
      ae_qidssr16 = "Adverse event: >=30% increase in QIDS-SR16",
      sae_qidsc16_item12 = "Serious AE: QIDS-C16 item 12 >= 2",
      sae_qidssr16_item12 = "Serious AE: QIDS-SR16 item 12 >= 2",
      ae_ideation_session = "AE: Suicidal ideation identified in session",
      ae_referral_ideation = "AE: Referral due to suicidal ideation/attempt",
      ae_dropout_related = "AE: Dropout related to adverse effects",
      any_sae = "Any serious adverse event"
    ),
    statistic = all_dichotomous() ~ "{n} ({p}%)",
    missing = "ifany"
  ) %>%
  add_overall() %>%
  add_p() %>%
  modify_header(label ~ "**Adverse event**")

ft <- as_flex_table(ae_table)
save_as_docx(ft, path = here("outputs", "tables", "31_adverse_events.docx"))
save_as_html(ft, path = here("outputs", "tables", "31_adverse_events.html"))

print(ae_table)

#----------------------------------------------------------------------#
# Save outputs
#----------------------------------------------------------------------#

saveRDS(ae_wide, here("outputs", "models", "31_adverse_events.rds"))
write_csv(ae_wide, here("outputs", "tables", "31_adverse_events_data.csv"))

#----------------------------------------------------------------------#
# End of script 31_adverse-events.r
#----------------------------------------------------------------------#
