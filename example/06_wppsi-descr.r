#----------------------------------------------------------------------#
# Project: JG2 Efficacy
# Script: 06_wppsi-analysis-main.r
# Script authors: daniel.fatori@gmail.com, ptotolo@ime.usp.br
# Description: Description of WPPSI outcomes
#----------------------------------------------------------------------#

###########################################
# Prefix t6 on WPPSI variables means 42mo
###########################################

#-------------------------------------------------------------------------------
# Description of WPPSI outcomes
#-------------------------------------------------------------------------------

# Count number of valid (non-missing) observations for each WPPSI outcome

colSums(!is.na(jg2[, c(
    "t6_wppsi_qi_total", 
    "t6_wppsi_qi_verbal", 
    "t6_wppsi_qi_vis_espac", 
    "t6_wppsi_qi_mem_trab")])
  )

# WPPSI description table

jg2_wppsi_table <- jg2 %>%
  select(
    t6_wppsi_qi_total, 
    t6_wppsi_qi_verbal, 
    t6_wppsi_qi_vis_espac, 
    t6_wppsi_qi_mem_trab) %>%
  tbl_summary(
    type = everything() ~ "continuous",
    statistic = all_continuous() ~ "{mean} ({sd}) [{min}, {max}]",
    digits = all_continuous() ~ 2,
    missing_text = "Missing",
    label = list(
      t6_wppsi_qi_total      = "IQ",
      t6_wppsi_qi_verbal     = "Verbal comprehension",
      t6_wppsi_qi_vis_espac  = "Visual spatial processing",
      t6_wppsi_qi_mem_trab   = "Working memory"
    )) %>%
  modify_header(
    label ~ "**WPPSI**", 
    stat_0 ~ "**Mean (SD) [Min, Max]**", 
    all_stat_cols() ~ "**Mean (SD) [Min, Max]**"
  )

gt::gtsave(as_gt(jg2_wppsi_table), filename = "outputs/jg2_wppsi_table.html")
gt::gtsave(as_gt(jg2_wppsi_table), filename = "outputs/jg2_wppsi_table.docx")
gt::gtsave(as_gt(jg2_wppsi_table), filename = "outputs/jg2_wppsi_table.pdf")

#----------------------------------------------------------------------#
# End of script 
#----------------------------------------------------------------------#