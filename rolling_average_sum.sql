WITH CTE AS (
    SELECT ID,sales,
        sum(sales) over(
            ORDER BY id
        ) as rolling_sales
    from sales_rolling_sum
)
SELECT *
FROM CTE;
SELECT *  from sales_rolling_sum;
