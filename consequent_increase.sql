-- identify cities where covid cases increasing everyday(consistently)
-- https://ik.imagekit.io/suresh29/sql_practice/everyday_increasing_cases.pdf
WITH cte
     AS (SELECT city,
                days,
                cases,
                Dense_rank()
                  over(
                    PARTITION BY city
                    ORDER BY days)
                   AS rnk_days,
                Dense_rank()
                  over(
                    PARTITION BY city
                    ORDER BY cases)
                   AS rnk_cases,
                Convert(Dense_rank()
                          over(
                            PARTITION BY city
                            ORDER BY days), DECIMAL) -
                Convert(Dense_rank()
                          over(
                            PARTITION BY city
                            ORDER BY cases), DECIMAL) AS
                diff
         FROM   covid
         ORDER  BY city,
                   days)
SELECT city
FROM   cte
GROUP  BY city
HAVING Count(DISTINCT diff) = 1;

SELECT *
FROM   covid; 