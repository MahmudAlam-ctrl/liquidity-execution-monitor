---

## Repository Structure

```text
liquidity-execution-monitor/
├── README.md
├── .gitignore
├── src/
│   └── risk_engine.py
├── data/
│   └── processed/
│       ├── orders.csv
│       ├── fills.csv
│       ├── market_snapshots.csv
│       └── incidents.csv
├── sql/
│   ├── schema.sql
│   ├── kpi_analysis.sql
│   └── incident_analysis.sql
├── dashboard/
│   ├── README.md
│   └── screenshots/
└── docs/
    ├── mysql_setup.md
    └── liquidity_operations_analysis.ipynb