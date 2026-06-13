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