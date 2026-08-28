#----------------------------------------------------------------------#
# Project: JG2 Efficacy
# Script: 08_cbcl-descr.r
# Script authors: daniel.fatori@gmail.com, ptotolo@ime.usp.br
# Description: Description of CBCL scores
#----------------------------------------------------------------------#

###############################################################
# Prefix t4, t5 and t6 on CBCL variables means 12, 24 and 42mo
###############################################################

#----------------------------------------------------------------------#
# Generate CBCL scores: 12mo
#----------------------------------------------------------------------#

# General description of CBCL items at 12mo

skim_without_charts(jg2 %>% select(starts_with("t4_cbcl")))

# Generate CBCL syndrome scale variables
jg2 <- jg2 %>%
  mutate(
    t4_cbcl_reat_emoc = t4_cbcl_21 + t4_cbcl_46 + t4_cbcl_51 + t4_cbcl_79 + t4_cbcl_82 + t4_cbcl_92 + t4_cbcl_97 + t4_cbcl_99,
    t4_cbcl_ans_dep = t4_cbcl_10 + t4_cbcl_33 + t4_cbcl_37 + t4_cbcl_43 + t4_cbcl_68 + t4_cbcl_87 + t4_cbcl_90,
    t4_cbcl_comp_som = t4_cbcl_7 + t4_cbcl_12 + t4_cbcl_19 + t4_cbcl_24 + t4_cbcl_39 + t4_cbcl_45 + t4_cbcl_78 + t4_cbcl_80 + t4_cbcl_86 + t4_cbcl_93,
    t4_cbcl_retraim = t4_cbcl_2 + t4_cbcl_14 + t4_cbcl_29 + t4_cbcl_62 + t4_cbcl_70 + t4_cbcl_71 + t4_cbcl_98,
    t4_cbcl_prob_sono = t4_cbcl_22 + t4_cbcl_38 + t4_cbcl_48 + t4_cbcl_67 + t4_cbcl_74 + t4_cbcl_84 + t4_cbcl_94,
    t4_cbcl_prob_aten = t4_cbcl_5 + t4_cbcl_6 + t4_cbcl_13 + t4_cbcl_26 + t4_cbcl_56 + t4_cbcl_59 + t4_cbcl_95,
    t4_cbcl_comport_agres = t4_cbcl_3 + t4_cbcl_8 + t4_cbcl_15 + t4_cbcl_16 + t4_cbcl_18 + t4_cbcl_20 + t4_cbcl_27 + t4_cbcl_35 + 
    t4_cbcl_42 + t4_cbcl_44 + t4_cbcl_53 + t4_cbcl_58 + t4_cbcl_69 + t4_cbcl_81 + t4_cbcl_83 + t4_cbcl_88 + t4_cbcl_96
  )

# Generate CBCL composite variables
jg2 <- jg2 %>%
  mutate(
    t4_cbcl_prob_inter = t4_cbcl_reat_emoc + t4_cbcl_ans_dep + t4_cbcl_comp_som + t4_cbcl_retraim,
    t4_cbcl_prob_exter = t4_cbcl_comport_agres + t4_cbcl_prob_aten,
    t4_cbcl_total_prob = rowSums(select(., paste0("t4_cbcl_", 1:99)), na.rm = FALSE)
  )

skim_without_charts(jg2 %>% select(
  t4_cbcl_reat_emoc,
  t4_cbcl_ans_dep,
  t4_cbcl_comp_som,
  t4_cbcl_retraim,
  t4_cbcl_prob_sono,
  t4_cbcl_prob_aten,
  t4_cbcl_comport_agres,
  t4_cbcl_prob_inter,
  t4_cbcl_prob_exter,
  t4_cbcl_total_prob
))

#----------------------------------------------------------------------#
# Generate CBCL scores: 24mo
#----------------------------------------------------------------------#

# General description of CBCL items at 24mo

skim_without_charts(jg2 %>% select(starts_with("t5_cbcl")))

# * Missing values in items t5_cbcl7, t5_cbcl10, t5_cbcl65, t5_cbcl77, t5_cbcl95, t5_cbcl101

# Imputing items with means of respective items:
vars <- c("t5_cbcl4", "t5_cbcl7", "t5_cbcl10", "t5_cbcl65", "t5_cbcl77", "t5_cbcl95")

for (v in vars) {
  # Calculate mean for the variable among record_id 80 or 40 (excluding NAs)
  m <- mean(jg2[[v]][jg2$record_id %in% c(80, 40)], na.rm = TRUE)
  # Impute missing values for those record_ids only
  jg2[[v]] <- ifelse(
    is.na(jg2[[v]]) & jg2$record_id %in% c(80, 40),
    m,
    jg2[[v]]
  )
}

