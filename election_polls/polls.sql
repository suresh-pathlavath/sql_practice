-- write a query to get the winner user id and other details when they invest money and reward proportionally

with cte1 as (SELECT p.user_id as user_id, 
p.poll_id as poll_id,
p.poll_option_id as options, 
p.amount as amount,
pa.correct_option_id as correct_answer,
sum(p.amount) over(PARTITION BY p.poll_id) as looser_total_amount
from polls as p 
LEFT JOIN poll_answers AS pa 
ON p.poll_id = pa.poll_id
WHERE p.poll_option_id != pa.correct_option_id)

,cte2 as (
    SELECT p.user_id as user_id, 
p.poll_id as poll_id,
p.amount as amount,
pa.correct_option_id as correct_answer,
sum(p.amount) over(PARTITION BY p.poll_id) as winner_total_amount
from polls as p 
LEFT JOIN poll_answers AS pa 
ON p.poll_id = pa.poll_id
WHERE p.poll_option_id = pa.correct_option_id 
)
SELECT DISTINCT c2.user_id, c2.amount,
 c2.poll_id,c1.looser_total_amount,c2.winner_total_amount as invested,
 c2.amount/c2.winner_total_amount as proportion,
 round((c2.amount/c2.winner_total_amount)* c1.looser_total_amount,0) as reward 
 FROM cte1 as c1 INNER JOIN cte2 as c2 
ON c1.poll_id = c2.poll_id

/*create table polls
(
user_id varchar(4),
poll_id varchar(3),
poll_option_id varchar(3),
amount int,
created_date date
)
-- Insert sample data into the investments table
INSERT INTO polls (user_id, poll_id, poll_option_id, amount, created_date) VALUES
('id1', 'p1', 'A', 200, '2021-12-01'),
('id2', 'p1', 'C', 250, '2021-12-01'),
('id3', 'p1', 'A', 200, '2021-12-01'),
('id4', 'p1', 'B', 500, '2021-12-01'),
('id5', 'p1', 'C', 50, '2021-12-01'),
('id6', 'p1', 'D', 500, '2021-12-01'),
('id7', 'p1', 'C', 200, '2021-12-01'),
('id8', 'p1', 'A', 100, '2021-12-01'),
('id9', 'p2', 'A', 300, '2023-01-10'),
('id10', 'p2', 'C', 400, '2023-01-11'),
('id11', 'p2', 'B', 250, '2023-01-12'),
('id12', 'p2', 'D', 600, '2023-01-13'),
('id13', 'p2', 'C', 150, '2023-01-14'),
('id14', 'p2', 'A', 100, '2023-01-15'),
('id15', 'p2', 'C', 200, '2023-01-16');

create table poll_answers
(
poll_id varchar(3),
correct_option_id varchar(3)
)

-- Insert sample data into the poll_answers table
INSERT INTO poll_answers (poll_id, correct_option_id) VALUES
('p1', 'C'),('p2', 'A');

;
SELECT * from poll_answers;
Credit: Ankit Bansal | YouTube | Probo Very Interesting SQL Interview Question
*/