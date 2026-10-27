#----------------------------------------------------------------------#
# Project: Motherly Plus
# Script: mi-helpers.r
# Description: Helpers shared by the outcome scripts (ITT on the imputed
#              datasets and complete-case). Sourced; not run by run-all.r.
#
# Model (Twisk et al., 2018, equation 2d): GEE with AR1 correlation, time
# dummies and time x group interactions, WITHOUT a group main effect. The
# baseline (T1) is the intercept, assumed equal in both groups by
# randomization; the treatment effect at each follow-up is the
# time x group coefficient.
#
# Imputed datasets: one model per imputation (mice::as.mira), pooled with
# Rubin's rules (mice::pool); marginal means and contrasts with emmeans.
#----------------------------------------------------------------------#

library(dplyr)
library(tidyr)
library(readr)
library(geepack)
library(mice)
library(emmeans)

group_levels <- c("Waitlist", "Intervention")

#----------------------------------------------------------------------#
# Data preparation
#----------------------------------------------------------------------#

# Completed (wide) datasets, one per imputation. The PSI-SF total is the
# sum of the three imputed subscales.
get_completed <- function(imp) {
  lapply(mice::complete(imp, "all"), function(d) {
    for (t in c(1, 3, 4)) {
      d[[paste0("psi_total_t", t)]] <- d[[paste0("psi_pd_t", t)]] +
        d[[paste0("psi_pcdi_t", t)]] + d[[paste0("psi_dc_t", t)]]
    }
    d
  })
}

# One row per participant, one column per variable and timepoint (e.g. gad7_t3)
long_to_wide <- function(long, vars) {
  long %>%
    select(record_id, time, all_of(vars)) %>%
    pivot_wider(
      id_cols = record_id,
      names_from = time,
      values_from = all_of(vars),
      names_glue = "{.value}_t{time}"
    )
}

# Long dataset for one outcome. times: timepoints analyzed (first = baseline).
# t3, t4: time dummies (0 at baseline); int: 1 = Intervention.
gee_long <- function(d, stem, times) {
  out <- d %>%
    select(record_id, group_f, all_of(paste0(stem, "_t", times))) %>%
    pivot_longer(
      starts_with(paste0(stem, "_t")),
      names_to = "time",
      names_prefix = paste0(stem, "_t"),
      names_transform = as.integer,
      values_to = "y"
    ) %>%
    arrange(record_id, time) %>%
    mutate(wave = match(time, times), int = as.numeric(group_f == "Intervention"))

  for (t in times[-1]) out[[paste0("t", t)]] <- as.numeric(out$time == t)
  out
}

fit_gee <- function(d, stem, times) {
  tp <- paste0("t", times[-1])
  f <- reformulate(c(tp, paste0(tp, ":int")), response = "y")
  dat <- gee_long(d, stem, times)
  if (anyNA(dat$y)) stop("Missing values in '", stem, "'.")
  geeglm(f, id = record_id, waves = wave, family = gaussian,
         corstr = "ar1", std.err = "san.se", data = dat)
}

# Pooled within-group SD at one timepoint (variance averaged over datasets)
pooled_sd <- function(data_list, stem, t) {
  v <- vapply(data_list, function(d) {
    y <- d[[paste0(stem, "_t", t)]]
    g <- d$group_f
    n1 <- sum(g == "Waitlist")
    n2 <- sum(g == "Intervention")
    ((n1 - 1) * var(y[g == "Waitlist"]) + (n2 - 1) * var(y[g == "Intervention"])) / (n1 + n2 - 2)
  }, numeric(1))
  sqrt(mean(v))
}

#----------------------------------------------------------------------#
# Marginal means, Waitlist - Intervention contrasts and Cohen's d (emmeans)
# from a geeglm or a mira (list of geeglm) object. Positive = favors the
# intervention.
#----------------------------------------------------------------------#

gee_emmeans <- function(object, data_list, stem, times) {
  tp <- paste0("t", times[-1])
  n <- nrow(data_list[[1]])
  at <- c(setNames(rep(list(0:1), length(tp)), tp), list(int = 0:1))

  # Valid cells: baseline (all dummies 0) or exactly one follow-up dummy.
  # Dummies come back as numbers (means) or factors (contrasts by dummy).
  dummies <- function(df) as.matrix(as.data.frame(lapply(df[tp], function(x) as.numeric(as.character(x)))))
  label_time <- function(df) paste0("T", times[as.vector(dummies(df) %*% seq_along(tp)) + 1])
  valid <- function(df) rowSums(dummies(df)) <= 1

  emm <- emmeans(object, reformulate(c("int", tp)), at = at)

  means <- as.data.frame(emm) %>%
    filter(valid(.)) %>%
    transmute(
      group_f = factor(group_levels[int + 1], levels = group_levels),
      time_f = factor(label_time(.), levels = paste0("T", times)),
      emmean, SE, df, lower.CL, upper.CL
    )

  con <- as.data.frame(contrast(emm, "pairwise", by = tp, adjust = "none", infer = TRUE))
  contrasts <- con %>%
    filter(rowSums(dummies(con)) == 1) %>%
    transmute(
      contrast = "Waitlist - Intervention",
      time_f = factor(label_time(.), levels = paste0("T", times)),
      estimate, SE, df, lower.CL, upper.CL, p.value
    )

  # Cohen's d = contrast / pooled within-group SD at the timepoint
  d <- bind_rows(lapply(times[-1], function(t) {
    at_t <- c(setNames(as.list(as.numeric(tp == paste0("t", t))), tp), list(int = 0:1))
    eff <- eff_size(emmeans(object, ~ int, at = at_t),
                    sigma = pooled_sd(data_list, stem, t), edf = n - 2)
    as.data.frame(eff) %>%
      transmute(cohen_d = effect.size, d_lower = lower.CL, d_upper = upper.CL)
  }))

  list(means = means, contrasts = bind_cols(contrasts, d))
}

