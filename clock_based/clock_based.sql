/*
-- Problem Statement: find the total number of hours clocked by each employee in the office 
I: means punch in 
O: means punch out
Note: Employee can do multiple punch in and punch out
*/


--  First Method
SELECT * FROM   clocked_hours;

WITH cte
     AS (SELECT *,ROW_NUMBER() OVER( partition BY empd_id, flag ORDER BY swipe) AS rn
         FROM   clocked_hours),
     cte2 AS (SELECT empd_id,
                Min(swipe)                                  AS swipe_in,
                Max(swipe)                                  AS swipe_out,
                TIMESTAMPDIFF(hour, Min(swipe), Max(swipe)) AS time_difference
         FROM   cte
         GROUP  BY empd_id,
                   rn)
SELECT empd_id,
       Sum(time_difference) AS total_hours
FROM   cte2
GROUP  BY empd_id ;

-- Second Method
WITH cte
     AS (SELECT *,
                LEAD(swipe, 1)
                  OVER( partition BY empd_id ORDER BY swipe) AS swipe_out
         FROM   clocked_hours)
SELECT empd_id,
       Sum(TIMESTAMPDIFF(hour, swipe, swipe_out)) AS office_hours
FROM   cte
WHERE  flag = 'I'
GROUP  BY empd_id; 


/*

create table clocked_hours(

empd_id int,

swipe time,

flag char

);

insert into clocked_hours values

(11114,'08:30','I'),

(11114,'10:30','O'),

(11114,'11:30','I'),

(11114,'15:30','O'),

(11115,'09:30','I'),

(11115,'17:30','O');


*/