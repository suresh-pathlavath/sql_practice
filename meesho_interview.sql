with cte as (
    select seat_number, occupancy, 
    lag(occupancy,1) over(partition by SUBSTRING(seat_number,1,1) ) prev_seat,
    lag(occupancy,2) over(partition by SUBSTRING(seat_number,1,1) ) prev_2nd,
    lag(occupancy,3) over(partition by SUBSTRING(seat_number,1,1) ) prev_3rd,
    lead(occupancy,1) over(partition by SUBSTRING(seat_number,1,1) ) next_seat,
    lead(occupancy,2) over(partition by SUBSTRING(seat_number,1,1) ) 2nd_next,
    lead(occupancy,3) over(partition by SUBSTRING(seat_number,1,1) ) 3rd_next

    
    from cinema_tickets
)
select seat_number from cte
where (prev_seat = 0 and prev_2nd = 0 and prev_3rd = 0 and occupancy = 0 )
or (occupancy = 0 and next_seat = 0 and 2nd_next = 0 and 3rd_next = 0)
;
select * from cinema_tickets;

-- meesho interview question

--https://www.youtube.com/watch?v=LikHiKuDXvg&ab_channel=Ananya