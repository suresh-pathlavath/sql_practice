select s.id  as id,
 case when (t.name != s.name) then 'Mismatch' end as comment
from find_source as s 
inner join find_target as t on s.id = t.id and s.name != t.name

union all 

select s.id as id  
, case when t.id  is null and t.name is null then 'New In Source' end as comment
from find_source as s 
left join find_target as t on s.id = t.id 
where t.id is null

union all 

select t.id as id , 
case when s.id is null and s.name is null then 'New In Target' end as comment
from find_source as s 
right join find_target as t on s.id = t.id 
where s.id is null
;
SELECT * from find_source;
SELECT * from find_target;

/*

https://www.youtube.com/watch?v=aE623ff7zkM&ab_channel=techTFQ

*/
