with cte as (

    select username, activity, startdate, enddate, 
    row_number() over(partition by username order by startdate) as rn,
    count(*) over(partition by username order by startdate range between unbounded PRECEDING and UNBOUNDED FOLLOWING) as cnt_new 
    
    from google_activity
)
select *
  from cte 
  where rn = case when cnt_new = 1 then 1 else cnt_new-1  end ;

select * from google_activity; 

/*

https://www.youtube.com/watch?v=ueOUSjdAZY8&ab_channel=techTFQ

*/