#----------------------------------------------------------------------#
# Project: Motherly Plus
# Script: simulate-data.r
# Description: TEMPORARY — Simulate realistic REDCap-style trial data.
# Generates n=104 participants with longitudinal outcomes T1-T4.
# DELETE BEFORE FINAL ANALYSIS / PUBLICATION.
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
# Load packages
#----------------------------------------------------------------------#

library(here)
library(tidyverse)

#----------------------------------------------------------------------#
# Set seed
#----------------------------------------------------------------------#

set.seed(20260908)

#----------------------------------------------------------------------#
# Trial parameters
#----------------------------------------------------------------------#

n <- 104

#----------------------------------------------------------------------#
# Helper: split total score into correlated Likert items
#----------------------------------------------------------------------#

make_items <- function(total, n_items, max_score, min_score = 0) {
  prop <- pmin(pmax(total / (n_items * max_score), 0.01), 0.99)
  mat <- matrix(NA, nrow = length(total), ncol = n_items)
  for (i in seq_along(total)) {
    if (is.na(total[i])) {
      mat[i, ] <- NA_real_
      next
    }
    base <- round(prop[i] * max_score)
    items <- pmin(pmax(base + sample(-2:2, n_items, replace = TRUE), min_score), max_score)
    diff <- total[i] - sum(items)
    guard <- 0
    while (diff != 0 && guard < 100) {
      idx <- sample(n_items, 1)
      if (diff > 0 && items[idx] < max_score) {
        items[idx] <- items[idx] + 1
        diff <- diff - 1
      } else if (diff < 0 && items[idx] > min_score) {
        items[idx] <- items[idx] - 1
        diff <- diff + 1
      }
      guard <- guard + 1
    }
    mat[i, ] <- items
  }
  mat
}

#----------------------------------------------------------------------#
# Baseline participant characteristics
#----------------------------------------------------------------------#

baseline <- tibble(
  record_id = 1:n,
  rand_number = sample(rep(c(1, 2), each = n / 2), n, replace = FALSE)
) %>%
  mutate(
    # Demographics
    t0_idade = pmax(pmin(round(rnorm(n, 29, 5)), 40), 18),
    t1_idade_bebe = round(pmin(pmax(rgamma(n, 3, 1 / 1.5), 0.5), 12), 1),
    t1_cor = sample(c(1, 2, 3, 4, 5), n, TRUE, prob = c(0.45, 0.30, 0.15, 0.08, 0.02)),
    t1_escola = sample(1:7, n, TRUE, prob = c(0.02, 0.05, 0.13, 0.30, 0.30, 0.15, 0.05)),
    t1_renda = sample(1:6, n, TRUE, prob = c(0.10, 0.20, 0.25, 0.25, 0.15, 0.05)),
    t1_ecivil = sample(c(1, 2, 3, 4, 5), n, TRUE, prob = c(0.55, 0.25, 0.10, 0.08, 0.02)),
    t1_trabalho = sample(c(0, 1), n, TRUE, prob = c(0.65, 0.35)),
    t1_estudando = sample(c(0, 1), n, TRUE, prob = c(0.85, 0.15)),
    t1_familia1 = sample(2:7, n, TRUE, prob = c(0.15, 0.35, 0.30, 0.12, 0.05, 0.03)),
    t1_filhos = sample(1:4, n, TRUE, prob = c(0.45, 0.35, 0.15, 0.05)),
    t1_prenatal1 = pmax(pmin(round(rnorm(n, 8, 3)), 20), 0),
    t1_prenatal10 = sample(c(0, 1), n, TRUE, prob = c(0.80, 0.20)),
    t1_sm1 = sample(c(0, 1), n, TRUE, prob = c(0.75, 0.25)),

    # Baseline totals
    t1_qidsc16_total = pmax(pmin(round(rnorm(n, 17, 3.5)), 27), 10),
    t1_qidssr16_total = pmax(pmin(round(t1_qidsc16_total + rnorm(n, 0, 2)), 27), 8),
    t1_total_gad = pmax(pmin(round(rnorm(n, 11, 4)), 21), 3),
    t1_total_sds = pmax(pmin(round(rnorm(n, 16, 6)), 30), 3),
    t1_total_epds = pmax(pmin(round(rnorm(n, 16, 4)), 30), 8),
    t1_psi_total = pmax(pmin(round(rnorm(n, 95, 18)), 180), 50),
    t1_cgi_s = sample(3:6, n, TRUE, prob = c(0.10, 0.35, 0.40, 0.15)),
    t1_badssf_total = pmax(pmin(round(rnorm(n, 32, 8)), 54), 12),
    t1_total_rpi = pmax(pmin(round(rnorm(n, 48, 10)), 80), 20),

    # Random effects for longitudinal correlation
    ri_qidsc = rnorm(n, 0, 2.5),
    ri_qidssr = rnorm(n, 0, 2.5),
    ri_gad = rnorm(n, 0, 2),
    ri_sds = rnorm(n, 0, 3),
    ri_epds = rnorm(n, 0, 3),
    ri_psi = rnorm(n, 0, 12),
    ri_badssf = rnorm(n, 0, 4),
    ri_rpi = rnorm(n, 0, 4)
  )

