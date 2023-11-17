with cte as (

    SELECT c.id as candidate, c.party as party, r.constituency_id, r.votes,
    dense_rank() over(partition by constituency_id order by max(r.votes) desc) as ranking

    from election_candidates as c 
    left join election_results as r 
    on c.id = r.candidate_id 
    group by 1,2,3,4
)
SELECT party, count(1) as candidates_count
from cte where ranking = 1 group by 1;

select * from election_results order by constituency_id;
select * from election_candidates;
/* https://techtfq.com/blog/solving-sql-queries-from-business-analyst-interview */