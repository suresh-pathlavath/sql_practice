
with cte as (

    select concat(c.first_name, ' ', c.last_name) as customer, camp.name, e.status
    from marketing_customers as c 
    left join marketing_campaigns as camp on c.id = camp.customer_id 
    left join marketing_events as e on camp.id = e.campaign_id 
)
, cte2 as (SELECT status as event_type, 
customer as customer, 
GROUP_CONCAT(distinct name  SEPARATOR ', ') AS concatenated_values,

count(1) as total ,
rank() over(partition by status order by count(1) desc) as rnk
from cte group by 1,2
order by event_type, total desc
)
select event_type, customer, concatenated_values as campign, total from cte2 where rnk = 1;


select * from marketing_customers;
select * from marketing_campaigns;
select * from marketing_events;

--  -- https://www.youtube.com/watch?v=W5Wvyc9Pass&ab_channel=techTFQ