#----------------------------------------------------------------------#
# Expand to long (T1-T4) and add treatment trajectory
#----------------------------------------------------------------------#

times <- tibble(
  time = 1:4,
  redcap_event_name = c("t1_arm_1", "t2_arm_1", "t3_arm_1", "t4_arm_1"),
  week = c(1, 2, 4, 8)
)

long <- baseline %>%
  cross_join(times) %>%
  mutate(
    treat_eff = ifelse(rand_number == 2, pmin(0.12 * (week - 1), 0.35), 0),
    placebo_eff = 0.04 * (week - 1),

    # QIDS-C16: only collected at T1 and T3 (clinical assessment)
    t1_qidsc16_total = ifelse(time %in% c(1, 3),
      pmax(pmin(round(
        t1_qidsc16_total - t1_qidsc16_total * (placebo_eff + treat_eff) + ri_qidsc + rnorm(n(), 0, 1.5)
      ), 27), 0), NA_real_),

    # QIDS-SR16: self-report at all timepoints
    t1_qidssr16_total = pmax(pmin(round(
      t1_qidssr16_total - t1_qidssr16_total * (placebo_eff + treat_eff * 1.1) + ri_qidssr + rnorm(n(), 0, 1.8)
    ), 27), 0),

    t1_total_gad = pmax(pmin(round(
      t1_total_gad - t1_total_gad * (placebo_eff + treat_eff * 0.9) + ri_gad + rnorm(n(), 0, 1.5)
    ), 21), 0),

    t1_total_sds = pmax(pmin(round(
      t1_total_sds - t1_total_sds * (placebo_eff + treat_eff * 0.8) + ri_sds + rnorm(n(), 0, 2)
    ), 30), 0),

    t1_total_epds = pmax(pmin(round(
      t1_total_epds - t1_total_epds * (placebo_eff + treat_eff * 0.95) + ri_epds + rnorm(n(), 0, 2)
    ), 30), 0),

    t1_psi_total = pmax(pmin(round(
      t1_psi_total - t1_psi_total * (placebo_eff + treat_eff * 0.6) + ri_psi + rnorm(n(), 0, 8)
    ), 180), 36),

    t1_badssf_total = pmax(pmin(round(
      t1_badssf_total + t1_badssf_total * (placebo_eff * 0.5 + treat_eff * 0.8) + ri_badssf + rnorm(n(), 0, 2.5)
    ), 54), 9),

    t1_total_rpi = pmax(pmin(round(
      t1_total_rpi + t1_total_rpi * (placebo_eff * 0.5 + treat_eff * 0.7) + ri_rpi + rnorm(n(), 0, 3)
    ), 100), 20),

    # Suicidality items — rare; QIDS-C item 12 only at T1/T3
    t1_qidsc16_12 = ifelse(time %in% c(1, 3),
                           sample(0:3, n(), TRUE, prob = c(0.88, 0.08, 0.03, 0.01)),
                           NA_real_),
    t1_qidssr16_12 = sample(0:3, n(), TRUE, prob = c(0.86, 0.09, 0.04, 0.01))
  )

