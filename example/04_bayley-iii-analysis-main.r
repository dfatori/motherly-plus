#----------------------------------------------------------------------#
# Project: JG2 Efficacy
# Script: 04_bayley-iii-analysis-main.r
# Script authors: daniel.fatori@gmail.com, ptotolo@ime.usp.br 
# Description: Intervention effects on Bayley-III outcomes
#----------------------------------------------------------------------#

#######################################
# Randomization status variable: t0_i03
    # Controle (1)
    # Intervencao (2)
#######################################

#######################################
# Timepoints
# - T1= 3mo
# - T2= 6mo
# - T3= 12mo
# - T4= 24mo
#######################################

#-------------------------------------------------------------------------------
# Contrasts for intervention-control testing at each timepoint
#-------------------------------------------------------------------------------

contrasts_list <- list(
  # Contrast for Time 1: Treatment vs. Control
  time1_diff = c(-1, 1, 0, 0, 0, 0, 0, 0),
  
  # Contrast for Time 2: Treatment vs. Control
  time2_diff = c(0, 0, -1, 1, 0, 0, 0, 0),
  
  # Contrast for Time 3: Treatment vs. Control
  time3_diff = c(0, 0, 0, 0, -1, 1, 0, 0),
  
  # Contrast for Time 4: Treatment vs. Control
  time4_diff = c(0, 0, 0, 0, 0, 0, -1, 1)
)

#-------------------------------------------------------------------------------
# Reshape wide to long (preparing for GEE models)
#-------------------------------------------------------------------------------

# Select only the variables needed for reshape
jg2_for_long <- jg2 %>%
  select(record_id,
    t0_i03, visitas_por_mes_t1, visitas_por_mes_t2, visitas_por_mes_t3,
    visitas_por_mes_t4,
    visitas_por_mes_t1_nq3, visitas_por_mes_t2_nq3, visitas_por_mes_t3_nq3,
    visitas_por_mes_t4_nq3,
    cog_total_bruto1, cog_total_bruto2, cog_total_bruto3, cog_total_bruto4,
    ling_rec_total_bruto1, ling_rec_total_bruto2, ling_rec_total_bruto3, ling_rec_total_bruto4,
    ling_exp_total_bruto1, ling_exp_total_bruto2, ling_exp_total_bruto3, ling_exp_total_bruto4,
    mot_fino_total_bruto1, mot_fino_total_bruto2, mot_fino_total_bruto3, mot_fino_total_bruto4,
    mot_gros_total_bruto1, mot_gros_total_bruto2, mot_gros_total_bruto3, mot_gros_total_bruto4
)

jg2_bayley_long <- reshape(
  jg2_for_long,
  varying = list(
    cog_total_bruto = paste0("cog_total_bruto", 1:4),
    ling_rec_total_bruto = paste0("ling_rec_total_bruto", 1:4),
    ling_exp_total_bruto = paste0("ling_exp_total_bruto", 1:4),
    mot_fino_total_bruto = paste0("mot_fino_total_bruto", 1:4),
    mot_gros_total_bruto = paste0("mot_gros_total_bruto", 1:4),
    visitas_por_mes = paste0("visitas_por_mes_t", 1:4),
    visitas_por_mes_nq3 = paste0("visitas_por_mes_t", 1:4, "_nq3")
  ),
  v.names = c("cog_total_bruto", "ling_rec_total_bruto", "ling_exp_total_bruto", "mot_fino_total_bruto", "mot_gros_total_bruto", "visitas_por_mes", "visitas_por_mes_nq3"),
  timevar = "time",
  idvar = "record_id",
  direction = "long"
)

glimpse(jg2_bayley_long)

#-------------------------------------------------------------------------------
# Bayley Cognition
#-------------------------------------------------------------------------------

cog <- geepack::geeglm(
  cog_total_bruto ~ factor(t0_i03) * factor(time),
  id = record_id,
  family = gaussian,
  corstr = "ar1",
  std.err = "san.se",
  data = jg2_bayley_long
)

summary(cog)
length(unique(cog$id))
table(jg2_bayley_long$t0_i03[unique(cog$id)])

