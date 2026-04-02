# requirements_or_packages.md

## Language

This project is written in **R**.

---

## Required Packages

Install the following packages before running the analysis:

```r
install.packages(c(
  "tidyverse",
  "lubridate",
  "ggplot2",
  "gridExtra",
  "zoo"
))
```

---

## Package Purpose

### tidyverse
Used for general data wrangling and piping workflow.

Main uses in this project:
- data transformation
- joins
- mutation
- filtering
- selecting columns

### lubridate
Used to parse and manipulate date variables.

Main uses:
- convert raw date strings into date format
- extract year information for filtering

### ggplot2
Used for building all charts in the project.

Main uses:
- line charts for policy intensity vs new cases
- bar charts for vaccination, cases, and deaths
- mortality trend line chart

### gridExtra
Used to combine multiple plots into one arranged output.

Main uses:
- stack 2021 policy charts vertically
- stack 2022 bar charts vertically

### zoo
Used for forward-filling missing cumulative values.

Main uses:
- handle missing values in 2022 vaccination / case / death data using `na.locf()`

---

## Optional Environment Notes

Recommended:
- R 4.2 or above
- RStudio for running and editing the script

---

## Expected File Inputs

Place the following CSV files inside:

```text
data/raw/
```

Required files:
- `owid-covid-data.csv`
- `face-covering-policies-covid.csv`
- `public-events-covid.csv`
- `stay-at-home-covid.csv`

---

## How to Run

From the project root:

```r
source("scripts/analysis.R")
```

This script will:
- create processed CSV outputs
- generate figure files
- print Chi-square results in the console

---

## Suggested Output Folders

```text
data/processed/
figures/
```

Generated outputs include:
- merged 2021 policy dataset
- 2021 Chi-square results
- 2022 processed metrics dataset
- portfolio-ready PNG charts
