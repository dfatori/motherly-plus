#----------------------------------------------------------------------#
# Project: Motherly Plus
# Script: figures-helpers.r
# Description: Shared plotting helpers for outcome figures.
#              Sourced by the analysis scripts; not run by run-all.r.
#----------------------------------------------------------------------#

library(ggplot2)
library(stringr)

# Consistent group colors across all figures
group_colors <- c("Waitlist" = "#1b9e77", "Intervention" = "#d95f02")

#----------------------------------------------------------------------#
# Line plot of estimated marginal means over time, by group, with 95% CI.
# `emm` is an emmeans object or a data frame with columns group_f, time_f,
# emmean and either asymp.LCL/asymp.UCL or lower.CL/upper.CL.
#----------------------------------------------------------------------#

plot_marginal_means <- function(emm, y_label, title_text, wrap = 50) {
  df <- as.data.frame(emm)

  # emmeans names the asymptotic CI columns differently across versions
  # (asymp.LCL/asymp.UCL vs lower.CL/upper.CL); normalize for plotting.
  if (all(c("asymp.LCL", "asymp.UCL") %in% names(df))) {
    df$conf_low <- df$asymp.LCL
    df$conf_high <- df$asymp.UCL
  } else {
    df$conf_low <- df$lower.CL
    df$conf_high <- df$upper.CL
  }

  ggplot(df, aes(x = time_f, y = emmean, color = group_f, group = group_f)) +
    geom_line(linewidth = 1, position = position_dodge(width = 0.2)) +
    geom_point(size = 3, position = position_dodge(width = 0.2)) +
    geom_errorbar(aes(ymin = conf_low, ymax = conf_high), width = 0.15, linewidth = 0.9,
                  position = position_dodge(width = 0.2)) +
    scale_color_manual(values = group_colors) +
    scale_x_discrete(drop = FALSE) +
    labs(
      title = str_wrap(title_text, width = wrap),
      x = "Timepoint",
      y = y_label,
      color = "Group"
    ) +
    theme_minimal(base_size = 13) +
    theme(
      plot.title = element_text(face = "bold", size = 13, hjust = 0),
      plot.title.position = "plot",
      plot.margin = margin(10, 15, 10, 10),
      axis.text.x = element_text(size = 10),
      legend.position = "right"
    )
}

#----------------------------------------------------------------------#
# Point plot of estimated marginal means of a single-timepoint outcome, by
# group, with 95% CI. `emm` has columns group_f, emmean, lower.CL, upper.CL.
#----------------------------------------------------------------------#

plot_group_means <- function(emm, y_label, title_text, wrap = 50) {
  ggplot(as.data.frame(emm), aes(x = group_f, y = emmean, color = group_f)) +
    geom_point(size = 3.5) +
    geom_errorbar(aes(ymin = lower.CL, ymax = upper.CL), width = 0.12, linewidth = 0.9) +
    scale_color_manual(values = group_colors) +
    scale_y_continuous(limits = c(1, 7), breaks = 1:7) +
    labs(
      title = str_wrap(title_text, width = wrap),
      x = "Group",
      y = y_label
    ) +
    theme_minimal(base_size = 13) +
    theme(
      plot.title = element_text(face = "bold", size = 13, hjust = 0),
      plot.title.position = "plot",
      plot.margin = margin(10, 15, 10, 10),
      legend.position = "none"
    )
}

#----------------------------------------------------------------------#
# Save a plot to PNG with a base-device fallback (graphics API mismatch).
#----------------------------------------------------------------------#

save_figure <- function(plot, path, width = 8, height = 5, dpi = 300) {
  tryCatch(
    ggsave(path, plot = plot, width = width, height = height, dpi = dpi, device = "png"),
    error = function(e) {
      message("ggsave failed (likely graphics API mismatch): ", conditionMessage(e))
      message("Falling back to base png device.")
      png(path, width = width, height = height, units = "in", res = dpi)
      print(plot)
      dev.off()
    }
  )
}