# Estimate marginal means
cog_emm <- emmeans(cog, ~ factor(t0_i03) * factor(time))
kable(cog_emm)

# Test if treatment effect varies over time, i.e. interaction is significant 
joint_tests(cog_emm)

# Test at which time treatment effect is significant
cog_emm_contrast <- contrast(cog_emm, 
                              contrasts_list, 
                              adjust = "fdr", 
                              infer = TRUE)

kable(cog_emm_contrast)

# Plot marginal means

time_labels <- c("1" = "3 months", "2" = "6 months", "3" = "12 months", "4" = "24 months")

cog_emm_df <- as.data.frame(cog_emm)
cog_emm_df

plot_cog_emm <- ggplot(cog_emm_df, aes(x = as.factor(time), y = emmean, color = as.factor(t0_i03), group = t0_i03)) +
  geom_line(size = 1, position = position_dodge(width = 0.2)) +
  geom_point(size = 4, position = position_dodge(width = 0.2)) +
  geom_errorbar(aes(ymin = lower.CL, ymax = upper.CL), width = 0.15, size = 1, position = position_dodge(width = 0.2)) +
  scale_x_discrete(
    labels = c("1" = "3 months", "2" = "6 months", "3" = "12 months", "4" = "24 months")
  ) +
  scale_color_manual(
    name = "",
    values = c("1" = "#1b9e77", "2" = "#d95f02"),
    labels = c("1" = "Control", "2" = "Intervention")
  ) +
  labs(
    title = "",
    x = "Timepoint",
    y = expression(bold("Bayley-III Cognition Raw Score"))
  ) +
  theme_minimal(base_size = 14) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
    legend.position = "right",
    legend.text = element_text(size = 12)
  )

plot_cog_emm

ggsave("outputs/marginsplot_cog.jpg", width = 7, height = 5, dpi = 300)

#-------------------------------------------------------------------------------
# Bayley Receptive Language
#-------------------------------------------------------------------------------

ling_rec <- geepack::geeglm(
  ling_rec_total_bruto ~ factor(t0_i03) * factor(time),
  id = record_id,
  family = gaussian,
  corstr = "ar1",
  std.err = "san.se",
  data = jg2_bayley_long,
)

summary(ling_rec)
length(unique(ling_rec$id))
table(jg2_bayley_long$t0_i03[unique(ling_rec$id)])

# Estimate marginal means
ling_rec_emm <- emmeans(ling_rec, ~ factor(t0_i03) * factor(time))

# Test if treatment effect varies over time, i.e. interaction is significant 
joint_tests(ling_rec_emm)

# Test at which time treatment effect is significant
ling_rec_emm_contrast <- contrast(ling_rec_emm, contrasts_list, 
                              adjust = "fdr", 
                              infer = TRUE)

kable(ling_rec_emm)
kable(ling_rec_emm_contrast)

plot_ling_rec_emm <- ggplot(as.data.frame(ling_rec_emm), aes(x = as.factor(time), y = emmean, color = as.factor(t0_i03), group = t0_i03)) +
  geom_line(size = 1, position = position_dodge(width = 0.2)) +
  geom_point(size = 4, position = position_dodge(width = 0.2)) +
  geom_errorbar(aes(ymin = lower.CL, ymax = upper.CL), width = 0.15, size = 1, position = position_dodge(width = 0.2)) +
  scale_x_discrete(labels = c("1" = "3 months", "2" = "6 months", "3" = "12 months", "4" = "24 months")) +
  scale_color_manual(
    name = "",
    values = c("1" = "#1b9e77", "2" = "#d95f02"),
    labels = c("1" = "Control", "2" = "Intervention")
  ) +
  labs(
    title = "",
    x = "Timepoint",
    y = expression(bold("Bayley-III Receptive Language Raw Score"))
  ) +
  theme_minimal(base_size = 14) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
    legend.position = "right",
    legend.text = element_text(size = 12)
  )

plot_ling_rec_emm

ggsave("outputs/marginsplot_ling_rec.jpg", width = 7, height = 5, dpi = 300)

