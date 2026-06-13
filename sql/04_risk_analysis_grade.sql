-- 13. Default rate por grade
SELECT 
    grade,
    COUNT(*) AS total_loans,
    ROUND(AVG(CASE WHEN default_flag = 1 THEN 1.0 ELSE 0 END) * 100, 2) AS default_rate
FROM loans_final
GROUP BY grade
ORDER BY default_rate DESC;


-- 14. Exposición financiera por grade
SELECT 
    grade,
    COUNT(*) AS total_loans,
    SUM(funded_amnt) AS total_funded,
    AVG(funded_amnt) AS avg_loan,
    ROUND(AVG(CASE WHEN default_flag = 1 THEN 1.0 ELSE 0 END) * 100, 2) AS default_rate
FROM loans_final
GROUP BY grade
ORDER BY total_funded DESC;


-- 15. Pérdida estimada por grade
SELECT 
    grade,
    SUM(funded_amnt) AS total_funded,
    ROUND(AVG(CASE WHEN default_flag = 1 THEN 1.0 ELSE 0 END) * 100, 2) AS default_rate,
    SUM(funded_amnt * default_flag) AS estimated_loss
FROM loans_final
GROUP BY grade
ORDER BY estimated_loss DESC;


-- 16. Default por grade y plazo
SELECT 
    grade,
    term_months,
    COUNT(*) AS total_loans,
    ROUND(AVG(CASE WHEN default_flag = 1 THEN 1.0 ELSE 0 END) * 100, 2) AS default_rate
FROM loans_final
GROUP BY grade, term_months
ORDER BY default_rate DESC;