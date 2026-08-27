SELECT
    symbol,
    ROUND(AVG(best_ask - best_bid), 4) AS avg_spread,
    ROUND(MAX(best_ask - best_bid), 4) AS max_spread,
    ROUND(AVG(bid_depth), 4) AS avg_bid_depth,
    ROUND(AVG(ask_depth), 4) AS avg_ask_depth
FROM market_snapshots
GROUP BY symbol
ORDER BY avg_spread DESC;