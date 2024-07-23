WITH cte AS (
    SELECT 
        CASE WHEN from_id < to_id THEN from_id ELSE to_id END AS person1,
        CASE WHEN from_id > to_id THEN from_id ELSE to_id END AS person2,
        duration
    FROM call_between
)
SELECT 
    person1,
    person2,
    COUNT(*) AS count,
    SUM(duration) AS total_duration
FROM cte 
GROUP BY person1, person2;

/*
-- Creating the Calls table
CREATE TABLE call_between (
    from_id INT,
    to_id INT,
    duration INT
);

-- Inserting the data into the Calls table
INSERT INTO call_between (from_id, to_id, duration) VALUES
(1, 2, 59),
(2, 1, 11),
(1, 3, 20),
(3, 4, 100),
(3, 4, 200),
(3, 4, 200),
(4, 3, 499);
*/