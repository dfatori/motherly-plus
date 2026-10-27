#----------------------------------------------------------------------#
# Project: Motherly Plus
# Script: 07_primary-outcome.r
# Description: Primary outcome analysis (QIDS-C16 at T3). GEE (Twisk et al.,
#              2018, eq. 2d) on the multiply imputed datasets, pooled with
#              Rubin's rules. ITT: all randomized participants.
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
# Load packages and helpers
#----------------------------------------------------------------------#

library(here)
library(tidyverse)
library(geepack)
library(mice)

source(here("scripts", "figures-helpers.r"))
source(here("scripts", "mi-helpers.r"))

#----------------------------------------------------------------------#
# Load imputed datasets
#----------------------------------------------------------------------#

imp <- readRDS(here("outputs", "models", "06_mice_imputations.rds"))
completed <- get_completed(imp)

#----------------------------------------------------------------------#
# Primary analysis: QIDS-C16 (clinician-rated, collected at T1 and T3)
# qidsc16 ~ T3 + T3:group  (baseline = intercept, same in both groups)
#----------------------------------------------------------------------#

qids <- analyze_gee_outcome(completed, "qidsc16", times = c(1, 3))

print(qids$model)
print(qids$means)
print(qids$contrasts)

cat("Cohen's d for QIDS-C16 at T3:", round(qids$contrasts$cohen_d[1], 3), "\n")

#----------------------------------------------------------------------#
# Save outputs
#----------------------------------------------------------------------#

save_gee_results(
  qids,
  prefix = "07_qids",
  label = "QIDS-C16",
  y_label = "QIDS-C16 total score",
  title_text = "QIDS-C16 estimated marginal means at baseline (T1) and post-treatment (T3)"
)

#----------------------------------------------------------------------#
# End of script 07_primary-outcome.r
#----------------------------------------------------------------------#