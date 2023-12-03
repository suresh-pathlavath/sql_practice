with cte as (

    SELECT Year, Brand, Amount, 
    lead(Amount) over(partition by Brand) as lead_amount,
    case when Amount < lead(Amount,1,amount+1) over(partition by Brand) THEN 1 else 0  END as count_sum
    from accounting_brands
) 
SELECT  Brand, Amount from cte where Brand not  in (select Brand from cte where count_sum = 0)
;

select * from accounting_brands;


/*
 https://www.youtube.com/watch?v=dWHSt0BVlv0&ab_channel=techTFQ
*/
