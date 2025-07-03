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
│ ├── BreastRiskData.xlsx # original synthetic Excel file
│ └── BreastRiskData_cleaned.sav # SPSS dataset after recodes
├── scripts/
│ └── analysis.sps # SPSS syntax: recodes, descriptives, crosstabs, regression
├── figures/
│ ├── risk_distribution.png # exported bar/box plots
│ └── regression_output.png # exported coefficients table
├── output/
│ └── BreastRisk_output.spv # SPSS Viewer file (optional, binary)
├── report.md # narrative findings write-up
└── README.md # you’re here
```

---

## 4 · New SPSS steps added (2025-07-02)

| Step | What was done | Where captured |
|------|---------------|----------------|
| **Import Excel → SPSS** | `File ▸ Open ▸ Data…` → imported **BreastRiskData.xlsx** into SPSS. | Start of `analysis.sps` |
| **Variable renaming & recoding** | - Renamed variables to tidy snake-case.<br>- Re-coded **FamilyHistory** “Yes/No” → 1/0.<br>- Re-coded **RiskCategory** *Average/Intermediate/High* → 1/2/3 (ordinal). | `analysis.sps` (section 1) |
| **Descriptives & Crosstab** | - Frequencies & descriptives for age, risk score.<br>- Crosstab + χ² for *FamilyHistory × RiskCategory*. | `analysis.sps` (section 2) |
| **Linear regression** | Modeled `risk_score` using `age`, `family_history`, `risk_category`. | `analysis.sps` (section 3) |
| **Figures exported** | Saved key plots/tables as PNG to **figures/** for use in the Markdown report. | `figures/` |
| **Write-up** | Summarised methods, key statistics, and interpretation. | `report.md` |

> **Re-run the analysis:**  
> 1. Open **scripts/analysis.sps** in IBM SPSS Statistics.  
> 2. Ensure `data/BreastRiskData_cleaned.sav` is present.  
> 3. Choose **Run ▸ All** to reproduce every table and figure.
