\# MySQL Database Setup \& Forensic Queries



\## 1. Schema Initialization

Execute `sql/schema.sql` in MySQL Workbench or terminal:

`source sql/schema.sql;`



This initializes the `liquidity\_monitor` database schema for `orders`, `fills`, `market\_snapshots`, and `incidents`.



\## 2. Data Loading

Import CSV files from `data/processed/` into MySQL:

\* `orders.csv` -> `orders`

\* `fills.csv` -> `fills`

\* `market\_snapshots.csv` -> `market\_snapshots`

\* `incidents.csv` -> `incidents`



\## 3. Analytical Queries

\* `sql/kpi\_analysis.sql`: Calculates fill rates, latency percentiles, slippage, and spread widening.

\* `sql/incident\_analysis.sql`: Investigates risk state transitions and execution breaches during volatile events.

