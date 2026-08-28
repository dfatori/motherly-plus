#----------------------------------------------------------------------#
# Project: JG2 Efficacy
# Script: 02_codebook.r
# Script authors: daniel.fatori@gmail.com, ptotolo@ime.usp.br 
# Description: List of variables
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
# Generate HTML with all variable names: List for reference
#----------------------------------------------------------------------#

# Create a data frame with variable names and their positions
variable_names <- data.frame(
  Position = 1:length(names(jg2)),
  Variable_Name = names(jg2),
  stringsAsFactors = FALSE
)

# Generate HTML table with all variable names
variable_names %>%
  knitr::kable(format = "html", 
               caption = "<p><strong>Codebook of dataset</strong></p>",
               col.names = c("Position", "Variable Name")) %>%
  writeLines(here("outputs", "01_codebook.html"))

# Also generate CSV version
variable_names %>%
  write.csv(here("outputs", "00_jg2-codebook.csv"), 
            row.names = FALSE)

#----------------------------------------------------------------------#
# End of script 
#----------------------------------------------------------------------#