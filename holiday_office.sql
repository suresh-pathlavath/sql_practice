--write a query to exclude holidays and show the difference between created_date and resolved date of tickets
-- https://ik.imagekit.io/suresh29/sql_practice/business_days.pdf
WITH cte
     AS (SELECT ticket_id,
                create_date,
                resolved_date,
                Timestampdiff(day, create_date, resolved_date)    AS
                date_difference,
                Timestampdiff(week, create_date, resolved_date)   AS
                week_difference,
                Timestampdiff(day, create_date, resolved_date) - 2 * (
                Timestampdiff(week, create_date, resolved_date) ) AS
                excluding_holidays,
                holiday_date,
                reason,
                Count(holiday_date)                               AS cnt
         FROM   date_tickets
                LEFT JOIN date_holidays
                       ON holiday_date BETWEEN create_date AND resolved_date
         GROUP  BY 1,
                   2,
                   3,
                   4,
                   5,
                   6,
                   7,
                   8)
SELECT ticket_id,
       create_date,
       resolved_date,
       excluding_holidays,
       excluding_holidays - cnt AS difference
FROM   cte;

SELECT *
FROM   date_holidays;

SELECT *
FROM   date_tickets; 