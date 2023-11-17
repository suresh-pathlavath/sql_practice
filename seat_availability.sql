with cte as (

    SELECT seat_no, is_empty
            , lag(is_empty,1) over(order by seat_no) as prev_1
            , lag(is_empty,2) over(order by seat_no) as prev_2
            , lead(is_empty,1) OVER(order by seat_no) as next_1
            , lead(is_empty,2) OVER(order by seat_no) as next_2
            
    FROM seat_availability
)
SELECT seat_no, is_empty

 FROM cte
 where is_empty = 'Y' and prev_1 = 'Y' and prev_2 = 'Y'
 or is_empty ='Y' and prev_1 = 'Y' and next_1 = 'Y'
 or is_empty = 'Y' and next_1 = 'Y' and next_2 = 'Y'
 ;
 SELECT * from seat_availability;