# Credit Risk Analysis using SQL

## Project Overview

This project analyzes a Lending Club loan portfolio containing more than **2.2 million loans** to identify the key drivers of credit risk, default behavior, and financial losses.

Using PostgreSQL, the analysis explores borrower characteristics, loan attributes, portfolio concentration, and estimated losses to generate business-oriented recommendations for credit risk management.

The project demonstrates how SQL can be used to transform raw lending data into actionable insights for underwriting, portfolio monitoring, and risk mitigation.

---

## Business Problem

Financial institutions face a fundamental challenge:

> How can they maximize lending activity while minimizing credit losses?

While some borrower segments exhibit high default rates, they do not always generate the greatest financial impact.

The objective of this analysis is to identify:

- Which borrower segments are most likely to default.
- Which segments generate the largest financial losses.
- Which variables are most useful for risk segmentation.
- Where risk management efforts should be prioritized.

---

## Dataset

**Source:** Lending Club Loan Data

The dataset includes information related to:

- Borrower income
- Debt-to-Income Ratio (DTI)
- Credit grade
- Loan purpose
- Home ownership
- Geographic location
- Loan performance

### Portfolio Size

| Metric | Value |
|----------|----------:|
| Total Loans | 2.25M+ |
| Total Funded Amount | $31.7B+ |
| Average Loan Amount | ~$14K |
| States Covered | 50+ |

---

## Tools & Technologies

- PostgreSQL
- DBeaver
- SQL
- Git
- GitHub

---

## SQL Techniques Used

The project incorporates several analytical SQL techniques:

- Data Cleaning
- Feature Engineering
- CASE Statements
- Common Table Expressions (CTEs)
- Aggregations
- Risk Segmentation
- Percentile Analysis
- Portfolio KPI Development
- Estimated Loss Calculation
- Multi-Dimensional Analysis

---

## Analysis Framework

The project follows the following workflow:

1. Data Preparation
2. Data Quality Assessment
3. Portfolio Overview
4. Credit Grade Risk Analysis
5. Income Analysis
6. Debt-to-Income Analysis
7. Loan Purpose Analysis
8. Home Ownership Analysis
9. Geographic Analysis
10. Feature Interaction Analysis
11. Estimated Loss Analysis
12. Executive Recommendations

---

# Key Findings

## 1. Grade is the Strongest Predictor of Default Risk

Default rates increase consistently as borrower grade deteriorates.

| Grade | Default Rate |
|----------|----------:|
| A | 3.49% |
| B | 8.46% |
| C | 14.11% |
| D | 20.09% |
| E | 28.07% |
| F | 36.37% |
| G | 39.97% |

### Insight

Risk increases more than **11 times** from Grade A to Grade G, confirming that borrower grade is the strongest predictor of default probability.

---

## 2. High Default Risk Does Not Necessarily Mean Highest Financial Loss

Although Grades F and G exhibit the highest default rates, they do not generate the largest economic losses.

| Grade | Estimated Loss |
|----------|----------:|
| C | $1.35B |
| D | $1.04B |
| B | $765M |

### Insight

The largest losses are concentrated in **Grade C**, driven by portfolio exposure rather than default rate alone.

This demonstrates the importance of evaluating both:

- Probability of Default
- Portfolio Exposure

---

## 3. Debt Consolidation Dominates Portfolio Exposure

Debt Consolidation is by far the largest loan purpose in the portfolio.

| Metric | Value |
|----------|----------:|
| Loans | 1.27M |
| Funded Amount | $20.26B |
| Estimated Loss | $2.83B |

### Insight

Portfolio concentration can be as important as borrower risk when evaluating overall credit exposure.

---

## 4. Grade C + Debt Consolidation Represents the Highest-Loss Segment

This segment generated the highest estimated loss among all Grade-Purpose combinations.

| Metric | Value |
|----------|----------:|
| Loans | 384,613 |
| Funded Amount | $6.09B |
| Default Rate | 14.47% |
| Estimated Loss | $855M |

### Insight

This segment should be prioritized for monitoring and risk mitigation initiatives.

---

## 5. Debt-to-Income Ratio (DTI) Adds Predictive Value

Higher DTI levels are associated with higher default rates, even within the same credit grade.

### Grade C

| DTI Segment | Default Rate |
|----------|----------:|
| Q1 | 12.54% |
| Q4 | 15.24% |

### Grade E

| DTI Segment | Default Rate |
|----------|----------:|
| Q1 | 24.25% |
| Q4 | 30.13% |

### Insight

DTI provides additional predictive power beyond borrower grade and should be incorporated into risk assessment processes.

---

## Business Recommendations

Based on the analysis, the following actions are recommended:

### Recommendation 1

Prioritize portfolio reviews and monitoring efforts for Grades C and D, which generate the largest estimated losses.

### Recommendation 2

Strengthen underwriting criteria for Debt Consolidation loans, especially within medium- and high-risk grades.

### Recommendation 3

Introduce stricter Debt-to-Income thresholds during the credit approval process.

### Recommendation 4

Develop early-warning indicators for borrowers exhibiting elevated DTI levels and weaker credit grades.

### Recommendation 5

Allocate risk management resources based on estimated loss exposure rather than default rate alone.

---

## Repository Structure

```text
credit-risk-sql-analysis/
│
├── data/
├── images/
├── sql/
│   ├── 01_data_preparation.sql
│   ├── 02_data_quality_checks.sql
│   ├── 03_portfolio_overview.sql
│   ├── 04_risk_analysis_grade.sql
│   ├── 05_risk_analysis_income_dti.sql
│   ├── 06_risk_analysis_purpose_homeownership_state.sql
│   ├── 07_feature_interaction_analysis.sql
│   ├── 08_estimated_loss_analysis.sql
│   └── 09_executive_summary.sql
│
└── README.md
```

---

## Future Improvements

- Build an interactive Power BI dashboard.
- Develop a predictive credit risk model.
- Compare portfolio performance across different economic periods.
- Implement customer-level risk scoring.
- Estimate Expected Loss using Probability of Default and Exposure metrics.

---

## Author

**Alejandro Guerrero**

Data Analytics | SQL | Python | ETL | Risk Analytics

GitHub: https://github.com/guerreroHC
Linkedin: https://www.linkedin.com/in/cesarguerreroh/