with cte as (
    SELECT player_id, device_id, games_played, event_date,
    rank() over(partition by player_id order by event_date ) as rnk 
    from players
)
select player_id, device_id, event_date as first_loggedin_date from cte  where rnk = 1;
SELECT * from players;

/*
https://www.linkedin.com/posts/nayamsoni_sql-queries-activity-7126559270594125825-Ig9u?utm_source=share&utm_medium=member_desktop
*/