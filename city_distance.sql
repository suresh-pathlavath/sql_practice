-- https://ik.imagekit.io/suresh29/sql_practice/filtering_cities.pdf
WITH cte
     AS (SELECT a.source,
                a.destination,
                a.distance,
                Row_number()
                  OVER() AS id
         FROM   city_distance a
                LEFT JOIN city_distance b
                       ON a.source = b.destination)
SELECT t2.source,
       t2.destination,
       t2.distance
FROM   cte AS t1
       LEFT JOIN cte AS t2
              ON t1.source = t2.destination
                 AND t1.id < t2.id
WHERE  t2.source IS NOT NULL;

SELECT *
FROM   city_distance; 