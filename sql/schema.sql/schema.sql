CREATE DATABASE IF NOT EXISTS liquidity_ops;

USE liquidity_ops;

DROP TABLE IF EXISTS incidents;
DROP TABLE IF EXISTS fills;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS market_snapshots;

-- Orders
CREATE TABLE orders (
    order_id VARCHAR(32) PRIMARY KEY,
    timestamp DATETIME(3),
    symbol VARCHAR(16),
    side VARCHAR(8),
    order_type VARCHAR(16),
    requested_price DECIMAL(18, 4),
    quantity DECIMAL(18, 4),
    status VARCHAR(16)
);

-- Fills
CREATE TABLE fills (
    fill_id VARCHAR(32) PRIMARY KEY,
    order_id VARCHAR(32),
    timestamp DATETIME(3),
    expected_price DECIMAL(18, 4),
    executed_price DECIMAL(18, 4),
    quantity DECIMAL(18, 4),
    latency_ms INT,
    fee DECIMAL(18, 4),
    status VARCHAR(16),
    slippage_pct DECIMAL(10, 4),
    risk_state VARCHAR(24),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- Market snapshots
CREATE TABLE market_snapshots (
    snapshot_id INT AUTO_INCREMENT PRIMARY KEY,
    timestamp DATETIME(3),
    symbol VARCHAR(16),
    best_bid DECIMAL(18, 4),
    best_ask DECIMAL(18, 4),
    bid_depth DECIMAL(18, 4),
    ask_depth DECIMAL(18, 4)
);

-- Incidents
CREATE TABLE incidents (
    incident_id VARCHAR(32) PRIMARY KEY,
    timestamp DATETIME(3),
    severity VARCHAR(16),
    category VARCHAR(32),
    symbol VARCHAR(16),
    `trigger` VARCHAR(255),
    risk_state VARCHAR(24),
    status VARCHAR(16)
);