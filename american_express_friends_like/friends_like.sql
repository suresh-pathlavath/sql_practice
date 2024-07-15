WITH user_page AS (
    SELECT DISTINCT f.user_id, l.page_id
    FROM friends AS f
    INNER JOIN likes AS l ON f.user_id = l.user_id
),
friends_page AS (
    SELECT DISTINCT f.user_id, f.friend_id, l.page_id
    FROM friends AS f
    INNER JOIN likes AS l ON f.friend_id = l.user_id
)

SELECT DISTINCT fp.user_id, fp.page_id
FROM friends_page AS fp
LEFT JOIN user_page AS up ON fp.user_id = up.user_id AND fp.page_id = up.page_id
WHERE up.user_id IS NULL
ORDER BY fp.user_id, fp.page_id;

SELECT * FROM likes;
SELECT * FROM friends;



/*
--https://www.youtube.com/watch?v=aGKzhAkkOP8



Problem Statement: give recommendation to the user whose friends liked the page but he/she not yet liked that page


CREATE TABLE friends (
    user_id INT,
    friend_id INT
);

-- Insert data into friends table
INSERT INTO friends VALUES
(1, 2),
(1, 3),
(1, 4),
(2, 1),
(3, 1),
(3, 4),
(4, 1),
(4, 3);

-- Create likes table
CREATE TABLE likes (
    user_id INT,
    page_id CHAR(1)
);

-- Insert data into likes table
INSERT INTO likes VALUES
(1, 'A'),
(1, 'B'),
(1, 'C'),
(2, 'A'),
(3, 'B'),
(3, 'C'),
(4, 'B');

*/