#-------------------------------------------------------------------------------
# Bayley Expressive Language
#-------------------------------------------------------------------------------

ling_exp <- geepack::geeglm(
  ling_exp_total_bruto ~ factor(t0_i03) * factor(time),
  id = record_id,
  family = gaussian,
  corstr = "ar1",
  std.err = "san.se",
  data = jg2_bayley_long,
)

summary(ling_exp)
length(unique(ling_exp$id))
table(jg2_bayley_long$t0_i03[unique(ling_exp$id)])

# Estimate marginal means
ling_exp_emm <- emmeans(ling_exp, ~ factor(t0_i03) * factor(time))

# Test if treatment effect varies over time, i.e. interaction is significant 
joint_tests(ling_exp_emm) # not signficant

# Test at which time treatment effect is significant
contrast(ling_exp_emm, contrasts_list, adjust = "fdr") # T1 significant

# Test at which time treatment effect is significant
ling_exp_emm_contrast <- contrast(ling_exp_emm, contrasts_list, 
                              adjust = "fdr", 
                              infer = TRUE)

kable(ling_exp_emm)
kable(ling_exp_emm_contrast)

plot_ling_exp_emm <- ggplot(as.data.frame(ling_exp_emm), aes(x = as.factor(time), y = emmean, color = as.factor(t0_i03), group = t0_i03)) +
  geom_line(size = 1, position = position_dodge(width = 0.2)) +
  geom_point(size = 4, position = position_dodge(width = 0.2)) +
  geom_errorbar(aes(ymin = lower.CL, ymax = upper.CL), width = 0.15, size = 1, position = position_dodge(width = 0.2)) +
  scale_x_discrete(labels = c("1" = "3 months", "2" = "6 months", "3" = "12 months", "4" = "24 months")) +
  scale_color_manual(
    name = "",
    values = c("1" = "#1b9e77", "2" = "#d95f02"),
    labels = c("1" = "Control", "2" = "Intervention")
  ) +
  labs(
    title = "",
    x = "Timepoint",
    y = expression(bold("Bayley-III Expressive Language Raw Score"))
  ) +
  theme_minimal(base_size = 14) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
    legend.position = "right",
    legend.text = element_text(size = 12)
  )

plot_ling_exp_emm

ggsave("outputs/marginsplot_ling_exp.jpg", width = 7, height = 5, dpi = 300)

#-------------------------------------------------------------------------------
# Bayley Fine Motor
#-------------------------------------------------------------------------------

mot_fino <- geepack::geeglm(
  mot_fino_total_bruto ~ factor(t0_i03) * factor(time),
  id = record_id,
  family = gaussian,
  corstr = "ar1",
  std.err = "san.se",
  data = jg2_bayley_long,
)

summary(mot_fino)
length(unique(mot_fino$id))
table(jg2_bayley_long$t0_i03[unique(mot_fino$id)])

# Estimate marginal means
mot_fino_emm <- emmeans(mot_fino, ~ factor(t0_i03) * factor(time))

# Test if treatment effect varies over time, i.e. interaction is significant 
joint_tests(mot_fino_emm) # signficant

# Test at which time treatment effect is significant
contrast(mot_fino_emm, contrasts_list, adjust = "none") # no difference

# Test at which time treatment effect is significant
mot_fino_emm_contrast <- contrast(mot_fino_emm, contrasts_list, 
                              adjust = "fdr", 
                              infer = TRUE)

kable(mot_fino_emm)
kable(mot_fino_emm_contrast)

