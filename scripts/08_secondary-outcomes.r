#----------------------------------------------------------------------#
# Project: Motherly Plus
# Script: 08_secondary-outcomes.r
# Description: Secondary outcomes at T3 and T4 (GEE, Twisk et al. 2018 eq. 2d)
#              and CGI-I at T3 (linear regression), on the multiply imputed
#              datasets pooled with Rubin's rules. ITT.
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
# Continuous secondary outcomes: outcome ~ T3 + T4 + T3:group + T4:group
# (baseline = intercept, same in both groups)
#----------------------------------------------------------------------#

secondary <- list(
  list(stem = "qidssr16", prefix = "08_qidssr16", label = "QIDS-SR16",
       y_label = "QIDS-SR16 total score"),
  list(stem = "gad7", prefix = "08_gad7", label = "GAD-7",
       y_label = "GAD-7 total score"),
  list(stem = "psqi", prefix = "08_psqi", label = "PSQI",
       y_label = "PSQI total score"),
  list(stem = "psi_pd", prefix = "08_psi_pd", label = "PSI-SF parental distress",
       y_label = "PSI-SF parental distress score"),
  list(stem = "psi_pcdi", prefix = "08_psi_pcdi", label = "PSI-SF parent-child dysfunctional interaction",
       y_label = "PSI-SF P-CDI score"),
  list(stem = "psi_total", prefix = "08_psi_total", label = "PSI-SF total stress",
       y_label = "PSI-SF total score"),
  list(stem = "sds", prefix = "08_sds", label = "SDS",
       y_label = "SDS total score"),
  list(stem = "epds", prefix = "08_epds", label = "EPDS",
       y_label = "EPDS total score")
)

for (o in secondary) {
  message("Fitting: ", o$label)
  res <- analyze_gee_outcome(completed, o$stem, times = c(1, 3, 4))
  save_gee_results(
    res,
    prefix = o$prefix,
    label = o$label,
    y_label = o$y_label,
    title_text = paste(o$label, "estimated marginal means over time, by group")
  )
}

#----------------------------------------------------------------------#
# CGI-I at T3 (no baseline): linear regression on group (score 1-7)
#----------------------------------------------------------------------#

cgi <- analyze_cgi_outcome(completed)
print(cgi$contrasts)

plot_cgi <- plot_group_means(
  cgi$means,
  y_label = "CGI-I score",
  title_text = "CGI-I estimated marginal means at post-treatment (T3), by group"
)
save_figure(plot_cgi, here("outputs", "figures", "08_cgi_marginal_means.png"), width = 6, height = 5)

save_table(cgi$model, "08_cgi_model_summary", "CGI-I linear regression coefficients (pooled)")
save_table(cgi$means, "08_cgi_marginal_means", "CGI-I estimated marginal means (pooled)")
save_table(cgi$contrasts, "08_cgi_contrasts", "CGI-I group contrast at T3 (pooled)")

if (any(cgi$model$fmi > 0.7, na.rm = TRUE)) {
  warning("CGI-I: fraction of missing information > 0.7; consider more imputations.")
}

#----------------------------------------------------------------------#
# End of script 08_secondary-outcomes.r
#----------------------------------------------------------------------#
