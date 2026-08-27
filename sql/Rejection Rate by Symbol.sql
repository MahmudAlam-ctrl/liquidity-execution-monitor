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