-- =====================================================
-- CREDIT PORTFOLIO SQL ANALYTICS
-- Setup desde loans_raw
-- =====================================================

-- 1. Crear tabla limpia con default_flag
DROP TABLE IF EXISTS loans_clean;

CREATE TABLE loans_clean AS
SELECT
    *,
    CASE
        WHEN loan_status IN (
            'Fully Paid',
            'Current',
            'Does not meet the credit policy. Status:Fully Paid'
        ) THEN 0

        WHEN loan_status IN (
            'Charged Off',
            'Default',
            'Does not meet the credit policy. Status:Charged Off',
            'Late (31-120 days)'
        ) THEN 1

        ELSE NULL
    END AS default_flag
FROM loans_raw
WHERE loan_status NOT IN (
    'In Grace Period',
    'Late (16-30 days)'
);

-- Validar distribución del default_flag
SELECT 
    default_flag,
    COUNT(*) AS total_records
FROM loans_clean
GROUP BY default_flag
ORDER BY default_flag;


-- 2. Crear tabla final con columnas relevantes y tipos corregidos
DROP TABLE IF EXISTS loans_final;

CREATE TABLE loans_final AS
SELECT
    CAST(NULLIF(loan_amnt, '') AS DOUBLE PRECISION) AS loan_amnt,
    CAST(NULLIF(funded_amnt, '') AS DOUBLE PRECISION) AS funded_amnt,
    CAST(LEFT(TRIM(term), 2) AS INTEGER) AS term_months,
    CAST(NULLIF(int_rate, '') AS DOUBLE PRECISION) AS int_rate,
    CAST(NULLIF(installment, '') AS DOUBLE PRECISION) AS installment,

    grade,
    sub_grade,
    purpose,
    application_type,

    CAST(NULLIF(annual_inc, '') AS DOUBLE PRECISION) AS annual_inc,
    home_ownership,
    emp_length,
    verification_status,
    addr_state,

    CAST(NULLIF(dti, '') AS DOUBLE PRECISION) AS dti,
    CAST(NULLIF(delinq_2yrs, '') AS INTEGER) AS delinq_2yrs,
    CAST(NULLIF(inq_last_6mths, '') AS INTEGER) AS inq_last_6mths,
    CAST(NULLIF(open_acc, '') AS INTEGER) AS open_acc,
    CAST(NULLIF(total_acc, '') AS INTEGER) AS total_acc,
    CAST(NULLIF(REPLACE(revol_util, '%', ''), '') AS DOUBLE PRECISION) AS revol_util,
    CAST(NULLIF(acc_now_delinq, '') AS INTEGER) AS acc_now_delinq,
    CAST(NULLIF(mort_acc, '') AS INTEGER) AS mort_acc,
    CAST(NULLIF(tot_cur_bal, '') AS DOUBLE PRECISION) AS tot_cur_bal,

    TO_DATE(issue_d, 'Mon-YYYY') AS issue_date,
    CAST(default_flag AS INTEGER) AS default_flag
FROM loans_clean;


-- 3. Validaciones iniciales
SELECT COUNT(*) AS total_records
FROM loans_final;

SELECT 
    default_flag,
    COUNT(*) AS total_records,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM loans_final
GROUP BY default_flag
ORDER BY default_flag;

SELECT *
FROM loans_final
LIMIT 5;


-- 4. Validación de term_months
SELECT 
    term_months,
    COUNT(*) AS cantidad
FROM loans_final
GROUP BY term_months
ORDER BY term_months;


-- 5. Validación de grade
SELECT 
    grade,
    COUNT(*) AS cantidad
FROM loans_final
GROUP BY grade
ORDER BY grade;


-- 6. Validación de sub_grade
SELECT 
    sub_grade,
    COUNT(*) AS cantidad
FROM loans_final
GROUP BY sub_grade
ORDER BY sub_grade;


-- 7. Validación home_ownership
SELECT 
    home_ownership,
    COUNT(*) AS cantidad
FROM loans_final
GROUP BY home_ownership
ORDER BY cantidad DESC;


-- 8. Agrupación sugerida de home_ownership
SELECT
    home_ownership,
    CASE
        WHEN home_ownership IN ('MORTGAGE', 'RENT', 'OWN') THEN home_ownership
        ELSE 'OTHER_UNKNOWN'
    END AS home_ownership_group,
    COUNT(*) AS cantidad
FROM loans_final
GROUP BY 
    home_ownership,
    CASE
        WHEN home_ownership IN ('MORTGAGE', 'RENT', 'OWN') THEN home_ownership
        ELSE 'OTHER_UNKNOWN'
    END
ORDER BY cantidad DESC;


-- 9. Validación application_type
SELECT 
    application_type,
    COUNT(*) AS cantidad
FROM loans_final
GROUP BY application_type
ORDER BY application_type;


-- 10. Validación verification_status
SELECT 
    verification_status,
    COUNT(*) AS cantidad
FROM loans_final
GROUP BY verification_status
ORDER BY verification_status;


-- 11. Profiling annual_inc
SELECT 
    MIN(annual_inc) AS minimo,
    MAX(annual_inc) AS maximo,
    AVG(annual_inc) AS promedio
FROM loans_final;

SELECT 
    COUNT(*) AS cantidad_de_ceros
FROM loans_final
WHERE annual_inc = 0;

SELECT 
    annual_inc
FROM loans_final
WHERE annual_inc IS NOT NULL
ORDER BY annual_inc DESC
LIMIT 10;

SELECT 
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY annual_inc) AS median_annual_inc
FROM loans_final;


-- 12. KPIs generales de cartera
SELECT 
    COUNT(*) AS total_prestamos,
    SUM(funded_amnt) AS monto_total_financiado,
    AVG(funded_amnt) AS monto_promedio_financiado,
    ROUND(AVG(CASE WHEN default_flag = 1 THEN 1.0 ELSE 0 END) * 100, 2) AS tasa_default_pct
FROM loans_final;


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


-- 17. Percentiles annual_inc
SELECT 
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY annual_inc) AS p25,
    PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY annual_inc) AS p50,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY annual_inc) AS p75
FROM loans_final;


-- 18. Default por bandas de ingreso
WITH income_segments AS (
    SELECT
        *,
        CASE
            WHEN annual_inc IS NULL THEN 'UNKNOWN'
            WHEN annual_inc <= 46000 THEN 'Q1'
            WHEN annual_inc <= 65000 THEN 'Q2'
            WHEN annual_inc <= 93000 THEN 'Q3'
            ELSE 'Q4'
        END AS income_band
    FROM loans_final
)
SELECT
    income_band,
    COUNT(*) AS total_loans,
    ROUND(AVG(CASE WHEN default_flag = 1 THEN 1.0 ELSE 0 END) * 100, 2) AS default_rate
FROM income_segments
GROUP BY income_band
ORDER BY income_band;


-- 19. Percentiles DTI
SELECT 
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY dti) AS p25,
    PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY dti) AS p50,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY dti) AS p75
FROM loans_final;