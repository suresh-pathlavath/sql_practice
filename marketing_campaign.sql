-- https://ik.imagekit.io/suresh29/sql_practice/marketing_campaign.pdf?updatedAt=1700904345263
WITH cte AS
(
          SELECT    Concat(c.first_name, ' ', c.last_name) AS customer,
                    camp.NAME,
                    e.status
          FROM      marketing_customers AS c
          LEFT JOIN marketing_campaigns AS camp
          ON        c.id = camp.customer_id
          LEFT JOIN marketing_events AS e
          ON        camp.id = e.campaign_id ) , cte2 AS
(
         SELECT   status                                                  AS event_type,
                  customer                                                AS customer,
                  group_concat(DISTINCT NAME separator ', ')              AS concatenated_values,
                  count(1)                                                AS total ,
                  rank() OVER(partition BY status ORDER BY count(1) DESC) AS rnk
         FROM     cte
         GROUP BY 1,
                  2
         ORDER BY event_type,
                  total DESC )
SELECT event_type,
       customer,
       concatenated_values AS campign,
       total
FROM   cte2
WHERE  rnk = 1;SELECT *
FROM   marketing_customers;SELECT *
FROM   marketing_campaigns;SELECT *
FROM   marketing_events;

--  -- https://www.youtube.com/watch?v=W5Wvyc9Pass&ab_channel=techTFQ