# ============================================================
# SCRIPT 01: Install Packages and Download Data
# Project: Education Spending and GDP in Africa
# Author : Emmanuel Unegbu
# Date: 15th April 2026
# ============================================================

install.packages("tidyverse")
install.packages("WDI")
install.packages("scales")
install.packages("broom")
install.packages("knitr")

library(tidyverse)   
library(WDI)         

raw_data <- WDI(
  country   = "all",
  indicator = c(
    "gdp_per_capita"    = "NY.GDP.PCAP.KD",
    "edu_spending_pct"  = "SE.XPD.TOTL.GD.ZS"
  ),
  start = 2000,
  end   = 2023,
  extra = TRUE
)

head(raw_data)
dim(raw_data)
str(raw_data)
names(raw_data)
View(raw_data)
