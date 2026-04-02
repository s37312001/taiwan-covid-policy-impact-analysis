# taiwan-covid-policy-impact-analysis
Introduction to Data Science essay from Data Science master course, University of Sheffield

# Taiwan COVID-19 Policy Impact Analysis

> An analytical project exploring whether government policy intensity was significantly associated with COVID-19 case severity in Taiwan, and how vaccination expansion related to mortality decline.

## Project Summary

When governments face a public health crisis, they need to decide whether to tighten mask rules, cancel public events, or restrict mobility. This project examines whether those policy shifts were meaningfully associated with pandemic outcomes in Taiwan. Using public COVID-19 data and policy response datasets from Our World in Data, I analyzed the relationship between policy intensity and case severity in 2021, then extended the analysis in 2022 to evaluate vaccination uptake, cumulative cases, and mortality rate trends.:contentReference[oaicite:2]{index=2} :contentReference[oaicite:3]{index=3}

## One-line Project Goal

To evaluate whether pandemic policy intensity in Taiwan was significantly associated with COVID-19 case severity, and whether higher vaccination coverage coincided with lower mortality risk.:contentReference[oaicite:4]{index=4} :contentReference[oaicite:5]{index=5}

## Business / Research Question

### Core question
- Were stricter government interventions associated with changes in COVID-19 case severity in Taiwan?
- After vaccination coverage increased, did mortality risk decline even as total cases rose?:contentReference[oaicite:6]{index=6} :contentReference[oaicite:7]{index=7}

### Decision-oriented framing
This project can be reframed as a policy analytics problem:

- Which non-pharmaceutical interventions are most strongly associated with changes in outbreak severity?
- When cases surge, which policies appear to move in sync with the outbreak most clearly?
- Once vaccination becomes widespread, should policymakers track mortality and severity more closely than raw case volume?

## Why This Project Matters

This project is not just about COVID-19. It demonstrates core analytics skills that are transferable to business analysis and data analysis roles:

- Converting a broad question into measurable analytical hypotheses
- Combining multiple datasets with different structures
- Cleaning and transforming time-series data
- Choosing a suitable statistical test based on variable types
- Presenting findings through charts and decision-friendly summaries
- Explaining limitations instead of overstating conclusions

## Dataset

This project uses public datasets from **Our World in Data**, including both COVID-19 metrics and policy response indicators. The analysis focuses on **Taiwan**.:contentReference[oaicite:8]{index=8} :contentReference[oaicite:9]{index=9}

### Main datasets
1. **OWID COVID-19 dataset**
   - `location`
   - `date`
   - `new_cases`
   - `people_vaccinated`
   - `total_cases`
   - `total_deaths`

2. **Policy response datasets**
   - Face covering policies
   - Cancellation of public events
   - Stay-at-home requirements:contentReference[oaicite:10]{index=10} :contentReference[oaicite:11]{index=11}

### Analysis periods
- **2021:** relationship between policy intensity and new case severity
- **2022:** vaccination, cumulative cases, cumulative deaths, and mortality rate trend:contentReference[oaicite:12]{index=12}

## Methodology

### Workflow

```text
Define question
   ↓
Collect COVID-19 and policy datasets
   ↓
Filter Taiwan data by year
   ↓
Clean and standardize date fields
   ↓
Join COVID data with 3 policy datasets by date
   ↓
2021 analysis:
- Convert new_cases into 5 severity levels
- Run Chi-square tests
   ↓
2022 analysis:
- Select vaccination, total cases, total deaths
- Fill missing cumulative values
- Calculate mortality rate
   ↓
Visualize findings
   ↓
Interpret results and limitations
