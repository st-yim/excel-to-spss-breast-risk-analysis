* Encoding: UTF-8.
SET DECIMAL COMMA OFF.
SET UNICODE ON.

* 1 ── Import raw Excel file.
GET DATA
  /TYPE=XLSX
  /FILE="data/BreastRiskData.xlsx"
  /SHEET=name "Sheet1"
  /FIRSTCASE=2            /* row 1 has headers            */
  /READNAMES=ON
  /ASSUMEDSTRWIDTH=100.
EXECUTE.

* 2 ── Rename variables to tidy snake_case.
RENAME VARIABLES
  (PatientID           = patient_id)
  (Age                 = age)
  ("FamilyHistory (Yes/No)" = family_history)
  ("RiskScore (%)"     = risk_score)
  (RiskCategory        = risk_category)
  (ScreeningRec        = screen_recommend).

* 3 ── Recode Family History: Yes→1, No→0.
RECODE family_history ('Yes'=1) ('No'=0).
VARIABLE LEVEL family_history (NOMINAL).
VALUE LABELS  family_history 0 'No' 1 'Yes'.
VARIABLE LABELS family_history "Family history of breast cancer (0=No, 1=Yes)".
EXECUTE.

* 4 ── Recode Risk Category: Average=1, Intermediate=2, High=3.
RECODE risk_category ('Average'=1) ('Intermediate'=2) ('High'=3).
VARIABLE LEVEL risk_category (ORDINAL).
VALUE LABELS  risk_category
  1 'Average'
  2 'Intermediate'
  3 'High'.
VARIABLE LABELS risk_category "Risk category (1=Avg, 2=Int, 3=High)".
EXECUTE.

* 5 ── Ensure correct measurement levels.
VARIABLE LEVEL age risk_score (SCALE).
VARIABLE LEVEL patient_id screen_recommend (NOMINAL).

* 6 ── Save cleaned dataset.
SAVE OUTFILE="data/BreastRiskData_cleaned.sav"
  /COMPRESSED.
EXECUTE.
