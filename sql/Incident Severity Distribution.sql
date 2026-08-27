SELECT
    severity,
    COUNT(*) AS incident_count
FROM incidents
GROUP BY severity
ORDER BY incident_count DESC;