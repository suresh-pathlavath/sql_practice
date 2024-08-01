SELECT * FROM employee_swipe ;
WITH cte AS (
    SELECT
        employee_id,
        CAST(activity_time AS DATE) AS date,
        activity_time,
        activity_type,
        LEAD(activity_time, 1) 
            OVER (PARTITION BY employee_id, CAST(activity_time AS DATE) ORDER BY activity_time) AS log_out,
        
        TIMESTAMPDIFF(
            HOUR,
            MIN(activity_time) 
                OVER (PARTITION BY employee_id, CAST(activity_time AS DATE)),
            MAX(activity_time) 
                OVER (PARTITION BY employee_id, CAST(activity_time AS DATE))
        ) AS total_time,
        
        TIMESTAMPDIFF(
            HOUR,activity_time,
            LEAD(activity_time, 1) 
                OVER (PARTITION BY employee_id, CAST(activity_time AS DATE) ORDER BY activity_time)
        ) AS time_difference
        
    FROM
        employee_swipe
)

SELECT 
    employee_id,date, total_time, SUM(time_difference) AS work_in_hours
FROM cte
WHERE activity_type = 'login'
GROUP BY employee_id,date,total_time
ORDER BY date;

/*
CREATE TABLE employee_swipe (
    employee_id INT,
    activity_type VARCHAR(10),
    activity_time datetime
);

-- Insert sample data
INSERT INTO employee_swipe (employee_id, activity_type, activity_time) VALUES
(1, 'login', '2024-07-23 08:00:00'),
(1, 'logout', '2024-07-23 12:00:00'),
(1, 'login', '2024-07-23 13:00:00'),
(1, 'logout', '2024-07-23 17:00:00'),
(2, 'login', '2024-07-23 09:00:00'),
(2, 'logout', '2024-07-23 11:00:00'),
(2, 'login', '2024-07-23 12:00:00'),
(2, 'logout', '2024-07-23 15:00:00'),
(1, 'login', '2024-07-24 08:30:00'),
(1, 'logout', '2024-07-24 12:30:00'),
(2, 'login', '2024-07-24 09:30:00'),
(2, 'logout', '2024-07-24 10:30:00');

*/