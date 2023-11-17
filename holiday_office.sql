with cte as (SELECT ticket_id, create_date, resolved_date, 
timestampdiff(day, create_date, resolved_date) as date_difference,
timestampdiff(week, create_date, resolved_date) as week_difference,
timestampdiff(day, create_date, resolved_date) - 2*(timestampdiff(week, create_date, resolved_date)) as excluding_holidays,
holiday_date, reason,
count(holiday_date) as cnt
from date_tickets
left join date_holidays on holiday_date between create_date and resolved_date
group by 1,2,3,4,5,6,7,8
)
select ticket_id, create_date, resolved_date, excluding_holidays, excluding_holidays - cnt as difference  from cte 
;
SELECT * from date_holidays;
SELECT * from date_tickets;