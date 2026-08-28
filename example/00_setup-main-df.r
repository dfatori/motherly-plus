#----------------------------------------------------------------------#
# Project: JG2 Efficacy
# Script: 00_setup.r
# Script authors: daniel.fatori@gmail.com, ptotolo@ime.usp.br 
# Description: Initial setup script
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
# Load packages
#----------------------------------------------------------------------#

library(here)
library(tidyverse)
library(knitr)
library(haven)
library(gtsummary)
library(summarytools)
library(geepack)
library(emmeans)
library(readxl)
library(skimr)
library(flextable)
library(officer)
library(patchwork)
library(chromote)
library(webshot2)

#----------------------------------------------------------------------#
# Set up folders
#----------------------------------------------------------------------#

output_folder_tables <- here("outputs", "tables")
output_folder_figures <- here("outputs", "figures")

#----------------------------------------------------------------------#
# Load main dataset with main outcomes
#----------------------------------------------------------------------#

jg2 <- read_dta(
    here("datasets", "jg2_completo_04_08_2022_v2.dta"))

# Save as CSV
write_csv(jg2, here("datasets", "jg2_completo_04_08_2022_v2.csv"))

jg2 <- read.csv(
    here("datasets", "jg2_completo_04_08_2022_v2.csv"))

#----------------------------------------------------------------------#
# Load dataset with WPPSI follow-up outcomes
#----------------------------------------------------------------------#

jg2_wppsi <- read_dta(
  here("datasets", "jg2_completo_30_08_2024.dta")) %>%
  select(
  record_id,
  t6_wppsi_data,
  t6_wppsi_dn_cca,
  t6_wppsi_rv_pb,
  t6_wppsi_rv_pe,
  t6_wppsi_bd_pb,
  t6_wppsi_bd_pe,
  t6_wppsi_pm_pb,
  t6_wppsi_pm_pe,
  t6_wppsi_in_pb,
  t6_wppsi_in_pe,
  t6_wppsi_oa_pb,
  t6_wppsi_oa_pe,
  t6_wppsi_zl_pb,
  t6_wppsi_zl_pe,
  t6_wppsi_pn_pb,
  t6_wppsi_pn_pe,
  t6_wppsi_compr_verbal,
  t6_wppsi_vis_espac,
  t6_wppsi_mem_trab,
  t6_wppsi_et_pe,
  t6_wppsi_qi_verbal,
  t6_wppsi_qi_verbal_perc,
  t6_wppsi_qi_vis_espac,
  t6_wppsi_qi_vis_esp_perc,
  t6_wppsi_qi_mem_trab,
  t6_wppsi_qi_mem_trab_perc,
  t6_wppsi_qi_total,
  t6_wppsi_qi_total_perc,
  t6_cbcl1_42, t6_cbcl2_42, t6_cbcl3_42, t6_cbcl4_42, t6_cbcl5_42, t6_cbcl6_42, t6_cbcl7_42, t6_cbcl8_42, t6_cbcl9_42, t6_cbcl10_42,
  t6_cbcl11_42, t6_cbcl12_42, t6_cbcl13_42, t6_cbcl14_42, t6_cbcl15_42, t6_cbcl16_42, t6_cbcl17_42, t6_cbcl18_42, t6_cbcl19_42, t6_cbcl20_42,
  t6_cbcl21_42, t6_cbcl22_42, t6_cbcl23_42, t6_cbcl24_42, t6_cbcl25_42, t6_cbcl26_42, t6_cbcl27_42, t6_cbcl28_42, t6_cbcl29_42, t6_cbcl30_42,
  t6_cbcl31_42, t6_cbcl32_42, t6_cbcl33_42, t6_cbcl34_42, t6_cbcl35_42, t6_cbcl36_42, t6_cbcl37_42, t6_cbcl38_42, t6_cbcl39_42, t6_cbcl40_42,
  t6_cbcl41_42, t6_cbcl42_42, t6_cbcl43_42, t6_cbcl44_42, t6_cbcl45_42, t6_cbcl46_42, t6_cbcl47_42, t6_cbcl48_42, t6_cbcl49_42, t6_cbcl50_42,
  t6_cbcl51_42, t6_cbcl52_42, t6_cbcl53_42, t6_cbcl54_42, t6_cbcl55_42, t6_cbcl56_42, t6_cbcl57_42, t6_cbcl58_42, t6_cbcl59_42, t6_cbcl60_42,
  t6_cbcl61_42, t6_cbcl62_42, t6_cbcl63_42, t6_cbcl64_42, t6_cbcl65_42, t6_cbcl66_42, t6_cbcl67_42, t6_cbcl68_42, t6_cbcl69_42, t6_cbcl70_42,
  t6_cbcl71_42, t6_cbcl72_42, t6_cbcl73_42, t6_cbcl74_42, t6_cbcl75_42, t6_cbcl76_42, t6_cbcl77_42, t6_cbcl78_42, t6_cbcl79_42, t6_cbcl80_42,
  t6_cbcl81_42, t6_cbcl82_42, t6_cbcl83_42, t6_cbcl84_42, t6_cbcl85_42, t6_cbcl86_42, t6_cbcl87_42, t6_cbcl88_42, t6_cbcl89_42, t6_cbcl90_42,
  t6_cbcl91_42, t6_cbcl92_42, t6_cbcl93_42, t6_cbcl94_42, t6_cbcl95_42, t6_cbcl96_42, t6_cbcl97_42, t6_cbcl98_42, t6_cbcl99_42, t6_cbcldescreva_42,
  t6_cbcl100_42, t6_cbcl101_42, t6_cbcl102_42, t6_cbcl103_42
  )

#----------------------------------------------------------------------#
# Merge jg2 with jg2_wppsi by record_id
#----------------------------------------------------------------------#

jg2 <- jg2 %>%
  left_join(jg2_wppsi, by = "record_id")

#----------------------------------------------------------------------#
# Initial checks and cleaning
#----------------------------------------------------------------------#

# Dimensions of dataset
dim(jg2)

#----------------------------------------------------------------------#
# End of script 00.setup.r
#----------------------------------------------------------------------#