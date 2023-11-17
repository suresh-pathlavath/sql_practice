with cte as (
    SELECT
    date_format(order_date, '%Y') as yearly,region,
    sum(sales) as sales
    from orders_practice
    group by 1,2
    order by 2
)
select *,
lag(sales,1,0) over(partition by region) as lag_sales, 
(sales-lag(sales,1,0) over(partition by region) )*1.0*100 / lag(sales,1,0) over()  as pct_growth
 from cte;

 select *     from orders_practice