# Generate CBCL syndrome scale variables
jg2 <- jg2 %>%
  mutate(
    t5_cbcl_reat_emoc = t5_cbcl21 + t5_cbcl46 + t5_cbcl51 + t5_cbcl79 + t5_cbcl82 + t5_cbcl92 + t5_cbcl97 + t5_cbcl99,
    t5_cbcl_ans_dep = t5_cbcl10 + t5_cbcl33 + t5_cbcl37 + t5_cbcl43 + t5_cbcl68 + t5_cbcl87 + t5_cbcl90,
    t5_cbcl_comp_som = t5_cbcl7 + t5_cbcl12 + t5_cbcl19 + t5_cbcl24 + t5_cbcl39 + t5_cbcl45 + t5_cbcl78 + t5_cbcl80 + t5_cbcl86 + t5_cbcl93,
    t5_cbcl_retraim = t5_cbcl2 + t5_cbcl14 + t5_cbcl29 + t5_cbcl62 + t5_cbcl70 + t5_cbcl71 + t5_cbcl98,
    t5_cbcl_prob_sono = t5_cbcl22 + t5_cbcl38 + t5_cbcl48 + t5_cbcl67 + t5_cbcl74 + t5_cbcl84 + t5_cbcl94,
    t5_cbcl_prob_aten = t5_cbcl5 + t5_cbcl6 + t5_cbcl13 + t5_cbcl26 + t5_cbcl56 + t5_cbcl59 + t5_cbcl95,
    t5_cbcl_comport_agres = t5_cbcl3 + t5_cbcl8 + t5_cbcl15 + t5_cbcl16 + t5_cbcl18 + t5_cbcl20 + t5_cbcl27 + 
      t5_cbcl35 + t5_cbcl42 + t5_cbcl44 + t5_cbcl53 + t5_cbcl58 + t5_cbcl69 + t5_cbcl81 + t5_cbcl83 + t5_cbcl88 + t5_cbcl96
  )

# Generate CBCL composite variables
jg2 <- jg2 %>%
  mutate(
    t5_cbcl_prob_inter = t5_cbcl_reat_emoc + t5_cbcl_ans_dep + t5_cbcl_comp_som + t5_cbcl_retraim,
    t5_cbcl_prob_exter = t5_cbcl_comport_agres + t5_cbcl_prob_aten,
    t5_cbcl_total_prob = rowSums(select(., paste0("t5_cbcl", 1:99)), na.rm = FALSE)
  )

#----------------------------------------------------------------------#
# Generate CBCL scores: 42mo
#----------------------------------------------------------------------#

# General description of CBCL items at 42mo

skim_without_charts(jg2 %>% select(starts_with("t6_cbcl")))

# Remove suffix _42 from variables t6_cbcl
names(jg2) <- ifelse(grepl('^t6_cbcl.*_42$', names(jg2)), sub('_42$', '', names(jg2)), names(jg2))

# Generate CBCL syndrome scale variables

jg2 <- jg2 %>%
  mutate(
    t6_cbcl_reat_emoc = t6_cbcl21 + t6_cbcl46 + t6_cbcl51 + t6_cbcl79 + t6_cbcl82 + t6_cbcl92 + t6_cbcl97 + t6_cbcl99,
    t6_cbcl_ans_dep = t6_cbcl10 + t6_cbcl33 + t6_cbcl37 + t6_cbcl43 + t6_cbcl68 + t6_cbcl87 + t6_cbcl90,
    t6_cbcl_comp_som = t6_cbcl7 + t6_cbcl12 + t6_cbcl19 + t6_cbcl24 + t6_cbcl39 + t6_cbcl45 + t6_cbcl78 + t6_cbcl80 + t6_cbcl86 + t6_cbcl93,
    t6_cbcl_retraim = t6_cbcl2 + t6_cbcl14 + t6_cbcl29 + t6_cbcl62 + t6_cbcl70 + t6_cbcl71 + t6_cbcl98,
    t6_cbcl_prob_sono = t6_cbcl22 + t6_cbcl38 + t6_cbcl48 + t6_cbcl67 + t6_cbcl74 + t6_cbcl84 + t6_cbcl94,
    t6_cbcl_prob_aten = t6_cbcl5 + t6_cbcl6 + t6_cbcl13 + t6_cbcl26 + t6_cbcl56 + t6_cbcl59 + t6_cbcl95,
    t6_cbcl_comport_agres = t6_cbcl3 + t6_cbcl8 + t6_cbcl15 + t6_cbcl16 + t6_cbcl18 + t6_cbcl20 + t6_cbcl27 + t6_cbcl35 + t6_cbcl42 + t6_cbcl44 + t6_cbcl53 + t6_cbcl58 + t6_cbcl69 + t6_cbcl81 + t6_cbcl83 + t6_cbcl88 + t6_cbcl96
  )

