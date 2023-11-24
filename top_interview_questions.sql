-- Display Highest and Lowest Salary in each department


WITH cte
     AS (SELECT *,
                Max(salary)
                  OVER(
                    partition BY dept
                    ORDER BY salary DESC) AS highest,
                Min(salary)
                  OVER(
                    partition BY dept
                    ORDER BY salary)      AS lowest
         FROM   practice_employee
         GROUP  BY id,
                   NAME,
                   dept,
                   salary)
SELECT *
FROM   cte;
SELECT * FROM   practice_employee; 

--- Q3 : Find actual distance car travelled 
--- Find actual distance --- 


WITH car_travelled
     AS (SELECT cars,
                days,
                cumulative_distance,
                Lag(cumulative_distance, 1, 0)
                  OVER(
                    partition BY cars ) AS lag_distance
         FROM   car_travels)
SELECT *,
       cumulative_distance - lag_distance AS distnace_travelled
FROM   car_travelled;

SELECT *
FROM   car_travels;

---  Convert A to B city or B to A city to just 1 record of A to B city --- 

WITH cte4
     AS (SELECT Row_number()
                  OVER() AS id,
                source,
                destination,
                distance
         FROM   src_dest_distance)
SELECT t1.source      AS source,
       t1.destination AS destination,
       t1.distance    AS distance
FROM   cte4 AS t1
       LEFT JOIN cte4 AS t2
              ON t1.source = t2.destination
                 AND t1.id < t2.id
WHERE  t2.id IS NOT NULL 

;
SELECT * FROM src_dest_distance;


-- Pizza Delivery Status
/*
A pizza company is taking orders from customers, and each pizza ordered is added to their database as a separate order.
Each order has an associated status, "CREATED or SUBMITTED or DELIVERED'. 
An order's Final_ Status is calculated based on status as follows:
Write a query to report the customer_name and Final_Status of each customer's arder. Order the results by customer
name.
1. When all orders for a customer have a status of DELIVERED, that customer's order has a Final_Status of COMPLETED.
2. If a customer has some orders that are not DELIVERED and some orders that are DELIVERED, the Final_ Status is IN PROGRESS.
3. If all of a customer's orders are SUBMITTED, the Final_Status is AWAITING PROGRESS.
4. Otherwise, the Final Status is AWAITING SUBMISSION.

*/

SELECT DISTINCT cust_name,
                'Complete' AS status
FROM   cust_orders AS d
WHERE  d.status = 'delivered'
       AND NOT EXISTS (SELECT 1
                       FROM   cust_orders AS d2
                       WHERE  d.cust_name = d2.cust_name
                              AND d2.status IN ( 'created', 'submitted' ))
UNION
SELECT DISTINCT cust_name,
                'In progress' AS status
FROM   cust_orders AS d
WHERE  d.status = 'delivered'
       AND EXISTS (SELECT 1
                   FROM   cust_orders AS d2
                   WHERE  d.cust_name = d2.cust_name
                          AND d2.status IN ( 'created', 'submitted' ))
UNION
SELECT cust_name,
       'AWAITING PROGRESS' AS status
FROM   cust_orders AS d
WHERE  d.status = 'SUBMITTED'
       AND NOT EXISTS (SELECT 1
                       FROM   cust_orders AS d2
                       WHERE  d.cust_name = d2.cust_name
                              AND d2.status IN ( 'delivered' ))
UNION
SELECT cust_name,
       'AWAITING submission' AS status
FROM   cust_orders AS d
WHERE  d.status = 'created'
       AND NOT EXISTS (SELECT 1
                       FROM   cust_orders AS d2
                       WHERE  d.cust_name = d2.cust_name
                              AND d2.status IN ( 'delivered', 'submitted' ));

SELECT *
FROM   cust_orders; 
-- source : https://www.youtube.com/watch?v=ZML_EJrBhnY&t=697s&ab_channel=techTFQ