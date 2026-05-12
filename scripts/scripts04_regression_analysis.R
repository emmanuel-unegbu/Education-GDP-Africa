# ============================================================
# SCRIPT 04: Regression Analysis
# Project: Education Spending and GDP in Africa
# Author: Emmanuel Unegbu
# Date: 17th April 2026
# ============================================================

library(tidyverse)
library(broom)     

africa_clean <- read_csv("data/africa_education_gdp_clean.csv")
View(africa_clean)

# MODEL 1: Simple Linear Regression
# TIs education spending associated with GDP per capita?
# Formula: GDP = a + b * EducationSpending + error

model1 <- lm(gdp_per_capita ~ edu_spending_pct, data = africa_clean)
summary(model1)

tidy_model1 <- tidy(model1, conf.int = TRUE)
print(tidy_model1)

# MODEL 2: Multiple Regression (Adding Controls)
# Is education spending associated with GDP per capita?
# even after accounting for the income group of the country?"

model2 <- lm(gdp_per_capita ~ edu_spending_pct + income, data = africa_clean)
summary(model2)

tidy_model2 <- tidy(model2, conf.int = TRUE)
print(tidy_model2)


# MODEL 3: Log-Level Regression
africa_clean <- africa_clean %>%
  mutate(log_gdp = log(gdp_per_capita))

model3 <- lm(log_gdp ~ edu_spending_pct, data = africa_clean)
summary(model3)

tidy_model3 <- tidy(model3, conf.int = TRUE)
print(tidy_model3)


sink("output/regression_results.txt")
cat("========================================\n")
cat("MODEL 1: Simple Regression\n")
cat("GDP Per Capita ~ Education Spending\n")
cat("========================================\n\n")
print(summary(model1))

cat("\n\n========================================\n")
cat("MODEL 2: With Income Controls\n")
cat("GDP Per Capita ~ Education Spending + Income Group\n")
cat("========================================\n\n")
print(summary(model2))

cat("\n\n========================================\n")
cat("MODEL 3: Log-Level Regression\n")
cat("Log(GDP Per Capita) ~ Education Spending\n")
cat("========================================\n\n")
print(summary(model3))
sink()


cat("\n Regression results saved to output/regression_results.txt \n")
