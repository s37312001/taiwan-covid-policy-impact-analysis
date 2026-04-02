# Methodology

## Data
This project uses public COVID-19 and policy response data from **Our World in Data**, focusing on **Taiwan**.

### Datasets
- COVID-19 dataset
- Face covering policies
- Public event cancellation policies
- Stay-at-home restrictions

### Key variables
- `new_cases`
- `people_vaccinated`
- `total_cases`
- `total_deaths`

---

## Data Preparation
I cleaned and standardized the datasets before analysis.

### Main steps
- filtered data for **Taiwan**
- converted date columns into a consistent format
- extracted `year`, `month`, and `day`
- aligned date column names across datasets
- merged datasets using `left_join()`
- removed duplicate columns after merging

---

## Analysis Design

### 2021: Policy vs. Case Severity
In 2021, policy variables were categorical while `new_cases` was continuous.  
To make the variables comparable, I converted `new_cases` into **five severity levels** using `cut()`.

I then used **Chi-square tests** to examine the relationship between case severity and:
- face covering policies
- public event cancellation
- stay-at-home requirements

### 2022: Vaccination vs. Outcome Trends
In 2022, policy variables had limited variation, so I used a different approach.

I focused on:
- vaccination growth
- total case growth
- total death growth
- mortality rate trend

Missing cumulative values were forward-filled using the `zoo` package.

---

## Visualization

### 2021
Used **line charts** to compare:
- new cases
- policy intensity over time

### 2022
Used **bar charts** to show:
- people vaccinated
- total cases
- total deaths

Also created a **mortality rate line chart** using:

```r
total_deaths / total_cases
