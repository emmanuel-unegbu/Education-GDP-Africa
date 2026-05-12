# ============================================================
# SCRIPT 03: Create Visualizations
# Project: Education Spending and GDP in Africa
# Author: Emmanuel Unegbu
# Date: 16th April 2026
# ============================================================

library(tidyverse)
library(scales)

africa_clean <- read_csv("data/africa_education_gdp_clean.csv")
View(africa_clean)

# CHART 1: Scatter Plot (The Core Relationship)

chart1 <- ggplot(africa_clean, aes(x = edu_spending_pct, y = gdp_per_capita)) +
  geom_point(alpha = 0.4, color = "steelblue", size = 2) +
  geom_smooth(method = "lm", color = "red", se = TRUE) +
  scale_y_continuous(labels = dollar_format()) +
  labs(
    title = "Education Spending vs. GDP Per Capita in Sub-Saharan Africa",
    subtitle = "Each dot is a country-year observation (2000–2023)",
    x = "Government Education Spending (% of GDP)",
    y = "GDP Per Capita (Constant 2015 USD)",
    caption = "Source: World Bank World Development Indicators"
  ) +
  theme_minimal(base_size = 13)

View(chart1)
print(chart1)
ggsave("output/chart1_scatter_education_gdp.png", chart1,
       width = 10, height = 7, dpi = 300)


spending_by_income <- africa_clean %>%
  group_by(income) %>%
  summarize(
    avg_edu_spending = mean(edu_spending_pct, na.rm = TRUE),
    avg_gdp = mean(gdp_per_capita, na.rm = TRUE),
    n_observations = n()
  ) %>%
  arrange(avg_gdp)

View(spending_by_income)
print(spending_by_income)

#chart2
chart2 <- ggplot(spending_by_income,
                 aes(x = reorder(income, avg_gdp), y = avg_edu_spending)) +
  geom_col(fill = "steelblue", width = 0.6) +
  geom_text(aes(label = round(avg_edu_spending, 1)),
            vjust = -0.5, size = 4.5) +
  labs(
    title = "Average Education Spending by Income Group",
    subtitle = "Sub-Saharan African Countries (2000–2023)",
    x = "World Bank Income Classification",
    y = "Average Education Spending (% of GDP)",
    caption = "Source: World Bank WDI"
  ) +
  theme_minimal(base_size = 13) +
  theme(axis.text.x = element_text(size = 11))

print(chart2)
ggsave("output/chart2_spending_by_income.png", chart2,
       width = 9, height = 6, dpi = 300)


# CHART 3: Top 10 vs Bottom 10 Countries
# Let's compare the countries that spend the MOST on education
# vs. those that spend the LEAST, and see their average GDP

country_averages <- africa_clean %>%
  group_by(country) %>%
  summarize(
    avg_edu_spending = mean(edu_spending_pct, na.rm = TRUE),
    avg_gdp = mean(gdp_per_capita, na.rm = TRUE)
  )
View(country_averages)

# Top 10 spenders on education
top10 <- country_averages %>%
  arrange(desc(avg_edu_spending)) %>%
  head(10) %>%
  mutate(group = "Top 10 Spenders")
View(top10)

# Bottom 10 spenders
bottom10 <- country_averages %>%
  arrange(avg_edu_spending) %>%
  head(10) %>%
  mutate(group = "Bottom 10 Spenders")
View(bottom10)

# Combine them
comparison <- bind_rows(top10, bottom10)

chart3 <- ggplot(comparison,
                 aes(x = reorder(country, avg_edu_spending),
                     y = avg_edu_spending,
                     fill = group)) +
  geom_col(width = 0.7) +
  coord_flip() +
  scale_fill_manual(values = c("Top 10 Spenders" = "steelblue",
                               "Bottom 10 Spenders" = "tomato")) +
  labs(
    title = "Top 10 vs Bottom 10 Education Spenders in Sub-Saharan Africa",
    subtitle = "Average government education spending as % of GDP (2000–2023)",
    x = "",
    y = "Education Spending (% of GDP)",
    fill = "",
    caption = "Source: World Bank WDI"
  ) +
  theme_minimal(base_size = 12) +
  theme(legend.position = "top")

print(chart3)
ggsave("output/chart3_top_bottom_spenders.png", chart3,
       width = 10, height = 8, dpi = 300)


# CHART 4: Education Spending Over Time (Selected Countries)
# Let's pick a few well-known African economies and see how their
# education spending changed over the years

selected_countries <- c("Nigeria", "South Africa", "Kenya",
                        "Ghana", "Ethiopia", "Rwanda")

time_data <- africa_clean %>%
  filter(country %in% selected_countries)

chart4 <- ggplot(time_data, aes(x = year, y = edu_spending_pct,
                                color = country)) +
  geom_line(linewidth = 1) +
  geom_point(size = 1.5) +
  labs(
    title = "Education Spending Over Time: Selected African Countries",
    subtitle = "Government education spending as % of GDP",
    x = "Year",
    y = "Education Spending (% of GDP)",
    color = "Country",
    caption = "Source: World Bank WDI"
  ) +
  theme_minimal(base_size = 13) +
  theme(legend.position = "right")

print(chart4)
ggsave("output/chart4_spending_over_time.png", chart4,
       width = 10, height = 6, dpi = 300)


# CHART 5: Distribution of GDP Per Capita
# A histogram showing how GDP per capita is distributed across
# all African country-year observations.
# This helps us understand: are most African countries poor with a few outliers?

chart5 <- ggplot(africa_clean, aes(x = gdp_per_capita)) +
  geom_histogram(bins = 30, fill = "steelblue", color = "white", alpha = 0.8) +
  scale_x_continuous(labels = dollar_format()) +
  labs(
    title = "Distribution of GDP Per Capita in Sub-Saharan Africa",
    subtitle = "All country-year observations (2000–2023)",
    x = "GDP Per Capita (Constant 2015 USD)",
    y = "Number of Observations",
    caption = "Source: World Bank WDI"
  ) +
  theme_minimal(base_size = 13)

print(chart5)
ggsave("output/chart5_gdp_distribution.png", chart5,
       width = 9, height = 6, dpi = 300)

cat("\n All 5 charts saved to the 'output' folder! \n")
