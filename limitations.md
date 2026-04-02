# Limitations

## Overview

This project provides a useful policy analytics case study, but it also has several limitations. These should be stated clearly in interviews and portfolio materials because they show analytical maturity and help avoid overstating the results.

---

## 1. The analysis shows association, not causation

The strongest limitation is methodological:

- the Chi-square test identifies whether two categorical variables are associated
- it does **not** prove that one variable caused the other

### What this means
Even though policy intensity and case severity were significantly related, this does not prove that the policies directly reduced or increased cases. Other external factors may have influenced both variables.

### Better interview phrasing
Instead of saying:

> These policies caused case numbers to fall

say:

> These policies were significantly associated with changes in outbreak severity in the observed dataset.

---

## 2. No time-lag effect was modeled

Policy changes do not usually affect outbreak metrics on the same day. There is often a lag between:

- policy implementation
- behavior change
- infection dynamics
- reported case numbers

### Why this matters
A same-day comparison may understate or misrepresent the real policy effect.

### Future improvement
A stronger version of this project would test:
- 7-day lag
- 14-day lag
- rolling averages
- time-series models

---

## 3. Taiwan was analyzed only at the national level

The data used here represents Taiwan as a whole and does not include regional breakdowns.

### Why this matters
Different cities or regions may have had:
- different outbreak intensity
- different mobility patterns
- different local policy enforcement
- different healthcare capacity

A country-level view can hide important regional variation.

---

## 4. Limited variation in 2022 policy data

The 2022 policy variables used in the original report had little usable variation, which meant the same statistical approach from 2021 could not be extended consistently.

### Why this matters
This limited direct year-over-year policy comparison.

### Resulting adjustment
The 2022 analysis was changed to focus on:
- vaccination
- cumulative cases
- cumulative deaths
- mortality rate

That makes the project coherent, but also means the two sections answer slightly different analytical questions.

---

## 5. Important control variables were not included

The project does not account for several factors that may influence both policy and outcome metrics, such as:

- vaccination lag
- virus variants
- testing volume
- mobility changes
- hospital capacity
- ICU load
- age structure of infections
- public compliance behavior

### Why this matters
Without these controls, the model cannot isolate the specific effect of each policy.

---

## 6. The use of binned case severity loses some detail

To run Chi-square tests, `new_cases` was converted from a continuous variable into five categories.

### Trade-off
This was a practical solution, but it also reduces information.

### Why this matters
Two days with quite different case counts may fall into the same category, while small cut-point choices can affect the result.

### Future improvement
A stronger approach would test:
- regression models
- generalized linear models
- interrupted time-series
- panel approaches if regional data is available

---

## 7. 2022 charts use cumulative metrics

The 2022 analysis uses cumulative totals for:
- vaccinations
- cases
- deaths

### Why this matters
Cumulative charts are useful for showing scale, but they can make growth patterns look smoother and may hide short-term turning points.

### Future improvement
Add:
- daily change
- 7-day moving average
- weekly growth rate

---

## 8. Literature depth can be expanded

The original report correctly notes that the literature review could be stronger.

### Why this matters
A broader literature review would help:
- sharpen the research framing
- compare Taiwan against similar countries
- justify variable selection more rigorously
- position the findings within existing evidence

---

## 9. Visual design can be improved for portfolio use

The charts are sufficient for analysis, but a GitHub portfolio version would benefit from:
- stronger titles
- more consistent styling
- annotation of key policy dates
- clearer axis labeling
- summary captions

### Why this matters
For interview use, presentation quality matters almost as much as the analysis itself.

---

## Best Way to Explain the Limitations in an Interview

A concise version you can say out loud:

> This project shows statistically significant associations between policy intensity and case severity, but I would not claim causal impact yet. The current version is limited by national-level aggregation, lack of lag analysis, and missing control variables like mobility or testing volume. If I were extending it, I would move toward time-series or regression-based modeling and include more granular regional data.
