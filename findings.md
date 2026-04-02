# Findings

## Executive Summary

This project finds that, in the 2021 Taiwan dataset, the intensity of three government policies was significantly associated with the severity level of new COVID-19 cases. In 2022, although cumulative total cases rose rapidly, mortality rate declined sharply after vaccine coverage expanded. Together, these findings suggest that policy tightening and vaccination rollout were both relevant to pandemic management, though the analysis supports **association rather than causation**.

---

## Key Finding 1: Policy intensity and case severity were significantly associated in 2021

Three Chi-square tests were performed to evaluate whether policy levels and case severity were related.

### Results
- **Face coverings:** X² = 90.402, p = 3.853e-16
- **Public event cancellation:** X² = 119.69, p < 2.2e-16
- **Stay-at-home requirements:** X² = 119.33, p < 2.2e-16

### Interpretation
All three p-values were well below conventional significance thresholds. This means the null hypothesis of no association was rejected for all three policy measures in the 2021 Taiwan dataset. In 2021, the policy intensity variables and the categorized outbreak severity variable were statistically linked, suggesting that policy changes moved together with changes in the outbreak environment.

## Key Finding 2: Policy tightening aligned with the May 2021 outbreak spike

The line charts show that Taiwan’s major outbreak period in 2021 occurred around May to June. During this period:

- face covering policy became more restrictive
- public event cancellation rules were tightened
- stay-at-home requirements were also raised

---

## Key Finding 3: Taiwan followed a “soft lockdown” pattern rather than prolonged hard lockdown

The project observes that Taiwan did not maintain the strictest policy level for extended periods. Instead, restrictions were increased during severe periods and downgraded afterward.

---

## Key Finding 4: In 2022, total cases increased, but mortality rate fell

The 2022 analysis focused on:

- people vaccinated
- total cases
- total deaths
- mortality rate

### Observed pattern
- vaccination levels continued to increase
- total cases rose sharply from around May 2022
- total deaths also increased in absolute terms
- mortality rate dropped substantially after April and remained much lower than earlier in the year

### Interpretation
Although infection volume expanded, the risk of death relative to total cases decreased. This is consistent with the view that broader vaccination coverage reduced the severity of outcomes.The raw number of infections alone did not tell the full story. Once vaccine coverage increased, mortality rate became a more meaningful severity indicator than case volume by itself.

---

## What These Findings Demonstrate

This project shows several practical analytics capabilities:

### 1. Multi-source data integration
The analysis combined one COVID dataset with three policy datasets and aligned them on date.

### 2. Method selection
The project adapted the method to the structure of the variables:
- Chi-square for 2021 categorical association
- trend analysis for 2022 cumulative metrics

### 3. Decision-oriented interpretation
Instead of stopping at statistical output, the findings were translated into a decision story about:
- policy responsiveness
- timing of restrictions
- vaccination and mortality trends

### 4. Analytical maturity
The project also recognizes that:
- significant association is not the same as causal proof
- aggregate country-level data has limitations
- stronger inference would require more advanced models