#----------------------------------------------------------------------#
# Instrument schedule (REDCap instrument-event mapping) and missing data
# QIDS-C16: T1, T3 | QIDS-SR16: T1-T4 | GAD-7, SDS, EPDS, PSQI, PSI-SF:
# T1, T3, T4 | BADS-SF, RPI: T1, T2 | CGI-S: T1 | CGI-I: T3.
# T1 is always complete; follow-up visits are missing completely at random
# here (intermittent non-response), with more loss in the waitlist group.
#----------------------------------------------------------------------#

long <- long %>%
  mutate(
    miss_prob = case_when(
      time == 1 ~ 0,
      time == 2 ~ 0.10 + 0.05 * (rand_number == 1),
      time == 3 ~ 0.18 + 0.08 * (rand_number == 1),
      time == 4 ~ 0.25 + 0.10 * (rand_number == 1)
    ),
    obs = rbinom(n(), 1, 1 - miss_prob) == 1,
    t1_qidsc16_total = ifelse(time %in% c(1, 3) & obs, t1_qidsc16_total, NA_real_),
    t1_qidsc16_12 = ifelse(obs, t1_qidsc16_12, NA_real_),
    t1_qidssr16_total = ifelse(obs, t1_qidssr16_total, NA_real_),
    t1_qidssr16_12 = ifelse(obs, t1_qidssr16_12, NA_real_),
    across(
      c(t1_total_gad, t1_total_sds, t1_total_epds, t1_psi_total),
      ~ ifelse(time %in% c(1, 3, 4) & obs, .x, NA_real_)
    ),
    across(c(t1_badssf_total, t1_total_rpi), ~ ifelse(time %in% c(1, 2) & obs, .x, NA_real_)),
    t1_cgi_s = ifelse(time == 1, t1_cgi_s, NA_real_)
  )

#----------------------------------------------------------------------#
# Generate item-level data from totals
#----------------------------------------------------------------------#

qidsc_items <- make_items(long$t1_qidsc16_total, 16, 3)
qidssr_items <- make_items(long$t1_qidssr16_total, 16, 3)
gad_items <- make_items(long$t1_total_gad, 7, 3)
sds_items <- make_items(long$t1_total_sds, 3, 10)
epds_items <- make_items(long$t1_total_epds, 10, 3)

for (i in 1:16) {
  long[[paste0("t1_qidsc16_", i)]] <- ifelse(long$time %in% c(1, 3), qidsc_items[, i], NA_real_)
  long[[paste0("t1_qidssr16_", i)]] <- qidssr_items[, i]
}
for (i in 1:7) long[[paste0("t1_gad", i)]] <- gad_items[, i]
for (i in 1:3) long[[paste0("t1_sds", i)]] <- sds_items[, i]
for (i in 1:10) long[[paste0("t1_epds", i)]] <- epds_items[, i]

# PSQI items (REDCap coding: 0-3 response categories; Q1/Q3 are HH:MM).
# Item responses at T1 are drawn once per participant; at T3/T4 they improve
# with the same placebo/treatment trajectory used for the other instruments.
psqi_probs <- list(
  t1_psqi_2 = c(0.25, 0.35, 0.25, 0.15),
  t1_psqi_4 = c(0.15, 0.30, 0.35, 0.20),
  t1_psqi_5a = c(0.30, 0.30, 0.25, 0.15),
  t1_psqi_5b = c(0.35, 0.30, 0.20, 0.15),
  t1_psqi_5c = c(0.50, 0.25, 0.15, 0.10),
  t1_psqi_5d = c(0.70, 0.15, 0.10, 0.05),
  t1_psqi_5e = c(0.60, 0.20, 0.12, 0.08),
  t1_psqi_5f = c(0.65, 0.20, 0.10, 0.05),
  t1_psqi_5g = c(0.65, 0.20, 0.10, 0.05),
  t1_psqi_5h = c(0.55, 0.25, 0.12, 0.08),
  t1_psqi_5i = c(0.55, 0.25, 0.12, 0.08),
  t1_psqi_5j2 = c(0.70, 0.15, 0.10, 0.05),
  t1_psqi_6 = c(0.15, 0.30, 0.35, 0.20),
  t1_psqi_7 = c(0.75, 0.12, 0.08, 0.05),
  t1_psqi_8 = c(0.65, 0.20, 0.10, 0.05),
  t1_psqi_9 = c(0.20, 0.30, 0.30, 0.20)
)

