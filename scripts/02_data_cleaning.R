# ============================================================
# SCRIPT 02: Clean and Prepare the Data
# Project: Education Spending and GDP in Africa
# Author: Emmanuel Unegbu
# Date: 15th April 2026
# ============================================================

library(tidyverse)

unique(raw_data$region)
unique(raw_data$income)

africa_data <- raw_data %>%
  filter(region == "Sub-Saharan Africa")

View(africa_data)
dim(africa_data)
sum(is.na(africa_data$gdp_per_capita))
sum(is.na(africa_data$edu_spending_pct))

africa_clean <- africa_data %>%
  filter(!is.na(gdp_per_capita), !is.na(edu_spending_pct))

dim(africa_clean)
View(africa_clean)

africa_clean <- africa_clean %>%
  select(country, iso3c, year, gdp_per_capita, edu_spending_pct, income)

head(africa_clean, 10)
summary(africa_clean)

write_csv(africa_clean, "data/africa_education_gdp_clean.csv")

cat("Number of countries:", length(unique(africa_clean$country)), "\n")
cat("Year range:", min(africa_clean$year), "to", max(africa_clean$year), "\n")
cat("Total observations:", nrow(africa_clean), "\n")
