* Encoding: UTF-8.
* Load cleaned dataset.
GET FILE='data/BreastRiskData_cleaned.sav'.

* Step 1: Descriptive Statistics.
DESCRIPTIVES VARIABLES=age risk_score
  /STATISTICS=MEAN STDDEV MIN MAX.

* Step 2: Frequencies for categorical variables.
FREQUENCIES VARIABLES=family_history risk_category
  /BARCHART FREQ
  /ORDER=ANALYSIS.

* Step 3: Crosstabs: Family History × Risk Category.
CROSSTABS
  /TABLES=family_history BY risk_category
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ
  /CELLS=COUNT COLUMN EXPECTED
  /BARCHART.

* Step 4: Correlation between Age and Risk Score.
CORRELATIONS
  /VARIABLES=age risk_score
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.

* Step 5: Linear Regression to Predict Risk Score.
REGRESSION
  /DEPENDENT risk_score
  /METHOD=ENTER age family_history risk_category.
