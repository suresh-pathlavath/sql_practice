SELECT e.name ,p.title, p.team, p.levels, p.payscale
from job_positions as p 
right join job_employees as e on p.id = e.position_id ;

SELECT * from job_positions;
SELECT * from job_employees;

/*
https://www.youtube.com/watch?v=HiscSRv7zWk&ab_channel=techTFQ
*/