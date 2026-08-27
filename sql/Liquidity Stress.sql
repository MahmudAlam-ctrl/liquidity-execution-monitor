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