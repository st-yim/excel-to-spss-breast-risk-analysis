# Excel-To-SPSS-Breast-Risk-Analysis

_Project demonstrating the creation of a synthetic breast cancer screening dataset in Excel, followed by statistical analysis in SPSS._

The repo walks through:

1. **Building a synthetic breast-cancer-screening dataset** in **Excel**
2. **Importing that dataset into SPSS**
3. Running a **basic analysis pipeline** that simulates real-world screening workflows

---

## 1 · Dataset (Excel)

### 1.1 Structure

| Column | Type | Example | Description |
|--------|------|---------|-------------|
| `PatientID` | text | `P001` | Auto-generated ID (`="P"&TEXT(ROW(A1),"000")`) |
| `Age` | integer | 52 | `RANDBETWEEN(30,75)` |
| `FamilyHistory` | text | Yes / No | `=IF(RAND()<0.3,"Yes","No")` (≈ 30 % have FH +) |
| `RiskScore` | decimal ( % ) | 18.4 | `=ROUND(RAND()*25+5,1)` → 5 – 30 % |
| `RiskCategory` | text | Average / Intermediate / High | `IFS(RiskScore<15,"Average", RiskScore<20,"Intermediate", TRUE,"High")` |
| `ScreeningRec` | text | Annual mammogram + MRI | Nested `IF` based on `RiskCategory` |

### 1.2 Why these ranges?

* **RiskScore 5 – 30 %** mirrors the **Tyrer–Cuzick** 10-year risk output  
  * < 15 % = Average  
  * 15–19.9 % = Intermediate  
  * ≥ 20 % = High  
* **Screening recommendations** follow ACS / NCCN guidance  
  * High → mammogram + MRI  
  * Intermediate → annual mammogram  
  * Average → start at age ≥ 40

An outlier > 30 % can be added manually to show “very-high-risk” handling.

---

## 2 · SPSS Workflow

1. **File ▶ Open ▶ Data…**  
   *Choose Excel → select `PatientData.xlsx`*
2. In the import wizard  
   * first row = variable names  
   * set `RiskScore` as _Scale_, others as shown above.
3. **Variable labels & value labels** (Doc in `spss/01_variable_setup.sps`)  
   * Adds clarity for `FamilyHistory`, `RiskCategory`.
4. **Analysis scripts** (`spss/02_analysis.sps`):  
   * Frequencies (`RiskCategory`, `FamilyHistory`)  
   * Descriptives (mean / sd of `RiskScore` by category)  
   * Crosstab (`FamilyHistory` × `RiskCategory`) with χ²

Outputs saved to `output/`.

---

## 3 · Repo layout

```
├── data/
│   ├── BreastRiskData.xlsx            # Original synthetic Excel dataset
│   └── BreastRiskData_cleaned.sav     # Cleaned SPSS dataset after recoding
├── scripts/
│   ├── 01_cleaning.sps                # SPSS syntax for recoding variables, value labels
│   └── 02_analysis.sps                # SPSS syntax for descriptives, crosstabs, regression
├── figures/
│   ├── risk_distribution.png          # Exported bar or box plot of risk categories
│   └── regression_output.png          # Screenshot of regression coefficients table
├── output/
│   └── BreastRisk_output.spv          # SPSS output file (viewer format, binary)
├── report.md                          # Written summary of analysis findings and interpretation
└── README.md                          # You’re here — project overview and instructions
```

---

## 4 · SPSS Analysis Pipeline Overview

| Step                     | What Was Done                                                                                                                                  | Where Captured                |
|--------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------|
| **Import Excel → SPSS** | Opened `File ▸ Open ▸ Data…` and imported **BreastRiskData.xlsx** into SPSS.                                                                  | Start of `scripts/01_cleaning.sps` |
| **Variable renaming & recoding** | - Renamed variables to tidy snake_case.  
| Re-coded **FamilyHistory** from “Yes/No” to 1/0.  
| Re-coded **RiskCategory** from Average/Intermediate/High to 1/2/3 (ordinal). | `scripts/01_cleaning.sps`     |
| **Descriptives & Crosstabs** | - Ran frequencies and descriptives for `age` and `risk_score`.  
| Crosstab + chi-square test for `family_history × risk_category`.                            | `scripts/02_analysis.sps`     |
| **Linear regression**    | Modeled `risk_score` as a function of `age`, `family_history`, and `risk_category`.                                                          | `scripts/02_analysis.sps`     |
| **Figures exported**     | Exported bar plots and regression output as PNGs for use in report.                                                                          | `figures/`                    |
| **Write-up**             | Summarized steps, findings, and interpretation.                                                                                              | `report.md`                   |


> **Re-run the analysis:**  
> 1. Open **scripts/02_analysis.sps** in IBM SPSS Statistics.  
> 2. Ensure `data/BreastRiskData_cleaned.sav` is present.  
> 3. Choose **Run ▸ All** to reproduce every table and figure.
