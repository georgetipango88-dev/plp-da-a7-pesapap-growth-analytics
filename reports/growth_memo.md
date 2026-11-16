# PesaPap Growth Analytics

## Executive Growth Report

**Programme:** Power Learn Project — Data Analytics Assignment 7  
**Analysis period:** January–June 2026  
**Currency:** Kenyan Shillings (KES)

---

## 1. Executive Summary

This analysis evaluates PesaPap's customer acquisition, transaction activity, product performance, customer value, retention patterns and experimental conversion outcomes.

The dataset contains 3,000 registered users and 12,000 recorded transactions, with a gross transaction value (GTV) of KES 15,979,309.

A significant data-quality issue was identified: 3,737 transactions (31.14%) occurred before the associated customer's recorded signup date. These records were excluded from post-signup behavioural analysis to avoid overstating genuine customer activity.

The resulting validated dataset contains 8,263 post-signup transactions worth KES 10,956,778.

## 2. Key Performance Indicators

| KPI                             |         Result |
| ------------------------------- | -------------: |
| Registered users                |          3,000 |
| Recorded transactions           |         12,000 |
| Raw GTV                         | KES 15,979,309 |
| Average raw transaction value   |   KES 1,331.61 |
| Pre-signup transactions         |          3,737 |
| Pre-signup transaction rate     |         31.14% |
| Valid post-signup transactions  |          8,263 |
| Valid post-signup GTV           | KES 10,956,778 |
| Average valid transaction value |   KES 1,326.00 |
| Post-signup activation rate     |         90.53% |

## 3. Data Quality and Validation

The initial audit identified no missing values, duplicate primary identifiers or orphan transaction references.

However, 31.14% of transaction records had dates earlier than the associated customer's signup date.

This issue affects the reliability of raw activation, frequency and retention measures. Therefore, post-signup analyses use transactions dated on or after the customer's recorded signup date.

The raw records should be preserved for investigation rather than silently deleted.

## 4. Transaction and Product Performance

Across valid post-signup transactions:

| Product      | Transactions | GTV (KES) | Transaction share |
| ------------ | -----------: | --------: | ----------------: |
| Send Money   |        2,864 | 3,823,065 |            34.66% |
| Airtime      |        2,503 | 3,244,566 |            30.29% |
| Bill Pay     |        1,673 | 2,267,472 |            20.25% |
| Merchant Pay |        1,223 | 1,621,675 |            14.80% |

Send Money generated the largest transaction volume and GTV contribution. Merchant Pay recorded the smallest transaction volume.

## 5. Acquisition and Activation

The validated post-signup activation analysis found:

| Channel  | Registered users | Transacting users | Activation rate |
| -------- | ---------------: | ----------------: | --------------: |
| Search   |              814 |               743 |          91.28% |
| Referral |              720 |               655 |          90.97% |
| Social   |              735 |               663 |          90.20% |
| Agent    |              731 |               655 |          89.60% |

Search recorded the highest activation rate among the four channels.

These results describe observed activity, not acquisition cost or marketing return on investment. Marketing expenditure data was not available.

## 6. Customer Segmentation and Value

The RFM analysis used recency, frequency and monetary value to classify 2,716 customers with valid post-signup transactions.

| Segment             | Customers | GTV (KES) | GTV share |
| ------------------- | --------: | --------: | --------: |
| Champions           |       641 | 4,457,113 |    40.68% |
| Loyal Customers     |       398 | 2,666,250 |    24.33% |
| Needs Attention     |       987 | 2,151,037 |    19.63% |
| Potential Loyalists |       544 | 1,351,083 |    12.33% |
| At Risk             |       146 |   331,295 |     3.02% |

Champions and Loyal Customers together account for approximately 65.01% of valid post-signup GTV.

These segments are based on the project's defined RFM scoring rules.

## 7. Cohort Retention

Customers were grouped by signup month. Monthly retention measures the percentage of each original signup cohort that completed at least one valid transaction in a given month.

The four observed cohorts contained:

- January: 773 customers
- February: 703 customers
- March: 745 customers
- April: 779 customers

Month 1 retention ranged from approximately 53.66% to 55.44%.

The June observation period is incomplete. Recent cohorts also have fewer observable months, so missing cohort periods must not be interpreted as zero retention.

## 8. A/B Experiment

The experiment included 3,000 participants.

| Group | Participants | Conversions | Conversion rate |
| ----- | -----------: | ----------: | --------------: |
| A     |        1,443 |         151 |          10.46% |
| B     |        1,557 |         215 |          13.81% |

Group B recorded a 3.34 percentage-point higher conversion rate than Group A, equivalent to approximately 31.96% relative lift.

The chi-square test produced:

- Chi-square statistic: 7.5106
- Degrees of freedom: 1
- P-value: 0.006134

The observed difference is statistically significant at the 5% level. However, causal interpretation depends on appropriate randomisation, consistent exposure and the absence of material experiment-design bias.

## 9. Strategic Recommendations

### Improve transaction data integrity

Investigate the 3,737 pre-signup transaction records. Review signup timestamps, transaction timestamps, timezone handling and data integration processes.

### Strengthen customer retention

Develop targeted engagement for customers classified as Needs Attention and At Risk. Monitor repeat transaction behaviour and cohort retention over complete observation periods.

### Protect high-value customer relationships

Maintain engagement with Champions and Loyal Customers, who contribute approximately 65.01% of valid GTV.

### Investigate product adoption

Explore ways to improve Merchant Pay adoption while maintaining the strong activity observed in Send Money and Airtime.

### Review acquisition channel performance

Continue monitoring activation by channel. Collect marketing expenditure data before evaluating customer acquisition cost or return on investment.

### Validate experimental implementation

Review the design and implementation of the A/B experiment before using the observed Group B conversion difference to inform a wider rollout.

## 10. Limitations

1. The dataset contains a substantial pre-signup transaction chronology issue.
2. January and June may represent incomplete observation periods.
3. Retention is based on monthly transaction activity, not continuous engagement.
4. Marketing expenditure and acquisition costs were unavailable.
5. RFM segment labels are project-defined.
6. Experiment conclusions depend on the validity of the experimental design.

## 11. Conclusion

The analysis provides a structured view of PesaPap's customer activity, product performance, acquisition channels, customer value and conversion experiment.

The most important immediate priority is improving transaction chronology and data integrity. Once the underlying records are reliable, the business can make more confident decisions about customer activation, retention, product adoption and growth.

---

**Prepared for:** PLP Data Analytics Assignment 7  
**Project:** PesaPap Growth Analytics
