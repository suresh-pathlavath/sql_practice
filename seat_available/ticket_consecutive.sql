-- Find a query to fetch consecutive seats for friends to book the movie tickets

--Method1
WITH cte AS (
    SELECT *, 
           LAG(free, 1) OVER() AS prev_seat,
           LEAD(free, 1) OVER() AS next_seat
    FROM movie_tickets
)
SELECT seat_id
FROM cte
WHERE free = 1 
  AND (prev_seat = 1 OR next_seat = 1)
ORDER BY seat_id  ;

-- Method2
WITH cte AS (
    SELECT mt1.seat_id AS s1, mt2.seat_id AS s2
    FROM movie_tickets mt1
    JOIN movie_tickets mt2
    ON mt1.seat_id + 1 = mt2.seat_id
    WHERE mt1.free = 1 AND mt2.free = 1
),
cte2 AS (
    SELECT s1 AS seats_available FROM cte
    UNION
    SELECT s2 AS seats_available FROM cte
)
SELECT * FROM cte2 ORDER BY seats_available;

SELECT * FROM 

/*
CREATE TABLE movie_tickets (
    seat_id INT PRIMARY KEY,
    free int
);
delete from movie_tickets;
INSERT INTO movie_tickets (seat_id, free) VALUES (1, 1);
INSERT INTO movie_tickets (seat_id, free) VALUES (2, 0);
INSERT INTO movie_tickets (seat_id, free) VALUES (3, 1);
INSERT INTO movie_tickets (seat_id, free) VALUES (4, 1);
INSERT INTO movie_tickets (seat_id, free) VALUES (5, 1);
INSERT INTO movie_tickets (seat_id, free) VALUES (6, 0);
INSERT INTO movie_tickets (seat_id, free) VALUES (7, 1);
INSERT INTO movie_tickets (seat_id, free) VALUES (8, 1);
INSERT INTO movie_tickets (seat_id, free) VALUES (9, 0);
INSERT INTO movie_tickets (seat_id, free) VALUES (10, 1);
INSERT INTO movie_tickets (seat_id, free) VALUES (11, 0);
INSERT INTO movie_tickets (seat_id, free) VALUES (12, 1);
INSERT INTO movie_tickets (seat_id, free) VALUES (13, 0);
INSERT INTO movie_tickets (seat_id, free) VALUES (14, 1);
INSERT INTO movie_tickets (seat_id, free) VALUES (15, 1);
INSERT INTO movie_tickets (seat_id, free) VALUES (16, 0);
INSERT INTO movie_tickets (seat_id, free) VALUES (17, 1);
INSERT INTO movie_tickets (seat_id, free) VALUES (18, 1);
INSERT INTO movie_tickets (seat_id, free) VALUES (19, 1);
INSERT INTO movie_tickets (seat_id, free) VALUES (20, 1);

Credit: Ankit Bansal (SQL Interview Question Asked in Tredence Analytics)
*/