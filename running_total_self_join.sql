SELECT a.transaction_id, a.Revenue, b.Revenue lag_revenue, a.Revenue+b.Revenue as running_total
from cumulative_sum as a
left join cumulative_sum as b 
on a.transaction_id = b.transaction_id +1 
;
SELECT * from cumulative_sum;


with cte as (

    select transaction_id, Revenue, sum(Revenue) over(order by Revenue) as running_total
    from cumulative_sum
)
SELECT * from cte