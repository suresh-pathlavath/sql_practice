with cte as (select *, 
CONVERT(row_number() over(order by emp_age asc),DECIMAL) AS r_asc,
CONVERT(row_number() over(order by emp_age DESC),DECIMAL) AS r_dsc

from employee_youtube ORDER BY emp_age)
select avg(emp_age)  from cte
where abs(r_asc- r_dsc) <=1
;

 SELECT * From employee_youtube;
--using percentile
SELECT *,
percentile_cont(0.5) within GROUP (order by emp_age) over() as median_age 
from employee_youtube;



-- https://www.youtube.com/watch?v=vyUQsKCyJ9g&ab_channel=AnkitBansal