SELECT
    symbol,
    ROUND(
        SUBSTRING_INDEX(
            SUBSTRING_INDEX(
                GROUP_CONCAT(latency_ms ORDER BY latency_ms),
                ',',
                CEIL(COUNT(*) * 0.95)
            ),
            ',',
            -1
        ),
        2
    ) AS p95_latency_ms
FROM (
    SELECT
        o.symbol,
        f.latency_ms
    FROM fills f
    JOIN orders o
        ON f.order_id = o.order_id
) x
GROUP BY symbol;