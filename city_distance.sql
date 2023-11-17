with cte as (
    
SELECT  a.source, a.destination, a.distance,
row_number() over() as id
from city_distance a 
left join city_distance b on a.source = b.destination

)


SELECT t2.source, t2.destination, t2.distance from cte as t1
left join cte as t2 on t1.source = t2.destination and t1.id < t2.id 
where t2.source is not null;
SELECT * from city_distance;