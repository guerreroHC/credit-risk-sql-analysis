-- Estimated Loss by Purpose

SELECT
    purpose,
    COUNT(*) AS total_loans,
    SUM(funded_amnt) AS total_funded,
    ROUND(
        AVG(CASE WHEN default_flag = 1 THEN 1.0 ELSE 0 END)*100,
        2
    ) AS default_rate,
    SUM(funded_amnt * default_flag) AS estimated_loss
FROM loans_final
GROUP BY purpose
ORDER BY estimated_loss DESC;

-- Estimated Loss by Grade + Purpose

select
	grade,
    purpose,
    COUNT(*) AS total_loans,
    SUM(funded_amnt) AS total_funded,
    ROUND(
        AVG(CASE WHEN default_flag = 1 THEN 1.0 ELSE 0 END)*100,
        2
    ) AS default_rate,
    SUM(funded_amnt * default_flag) AS estimated_loss
FROM loans_final
GROUP BY grade, purpose
ORDER BY estimated_loss DESC;