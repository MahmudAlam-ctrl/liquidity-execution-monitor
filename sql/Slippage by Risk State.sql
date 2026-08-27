SELECT
    risk_state,
    COUNT(*) AS executions,
    ROUND(AVG(slippage_pct), 4) AS avg_slippage_pct,
    ROUND(MAX(slippage_pct), 4) AS max_slippage_pct,
    ROUND(AVG(latency_ms), 2) AS avg_latency_ms,
    MAX(latency_ms) AS max_latency_ms
FROM fills
GROUP BY risk_state
ORDER BY
    CASE risk_state
        WHEN 'NORMAL' THEN 1
        WHEN 'WARNING' THEN 2
        WHEN 'THROTTLE' THEN 3
        WHEN 'EMERGENCY_PAUSE' THEN 4
    END;