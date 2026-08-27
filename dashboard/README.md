# 📊 Looker Execution Quality & Operations Dashboard

🔗 [View Live Interactive Dashboard](https://datastudio.google.com/s/gYlNDJ42ztk)

This visualization layer provides real-time and post-trade visibility into order execution quality, transaction costs, liquidity depth, and operational risk states across synthetic crypto trading venues.

---

> ⚡ Operational Metrics Summary

| Metric | Benchmark Value | Operational Target |
| --- | --- | --- |
| 📦 **Total Orders** | `5,000` | — |
| ✅ **Fill Rate** | `97.58%` | $>95.00\%$ |
| ⚡ **Avg Latency** | `43.48 ms` | $<50.00\text{ ms}$ |
| 🚨 **Open Incidents** | `410` | Minimizing Critical Breaches |

---

>🔍 Dashboard Sections & Analytical Modules

🎯 1. Executive Overview

>High-Level Operations Monitoring:** Tracks overall system health and execution volume.


>Core KPIs:** Aggregates total order flow, global fill rate, system-wide latency, and active incidents in real time.


>Asset Breakdown:** Filters performance across major trading pairs (`BTCUSDT`, `ETHUSDT`, `SOLUSDT`).

>> 📈 2. Execution Quality & Transaction Cost Analysis (TCA)

>Microstructure TCA:** Analyzes price slippage distributions and execution latency.
>Scatter Plot Correlation:** Visualizes latency spikes vs. slippage percentage deterioration.
>Venue & Symbol Metrics:** Highlights asset-level execution quality anomalies.

>> 💧 3. Liquidity Depth & Market Stress Monitoring

>Order Book Health:** Tracks top-of-book bid and ask depth collapse during high-volatility events.
>Spread Dynamics:** Monitors bid-ask spread widening during synthetic market stress cycles.

>> 🛡️ 4. Operational Risk & Incident Tracking

>Automated Risk Engine:** Tracks real-time state machine transitions (`NORMAL` ➔ `WARNING` ➔ `THROTTLE` ➔ `EMERGENCY_PAUSE`).
>Forensic Log:** Categorizes incident severity (`CRITICAL`, `HIGH`) and flags SLA execution breaches.

---

🖼️ *High-resolution visual exports for each section are available in the [`screenshots/`](https://www.google.com/search?q=screenshots/) directory.*
