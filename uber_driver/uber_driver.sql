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
SELECT *     FROM uber_driver;

    

    /*

CREATE TABLE uber_driver
  (
     id         VARCHAR(10),
     start_time TIME,
     end_time   TIME,
     start_loc  VARCHAR(10),
     end_loc    VARCHAR(10)
  );
insert into uber_driver values('dri_1', '09:00', '09:30', 'a','b'),('dri_1', '09:30', '10:30', 'b','c'),('dri_1','11:00','11:30', 'd','e');
insert into uber_driver values('dri_1', '12:00', '12:30', 'f','g'),('dri_1', '13:30', '14:30', 'c','h');
insert into uber_driver values('dri_2', '12:15', '12:30', 'f','g'),('dri_2', '13:30', '14:30', 'c','h');

Crdit: Ankit Bansal
*/