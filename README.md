# ⚡ Liquidity Operations & Execution Quality Monitoring System

![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Pandas](https://img.shields.io/badge/Pandas-150458?style=for-the-badge&logo=pandas&logoColor=white)
![NumPy](https://img.shields.io/badge/NumPy-013243?style=for-the-badge&logo=numpy&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Looker Studio](https://img.shields.io/badge/Looker%20Studio-4285F4?style=for-the-badge&logo=google-cloud&logoColor=white)
![Git](https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white)

A portfolio-grade analytics and monitoring system engineered to simulate order execution pipelines, detect liquidity depth degradation, perform Transaction Cost Analysis (TCA), and manage automated risk escalation across synthetic crypto trading venues.

> ⚠️ **Disclaimer:** This project operates on 100% synthetic market data engineered for operational risk modeling and transaction cost analysis. It is not connected to any live exchange or proprietary execution pipeline.

---

### 🛠️ Technical Stack & Infrastructure

| Layer | Technology | Operational Function |
| :--- | :--- | :--- |
| **Data Generation Engine** | Python, Pandas, NumPy | Synthetic market order flow, liquidity collapse simulation, latency & slippage distributions |
| **Storage & Forensics** | MySQL Workbench, SQL | Schema design, CTEs, window functions, SLA breach identification, execution KPI queries |
| **Visualization & TCA** | Looker Studio | Interactive executive monitoring, latency vs. slippage scatter plots, risk state tracking |
| **Version & Workflow** | Git, GitHub, Colab | Version control, modular repo architecture, exploratory analytical workflows |

---

### 🔄 System Data Pipeline

```text
┌──────────────────────────┐      ┌──────────────────────────┐      ┌──────────────────────────┐      ┌──────────────────────────┐
│   Python Risk Engine     │ ───► │  Processed Datasets CSV  │ ───► │   MySQL Database Layer   │ ───► │ Looker Studio Dashboard  │
│ (Order Flow & Anomalies) │      │ (Orders, Fills, Market)  │      │ (CTEs & Forensic Logic)  │      │  (Exec & Risk Insights)  │
└──────────────────────────┘      └──────────────────────────┘      └──────────────────────────┘      └──────────────────────────┘
🚦 Risk State Escalation Model
The system tracks consecutive execution anomalies and dynamically transitions through 4 deterministic risk states:

🟢 NORMAL: Standard execution parameters (low latency, minimal slippage).

🟡 WARNING: Initial anomaly flagged (latency/slippage spike detected).

🟠 THROTTLE: 2 consecutive anomalies; rate-limiting protocols triggered.

🔴 EMERGENCY_PAUSE: 3+ consecutive anomalies; execution circuit-breaker engaged.

liquidity-execution-monitor/
├── README.md                                  # Portfolio documentation & architecture overview
├── .gitignore                                 # System & Python environment exclusions
├── src/
│   └── risk_engine.py                         # Production Python execution simulation script
├── data/
│   └── processed/
│       ├── orders.csv                         # Generated order flow log (5,000 records)
│       ├── fills.csv                          # Execution fill & TCA metrics log
│       ├── market_snapshots.csv               # Top-of-book bid/ask depth & spread logs
│       └── incidents.csv                      # Operational risk breach incident log
├── sql/
│   ├── schema.sql                             # DDL script for database & table creation
│   ├── kpi_analysis.sql                       # Fill rates, latency percentiles & slippage queries
│   └── incident_analysis.sql                  # Risk state transitions & anomaly investigation queries
├── dashboard/
│   ├── README.md                              # Looker Studio section breakdown & live link
│   └── screenshots/                           # Visual dashboard exports
└── docs/
    ├── mysql_setup.md                         # Database initialization & CSV loading guide
    └── liquidity_operations_analysis.ipynb    # Exploratory data analysis notebook
