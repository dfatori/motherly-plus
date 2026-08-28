#----------------------------------------------------------------------#
# Project: JG2 Efficacy
# Script: 07_wppsi-analysis-main.r
# Script authors: daniel.fatori@gmail.com, ptotolo@ime.usp.br
# Description: Intervention effects on WPPSI outcomes
#----------------------------------------------------------------------#

###########################################
# Prefix t6 on WPPSI variables means 42mo
###########################################

#-------------------------------------------------------------------------------
# WPPSI Total IQ
#-------------------------------------------------------------------------------

wppsi_qi_total <- lm(t6_wppsi_qi_total ~ factor(t0_i03), data = jg2)
summary(wppsi_qi_total)

length(wppsi_qi_total$residuals)
table(jg2$t0_i03[complete.cases(jg2[, c("t6_wppsi_qi_total", "t0_i03")])])

wppsi_qi_total_emm <- emmeans(wppsi_qi_total, ~ t0_i03)

wppsi_qi_total_emm_contrast <- contrast(wppsi_qi_total_emm, 
    method = "pairwise")

kable(wppsi_qi_total_emm_contrast)

#-------------------------------------------------------------------------------
# WPPSI Verbal comprehension
#-------------------------------------------------------------------------------

wppsi_qi_verbal <- lm(t6_wppsi_qi_verbal ~ factor(t0_i03), data = jg2)
summary(wppsi_qi_verbal)

wppsi_qi_verbal_emm <- emmeans(wppsi_qi_verbal, ~ t0_i03)
kable(wppsi_qi_verbal_emm)

wppsi_qi_verbal_emm_contrast <- contrast(wppsi_qi_verbal_emm, 
    method = "pairwise")

kable(wppsi_qi_verbal_emm_contrast)

#-------------------------------------------------------------------------------
# WPPSI Visual spatial processing
#-------------------------------------------------------------------------------

wppsi_qi_vis_espac <- lm(t6_wppsi_qi_vis_espac ~ factor(t0_i03), data = jg2)
summary(wppsi_qi_vis_espac)

wppsi_qi_vis_espac_emm <- emmeans(wppsi_qi_vis_espac, ~ t0_i03)
kable(wppsi_qi_vis_espac_emm)

wppsi_qi_vis_espac_emm_contrast <- contrast(wppsi_qi_vis_espac_emm, 
    method = "pairwise")

kable(wppsi_qi_vis_espac_emm_contrast)

#-------------------------------------------------------------------------------
# WPPSI Working memory
#-------------------------------------------------------------------------------

wppsi_qi_mem_trab <- lm(t6_wppsi_qi_mem_trab ~ factor(t0_i03), data = jg2)
summary(wppsi_qi_mem_trab)

wppsi_qi_mem_trab_emm <- emmeans(wppsi_qi_mem_trab, ~ t0_i03)
kable(wppsi_qi_mem_trab_emm)

wppsi_qi_mem_trab_emm_contrast <- contrast(wppsi_qi_mem_trab_emm, 
    method = "pairwise")

kable(wppsi_qi_mem_trab_emm_contrast)

#----------------------------------------------------------------------#
# End of script 
#----------------------------------------------------------------------#