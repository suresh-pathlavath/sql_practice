with cte as (
    select *
    , row_number() over(partition by hall_id order by start_date) as event_id
    from hall_events
)
SELECT * from cte;

SELECT * from hall_events;

-- https://www.youtube.com/watch?v=dX14FgKTpyg&ab_channel=AnkitBansal