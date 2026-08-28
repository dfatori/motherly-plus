#----------------------------------------------------------------------#
# Project: JG2 Efficacy
# Script: 09_cbcl-analysis-main.r
# Script authors: daniel.fatori@gmail.com, ptotolo@ime.usp.br
# Description: Intervention effects on CBCL outcomes
#----------------------------------------------------------------------#

#-------------------------------------------------------------------------------
# Contrasts for intervention-control testing at each timepoint
#-------------------------------------------------------------------------------

contrasts_list <- list(
  # Contrast for Time 1: Treatment vs. Control
  time1_diff = c(-1, 1, 0, 0, 0, 0),
  
  # Contrast for Time 2: Treatment vs. Control
  time2_diff = c(0, 0, -1, 1, 0, 0),
  
  # Contrast for Time 3: Treatment vs. Control
  time3_diff = c(0, 0, 0, 0, -1, 1)
)

#----------------------------------------------------------------------#
# Reshape wide to long (preparing for GEE models)
#----------------------------------------------------------------------#

# Select only the variables needed for CBCL reshape
jg2_cbcl_for_long <- jg2 %>%
  select(record_id, t0_i03, visitas_total, visitas_total_nq3,
         cbcl_prob_inter1, cbcl_prob_inter2, cbcl_prob_inter3,
         cbcl_prob_exter1, cbcl_prob_exter2, cbcl_prob_exter3,
         cbcl_total_prob1, cbcl_total_prob2, cbcl_total_prob3)

jg2_cbcl_long <- reshape(
  jg2_cbcl_for_long,
  varying = list(
    cbcl_prob_inter = paste0("cbcl_prob_inter", 1:3),
    cbcl_prob_exter = paste0("cbcl_prob_exter", 1:3),
    cbcl_total_prob = paste0("cbcl_total_prob", 1:3)
  ),
  v.names = c("cbcl_prob_inter", "cbcl_prob_exter", "cbcl_total_prob"),
  timevar = "time",
  idvar = "record_id",
  direction = "long"
)

glimpse(jg2_cbcl_long)

#----------------------------------------------------------------------#
# CBCL Internalizing
#----------------------------------------------------------------------#

cbcl_int <- geepack::geeglm(
  cbcl_prob_inter ~ factor(t0_i03) * factor(time),
  id = record_id,
  family = gaussian,
  corstr = "ar1",
  std.err = "san.se",
  data = jg2_cbcl_long,
)

summary(cbcl_int)
length(unique(cbcl_int$id))
table(jg2_cbcl_long$t0_i03[unique(cbcl_int$id)])

# Estimate marginal means
cbcl_int_emm <- emmeans(cbcl_int, ~ factor(t0_i03) * factor(time))

# Test if treatment effect varies over time, i.e. interaction is significant 
joint_tests(cbcl_int_emm)

kable(cbcl_int_emm)

cbcl_int_emm_contrast <- contrast(cbcl_int_emm, 
  contrasts_list, 
  adjust = "fdr", 
  infer = TRUE)

kable(cbcl_int_emm_contrast)

# Plot marginal means

time_labels <- c("1" = "12 months", "2" = "24 months", "3" = "48 months")

cbcl_int_emm_df <- as.data.frame(cbcl_int_emm)

ggplot(cbcl_int_emm_df, aes(x = as.factor(time), y = emmean, color = as.factor(t0_i03), group = t0_i03)) +
  geom_line(size = 1, position = position_dodge(width = 0.2)) +
  geom_point(size = 4, position = position_dodge(width = 0.2)) +
  geom_errorbar(aes(ymin = lower.CL, ymax = upper.CL), width = 0.15, size = 1, position = position_dodge(width = 0.2)) +
  scale_x_discrete(
    labels = c("1" = "12 months", "2" = "24 months", "3" = "48 months")
  ) +
  scale_color_manual(
    name = "",
    values = c("1" = "#1b9e77", "2" = "#d95f02"),
    labels = c("1" = "Control", "2" = "Intervention")
  ) +
  labs(
    title = "",
    x = "Timepoint",
    y = expression(bold("CBCL Internalizing Raw Score"))
  ) +
  theme_minimal(base_size = 14) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
    legend.position = "right",
    legend.text = element_text(size = 12)
  )