#----------------------------------------------------------------------#
# ITT: GEE in each imputed dataset, pooled with Rubin's rules (mice::pool)
#----------------------------------------------------------------------#

analyze_gee_outcome <- function(completed, stem, times) {
  m <- as.mira(lapply(completed, fit_gee, stem = stem, times = times))
  pooled <- pool(m)

  model <- summary(pooled, conf.int = TRUE) %>%
    as_tibble() %>%
    select(-`2.5 %`, -`97.5 %`) %>%
    left_join(select(pooled$pooled, term, fmi), by = "term")

  c(list(model = model), gee_emmeans(m, completed, stem, times))
}

# Marginal means, Waitlist - Intervention contrast and Cohen's d for a
# single-timepoint outcome fitted with lm (outcome ~ int), from an lm or a
# mira (list of lm) object. Same output layout as gee_emmeans().
lm_emmeans <- function(object, data_list, stem, t = 3) {
  emm <- emmeans(object, ~ int, at = list(int = 0:1))
  time_f <- factor(paste0("T", t))

  means <- as.data.frame(emm) %>%
    transmute(
      group_f = factor(group_levels[int + 1], levels = group_levels),
      time_f = time_f,
      emmean, SE, df, lower.CL, upper.CL
    )

  contrasts <- as.data.frame(contrast(emm, "pairwise", adjust = "none", infer = TRUE)) %>%
    transmute(
      contrast = "Waitlist - Intervention",
      time_f = time_f,
      estimate, SE, df, lower.CL, upper.CL, p.value
    )

  d <- as.data.frame(eff_size(emm, sigma = pooled_sd(data_list, stem, t),
                              edf = nrow(data_list[[1]]) - 2)) %>%
    transmute(cohen_d = effect.size, d_lower = lower.CL, d_upper = upper.CL)

  list(means = means, contrasts = bind_cols(contrasts, d))
}

# CGI-I at T3 (no baseline): scored 1-7 and analyzed as a continuous outcome
# (linear regression on group) in each imputed dataset, pooled with Rubin's
# rules. Positive contrast = favors the intervention (lower score = better).
cgi_numeric <- function(d) {
  d$cgi_i_t3 <- as.numeric(as.character(d$cgi_i_t3))
  d$int <- as.numeric(d$group_f == "Intervention")
  d
}

analyze_cgi_outcome <- function(completed) {
  completed <- lapply(completed, cgi_numeric)
  m <- as.mira(lapply(completed, function(d) lm(cgi_i_t3 ~ int, data = d)))
  pooled <- pool(m)

  model <- summary(pooled, conf.int = TRUE) %>%
    as_tibble() %>%
    select(-`2.5 %`, -`97.5 %`) %>%
    left_join(select(pooled$pooled, term, fmi), by = "term")

  c(list(model = model), lm_emmeans(m, completed, "cgi_i"))
}

#----------------------------------------------------------------------#
# Save a table as CSV and HTML
#----------------------------------------------------------------------#

save_table <- function(df, stub, caption) {
  write_csv(df, here::here("outputs", "tables", paste0(stub, ".csv")))
  knitr::kable(df, format = "html", caption = caption) %>%
    writeLines(here::here("outputs", "tables", paste0(stub, ".html")))
}

#----------------------------------------------------------------------#
# Save tables and the marginal-means figure of a continuous outcome.
# Warns if the fraction of missing information exceeds 0.7, the level for
# which Graham et al. (2007) recommend m = 100 or more imputations.
#----------------------------------------------------------------------#

save_gee_results <- function(res, prefix, label, y_label, title_text) {
  save_table(res$model, paste0(prefix, "_model_summary"), paste(label, "GEE model summary (pooled)"))
  save_table(res$means, paste0(prefix, "_marginal_means"), paste(label, "estimated marginal means (pooled)"))
  save_table(res$contrasts, paste0(prefix, "_contrasts"), paste(label, "group contrasts by timepoint (pooled)"))

  fig <- plot_marginal_means(res$means, y_label = y_label, title_text = title_text)
  save_figure(fig, here::here("outputs", "figures", paste0(prefix, "_marginal_means.png")))

  if (any(res$model$fmi > 0.7, na.rm = TRUE)) {
    warning(label, ": fraction of missing information > 0.7; consider more imputations.")
  }
  invisible(fig)
}
