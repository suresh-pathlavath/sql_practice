-- https://ik.imagekit.io/suresh29/sql_practice/billing_amount.pdf
-- Average billing amount for each customer between 2019 to 2020

WITH cte
     AS (SELECT customer_id,
                customer_name,
                CASE
                  WHEN ( Year(billing_creation_date) = 2019 ) THEN billed_amount
                  ELSE 0
                END AS customer_2019,
                CASE
                  WHEN ( Year(billing_creation_date) = 2020 ) THEN billed_amount
                  ELSE 0
                END AS customer_2020,
                CASE
                  WHEN ( Year(billing_creation_date) = 2021 ) THEN billed_amount
                  ELSE 0
                END AS customer_2021
         FROM   billing)
SELECT customer_id,
       customer_name,
       Avg(customer_2019 + customer_2020 + customer_2021) AS average
FROM   cte
GROUP  BY 1,
          2; 
SELECT * from billing;
SELECT (100+150+100)/3


/*
https://www.youtube.com/watch?v=jS5_hjFgfzA&ab_channel=techTFQ
*/