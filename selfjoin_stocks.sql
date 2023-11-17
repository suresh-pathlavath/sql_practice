with cte as (
    select row_number() over(order by trade_id) as id, trade_id, trade_timestamp, trade_stock, quantity, Price
     from Trade_tbl
)
SELECT a.trade_id, b.trade_id, a.price, b.price, a.trade_timestamp, b.trade_timestamp,
timestampdiff(SECOND,  a.trade_timestamp, b.trade_timestamp) as time_difference, 
round(abs((a.price - b.price)*1.0*100/a.price),2) as pct_change
from cte as a 
left join cte as b on a.id < b.id
where timestampdiff(SECOND,  a.trade_timestamp, b.trade_timestamp) <=10 
and round(abs((a.price - b.price)*1.0*100/a.price),2) >10
order by a.trade_id, b.trade_id
;
SELECT * from Trade_tbl;

/*

https://www.youtube.com/watch?v=X6i1WMx0vnY&ab_channel=AnkitBansal

    */