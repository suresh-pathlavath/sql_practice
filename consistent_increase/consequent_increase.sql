WITH cte AS (
    SELECT city, days, cases,
        DENSE_RANK() OVER (PARTITION BY city ORDER BY days) AS rnk_days,
        DENSE_RANK() OVER (PARTITION BY city ORDER BY cases) AS rnk_cases,
        DENSE_RANK() OVER (PARTITION BY city ORDER BY days) - DENSE_RANK() OVER (PARTITION BY city ORDER BY cases) AS diff
    FROM covid
)
SELECT city
FROM cte
GROUP BY city
HAVING COUNT(DISTINCT diff) = 1;

SELECT * FROM covid;
