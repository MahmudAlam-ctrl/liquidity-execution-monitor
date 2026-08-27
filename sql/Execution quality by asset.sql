SELECT 
    o.symbol,
    COUNT(f.fill_id) AS total_fills,
    ROUND(AVG(f.latency_ms), 2) AS avg_latency_ms,
    ROUND(MAX(f.latency_ms), 2) AS max_latency_ms,
    ROUND(AVG(f.slippage_pct), 4) AS avg_slippage_pct,
    ROUND(MAX(f.slippage_pct), 4) AS max_slippage_pct
FROM fills f
JOIN orders o 
    ON f.order_id = o.order_id
GROUP BY o.symbol
ORDER BY avg_slippage_pct DESC;