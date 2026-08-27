USE liquidity_ops;

-- =====================================================
-- 1. Critical Incidents Summary
-- =====================================================

SELECT 
    symbol,
    severity,
    risk_state,
    COUNT(incident_id) AS total_incidents
FROM incidents
GROUP BY symbol, severity, risk_state
ORDER BY total_incidents DESC;


-- =====================================================
-- 2. Incident Severity Distribution
-- =====================================================

SELECT
    severity,
    COUNT(*) AS incident_count
FROM incidents
GROUP BY severity
ORDER BY incident_count DESC;


-- =====================================================
-- 3. Risk State Analysis
-- =====================================================

SELECT 
    risk_state,
    COUNT(fill_id) AS total_events,
    ROUND(AVG(latency_ms), 2) AS avg_latency_ms,
    ROUND(AVG(slippage_pct), 4) AS avg_slippage_pct
FROM fills
GROUP BY risk_state
ORDER BY avg_slippage_pct DESC;


-- =====================================================
-- 4. Slippage by Risk State
-- =====================================================

SELECT
    risk_state,
    COUNT(*) AS executions,
    ROUND(AVG(slippage_pct), 4) AS avg_slippage_pct,
    ROUND(MAX(slippage_pct), 4) AS max_slippage_pct,
    ROUND(AVG(latency_ms), 2) AS avg_latency_ms,
    MAX(latency_ms) AS max_latency_ms
FROM fills
GROUP BY risk_state
ORDER BY avg_slippage_pct DESC;


-- =====================================================
-- 5. Liquidity Stress
-- =====================================================

SELECT
    symbol,
    COUNT(*) AS stressed_snapshots,
    ROUND(AVG(bid_depth), 4) AS avg_bid_depth,
    ROUND(AVG(ask_depth), 4) AS avg_ask_depth
FROM market_snapshots
WHERE bid_depth < 1
   OR ask_depth < 1
GROUP BY symbol
ORDER BY stressed_snapshots DESC;