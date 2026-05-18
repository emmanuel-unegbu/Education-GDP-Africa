# Education Spending and GDP in Sub-Saharan Africa

A reproducible research project investigating the relationship between government education spending and GDP per capita across African countries, using World Bank data.

**Author:** Emmanuel Unegbu\
**Date:** May 2026\
**Tools:** R, RStudio, Quarto

------------------------------------------------------------------------

## Research Question

Do African countries that spend a larger share of their GDP on education tend to have higher GDP per capita?

## Data

-   **Source:** World Bank World Development Indicators
-   **Indicators used:**
    -   GDP per capita, constant 2015 USD (`NY.GDP.PCAP.KD`)
    -   Government education spending as % of GDP (`SE.XPD.TOTL.GD.ZS`)
-   **Coverage:** Sub-Saharan African countries
-   **Access method:** Downloaded directly in R using the `WDI` package

## Methods

1.  Data acquisition via the World Bank API
2.  Cleaning and reshaping with `dplyr` and `tidyr`
3.  Visualization with `ggplot2` (5 charts)
4.  Linear regression analysis (level-level and log-level specifications)
5.  Reporting in Quarto

## How to Reproduce This Project

1.  Clone this repository or download as a ZIP
2.  Open `education_gdp_project.Rproj` in RStudio
3.  Run the scripts in order:
    -   `scripts/01_data_download.R`
    -   `scripts/02_data_cleaning.R`
    -   `scripts/03_visualizations.R`
    -   `scripts/04_regression_analysis.R`
4.  Open `index.qmd` and click **Render**

## Project Structure

-   education_gdp_project
-   index.qmd
-   index.html
-   data -output
-   scripts

## Key Findings

The analysis finds a weak positive relationship association between education spending and GDP per capita across Sub-Saharan African countries. The simple linear model explains roughly 4.5% of the variation. The results are descriptive — establishing causation would require panel methods, instrumental variables, or accounting for time lags.

## Limitations

This is a descriptive analysis. Findings should not be interpreted as causal because of reverse causality, omitted variables (institutions, geography, resources), and the long time lags between education investment and economic outcomes etc.

## License

This project is shared for educational purposes.

## Contact

[emmanuelunegbu90\@gmail.com](mailto:emmanuelunegbu90@gmail.com){.email}
