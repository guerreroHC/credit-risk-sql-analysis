-- 21. Borrower Purpose Risk Analysis
select purpose, COUNT(*) as total_loans, ROUND(avg(
													case
														when default_flag = 1 then 1.0
														else 0
													end	
												)*100, 2) as default_rate
from loans_final lf
group by purpose 
order by default_rate DESC

-- 22. home ownership analysis
select home_ownership , COUNT(*) as total_loans, ROUND(avg(
													case
														when default_flag = 1 then 1.0
														else 0
													end	
												)*100, 2) as default_rate
from loans_final lf
group by home_ownership 
order by default_rate desc


-- 25. geographic analysis

select addr_state from loans_final lf 

select addr_state,
 COUNT(*) AS total_loans, 
    ROUND(AVG(
        CASE
            WHEN default_flag = 1 THEN 1.0
            ELSE 0
        END
    ) * 100, 2) AS default_rate
from loans_final
group by addr_state 
order by default_rate desc