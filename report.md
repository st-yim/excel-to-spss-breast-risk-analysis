# Breast Cancer Risk Analysis Report

_This report summarizes findings from a synthetic breast cancer screening dataset created in Excel and analyzed using SPSS._

---

## 📁 Dataset Overview

The dataset used in this analysis is included in [`data/BreastRiskData.xlsx`](../data/BreastRiskData.xlsx).  
See the `README.md` for full details on how the data were constructed and recoded.

| Variable Name         | Label                                 | Type     | Notes                                  |
|-----------------------|----------------------------------------|----------|----------------------------------------|
| `patient_id`          | Patient ID                             | String   | Unique identifier                      |
| `age`                 | Age (years)                            | Numeric  | 30–75 range                            |
| `family_history`      | Family History of Breast Cancer        | Numeric  | 0 = No, 1 = Yes                        |
| `risk_score`          | Risk Score (%)                         | Numeric  | 5–30% scale                            |
| `risk_category`       | Risk Category                          | Ordinal  | 1 = Avg, 2 = Int, 3 = High             |
| `screen_recommend`    | Screening Recommendation               | String   | Textual recommendation based on risk   |

---

## 🔢 Descriptive Statistics

**Frequencies:**

- **Family History**  
  - Yes: 47.4%  
  - No: 52.6%  

- **Risk Category**  
  - Average: 42.1%  
  - Intermediate: 31.6%  
  - High: 26.3%  

**Descriptives:**

- Mean Age: **50.8 years**  
- Mean Risk Score: **16.45%**  

---

## 📊 Crosstab Analysis

**Relationship between Family History and Risk Category:**

|                        | Average | Intermediate | High | Total |
|------------------------|---------|--------------|------|-------|
| No Family History      | 5       | 5            | 0    | 10    |
| Yes (Family History)   | 3       | 1            | 5    | 9     |

- **Pearson Chi-Square** = 8.137  
- **p-value** = 0.017 → **statistically significant**

🔎 Interpretation:  
Patients with a family history of breast cancer are more likely to fall into the **high-risk** category.

---

## 📈 Correlation

**Pearson correlation between Age and Risk Score**  
- r = **0.410**, p = **0.081**

📌 This indicates a **moderate positive relationship**, though not statistically significant at α = 0.05.

---

## 📉 Regression Analysis

**Simple linear regression: Predict Risk Score using Age**

- Coefficient for Age: **0.211**
- R² = **0.168**  
- p = **0.081**

📌 Interpretation:  
For each additional year of age, the model estimates a **+0.21%** increase in risk score, though not statistically significant in this sample.

---

## 🖼️ Figures

Key plots and regression tables have been exported to the [`figures/`](../figures) folder:

- `risk_distribution.png` – Crosstab bar chart  
- `regression_output.png` – Coefficients table from linear regression  

---

## 📂 Files & Scripts

| Component         | Path                              | Description                               |
|------------------|-----------------------------------|-------------------------------------------|
| Data              | `data/BreastRiskData_cleaned.sav` | SPSS-ready dataset after cleaning         |
| Cleaning Script   | `scripts/01_cleaning.sps`         | SPSS syntax for variable setup & recodes  |
| Analysis Script   | `scripts/02_analysis.sps`         | Frequencies, crosstabs, regression         |
| Report            | `report.md`                       | You are here!                             |

---

## ✅ Summary

This project walks through:

- Creating a realistic synthetic breast cancer dataset
- Preprocessing and coding in SPSS
- Running meaningful analysis steps like frequencies, crosstabs, and regression
- Writing up findings in a reproducible format

_This showcases the fundamentals of real-world clinical data analysis._