# Generate CBCL composite variables
jg2 <- jg2 %>%
  mutate(
    t6_cbcl_prob_inter = t6_cbcl_reat_emoc + t6_cbcl_ans_dep + t6_cbcl_comp_som + t6_cbcl_retraim,
    t6_cbcl_prob_exter = t6_cbcl_comport_agres + t6_cbcl_prob_aten,
    t6_cbcl_total_prob = rowSums(select(., paste0("t6_cbcl", 1:99)), na.rm = FALSE)
  )

#----------------------------------------------------------------------#
# Description of CBCL scores: 12mo
#----------------------------------------------------------------------#

# Count number of valid (non-missing) observations for each CBCL outcome

skim(jg2 %>% select(
  t4_cbcl_reat_emoc,
  t4_cbcl_ans_dep,
  t4_cbcl_comp_som,
  t4_cbcl_retraim,
  t4_cbcl_prob_sono,
  t4_cbcl_prob_aten,
  t4_cbcl_comport_agres,
  t4_cbcl_prob_inter,
  t4_cbcl_prob_exter,
  t4_cbcl_total_prob
))

# Description of CBCL scores at 24mo

jg2_cbcl_table <- jg2 %>%
  select(
    t4_cbcl_reat_emoc,
    t4_cbcl_ans_dep,
    t4_cbcl_comp_som,
    t4_cbcl_retraim,
    t4_cbcl_prob_sono,
    t4_cbcl_prob_aten,
    t4_cbcl_comport_agres,
    t4_cbcl_prob_inter,
    t4_cbcl_prob_exter,
    t4_cbcl_total_prob
  ) %>%
  tbl_summary(
    type = everything() ~ "continuous",
    statistic = all_continuous() ~ "{mean} ({sd}) [{min}, {max}]",
    digits = all_continuous() ~ 2,
    missing_text = "Missing",
    label = list(
      t4_cbcl_reat_emoc      = "Emotional Reactivity",
      t4_cbcl_ans_dep        = "Anxious/Depressed",
      t4_cbcl_comp_som       = "Somatic Complaints",
      t4_cbcl_retraim        = "Withdrawn",
      t4_cbcl_prob_sono      = "Sleep Problems",
      t4_cbcl_prob_aten      = "Attention Problems",
      t4_cbcl_comport_agres  = "Aggressive Behavior",
      t4_cbcl_prob_inter     = "Internalizing Problems",
      t4_cbcl_prob_exter     = "Externalizing Problems",
      t4_cbcl_total_prob     = "Total Problems"
    )) %>%
  modify_header(
    label ~ "**CBCL at 24mo**", 
    stat_0 ~ "**Mean (SD) [Min, Max]**", 
    all_stat_cols() ~ "**Mean (SD) [Min, Max]**"
  )

gt::gtsave(as_gt(jg2_cbcl_table), filename = "outputs/jg2_cbcl_table.html")
gt::gtsave(as_gt(jg2_cbcl_table), filename = "outputs/jg2_cbcl_table.docx")
# gt::gtsave(as_gt(jg2_cbcl_table), filename = "outputs/jg2_cbcl_table.pdf")

#----------------------------------------------------------------------#
# Description of CBCL scores: 24mo
#----------------------------------------------------------------------#

# Count number of valid (non-missing) observations for each CBCL outcome

skimr::skim(jg2 %>% select(
  t5_cbcl_reat_emoc,
  t5_cbcl_ans_dep,
  t5_cbcl_comp_som,
  t5_cbcl_retraim,
  t5_cbcl_prob_sono,
  t5_cbcl_prob_aten,
  t5_cbcl_comport_agres,
  t5_cbcl_prob_inter,
  t5_cbcl_prob_exter,
  t5_cbcl_total_prob
))

# Description of CBCL scores at 24mo

jg2_cbcl_table_24mo <- jg2 %>%
  select(
    t5_cbcl_reat_emoc,
    t5_cbcl_ans_dep,
    t5_cbcl_comp_som,
    t5_cbcl_retraim,
    t5_cbcl_prob_sono,
    t5_cbcl_prob_aten,
    t5_cbcl_comport_agres,
    t5_cbcl_prob_inter,
    t5_cbcl_prob_exter,
    t5_cbcl_total_prob
  ) %>%
  tbl_summary(
    type = everything() ~ "continuous",
    statistic = all_continuous() ~ "{mean} ({sd}) [{min}, {max}]",
    digits = all_continuous() ~ 2,
    missing_text = "Missing",
    label = list(
      t5_cbcl_reat_emoc      = "Emotional Reactivity",
      t5_cbcl_ans_dep        = "Anxious/Depressed",
      t5_cbcl_comp_som       = "Somatic Complaints",
      t5_cbcl_retraim        = "Withdrawn",
      t5_cbcl_prob_sono      = "Sleep Problems",
      t5_cbcl_prob_aten      = "Attention Problems",
      t5_cbcl_comport_agres  = "Aggressive Behavior",
      t5_cbcl_prob_inter     = "Internalizing Problems",
      t5_cbcl_prob_exter     = "Externalizing Problems",
      t5_cbcl_total_prob     = "Total Problems"
    )) %>%
  modify_header(
    label ~ "**CBCL at 42mo**", 
    stat_0 ~ "**Mean (SD) [Min, Max]**", 
    all_stat_cols() ~ "**Mean (SD) [Min, Max]**"
  )

