-- Find the price at the start of every month and determine the difference from the previous month
SELECT * FROM   sku_datetime;
WITH cte
     AS (SELECT *,
                ROW_NUMBER()
                  OVER(
                    PARTITION BY sku_id, YEAR(price_date), MONTH(price_date)
                    ORDER BY price_date DESC) AS rn
         FROM   sku_datetime),
     cte2
     AS (SELECT *
         FROM   sku_datetime
         WHERE  DAY(price_date) = 1
         UNION ALL
         SELECT sku_id,
                DATE_FORMAT(DATE_ADD(price_date, interval 1 month), '%Y-%m-01')
                next_month,
                price
         FROM   cte
         WHERE  rn = 1)
SELECT *, ( price - LAG(price, 1, 10) OVER() ) AS difference
FROM   cte2 ;


/*
create table sku_datetime 
(
sku_id int,
price_date date ,
price int
);
insert into sku_datetime values 
(1,'2023-01-01',10)
,(1,'2023-02-15',15)
,(1,'2023-03-03',18)
,(1,'2023-03-27',15)
,(1,'2023-04-06',20);

credit: https://www.youtube.com/watch?v=MQXfhH1d8K0
*?
