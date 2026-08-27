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