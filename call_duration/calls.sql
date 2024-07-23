WITH incoming_total AS (
    SELECT incoming_caller_id, SUM(call_duration) AS total_incoming
    FROM calls
    GROUP BY incoming_caller_id
),
outgoing_total AS (
    SELECT outgoing_caller_id, SUM(call_duration) AS total_outgoing
    FROM calls
    GROUP BY outgoing_caller_id
),
incoming_outgoing AS (
    SELECT outgoing_caller_id AS ID, total_outgoing AS duration
    FROM outgoing_total
    UNION
    SELECT incoming_caller_id AS ID, total_incoming AS duration
    FROM incoming_total
)
SELECT ID, SUM(duration) AS total_call_duration
FROM incoming_outgoing
GROUP BY ID
ORDER BY ID;


SELECT * FROM calls;

/*
CREATE TABLE calls (
 incoming_caller_id INT,
 outgoing_caller_id INT,
 call_duration INT
);

INSERT INTO calls (incoming_caller_id, outgoing_caller_id, call_duration) VALUES
(1, 2, 60),
(2, 1,30), 
(2, 3, 120),
(1, 3, 180),
(3, 1,70), 
(3, 1,90), 
(3, 2, 240);
*/