with cte as (SELECT 
city, days,cases,
dense_rank() over(partition by city order by days) as rnk_days,
dense_rank() over(partition by city order by cases) as rnk_cases,
CONVERT(dense_rank() over(partition by city order by days), DECIMAL) - CONVERT(dense_rank() over(partition by city order by cases), DECIMAL) AS diff
FROM covid
order by city, days)
select city  from cte group by city having count(distinct diff) = 1 
