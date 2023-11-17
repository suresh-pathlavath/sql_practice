with cte as (SELECT 
comment, translation,
case when translation is null then comment 
    when translation is not null then translation end as expected_output
 from comments_and_translations
 )
 select expected_output from cte 
 ;
 SELECT * from comments_and_translations;

 /*

 https://www.youtube.com/watch?v=aE623ff7zkM&ab_channel=techTFQ

 */