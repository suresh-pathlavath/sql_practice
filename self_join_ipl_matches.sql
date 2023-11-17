with cte as (
    SELECT row_number() over(order by team_name) as id, 
    team_code, team_name
    from ipl_teams
)
select a.team_name as team, b.team_name as opponent_team
from cte as a 
join cte as b on  a.id < b.id
order by a.id, b.id;

with cte2 as (select row_number() over(order by team_name) as id,  a.team_name as team
from ipl_teams as a  )

SELECT a.team as team, b.team as opponent_team 
from cte2 as a 
join cte2 as b on a.id <> b.id 
/*
https://www.youtube.com/watch?v=aE623ff7zkM&ab_channel=techTFQ

*/