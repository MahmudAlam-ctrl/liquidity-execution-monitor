import os
import random
from datetime import datetime, timedelta

import numpy as np
import pandas as pd


# ============================================================
# PROJECT CONFIGURATION
# ============================================================

NUM_ORDERS = 5000
START_TIME = datetime(2026, 8, 26, 9, 0, 0)

SYMBOLS = ["BTCUSDT", "ETHUSDT", "SOLUSDT"]

OUTPUT_DIR = "data/processed"


# ============================================================
# REPRODUCIBILITY
# ============================================================

np.random.seed(42)
random.seed(42)


# ============================================================
# CREATE OUTPUT DIRECTORY
# ============================================================

os.makedirs(OUTPUT_DIR, exist_ok=True)

print("Project directories ready.")


# ============================================================
# INITIALIZE DATA COLLECTIONS
# ============================================================

orders = []
fills = []
snapshots = []
incidents = []

current_time = START_TIME
risk_state = "NORMAL"
consecutive_anomalies = 0

print("Risk engine configuration loaded.")


# ============================================================
# SYNTHETIC MARKET / ORDER SIMULATION
# ============================================================

for i in range(1, NUM_ORDERS + 1):

    # --------------------------------------------------------
    # Order identifiers
    # --------------------------------------------------------

    order_id = f"ORD-{i:06d}"
    fill_id = f"FIL-{i:06d}"

    # --------------------------------------------------------
    # Random market attributes
    # --------------------------------------------------------

    symbol = random.choice(SYMBOLS)
    side = random.choice(["BUY", "SELL"])

    if symbol == "BTCUSDT":
        base_price = 60000.0
    elif symbol == "ETHUSDT":
        base_price = 3000.0
    else:
        base_price = 140.0

    # --------------------------------------------------------
    # Market price simulation
    # --------------------------------------------------------

    mid_price = round(
        base_price + np.random.normal(0, base_price * 0.001),
        2
    )

    half_spread = round(mid_price * 0.0001, 2)

    best_bid = round(mid_price - half_spread, 2)
    best_ask = round(mid_price + half_spread, 2)

    # --------------------------------------------------------
    # Synthetic market stress condition
    #
    # Every 120 orders, orders 100-110 represent a
    # temporary liquidity / execution stress period.
    # --------------------------------------------------------

    is_anomaly = (
        (i % 120 >= 100)
        and
        (i % 120 <= 110)
    )

    # --------------------------------------------------------
    # Normal vs stressed market conditions
    # --------------------------------------------------------

    if is_anomaly:

        # Liquidity becomes thin
        bid_depth = round(
            random.uniform(0.1, 0.5),
            4
        )

        ask_depth = round(
            random.uniform(0.1, 0.5),
            4
        )

        # Latency increases significantly
        latency_ms = int(
            np.random.exponential(scale=250) + 180
        )

        # Execution slippage increases
        slippage_pct = round(
            random.uniform(0.15, 0.45),
            4
        )

        consecutive_anomalies += 1

    else:

        # Normal liquidity
        bid_depth = round(
            random.uniform(5.0, 25.0),
            4
        )

        ask_depth = round(
            random.uniform(5.0, 25.0),
            4
        )

        # Normal API / execution latency
        latency_ms = int(
            np.random.exponential(scale=12) + 5
        )

        # Normal execution slippage
        slippage_pct = round(
            abs(np.random.normal(0.01, 0.02)),
            4
        )

        # Gradually recover from anomaly state
        consecutive_anomalies = max(
            0,
            consecutive_anomalies - 1
        )

    # --------------------------------------------------------
    # Order quantity
    # --------------------------------------------------------

    requested_qty = round(
        random.uniform(0.1, 2.5),
        3
    )

    # --------------------------------------------------------
    # Expected execution price
    # --------------------------------------------------------

    requested_price = (
        best_ask
        if side == "BUY"
        else best_bid
    )

    # --------------------------------------------------------
    # Simulated execution price
    # --------------------------------------------------------

    price_dir = (
        1
        if side == "BUY"
        else -1
    )

    executed_price = round(
        requested_price
        * (
            1
            + (
                price_dir
                * (slippage_pct / 100)
            )
        ),
        2
    )

    # --------------------------------------------------------
    # Order status
    #
    # During anomaly periods there is a 25% chance
    # that an order is rejected.
    # --------------------------------------------------------

    status = (
        "REJECTED"
        if (
            is_anomaly
            and
            random.random() < 0.25
        )
        else "FILLED"
    )

    # --------------------------------------------------------
    # Event timestamp
    # --------------------------------------------------------

    current_time += timedelta(
        milliseconds=random.randint(50, 300)
    )

    ts_str = current_time.strftime(
        "%Y-%m-%d %H:%M:%S.%f"
    )[:-3]

    # ========================================================
    # RISK STATE MACHINE
    # ========================================================

    if consecutive_anomalies >= 3:

        risk_state = "EMERGENCY_PAUSE"

    elif consecutive_anomalies == 2:

        risk_state = "THROTTLE"

    elif consecutive_anomalies == 1:

        risk_state = "WARNING"

    else:

        risk_state = "NORMAL"

    # ========================================================
    # ORDERS DATASET
    # ========================================================

    orders.append([
        order_id,
        ts_str,
        symbol,
        side,
        "MARKET",
        requested_price,
        requested_qty,
        status
    ])

    # ========================================================
    # FILLS DATASET
    # ========================================================

    if status == "FILLED":

        fee = round(
            executed_price
            * requested_qty
            * 0.0004,
            4
        )

        fills.append([
            fill_id,
            order_id,
            ts_str,
            requested_price,
            executed_price,
            requested_qty,
            latency_ms,
            fee,
            "SUCCESS",
            slippage_pct,
            risk_state
        ])

    # ========================================================
    # MARKET SNAPSHOT DATASET
    # ========================================================

    snapshots.append([
        ts_str,
        symbol,
        best_bid,
        best_ask,
        bid_depth,
        ask_depth
    ])

    # ========================================================
    # INCIDENT GENERATION
    # ========================================================

    if (
        risk_state in [
            "THROTTLE",
            "EMERGENCY_PAUSE"
        ]
        and
        is_anomaly
    ):

        incidents.append([
            f"INC-{len(incidents) + 1:04d}",
            ts_str,
            (
                "CRITICAL"
                if risk_state == "EMERGENCY_PAUSE"
                else "HIGH"
            ),
            "Execution Quality",
            symbol,
            (
                f"Slippage: {slippage_pct}%, "
                f"Latency: {latency_ms}ms"
            ),
            risk_state,
            "OPEN"
        ])


