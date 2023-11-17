with cte as (select emp_id, 
CASE WHEN salary_component_type = 'Salary'  THEN val END AS salary,
CASE WHEN salary_component_type = 'bonus'  THEN val END AS bonus,
CASE WHEN salary_component_type = 'hike_percent'  THEN val END AS hike_percent
from emp_compensation)
select emp_id, sum(salary) as salary,
sum(bonus) as bonus,
sum(hike_percent) as hike_percent
from cte group by emp_id;
select * from emp_compensation;
