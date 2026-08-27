SELECT 
    symbol,
    severity,
    risk_state,
    COUNT(incident_id) AS total_incidents
FROM incidents
GROUP BY symbol, severity, risk_state
ORDER BY total_incidents DESC;