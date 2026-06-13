-- 23. Grade + Income

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
    grade, 
    income_band, 
    COUNT(*) AS total_loans, 
    ROUND(AVG(
        CASE
            WHEN default_flag = 1 THEN 1.0
            ELSE 0
        END
    ) * 100, 2) AS default_rate
FROM income_segments
GROUP BY grade, income_band
ORDER BY grade, income_band;

-- 24. Grade + DTI

with dti_segments as (
	select *,
		case 
			when dti <= 11.89 then 'Q1'
			when dti>11.89 and dti <= 17.83 then 'Q2'
			when dti>17.83 and dti <=24.48 then 'Q3'
			when dti>24.48 then 'Q4'
			else 'UNKNOWN'
		end as dti_band
	from loans_final
)
SELECT 
    grade, 
    dti_band, 
    COUNT(*) AS total_loans, 
    ROUND(AVG(
        CASE
            WHEN default_flag = 1 THEN 1.0
            ELSE 0
        END
    ) * 100, 2) AS default_rate
FROM dti_segments
GROUP BY grade, dti_band
ORDER BY grade, dti_band;