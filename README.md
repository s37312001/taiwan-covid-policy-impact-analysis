# Taiwan COVID-19 Policy Impact Analysis

> A data analysis project exploring whether government policy intensity was significantly associated with COVID-19 case severity in Taiwan, and how vaccination expansion related to mortality decline.

---
## 1. Project Structure

```text
├── README.md
├── docs/
│   ├── methodology.md
│   ├── findings.md
│   ├── conclution_and_limitations.md
│   └── references.md
├── scripts/
│   └── analysis.R
```
---

## 2. Project Overview

This project analyzes whether government policy responses were meaningfully associated with COVID-19 outcomes in Taiwan.

Using public datasets from **Our World in Data**, I combined Taiwan’s COVID-19 case data with three policy indicators:

- Face covering policies
- Cancellation of public events
- Stay-at-home requirements

The project focuses on two analytical questions:

1. In **2021**, were stricter policies significantly associated with higher COVID-19 case severity?
2. In **2022**, after vaccination coverage increased, did mortality risk decline even though total cases rose?

---

## 3. Why I Chose This Topic

Governments often need to make time-sensitive decisions during crises, but decision-makers cannot rely on intuition alone.  
This project starts from a practical question:

> When case numbers surge, do policy changes actually move together with outbreak severity?

---

## 4. Problem Statement

### Research Question
- Are government policy measures significantly associated with COVID-19 case severity in Taiwan?
- Does increased vaccination coverage correspond with lower mortality risk?
---

## 5. Data Source

### Main Source
Public datasets from **Our World in Data**

### Datasets Used
- `owid-covid-data.csv`
- `face-covering-policies-covid.csv`
- `public-events-covid.csv`
- `stay-at-home-covid.csv`

### Key Variables
#### 2021 analysis
- `location`
- `date`
- `new_cases`
- `facial_coverings`
- `cancel_public_events`
- `stay_home_requirements`

#### 2022 analysis
- `people_vaccinated`
- `total_cases`
- `total_deaths`

---
## 6. Recommended Reading Order
1. [Methodology](methodology.md)
2. [Findings](findings.md)
3. [Conclution](conclution_and_limitation.md)
4. [References](references.md)
5. [Analysis Script](analysis.R)

