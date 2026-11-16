# PesaPap Growth Analytics

## Project Overview

PesaPap Growth Analytics is a data analytics project developed for PLP Data Analytics Assignment 7.

The project analyses customer acquisition, transaction activity, product performance, customer segmentation, cohort retention and A/B experiment outcomes.

## Technologies Used

- Python
- Pandas
- NumPy
- Matplotlib
- SciPy
- SQLite
- Jupyter Notebook
- SQL

## Project Structure

```text
plp-da-a7-pesapap-growth-analytics/
│
├── users.csv
├── transactions.csv
├── experiment.csv
├── pesapap.db
├── generate_data.py
├── build_database.py
├── pesapap_analysis.ipynb
├── requirements.txt
├── README.md
│
├── sql/
│   └── queries.sql
│
└── reports/
    └── growth_memo.md
```

## Key Analysis Areas

1. Data validation and quality assessment.
2. Transaction KPIs and gross transaction value.
3. Product and acquisition channel performance.
4. Customer activation.
5. RFM customer segmentation.
6. Cohort retention analysis.
7. A/B experiment statistical testing.
8. Business recommendations.

## Important Data Quality Finding

The analysis identified 3,737 transactions (31.14% of recorded transactions) occurring before the associated customers' recorded signup dates.

These records were excluded from post-signup behavioural analysis. The original records were retained for investigation.

## Setup Instructions

Create and activate a Python virtual environment, then install the dependencies:

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install -r requirements.txt
```

Run the analysis notebook using Jupyter or VS Code.

## Reports

The executive growth report is available in:

`reports/growth_memo.md`

## Author

PLP Data Analytics Assignment 7 — PesaPap Growth Analytics
