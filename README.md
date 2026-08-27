# Liquidity Operations & Execution Quality Monitoring System

A portfolio-grade analytics and monitoring system that simulates order execution, detects liquidity degradation, evaluates operational risk, and provides SQL forensic analysis alongside Looker dashboards.

> **Disclaimer:** This project uses 100% synthetic data generated for operational modeling purposes and is not connected to any live exchange or proprietary trading system.

---

## Technical Stack & Architecture

- **Language & Libraries:** Python (Pandas, NumPy)
- **Database Engine:** MySQL Workbench (Schema Design, Bulk Data Loading, CTEs, Window Functions)
- **Visualization:** Looker Studio (Multi-page Executive & Risk Dashboard)
- **Version Control:** Git & GitHub

```text
Python Generator ➔ Processed CSV Layer ➔ MySQL Forensic Layer ➔ Looker Studio Dashboard







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