print("Synthetic market simulation completed.")


# ============================================================
# CREATE DATAFRAMES
# ============================================================

orders_df = pd.DataFrame(
    orders,
    columns=[
        "order_id",
        "timestamp",
        "symbol",
        "side",
        "order_type",
        "requested_price",
        "quantity",
        "status"
    ]
)


fills_df = pd.DataFrame(
    fills,
    columns=[
        "fill_id",
        "order_id",
        "timestamp",
        "expected_price",
        "executed_price",
        "quantity",
        "latency_ms",
        "fee",
        "status",
        "slippage_pct",
        "risk_state"
    ]
)


snapshots_df = pd.DataFrame(
    snapshots,
    columns=[
        "timestamp",
        "symbol",
        "best_bid",
        "best_ask",
        "bid_depth",
        "ask_depth"
    ]
)


incidents_df = pd.DataFrame(
    incidents,
    columns=[
        "incident_id",
        "timestamp",
        "severity",
        "category",
        "symbol",
        "trigger",
        "risk_state",
        "status"
    ]
)


print("DataFrames created.")


# ============================================================
# DATASET SUMMARY
# ============================================================

print()
print("===== DATASET SUMMARY =====")
print(f"Orders: {len(orders_df):,}")
print(f"Fills: {len(fills_df):,}")
print(f"Market snapshots: {len(snapshots_df):,}")
print(f"Incidents: {len(incidents_df):,}")


# ============================================================
# EXPORT CSV FILES
# ============================================================

orders_df.to_csv(
    os.path.join(OUTPUT_DIR, "orders.csv"),
    index=False
)

fills_df.to_csv(
    os.path.join(OUTPUT_DIR, "fills.csv"),
    index=False
)

snapshots_df.to_csv(
    os.path.join(OUTPUT_DIR, "market_snapshots.csv"),
    index=False
)

incidents_df.to_csv(
    os.path.join(OUTPUT_DIR, "incidents.csv"),
    index=False
)


print()
print("CSV files successfully generated.")


# ============================================================
# DATA QUALITY CHECK
# ============================================================

print()
print("===== DATA QUALITY CHECK =====")

print()
print("Orders")
print(orders_df.info())

print()
print("Fills")
print(fills_df.info())

print()
print("Market Snapshots")
print(snapshots_df.info())

print()
print("Incidents")
print(incidents_df.info())


print()
print("===== MISSING VALUES =====")

print()
print("Orders")
print(orders_df.isna().sum())

print()
print("Fills")
print(fills_df.isna().sum())

print()
print("Market Snapshots")
print(snapshots_df.isna().sum())

print()
print("Incidents")
print(incidents_df.isna().sum())


# ============================================================
# EXECUTION KPIs
# ============================================================

total_orders = len(orders_df)

filled_orders = (
    orders_df["status"] == "FILLED"
).sum()

rejected_orders = (
    orders_df["status"] == "REJECTED"
).sum()

fill_rate = (
    filled_orders / total_orders * 100
)

avg_latency = fills_df["latency_ms"].mean()

avg_slippage = fills_df["slippage_pct"].mean()

open_incidents = (
    incidents_df["status"] == "OPEN"
).sum()


print()
print("===== EXECUTION KPIs =====")

print(f"Total Orders: {total_orders:,}")
print(f"Filled Orders: {filled_orders:,}")
print(f"Rejected Orders: {rejected_orders:,}")
print(f"Fill Rate: {fill_rate:.2f}%")
print(f"Average Latency: {avg_latency:.2f} ms")
print(f"Average Slippage: {avg_slippage:.4f}%")
print(f"Open Incidents: {open_incidents:,}")


# ============================================================
# RISK STATE DISTRIBUTION
# ============================================================

print()
print("===== FILL RISK STATE DISTRIBUTION =====")

print(
    fills_df["risk_state"]
    .value_counts()
)


print()
print("===== INCIDENT RISK STATE DISTRIBUTION =====")

print(
    incidents_df["risk_state"]
    .value_counts()
)


# ============================================================
# FINAL OUTPUT
# ============================================================

print()
print("==============================================")
print("Pipeline complete.")
print("CSV files generated in data/processed/")
print("==============================================")