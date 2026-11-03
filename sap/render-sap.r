#----------------------------------------------------------------------#
# Project: Motherly Plus
# Script: render-sap.r
# Description: Render SAP.md to SAP.docx and SAP.pdf via pandoc
#----------------------------------------------------------------------#

library(here)

sap_md <- here("sap", "SAP.md")

system2("pandoc", c(shQuote(sap_md), "-o", shQuote(here("sap", "SAP.docx"))))
system2("pandoc", c(shQuote(sap_md), "-o", shQuote(here("sap", "SAP.pdf")), "--pdf-engine=xelatex"))

#----------------------------------------------------------------------#
# End of script render-sap.r
#----------------------------------------------------------------------#