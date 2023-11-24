WITH cte
     AS (SELECT a.cid         AS cid,
                a.fid         AS fid,
                a.origin      AS origin,
                a.destination AS destination,
                b.cid         AS b_cid,
                b.fid         AS b_fid,
                b.origin      AS b_origin,
                b.destination AS b_destination
         FROM   tiger_analytics_flights AS a
                INNER JOIN tiger_analytics_flights AS b
                        ON a.destination = b.origin
                           AND a.cid = b.cid)
SELECT origin,
       b_destination AS destination
FROM   cte
WHERE  destination IS NOT NULL;

SELECT *
FROM   tiger_analytics_flights;

SELECT *
FROM   tiger_analytics_flights;
-- https://www.youtube.com/watch?v=eMQDHHfUJtU&ab_channel=AnkitBansal