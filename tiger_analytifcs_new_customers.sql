WITH cte
     AS (SELECT *,
                Row_number()
                  OVER(
                    partition BY customer
                    ORDER BY order_date) AS rn
         FROM   tiger_analytics_sales)
SELECT Date_format(order_date, '%M') AS mon,
       Count(DISTINCT customer)      AS cnt
FROM   cte
WHERE  rn = 1
GROUP  BY 1;
SELECT * from tiger_analytics_sales;
--https://www.youtube.com/watch?v=eMQDHHfUJtU&ab_channel=AnkitBansal