psqi_base <- as_tibble(lapply(psqi_probs, function(p) sample(0:3, n, TRUE, prob = p))) %>%
  mutate(
    record_id = baseline$record_id,
    t1_psqi_1 = sprintf("%02d:%02d", sample(20:23, n, TRUE), sample(0:59, n, TRUE)),
    t1_psqi_3 = sprintf("%02d:%02d", sample(5:9, n, TRUE), sample(0:59, n, TRUE))
  ) %>%
  rename_with(~ paste0(.x, "_b"), -record_id)

long <- left_join(long, psqi_base, by = "record_id")
psqi_obs <- long$time %in% c(1, 3, 4) & long$obs
psqi_eff <- long$placebo_eff + long$treat_eff * 0.7

for (v in names(psqi_probs)) {
  noise <- ifelse(long$time == 1, 0, rnorm(nrow(long), 0, 0.4))
  long[[v]] <- ifelse(
    psqi_obs,
    pmin(pmax(round(long[[paste0(v, "_b")]] * (1 - psqi_eff) + noise), 0), 3),
    NA_real_
  )
}
long$t1_psqi_1 <- ifelse(psqi_obs, long$t1_psqi_1_b, NA_character_)
long$t1_psqi_3 <- ifelse(psqi_obs, long$t1_psqi_3_b, NA_character_)

# PSI-SF 36 items (1-5 Likert)
psi_item_names <- c(
  "t1_psi56", "t1_psi69", "t1_psi70", "t1_psi72", "t1_psi73", "t1_psi76",
  "t1_psi80", "t1_psi85", "t1_psi91", "t1_psi92", "t1_psi93", "t1_psi100",
  "t1_psi10", "t1_psi14", "t1_psi13", "t1_psi12", "t1_psi34", "t1_psi23",
  "t1_psi24", "t1_psi26", "t1_psi38", "t1_psi58", "t1_psi63", "t1_psi64",
  "t1_psi17", "t1_psi19", "t1_psi20", "t1_psi44", "t1_psi32", "t1_psi18",
  "t1_psi36", "t1_psi41", "t1_psi42", "t1_psi31", "t1_psi47", "t1_psi50"
)
psi_items_mat <- make_items(long$t1_psi_total, 36, 5, min_score = 1)
for (i in 1:36) long[[psi_item_names[i]]] <- psi_items_mat[, i]

# WAI-SR at T2
long <- long %>%
  mutate(
    t2_waisrc_goals = ifelse(time == 2, pmax(pmin(round(rnorm(n(), 22, 3)), 28), 4), NA_real_),
    t2_waisrc_tasks = ifelse(time == 2, pmax(pmin(round(rnorm(n(), 22, 3)), 28), 4), NA_real_),
    t2_waisrc_bond = ifelse(time == 2, pmax(pmin(round(rnorm(n(), 24, 3)), 28), 4), NA_real_),
    t2_waisrt_goals = ifelse(time == 2, pmax(pmin(round(rnorm(n(), 21, 3)), 28), 4), NA_real_),
    t2_waisrt_tasks = ifelse(time == 2, pmax(pmin(round(rnorm(n(), 21, 3)), 28), 4), NA_real_),
    t2_waisrt_bond = ifelse(time == 2, pmax(pmin(round(rnorm(n(), 23, 3)), 28), 4), NA_real_)
  )

# CGI-I at T3
long <- long %>%
  mutate(
    t3_cgi_i = ifelse(
      time == 3 & obs,
      sample(1:7, n(), TRUE, prob = c(0.25, 0.25, 0.20, 0.15, 0.08, 0.05, 0.02)),
      NA_real_
    )
  )

#----------------------------------------------------------------------#
# Adverse event static fields
#----------------------------------------------------------------------#

