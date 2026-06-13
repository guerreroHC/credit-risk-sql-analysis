-- Portfolio KPIs

SELECT
    COUNT(*) AS total_loans,
    SUM(funded_amnt) AS total_funded,
    AVG(funded_amnt) AS avg_loan_amount,
    ROUND(
        AVG(CASE WHEN default_flag = 1 THEN 1.0 ELSE 0 END)*100,
        2
    ) AS default_rate
FROM loans_final;