ggsave("outputs/marginsplot_cbcl_int.jpg", width = 7, height = 5, dpi = 300)

#----------------------------------------------------------------------#
# CBCL Externalizing
#----------------------------------------------------------------------#

cbcl_ext <- geepack::geeglm(
  cbcl_prob_exter ~ factor(t0_i03) * factor(time),
  id = record_id,
  family = gaussian,
  corstr = "ar1",
  std.err = "san.se",
  data = jg2_cbcl_long,
)

summary(cbcl_ext)

# Estimate marginal means
cbcl_ext_emm <- emmeans(cbcl_ext, ~ factor(t0_i03) * factor(time))

# Test if treatment effect varies over time, i.e. interaction is significant 
joint_tests(cbcl_ext_emm) # not signficant

kable(cbcl_ext_emm)

cbcl_ext_emm_contrast <- contrast(cbcl_ext_emm, contrasts_list, adjust = "fdr")

# Plot marginal means
cbcl_ext_emm_df <- as.data.frame(cbcl_ext_emm)

ggplot(cbcl_ext_emm_df, aes(x = as.factor(time), y = emmean, color = as.factor(t0_i03), group = t0_i03)) +
  geom_line(size = 1, position = position_dodge(width = 0.2)) +
  geom_point(size = 4, position = position_dodge(width = 0.2)) +
  geom_errorbar(aes(ymin = lower.CL, ymax = upper.CL), width = 0.15, size = 1, position = position_dodge(width = 0.2)) +
  scale_x_discrete(
    labels = c("1" = "12 months", "2" = "24 months", "3" = "48 months")
  ) +
  scale_color_manual(
    name = "",
    values = c("1" = "#1b9e77", "2" = "#d95f02"),
    labels = c("1" = "Control", "2" = "Intervention")
  ) +
  labs(
    title = "",
    x = "Timepoint",
    y = expression(bold("CBCL Externalizing Raw Score"))
  ) +
  theme_minimal(base_size = 14) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
    legend.position = "right",
    legend.text = element_text(size = 12)
  )

ggsave("outputs/marginsplot_cbcl_ext.jpg", width = 7, height = 5, dpi = 300)

#----------------------------------------------------------------------#
# CBCL Total problems
#----------------------------------------------------------------------#

cbcl_total <- geepack::geeglm(
  cbcl_total_prob ~ factor(t0_i03) * factor(time),
  id = record_id,
  family = gaussian,
  corstr = "ar1",
  std.err = "san.se",
  data = jg2_cbcl_long,
)

summary(cbcl_total)

# Estimate marginal means
cbcl_total_emm <- emmeans(cbcl_total, ~ factor(t0_i03) * factor(time))

# Test if treatment effect varies over time, i.e. interaction is significant 
joint_tests(cbcl_total_emm) # not signficant

kable(cbcl_total_emm)

cbcl_total_emm_contrast <- contrast(cbcl_total_emm, contrasts_list, adjust = "fdr")

# Plot marginal means
cbcl_total_emm_df <- as.data.frame(cbcl_total_emm)

ggplot(cbcl_total_emm_df, aes(x = as.factor(time), y = emmean, color = as.factor(t0_i03), group = t0_i03)) +
  geom_line(size = 1, position = position_dodge(width = 0.2)) +
  geom_point(size = 4, position = position_dodge(width = 0.2)) +
  geom_errorbar(aes(ymin = lower.CL, ymax = upper.CL), width = 0.15, size = 1, position = position_dodge(width = 0.2)) +
  scale_x_discrete(
    labels = c("1" = "12 months", "2" = "24 months", "3" = "48 months")
  ) +
  scale_color_manual(
    name = "",
    values = c("1" = "#1b9e77", "2" = "#d95f02"),
    labels = c("1" = "Control", "2" = "Intervention")
  ) +
  labs(
    title = "",
    x = "Timepoint",
    y = expression(bold("CBCL Total Problems Raw Score"))
  ) +
  theme_minimal(base_size = 14) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
    legend.position = "right",
    legend.text = element_text(size = 12)
  )

ggsave("outputs/marginsplot_cbcl_total.jpg", width = 7, height = 5, dpi = 300)

#----------------------------------------------------------------------#
# End of script 
#----------------------------------------------------------------------#