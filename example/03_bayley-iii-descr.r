#----------------------------------------------------------------------#
# Project: JG2 Efficacy
# Script: 03_bayley-iii-descr.r
# Script authors: daniel.fatori@gmail.com, ptotolo@ime.usp.br 
# Description: Description of Bayley-III outcomes
#----------------------------------------------------------------------#

#-------------------------------------------------------------------------------
# Cleaning Bayley-III outcomes
#-------------------------------------------------------------------------------

# Bayley assessments must have the following age patterns: 1 month before or after the expected age.
# - bayley 1 (3mo) must be between 2-4
# - bayley 2 (6mo) must be between 5-7
# - bayley 3 (12mo) must be between 11-13
# - bayley 4 (24mo) must be between 23-25

# Set scores to NA if age is out of valid range
jg2 <- jg2 %>%
  mutate(
    cog_total_bruto1 = ifelse(age1 < 2 | age1 > 4, NA, cog_total_bruto1),
    cog_total_bruto2 = ifelse(age2 < 5 | age2 > 7, NA, cog_total_bruto2),
    cog_total_bruto3 = ifelse(age3 < 11 | age3 > 13, NA, cog_total_bruto3),
    cog_total_bruto4 = ifelse(age4 < 23 | age4 > 25, NA, cog_total_bruto4),

    ling_rec_total_bruto1 = ifelse(age1 < 2 | age1 > 4, NA, ling_rec_total_bruto1),
    ling_rec_total_bruto2 = ifelse(age2 < 5 | age2 > 7, NA, ling_rec_total_bruto2),
    ling_rec_total_bruto3 = ifelse(age3 < 11 | age3 > 13, NA, ling_rec_total_bruto3),
    ling_rec_total_bruto4 = ifelse(age4 < 23 | age4 > 25, NA, ling_rec_total_bruto4),

    ling_exp_total_bruto1 = ifelse(age1 < 2 | age1 > 4, NA, ling_exp_total_bruto1),
    ling_exp_total_bruto2 = ifelse(age2 < 5 | age2 > 7, NA, ling_exp_total_bruto2),
    ling_exp_total_bruto3 = ifelse(age3 < 11 | age3 > 13, NA, ling_exp_total_bruto3),
    ling_exp_total_bruto4 = ifelse(age4 < 23 | age4 > 25, NA, ling_exp_total_bruto4),

    mot_fino_total_bruto1 = ifelse(age1 < 2 | age1 > 4, NA, mot_fino_total_bruto1),
    mot_fino_total_bruto2 = ifelse(age2 < 5 | age2 > 7, NA, mot_fino_total_bruto2),
    mot_fino_total_bruto3 = ifelse(age3 < 11 | age3 > 13, NA, mot_fino_total_bruto3),
    mot_fino_total_bruto4 = ifelse(age4 < 23 | age4 > 25, NA, mot_fino_total_bruto4),

    mot_gros_total_bruto1 = ifelse(age1 < 2 | age1 > 4, NA, mot_gros_total_bruto1),
    mot_gros_total_bruto2 = ifelse(age2 < 5 | age2 > 7, NA, mot_gros_total_bruto2),
    mot_gros_total_bruto3 = ifelse(age3 < 11 | age3 > 13, NA, mot_gros_total_bruto3),
    mot_gros_total_bruto4 = ifelse(age4 < 23 | age4 > 25, NA, mot_gros_total_bruto4)
  )

#-------------------------------------------------------------------------------
# Descrption of Bayley-III outcomes
#-------------------------------------------------------------------------------

# Bayley-III description by timepoint

jg2_bayley_table <- jg2 %>%
  select(
    cog_total_bruto1, cog_total_bruto2, cog_total_bruto3, cog_total_bruto4,
    ling_rec_total_bruto1, ling_rec_total_bruto2, ling_rec_total_bruto3, ling_rec_total_bruto4,
    ling_exp_total_bruto1, ling_exp_total_bruto2, ling_exp_total_bruto3, ling_exp_total_bruto4,
    mot_fino_total_bruto1, mot_fino_total_bruto2, mot_fino_total_bruto3, mot_fino_total_bruto4,
    mot_gros_total_bruto1, mot_gros_total_bruto2, mot_gros_total_bruto3, mot_gros_total_bruto4
  ) %>%
  tbl_summary(
    type = everything() ~ "continuous",
    statistic = all_continuous() ~ "{mean} ({sd}) [{min}, {max}]",
    digits = all_continuous() ~ 2,
    label = list(
      cog_total_bruto1 = "Cognition at T1",
      cog_total_bruto2 = "Cognition at T2",
      cog_total_bruto3 = "Cognition at T3",
      cog_total_bruto4 = "Cognition at T4",
      ling_rec_total_bruto1 = "Receptive Language at T1",
      ling_rec_total_bruto2 = "Receptive Language at T2",
      ling_rec_total_bruto3 = "Receptive Language at T3",
      ling_rec_total_bruto4 = "Receptive Language at T4",
      ling_exp_total_bruto1 = "Expressive Language at T1",
      ling_exp_total_bruto2 = "Expressive Language at T2",
      ling_exp_total_bruto3 = "Expressive Language at T3",
      ling_exp_total_bruto4 = "Expressive Language at T4",
      mot_fino_total_bruto1 = "Fine Motor at T1",
      mot_fino_total_bruto2 = "Fine Motor at T2",
      mot_fino_total_bruto3 = "Fine Motor at T3",
      mot_fino_total_bruto4 = "Fine Motor at T4",
      mot_gros_total_bruto1 = "Gross Motor at T1",
      mot_gros_total_bruto2 = "Gross Motor at T2",
      mot_gros_total_bruto3 = "Gross Motor at T3",
      mot_gros_total_bruto4 = "Gross Motor at T4"
    ),
    missing_text = "Missing"
  ) %>%
  modify_header(label ~ "**Bayley-III, Timepoint**", 
    stat_0 ~ "**Mean (SD) [Min, Max]**", 
    all_stat_cols() ~ "**Mean (SD) [Min, Max]**")