plot_mot_fino_emm <- ggplot(as.data.frame(mot_fino_emm), aes(x = as.factor(time), y = emmean, color = as.factor(t0_i03), group = t0_i03)) +
  geom_line(size = 1, position = position_dodge(width = 0.2)) +
  geom_point(size = 4, position = position_dodge(width = 0.2)) +
  geom_errorbar(aes(ymin = lower.CL, ymax = upper.CL), width = 0.15, size = 1, position = position_dodge(width = 0.2)) +
  scale_x_discrete(labels = c("1" = "3 months", "2" = "6 months", "3" = "12 months", "4" = "24 months")) +
  scale_color_manual(
    name = "",
    values = c("1" = "#1b9e77", "2" = "#d95f02"),
    labels = c("1" = "Control", "2" = "Intervention")
  ) +
  labs(
    title = "",
    x = "Timepoint",
    y = expression(bold("Bayley-III Fine Motor Raw Score"))
  ) +
  theme_minimal(base_size = 14) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
    legend.position = "right",
    legend.text = element_text(size = 12)
  )

plot_mot_fino_emm

ggsave("outputs/marginsplot_mot_fino.jpg", width = 7, height = 5, dpi = 300)

#-------------------------------------------------------------------------------
# Bayley Gross Motor
#-------------------------------------------------------------------------------

mot_gros <- geepack::geeglm(
  mot_gros_total_bruto ~ factor(t0_i03) * factor(time),
  id = record_id,
  family = gaussian,
  corstr = "ar1",
  std.err = "san.se",
  data = jg2_bayley_long,
)

summary(mot_gros)
length(unique(mot_fino$id))
table(jg2_bayley_long$t0_i03[unique(mot_fino$id)])

# Estimate marginal means
mot_gros_emm <- emmeans(mot_gros, ~ factor(t0_i03) * factor(time))

# Test if treatment effect varies over time, i.e. interaction is significant 
joint_tests(mot_gros_emm) # not signficant

# Test at which time treatment effect is significant
mot_gros_emm_contrast <- contrast(mot_gros_emm, contrasts_list, 
                              adjust = "fdr", 
                              infer = TRUE)

kable(mot_gros_emm)
kable(mot_gros_emm_contrast)

plot_mot_gros_emm <- ggplot(as.data.frame(mot_gros_emm), aes(x = as.factor(time), y = emmean, color = as.factor(t0_i03), group = t0_i03)) +
  geom_line(size = 1, position = position_dodge(width = 0.2)) +
  geom_point(size = 4, position = position_dodge(width = 0.2)) +
  geom_errorbar(aes(ymin = lower.CL, ymax = upper.CL), width = 0.15, size = 1, position = position_dodge(width = 0.2)) +
  scale_x_discrete(labels = c("1" = "3 months", "2" = "6 months", "3" = "12 months", "4" = "24 months")) +
  scale_color_manual(
    name = "",
    values = c("1" = "#1b9e77", "2" = "#d95f02"),
    labels = c("1" = "Control", "2" = "Intervention")
  ) +
  labs(
    title = "",
    x = "Timepoint",
    y = expression(bold("Bayley-III Gross Motor Raw Score"))
  ) +
  theme_minimal(base_size = 14) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
    legend.position = "right",
    legend.text = element_text(size = 12)
  )

plot_mot_gros_emm

ggsave("outputs/marginsplot_mot_gros.jpg", width = 7, height = 5, dpi = 300)

#-------------------------------------------------------------------------------
# Bayley merged plots
#-------------------------------------------------------------------------------

combined_bayley_plot <- (
  (plot_cog_emm + labs(title = "Cognition", y = "Raw Score", x = "") + theme(legend.position = "none")) +
  (plot_ling_rec_emm + labs(title = "Receptive Language", y = "Raw Score", x = "") + theme(legend.position = "none")) +
  (plot_ling_exp_emm + labs(title = "Expressive Language", y = "Raw Score", x = "") + theme(legend.position = "none"))
) / (
  (plot_mot_fino_emm + labs(title = "Fine Motor", y = "Raw Score", x = "") + theme(legend.position = "none")) +
  (plot_mot_gros_emm + labs(title = "Gross Motor", y = "Raw Score", x = "") + theme(legend.position = "right")) +
  plot_spacer()
) + 
plot_annotation(title = "")

# Display and save
combined_bayley_plot

ggsave("outputs/bayley_combined_marginsplot.jpg", combined_bayley_plot, width = 15, height = 10, dpi = 300)

#----------------------------------------------------------------------#
# End of script
#----------------------------------------------------------------------#