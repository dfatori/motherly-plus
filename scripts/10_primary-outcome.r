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

# QIDS-C16 is clinician-rated and only collected at T1 and T3.
# Build one row per participant with scores at both timepoints.
qids_wide <- baseline %>%
  select(record_id, group, group_f) %>%
  left_join(
    readRDS(here("outputs", "models", "00_long_analytic.rds")) %>%
      select(record_id, time, qidsc16) %>%
      filter(time %in% c(1, 3)) %>%
      pivot_wider(
        id_cols = record_id,
        names_from = time,
        values_from = qidsc16,
        names_prefix = "qidsc16_t"
      ),
    by = "record_id"
  )

# Convert to long format for repeated-measures GEE.
qids_long <- qids_wide %>%
  pivot_longer(
    cols = starts_with("qidsc16_t"),
    names_to = "time",
    values_to = "qidsc16"
  ) %>%
  mutate(
    time = as.integer(gsub("qidsc16_t", "", time)),
    time_f = factor(time, levels = c(1, 3), labels = c("T1", "T3"))
  )

#----------------------------------------------------------------------#
# Primary analysis: GEE with group x time interaction
# ITT: all randomized participants retained; GEE uses available data.
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

# Estimated marginal means and contrasts.
qids_emm <- emmeans(qids_fit, ~ group_f * time_f)
kable(qids_emm)

joint_tests(qids_emm)

# Pairwise group contrasts at each timepoint, FDR adjusted.
qids_contrasts <- contrast(
  qids_emm,
  method = "pairwise",
  by = "time_f",
  adjust = "fdr",
  infer = TRUE
)
kable(qids_contrasts)

# Primary contrast of interest: Intervention vs Waitlist at T3
qids_t3_contrast <- contrast(
  qids_emm,
  list(t3_diff = c(0, 0, -1, 1)),
  adjust = "fdr",
  infer = TRUE
)
kable(qids_t3_contrast)

# Cohen's d at T3 = mean difference / observed SD.
qids_t3 <- as.data.frame(qids_emm) %>% filter(time_f == "T3")
d_qids_t3 <- (qids_t3$emmean[qids_t3$group_f == "Intervention"] -
              qids_t3$emmean[qids_t3$group_f == "Waitlist"]) /
             sd(qids_long$qidsc16, na.rm = TRUE)
cat("Cohen's d for QIDS-C16 at T3:", round(d_qids_t3, 3), "\n")

#----------------------------------------------------------------------#
# Plot marginal means
#----------------------------------------------------------------------#

qids_emm_df <- as.data.frame(qids_emm)

# emmeans names the asymptotic CI columns differently across versions
# (asymp.LCL/asymp.UCL vs lower.CL/upper.CL); normalize for plotting.
if (all(c("asymp.LCL", "asymp.UCL") %in% names(qids_emm_df))) {
  qids_emm_df$conf_low <- qids_emm_df$asymp.LCL
  qids_emm_df$conf_high <- qids_emm_df$asymp.UCL
} else {
  qids_emm_df$conf_low <- qids_emm_df$lower.CL
  qids_emm_df$conf_high <- qids_emm_df$upper.CL
}

qids_plot <- ggplot(qids_emm_df, aes(x = time_f, y = emmean, color = group_f, group = group_f)) +
  geom_line(linewidth = 1, position = position_dodge(width = 0.2)) +
  geom_point(size = 4, position = position_dodge(width = 0.2)) +
  geom_errorbar(aes(ymin = conf_low, ymax = conf_high), width = 0.15, linewidth = 1,
                position = position_dodge(width = 0.2)) +
  scale_color_manual(values = c("Waitlist" = "#1b9e77", "Intervention" = "#d95f02")) +
  scale_x_discrete(drop = FALSE) +
  labs(
    title = "QIDS-C16 mean scores at baseline (T1) and post-treatment (T3)",
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
tryCatch(
  ggsave(here("outputs", "figures", "10_qids_marginal_means.png"),
         width = 7, height = 5, dpi = 300, device = "png"),
  error = function(e) {
    message("ggsave failed (likely graphics API mismatch): ", conditionMessage(e))
    message("Falling back to base png device.")
    png(here("outputs", "figures", "10_qids_marginal_means.png"),
        width = 7, height = 5, units = "in", res = 300)
    print(qids_plot)
    dev.off()
  }
)


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
