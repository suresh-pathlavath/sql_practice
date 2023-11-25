-- second most recent activity of each user
-- https://ik.imagekit.io/suresh29/sql_practice/google_recent_user_activity.pdf
WITH cte
     AS (SELECT username,
                activity,
                startdate,
                enddate,
                Row_number()
                  over(
                    PARTITION BY username
                    ORDER BY startdate) AS rn,
                Count(*)
                  over(
                    PARTITION BY username
                    ORDER BY startdate RANGE BETWEEN unbounded preceding AND
                  unbounded
                  following
                  )                     AS cnt_new
         FROM   google_activity)
SELECT *
FROM   cte
WHERE  rn = CASE
              WHEN cnt_new = 1 THEN 1
              ELSE cnt_new - 1
            END;

SELECT *
FROM   google_activity;
/*

https://www.youtube.com/watch?v=ueOUSjdAZY8&ab_channel=techTFQ

*/