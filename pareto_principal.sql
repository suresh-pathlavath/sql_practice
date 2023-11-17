--SELECT 0.8*SUM(Sales) from orders_practice
WITH cte AS(SELECT Product_ID,
    sum(Sales) AS total_sales
FROM orders_practice
GROUP by 1
ORDER BY total_sales),
cte2 as (SELECT *,
    sum(total_sales) over( order by Product_ID rows BETWEEN UNBOUNDED PRECEDING and current row
    ) as running_total,
    0.80*sum(total_sales) over() as 80_per_sales
FROM cte)
SELECT * FROM cte2
WHERE running_total <= 80_per_sales