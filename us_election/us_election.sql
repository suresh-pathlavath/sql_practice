with cte as (SELECT concat(first_name, ' ', last_name) as candidate, state, count(1) as total ,
dense_rank() over(partition by concat(first_name, ' ', last_name) order by count(1) desc) as rnk
from us_election_candidates as c 
left join us_election_results as r 
on c.id = r.candidate_id
group by 1,2
order by candidate)
,cte2 as (select 
candidate, 
GROUP_CONCAT(case when rnk = 1 then concat(state,' ', '(', total, ')' ) end  SEPARATOR ', ') as 1st_place
, GROUP_CONCAT(case when rnk = 2 then concat(state,' ', '(', total, ')' ) end  SEPARATOR ', ') as 2nd_place
, GROUP_CONCAT(case when rnk = 3 then concat(state,' ', '(', total, ')' ) end  SEPARATOR ', ') as 3rd_place
 from cte GROUP by 1)
SELECT  * from cte2;
select * from us_election_candidates;
select * from us_election_results;


-- https://www.youtube.com/watch?v=W5Wvyc9Pass&ab_channel=techTFQ  watch 3rd part