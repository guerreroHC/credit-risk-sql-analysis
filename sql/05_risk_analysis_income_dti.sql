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

-- 20. Creación de bandas del DTI
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
select
	dti_band,
	COUNT(*) as total_loans,
	ROUND(
		avg(
			case
				when default_flag = 1 then 1.0
				else 0
			end	
		) *100, 2) as default_rate
		
from dti_segments
group by dti_band
order by dti_band;