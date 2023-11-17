WITH cte as (
    SELECT id,
        start_time,
        end_time,
        start_loc,
        end_loc,
        lag(end_loc) OVER() as lag_loc
    FROM uber_driver
)
SELECT id,
    sum(
        CASE
            WHEN start_loc = lag_loc THEN 1
            else 0
        END
    ) as test
from cte
GROUP BY 1
    /*
     https://www.youtube.com/watch?v=eayyD51fIVY&ab_channel=AnkitBansal
     */