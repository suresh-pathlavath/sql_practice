with cte as (
    select cust_id, txn_date, txn_amt,
    sum(txn_amt) over(partition by cust_id order by txn_date, txn_amt) as cum_amt
    from customer_txn
)
, cte2 as (SELECT *, rank() over(partition by cust_id order by cum_amt) as ranking
 from cte  where cum_amt> 2000)
select cust_id, txn_amt, txn_date, cum_amt from cte2 where ranking = 1;




with cte as (
    select cust_id, txn_date, txn_amt,
    sum(txn_amt) over(partition by cust_id order by txn_date, txn_amt) as cum_amt
    from customer_txn
)
SELECT 
*
 from cte where cum_amt>2000;

SELECT * from customer_txn;

-- https://www.youtube.com/watch?v=1t5BvhYItcM&ab_channel=Ananya