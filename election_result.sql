-- party wise winning candidates
-- https://ik.imagekit.io/suresh29/sql_practice/election_results.pdf
WITH cte
     AS (SELECT c.id                            AS candidate,
                c.party                         AS party,
                r.constituency_id,
                r.votes,
                Dense_rank()
                  OVER(
                    partition BY constituency_id
                    ORDER BY Max(r.votes) DESC) AS ranking
         FROM   election_candidates AS c
                LEFT JOIN election_results AS r
                       ON c.id = r.candidate_id
         GROUP  BY 1,
                   2,
                   3,
                   4)
SELECT party,
       Count(1) AS candidates_count
FROM   cte
WHERE  ranking = 1
GROUP  BY 1;

SELECT *
FROM   election_results
ORDER  BY constituency_id;

SELECT *
FROM   election_candidates;
/* https://techtfq.com/blog/solving-sql-queries-from-business-analyst-interview */