gt::gtsave(as_gt(jg2_bayley_table), filename = "outputs/jg2_bayley_table.html")
gt::gtsave(as_gt(jg2_bayley_table), filename = "outputs/jg2_bayley_table.docx")
# gt::gtsave(as_gt(jg2_bayley_table), filename = "outputs/jg2_bayley_table.pdf")

print(jg2_bayley_table)

#-------------------------------------------------------------------------------
# Histogram Plots of Bayley-III Outcomes
#-------------------------------------------------------------------------------

# Histogram for Cognition variables
plot_cog <- jg2 %>%
  select(cog_total_bruto1, cog_total_bruto2, cog_total_bruto3, cog_total_bruto4) %>%
  pivot_longer(everything(), names_to = "variable", values_to = "value") %>%
  ggplot(aes(x = value, fill = variable)) +
  geom_histogram(position = "dodge", bins = 20, color = "black") +
  facet_wrap(~variable, scales = "free") +
  labs(x = "Score", y = "Count", title = "Distribution of Cognition Scores by Timepoint") +
  theme_minimal()

ggsave("outputs/hist_cognition.jpg", plot_cog, width = 8, height = 5)

# Histogram for Receptive Language variables
plot_rec <- jg2 %>%
  select(ling_rec_total_bruto1, ling_rec_total_bruto2, ling_rec_total_bruto3, ling_rec_total_bruto4) %>%
  pivot_longer(everything(), names_to = "variable", values_to = "value") %>%
  ggplot(aes(x = value, fill = variable)) +
  geom_histogram(position = "dodge", bins = 20, color = "black") +
  facet_wrap(~variable, scales = "free") +
  labs(x = "Score", y = "Count", title = "Distribution of Receptive Language Scores by Timepoint") +
  theme_minimal()

ggsave("outputs/hist_receptive_language.jpg", plot_rec, width = 8, height = 5)

# Histogram for Expressive Language variables
plot_exp <- jg2 %>%
  select(ling_exp_total_bruto1, ling_exp_total_bruto2, ling_exp_total_bruto3, ling_exp_total_bruto4) %>%
  pivot_longer(everything(), names_to = "variable", values_to = "value") %>%
  ggplot(aes(x = value, fill = variable)) +
  geom_histogram(position = "dodge", bins = 20, color = "black") +
  facet_wrap(~variable, scales = "free") +
  labs(x = "Score", y = "Count", title = "Distribution of Expressive Language Scores by Timepoint") +
  theme_minimal()

ggsave("outputs/hist_expressive_language.jpg", plot_exp, width = 8, height = 5)

# Histogram for Fine Motor variables
plot_fino <- jg2 %>%
  select(mot_fino_total_bruto1, mot_fino_total_bruto2, mot_fino_total_bruto3, mot_fino_total_bruto4) %>%
  pivot_longer(everything(), names_to = "variable", values_to = "value") %>%
  ggplot(aes(x = value, fill = variable)) +
  geom_histogram(position = "dodge", bins = 20, color = "black") +
  facet_wrap(~variable, scales = "free") +
  labs(x = "Score", y = "Count", title = "Distribution of Fine Motor Scores by Timepoint") +
  theme_minimal()

ggsave("outputs/hist_fine_motor.jpg", plot_fino, width = 8, height = 5)

# Histogram for Gross Motor variables
plot_gros <- jg2 %>%
  select(mot_gros_total_bruto1, mot_gros_total_bruto2, mot_gros_total_bruto3, mot_gros_total_bruto4) %>%
  pivot_longer(everything(), names_to = "variable", values_to = "value") %>%
  ggplot(aes(x = value, fill = variable)) +
  geom_histogram(position = "dodge", bins = 20, color = "black") +
  facet_wrap(~variable, scales = "free") +
  labs(x = "Score", y = "Count", title = "Distribution of Gross Motor Scores by Timepoint") +
  theme_minimal()