ae <- baseline %>%
  mutate(
    pron_ideacao = sample(c(0, 1), n, TRUE, prob = c(0.95, 0.05)),
    pron_ideacao_plano = ifelse(pron_ideacao == 1, sample(c(0, 1), sum(pron_ideacao == 1), TRUE, prob = c(0.7, 0.3)), 0),
    enc_1___2 = sample(c(0, 1), n, TRUE, prob = c(0.97, 0.03)),
    enc_1___3 = sample(c(0, 1), n, TRUE, prob = c(0.99, 0.01)),
    dropout7 = sample(c(0, 1), n, TRUE, prob = c(0.98, 0.02))
  ) %>%
  select(record_id, pron_ideacao, pron_ideacao_plano, enc_1___2, enc_1___3, dropout7)

#----------------------------------------------------------------------#
# Assemble REDCap-style CSV
#----------------------------------------------------------------------#

qidsc_item_names <- setdiff(paste0("t1_qidsc16_", 1:16), c("t1_qidsc16_total", "t1_qidsc16_12"))
qidssr_item_names <- setdiff(paste0("t1_qidssr16_", 1:16), c("t1_qidssr16_total", "t1_qidssr16_12"))
gad_item_names <- paste0("t1_gad", 1:7)
sds_item_names <- paste0("t1_sds", 1:3)
epds_item_names <- paste0("t1_epds", 1:10)
psqi_item_names <- c("t1_psqi_1", "t1_psqi_2", "t1_psqi_3", "t1_psqi_4",
                     paste0("t1_psqi_5", letters[1:9]), "t1_psqi_5j2",
                     "t1_psqi_6", "t1_psqi_7", "t1_psqi_8", "t1_psqi_9")

redcap_cols <- c(
  "record_id", "redcap_event_name", "rand_number",
  "t1_idade_bebe",
  "t1_cor", "t1_escola", "t1_renda", "t1_ecivil",
  "t1_trabalho", "t1_estudando", "t1_familia1", "t1_filhos",
  "t1_prenatal1", "t1_prenatal10", "t1_sm1",
  "t1_qidsc16_total", "t1_qidssr16_total",
  "t1_total_gad", "t1_total_epds",
  "t1_badssf_total", "t1_total_rpi", "t1_cgi_s",
  "t1_qidsc16_12", "t1_qidssr16_12",
  qidsc_item_names, qidssr_item_names,
  gad_item_names, sds_item_names, epds_item_names,
  psqi_item_names,
  psi_item_names,
  "t2_waisrc_goals", "t2_waisrc_tasks", "t2_waisrc_bond",
  "t2_waisrt_goals", "t2_waisrt_tasks", "t2_waisrt_bond",
  "t3_cgi_i"
)

redcap_long <- long %>%
  select(all_of(redcap_cols)) %>%
  left_join(ae, by = "record_id")

# Sparse T0 rows (screening placeholders): in REDCap, screening-event
# variables such as maternal age (t0_idade) live only on t0_arm_1, while
# randomization (rand_number) is recorded at t1_arm_1. Mirror that here.
t0_rows <- baseline %>%
  select(record_id, t0_idade) %>%
  mutate(redcap_event_name = "t0_arm_1") %>%
  left_join(ae, by = "record_id")

redcap_full <- bind_rows(redcap_long, t0_rows) %>%
  arrange(record_id, redcap_event_name)

#----------------------------------------------------------------------#
# Save
#----------------------------------------------------------------------#

write_csv(redcap_full, here("data", "MotherlyRCT2026_DATA_simulated.csv"))
saveRDS(redcap_full, here("outputs", "models", "simulated_trial_long.rds"))
saveRDS(baseline, here("outputs", "models", "simulated_trial_baseline.rds"))

message("Simulated dataset saved:")
message("  data/MotherlyRCT2026_DATA_simulated.csv")
message("  outputs/models/simulated_trial_long.rds")
message("  outputs/models/simulated_trial_baseline.rds")
message("Participants: ", n_distinct(redcap_full$record_id))
message("Rows: ", nrow(redcap_full))
