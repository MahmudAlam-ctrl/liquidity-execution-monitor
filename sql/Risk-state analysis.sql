SELECT 
    risk_state,
    COUNT(fill_id) AS total_events,
    ROUND(AVG(latency_ms), 2) AS avg_latency_ms,
    ROUND(AVG(slippage_pct), 4) AS avg_slippage_pct
FROM fills
GROUP BY risk_state
ORDER BY avg_slippage_pct DESC;