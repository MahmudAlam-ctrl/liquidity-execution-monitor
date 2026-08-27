USE liquidity_ops;

-- =====================================================
-- 1. Execution Quality by Asset
-- =====================================================

SELECT 
    o.symbol,
    COUNT(f.fill_id) AS total_fills,
    ROUND(AVG(f.latency_ms), 2) AS avg_latency_ms,
    MAX(f.latency_ms) AS max_latency_ms,
    ROUND(AVG(f.slippage_pct), 4) AS avg_slippage_pct,
    ROUND(MAX(f.slippage_pct), 4) AS max_slippage_pct
FROM fills f
JOIN orders o
    ON f.order_id = o.order_id
GROUP BY o.symbol
ORDER BY avg_slippage_pct DESC;


-- =====================================================
-- 2. Fill Rate
-- =====================================================

SELECT
    COUNT(*) AS total_orders,
    SUM(CASE WHEN status = 'FILLED' THEN 1 ELSE 0 END) AS filled_orders,
    SUM(CASE WHEN status = 'REJECTED' THEN 1 ELSE 0 END) AS rejected_orders,
    ROUND(
        100.0 * SUM(CASE WHEN status = 'FILLED' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS fill_rate_pct
FROM orders;


-- =====================================================
-- 3. Rejection Rate by Symbol
-- =====================================================

SELECT
    symbol,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN status = 'REJECTED' THEN 1 ELSE 0 END) AS rejected_orders,
    ROUND(
        100.0 * SUM(CASE WHEN status = 'REJECTED' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS rejection_rate_pct
FROM orders
GROUP BY symbol
ORDER BY rejection_rate_pct DESC;


-- =====================================================
-- 4. Liquidity & Spread Analysis
-- =====================================================

SELECT
    symbol,
    ROUND(AVG(best_ask - best_bid), 4) AS avg_spread,
    ROUND(MAX(best_ask - best_bid), 4) AS max_spread,
    ROUND(AVG(bid_depth), 4) AS avg_bid_depth,
    ROUND(AVG(ask_depth), 4) AS avg_ask_depth
FROM market_snapshots
GROUP BY symbol
ORDER BY avg_spread DESC;


-- =====================================================
-- 5. Overall Execution KPI
-- =====================================================

SELECT
    COUNT(*) AS total_fills,
    ROUND(AVG(latency_ms), 2) AS avg_latency_ms,
    ROUND(MAX(latency_ms), 2) AS max_latency_ms,
    ROUND(AVG(slippage_pct), 4) AS avg_slippage_pct,
    ROUND(MAX(slippage_pct), 4) AS max_slippage_pct,
    ROUND(SUM(fee), 4) AS total_fees
FROM fills;