gt::gtsave(as_gt(jg2_cbcl_table_24mo), filename = "outputs/jg2_cbcl_table_24mo.html")
gt::gtsave(as_gt(jg2_cbcl_table_24mo), filename = "outputs/jg2_cbcl_table_24mo.docx")
# gt::gtsave(as_gt(jg2_cbcl_table_42mo), filename = "outputs/jg2_cbcl_table_24mo.pdf")

#----------------------------------------------------------------------#
# Description of CBCL scores: 42mo
#----------------------------------------------------------------------#

# Count number of valid (non-missing) observations for each CBCL outcome

skimr::skim(jg2 %>% select(
  t6_cbcl_reat_emoc,
  t6_cbcl_ans_dep,
  t6_cbcl_comp_som,
  t6_cbcl_retraim,
  t6_cbcl_prob_sono,
  t6_cbcl_prob_aten,
  t6_cbcl_comport_agres,
  t6_cbcl_prob_inter,
  t6_cbcl_prob_exter,
  t6_cbcl_total_prob
))

# Description of CBCL scores at 42mo

jg2_cbcl_table_42mo <- jg2 %>%
  select(
    t6_cbcl_reat_emoc,
    t6_cbcl_ans_dep,
    t6_cbcl_comp_som,
    t6_cbcl_retraim,
    t6_cbcl_prob_sono,
    t6_cbcl_prob_aten,
    t6_cbcl_comport_agres,
    t6_cbcl_prob_inter,
    t6_cbcl_prob_exter,
    t6_cbcl_total_prob
  ) %>%
  tbl_summary(
    type = everything() ~ "continuous",
    statistic = all_continuous() ~ "{mean} ({sd}) [{min}, {max}]",
    digits = all_continuous() ~ 2,
    missing_text = "Missing",
    label = list(
      t6_cbcl_reat_emoc      = "Emotional Reactivity",
      t6_cbcl_ans_dep        = "Anxious/Depressed",
      t6_cbcl_comp_som       = "Somatic Complaints",
      t6_cbcl_retraim        = "Withdrawn",
      t6_cbcl_prob_sono      = "Sleep Problems",
      t6_cbcl_prob_aten      = "Attention Problems",
      t6_cbcl_comport_agres  = "Aggressive Behavior",
      t6_cbcl_prob_inter     = "Internalizing Problems",
      t6_cbcl_prob_exter     = "Externalizing Problems",
      t6_cbcl_total_prob     = "Total Problems"
    )) %>%
  modify_header(
    label ~ "**CBCL at 42mo**", 
    stat_0 ~ "**Mean (SD) [Min, Max]**", 
    all_stat_cols() ~ "**Mean (SD) [Min, Max]**"
  )

gt::gtsave(as_gt(jg2_cbcl_table_42mo), filename = "outputs/jg2_cbcl_table_42mo.html")
gt::gtsave(as_gt(jg2_cbcl_table_42mo), filename = "outputs/jg2_cbcl_table_42mo.docx")
# gt::gtsave(as_gt(jg2_cbcl_table_42mo), filename = "outputs/jg2_cbcl_table_42mo.pdf")

#----------------------------------------------------------------------#
# Renaming core CBCL variables
#----------------------------------------------------------------------#

for (i in 4:6) {
  old_inter <- paste0("t", i, "_cbcl_prob_inter")
  new_inter <- paste0("cbcl_prob_inter", i - 3)
  old_exter <- paste0("t", i, "_cbcl_prob_exter")
  new_exter <- paste0("cbcl_prob_exter", i - 3)
  old_total <- paste0("t", i, "_cbcl_total_prob")
  new_total <- paste0("cbcl_total_prob", i - 3)
  
  names(jg2)[names(jg2) == old_inter] <- new_inter
  names(jg2)[names(jg2) == old_exter] <- new_exter
  names(jg2)[names(jg2) == old_total] <- new_total
}

# Use skimr to check new CBCL summary variables
skim_without_charts(jg2 %>% 
    select(cbcl_prob_inter1, cbcl_prob_inter2, cbcl_prob_inter3,
    cbcl_prob_exter1, cbcl_prob_exter2, cbcl_prob_exter3,
    cbcl_total_prob1, cbcl_total_prob2, cbcl_total_prob3))

#----------------------------------------------------------------------#
# End of script 
#----------------------------------------------------------------------#