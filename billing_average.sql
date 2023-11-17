with cte as (SELECT customer_id, customer_name,
case when (year(billing_creation_date) =2019) THEN billed_amount else 0 end as customer_2019,
case when (year(billing_creation_date) =2020) THEN billed_amount else 0 end as customer_2020,
case when (year(billing_creation_date) =2021) THEN billed_amount else 0 end as customer_2021
from billing)
SELECT customer_id, customer_name, avg(customer_2019+ customer_2020+customer_2021) as average from cte
group by 1,2;
SELECT * from billing;
SELECT (100+150+100)/3


/*
https://www.youtube.com/watch?v=jS5_hjFgfzA&ab_channel=techTFQ
*/