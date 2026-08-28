#----------------------------------------------------------------------#
# Project: Motherly+ RCT3
# Script: 10_primary-outcome.r
# Description: Primary outcome analysis (QIDS-C16 at T3) using GEE
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
# Load packages
#----------------------------------------------------------------------#

library(here)
library(tidyverse)
library(geepack)
library(emmeans)
library(knitr)
library(ggplot2)

#----------------------------------------------------------------------#
# Load data
#----------------------------------------------------------------------#

baseline <- readRDS(here("outputs", "models", "00_baseline_analytic.rds"))

# Build wide dataset with QIDS-C16 at T1-T4
qids_wide <- baseline %>%
  select(record_id, group, group_f) %>%
  left_join(
    readRDS(here("outputs", "models", "00_long_analytic.rds")) %>%
      select(record_id, time, qidsc16) %>%
      filter(!is.na(qidsc16)) %>%
      pivot_wider(
        id_cols = record_id,
        names_from = time,
        values_from = qidsc16,
        names_prefix = "qidsc16_t"
      ),
    by = "record_id"
  )

# Reshape to long
qids_long <- qids_wide %>%
  pivot_longer(
    cols = starts_with("qidsc16_t"),
    names_to = "time",
    values_to = "qidsc16"
  ) %>%
  mutate(
    time = as.integer(gsub("qidsc16_t", "", time)),
    time_f = factor(time, levels = c(1, 2, 3, 4), labels = c("T1", "T2", "T3", "T4"))
  ) %>%
  filter(!is.na(qidsc16))

#----------------------------------------------------------------------#
# Primary analysis: GEE with group x time interaction
#----------------------------------------------------------------------#

qids_fit <- geeglm(
  qidsc16 ~ group_f * time_f,
  id = record_id,
  family = gaussian,
  corstr = "ar1",
  std.err = "san.se",
  data = qids_long
)

summary(qids_fit)

# Marginal means
qids_emm <- emmeans(qids_fit, ~ group_f * time_f)
kable(qids_emm)

# Overall test of interaction
joint_tests(qids_emm)

# Pairwise contrasts at each timepoint, FDR adjusted
qids_contrasts <- contrast(
  qids_emm,
  method = "pairwise",
  by = "time_f",
  adjust = "fdr",
  infer = TRUE
)
kable(qids_contrasts)

# Primary contrast of interest: T3
qids_t3_contrast <- contrast(
  qids_emm,
  list(t3_diff = c(0, 0, -1, 1, 0, 0, 0, 0)),
  adjust = "fdr",
  infer = TRUE
)
kable(qids_t3_contrast)

# Effect size: Cohen's d at T3
qids_t3 <- as.data.frame(qids_emm) %>% filter(time_f == "T3")
d_qids_t3 <- (qids_t3$emmean[qids_t3$group_f == "Intervention"] -
              qids_t3$emmean[qids_t3$group_f == "Waitlist"]) /
             sd(qids_long$qidsc16, na.rm = TRUE)
cat("Cohen's d for QIDS-C16 at T3:", round(d_qids_t3, 3), "\n")

#----------------------------------------------------------------------#
# Plot marginal means
#----------------------------------------------------------------------#

qids_emm_df <- as.data.frame(qids_emm)

qids_plot <- ggplot(qids_emm_df, aes(x = time_f, y = emmean, color = group_f, group = group_f)) +
  geom_line(linewidth = 1, position = position_dodge(width = 0.2)) +
  geom_point(size = 4, position = position_dodge(width = 0.2)) +
  geom_errorbar(aes(ymin = lower.CL, ymax = upper.CL), width = 0.15, linewidth = 1,
                position = position_dodge(width = 0.2)) +
  scale_color_manual(values = c("Waitlist" = "#1b9e77", "Intervention" = "#d95f02")) +
  labs(
    title = "QIDS-C16 mean scores over time",
    x = "Timepoint",
    y = "QIDS-C16 total score",
    color = "Group"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
    legend.position = "right"
  )

qids_plot
ggsave(here("outputs", "figures", "10_qids_marginal_means.jpg"),
       width = 7, height = 5, dpi = 300)

#----------------------------------------------------------------------#
#----------------------------------------------------------------------#
# Save outputs
#----------------------------------------------------------------------#

saveRDS(qids_fit, here("outputs", "models", "10_qids_gee_fit.rds"))

# Contrasts table as CSV and HTML
qids_contrasts_df <- as.data.frame(qids_contrasts)
write_csv(qids_contrasts_df, here("outputs", "tables", "10_qids_contrasts.csv"))
qids_contrasts_df %>%
  knitr::kable(format = "html", caption = "QIDS-C16 pairwise contrasts by timepoint") %>%
  writeLines(here("outputs", "tables", "10_qids_contrasts.html"))

# Marginal means table as CSV and HTML
qids_emm_df_out <- as.data.frame(qids_emm)
write_csv(qids_emm_df_out, here("outputs", "tables", "10_qids_marginal_means.csv"))
qids_emm_df_out %>%
  knitr::kable(format = "html", caption = "QIDS-C16 estimated marginal means") %>%
  writeLines(here("outputs", "tables", "10_qids_marginal_means.html"))

# Model summary as HTML
qids_summary_df <- broom::tidy(qids_fit)
write_csv(qids_summary_df, here("outputs", "tables", "10_qids_model_summary.csv"))
qids_summary_df %>%
  knitr::kable(format = "html", caption = "QIDS-C16 GEE model summary") %>%
  writeLines(here("outputs", "tables", "10_qids_model_summary.html"))

#----------------------------------------------------------------------#
# End of script 10_primary-outcome.r
#----------------------------------------------------------------------#