ggsave("outputs/hist_gross_motor.jpg", plot_gros, width = 8, height = 5)

#-------------------------------------------------------------------------------
# Individual trajectories of Bayley-III variables
#-------------------------------------------------------------------------------

# Individual trajectories for Cognition variables
jg2 %>%
  select(record_id, cog_total_bruto1, cog_total_bruto2, cog_total_bruto3, cog_total_bruto4) %>%
  pivot_longer(
    cols = starts_with("cog_total_bruto"),
    names_to = "timepoint",
    values_to = "score") %>%
  mutate(time = as.integer(gsub("cog_total_bruto", "", timepoint))) %>%
  ggplot(aes(x = time, y = score, group = record_id)) +
  geom_line(alpha = 0.3) +
  geom_point(alpha = 0.3, size = 3.5) +
  scale_x_continuous(breaks = 1:4, labels = c("T1", "T2", "T3", "T4")) +
  labs(x = "Timepoint", y = "Cognition Score", title = "Individual Trajectories: Cognition Scores") +
  theme_minimal()

# Individual trajectories for Receptive Language variables
jg2 %>%
  select(record_id, ling_rec_total_bruto1, ling_rec_total_bruto2, ling_rec_total_bruto3, ling_rec_total_bruto4) %>%
  pivot_longer(
    cols = starts_with("ling_rec_total_bruto"),
    names_to = "timepoint",
    values_to = "score") %>%
  mutate(time = as.integer(gsub("ling_rec_total_bruto", "", timepoint))) %>%
  ggplot(aes(x = time, y = score, group = record_id)) +
  geom_line(alpha = 0.3) +
  geom_point(alpha = 0.3, size = 3.5) +
  scale_x_continuous(breaks = 1:4, labels = c("T1", "T2", "T3", "T4")) +
  labs(x = "Timepoint", y = "Receptive Language Score", title = "Individual Trajectories: Receptive Language Scores") +
  theme_minimal()

# Individual trajectories for Expressive Language variables
jg2 %>%
  select(record_id, ling_exp_total_bruto1, ling_exp_total_bruto2, ling_exp_total_bruto3, ling_exp_total_bruto4) %>%
  pivot_longer(
    cols = starts_with("ling_exp_total_bruto"),
    names_to = "timepoint",
    values_to = "score") %>%
  mutate(time = as.integer(gsub("ling_exp_total_bruto", "", timepoint))) %>%
  ggplot(aes(x = time, y = score, group = record_id)) +
  geom_line(alpha = 0.3) +
  geom_point(alpha = 0.3, size = 3.5) +
  scale_x_continuous(breaks = 1:4, labels = c("T1", "T2", "T3", "T4")) +
  labs(x = "Timepoint", y = "Expressive Language Score", title = "Individual Trajectories: Expressive Language Scores") +
  theme_minimal()

# Individual trajectories for Fine Motor variables
jg2 %>%
  select(record_id, mot_fino_total_bruto1, mot_fino_total_bruto2, mot_fino_total_bruto3, mot_fino_total_bruto4) %>%
  pivot_longer(
    cols = starts_with("mot_fino_total_bruto"),
    names_to = "timepoint",
    values_to = "score") %>%
  mutate(time = as.integer(gsub("mot_fino_total_bruto", "", timepoint))) %>%
  ggplot(aes(x = time, y = score, group = record_id)) +
  geom_line(alpha = 0.3) +
  geom_point(alpha = 0.3, size = 3.5) +
  scale_x_continuous(breaks = 1:4, labels = c("T1", "T2", "T3", "T4")) +
  labs(x = "Timepoint", y = "Fine Motor Score", title = "Individual Trajectories: Fine Motor Scores") +
  theme_minimal()

# Individual trajectories for Gross Motor variables
jg2 %>%
  select(record_id, mot_gros_total_bruto1, mot_gros_total_bruto2, mot_gros_total_bruto3, mot_gros_total_bruto4) %>%
  pivot_longer(
    cols = starts_with("mot_gros_total_bruto"),
    names_to = "timepoint",
    values_to = "score") %>%
  mutate(time = as.integer(gsub("mot_gros_total_bruto", "", timepoint))) %>%
  ggplot(aes(x = time, y = score, group = record_id)) +
  geom_line(alpha = 0.3) +
  geom_point(alpha = 0.3, size = 3.5) +
  scale_x_continuous(breaks = 1:4, labels = c("T1", "T2", "T3", "T4")) +
  labs(x = "Timepoint", y = "Gross Motor Score", title = "Individual Trajectories: Gross Motor Scores") +
  theme_minimal()

#----------------------------------------------------------------------#
# End of script 
#----------------------------------------------------------------------#
