# Methodology

## Overview

This project evaluates whether government policy intensity was associated with COVID-19 outbreak severity in Taiwan. The analysis is split into two parts:

- **2021 analysis:** tests whether policy levels were significantly associated with daily case severity
- **2022 analysis:** examines vaccination growth, cumulative cases, cumulative deaths, and mortality rate trends

The project uses Taiwan as a case study to show how policy analytics can be structured from raw public data into a decision-oriented analysis.

---

## Analytical Framework

The workflow followed six main steps:

1. Define the policy-effectiveness question
2. Collect COVID-19 and policy response datasets
3. Clean and standardize date fields
4. Merge multiple datasets by date
5. Apply statistical testing and visualization
6. Interpret findings and limitations

---

## Data Sources

The project uses public datasets from **Our World in Data**:

- COVID-19 complete dataset
- Face covering policies
- Public event cancellation policies
- Stay-at-home requirements

These data sources were selected because they provide both outcome metrics and policy intensity indicators in a comparable format.

---

## Scope of Analysis

### Geographic scope
- Taiwan

### Time scope
- **2021:** used for policy-versus-case analysis
- **2022:** used for vaccination and mortality trend analysis

The analysis separates 2021 and 2022 because the policy data used for 2022 had limited variation, making the same 2021 testing approach less useful.

---

## Data Preparation

### Step 1: Filter Taiwan records
The datasets were filtered to include only rows for **Taiwan**.

### Step 2: Standardize date fields
Date variables were converted into date format using `lubridate::ymd()` so they could be merged correctly.

### Step 3: Merge datasets
The COVID dataset was joined with the three policy datasets using date as the common key.

### Step 4: Remove duplicated fields
After joining, redundant year / month / day columns created during preprocessing were removed.

### Step 5: Handle missing values
For the 2022 cumulative metrics, missing values were forward-filled using `zoo::na.locf()`.

---

## Variables Used

### 2021 analysis
- `new_cases`
- `facial_coverings`
- `cancel_public_events`
- `stay_home_requirements`

### 2022 analysis
- `people_vaccinated`
- `total_cases`
- `total_deaths`
- `mortality_rate`

---

## Statistical Method

## 2021: Chi-square test

The original dataset included:

- one **continuous** variable: `new_cases`
- multiple **categorical** policy variables

Because Chi-square requires categorical inputs, `new_cases` was transformed into **five severity levels** using `cut()`.

This created a derived variable:

- `level_new_cases`

Three Chi-square tests were then run:

1. `level_new_cases × facial_coverings`
2. `level_new_cases × cancel_public_events`
3. `level_new_cases × stay_home_requirements`

This approach tests whether the distribution of case severity levels differs across policy intensity levels.

---

## 2022: Trend analysis

For 2022, the project shifted from hypothesis testing to descriptive analysis because the policy variables had limited variation.

The focus moved to:

- vaccination growth
- cumulative cases
- cumulative deaths
- mortality rate trend

Mortality rate was calculated as:

```text
mortality_rate = total_deaths / total_cases
```

This made it possible to evaluate whether severe outcomes fell relative to infections after vaccine coverage increased.

---

## Visualization Strategy

The project used `ggplot2` and `gridExtra` to create two groups of visual outputs.

### 2021 charts
Line charts comparing:
- new cases
- policy intensity levels

These were used to visually inspect whether policy tightening aligned with outbreak spikes.

### 2022 charts
Bar charts for:
- people vaccinated
- total cases
- total deaths

Line chart for:
- mortality rate

These were used to compare whether rising cases also translated into proportionally higher death risk.

---

## Workflow Diagram

```text
Define question
   ↓
Collect COVID-19 + policy data
   ↓
Filter Taiwan data
   ↓
Clean date fields
   ↓
Join multiple datasets by date
   ↓
2021:
- Categorize new_cases
- Run Chi-square tests
   ↓
2022:
- Forward-fill cumulative metrics
- Compute mortality rate
   ↓
Create charts
   ↓
Interpret findings and limitations
```

---

## Why This Method Matters for an Analytics Portfolio

This methodology is useful for interview purposes because it shows the ability to:

- work with real public datasets
- clean and standardize inconsistent data structures
- merge multiple sources into one analytical table
- select methods based on variable type
- convert statistical output into business-facing insights
- document limitations rather than overstating results
